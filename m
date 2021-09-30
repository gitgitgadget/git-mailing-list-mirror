Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01964C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4451615E0
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbhI3Qzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 12:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbhI3Qzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 12:55:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17355C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 09:53:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v10so24906778edj.10
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qCs0FAddMGwi7EsGIyAjjzd0msOEkbBGIUW7rQp7Vtc=;
        b=MX+EqTTBN+o+uCyf6o8SCxi6owSGD6iyDwChSFSa3n9t9o4+OSbTvaAeDTGHEcDiJH
         Zb254uSYoegQzBeNhUumR+IaOdIXnl4ujiKD1gSbthDWL7+oFEk8FrtruEDLIUdgxplR
         bFkoRYk6gvvl6c9wE2v9Yhs6pnA+RxpTkpskZjtI033d/iUYYQc5q8wW6VMHWZiZiQAu
         9CWzxOfY+u14O8Fnnpxp+VT/HKx0NBa779u1dgiL1Bnj2eV10eaTujy+h2IuWZ7D3Apn
         1iz5SMIazmDM7peSyffPXkioSSEck1yfelnQ3lQ7vbH9PH6tIIA6pf6YUikiTpnqDiX3
         0JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qCs0FAddMGwi7EsGIyAjjzd0msOEkbBGIUW7rQp7Vtc=;
        b=A0TUcFvmHcVzixhZw7XWW7z4LUYCyqktJeR+a/kBnvR37D2t2SvT82XFnAb/IxLlEv
         dK6O8P1I+SFCKIhS3v59M8rQB9XjR2h4GuvXO7nATT//TplKSIt7n94gkqpKbbg/tNgi
         GEXeaGWNokwX1mCAotVMmyBRVvSNzBDPhG6BAvuUVHwTv6ojd/zl3N/NdpYTYqAANCHM
         nzozYYDBVAVIse2tLesLw4CyNH0lhlzZkwQlXN0Y4gns7eMnEbFZjuC5fdmUpLZcJbjl
         tCwq1jjhDWvzWBWRslmcjZCziwpiMmiLal9R+KgBVujsa50thH4NQPC0UmZFH/U2LhJM
         eNDQ==
X-Gm-Message-State: AOAM531zqAVzEyYcWP21V1Kd317WAO5cdIuHuWm1JcwAWjQmwr6Ut90t
        kHWGwcRxD+WRmVmVdK1P3FkHuGd73z3A5bzk
X-Google-Smtp-Source: ABdhPJwcAwgyAxx9j2CNIYL2laXFSGMR2a7x/RXMq9+H8N6C+0sKosvALAW0hBquNjsXgCORSQByhQ==
X-Received: by 2002:a17:906:4b09:: with SMTP id y9mr315068eju.426.1633020831300;
        Thu, 30 Sep 2021 09:53:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dt4sm1739574ejb.27.2021.09.30.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:53:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/7] merge-ort: capture and print ll-merge warnings in
 our preferred fashion
Date:   Thu, 30 Sep 2021 18:53:45 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ce95b82fc492d48fa6022df424f9a303a1c70ad4.1630376800.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <ce95b82fc492d48fa6022df424f9a303a1c70ad4.1630376800.git.gitgitgadget@gmail.com>
Message-ID: <87a6jut36p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:

> @@ -108,8 +108,14 @@ test_expect_success 'refuse to merge binary files' '
>  	printf "\0\0" >binary-file &&
>  	git add binary-file &&
>  	git commit -m binary2 &&
> -	test_must_fail git merge F >merge.out 2>merge.err &&
> -	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
> +	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +	then
> +		test_must_fail git merge F >merge.out &&
> +		grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.out
> +	else
> +		test_must_fail git merge F >merge.out 2>merge.err &&
> +		grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
> +	fi
>  '

To save readers from eyeballing if a single character has changed here,
which I don't think it has, just do:

if ...
then
	cmd >actual
else
	other cmd >actual
fi &&
grep [...]

I.e. no need to duplicate the "grep" here just because of merge.out v.s. merge.err.

[...]

> -	test_must_fail git merge bin-main 2>stderr &&
> -	grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
> +	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +	then
> +		test_must_fail git merge bin-main >stdout &&
> +		grep -i "warning.*cannot merge.*HEAD vs. bin-main" stdout
> +	else
> +		test_must_fail git merge bin-main 2>stderr &&
> +		grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
> +	fi


ditto.
