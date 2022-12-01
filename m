Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43417C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 14:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiLAOrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLAOrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 09:47:00 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786AA9CDF
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 06:47:00 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z131so1158516iof.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 06:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=XhTzCo6NKDm1fag4shcsiXNbjIh8ksp6fvzdqYCIo80=;
        b=n3KdyR/7VK9nb+VC//PuNgx9dFGL2nwABBH0Uv0o1wYmftgQtbDRkMV2GLxFkz9CBe
         V0JAs6GZFHmwROsuDte4fXvajas7r72a/GYAkTuBLr8ZycVB23KlGtIA/oyGh+t+iDOo
         M7Pq9rwYljgvmg4GOUmjN45BfW+Ne/N0FyuYWHHjvT+odUEVyOME6o/dhY23sAdJG9KR
         MZNfAm5Pzbl9bmG2RHt+P8STWvWiqwld8mxL3mGecwx1NZT+QQse6E7sNJw2fG90sLtO
         2iS61AG+FaTpF00RsRcR5ruPXVqAW3nxrThMdWpC0FVDh9qbCfO2AlJyLmb/r8Exw44l
         pAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhTzCo6NKDm1fag4shcsiXNbjIh8ksp6fvzdqYCIo80=;
        b=oQ4p92yukwUifw6Cy3HwqzE6/pxTuoCLLgbD0GXC0fVjKXbzeL6EGQBJd7Ip2Psm/P
         AOCGw6qdgmQH7UTjGpncIrfA06vzqJexJt3dYVfvgivJM/L5r4wR5vMxvEj22CIGuRC7
         JdRk7/lzxnDF8KWBc2pdUzx9kyTJP7KRDbCxBMqk0RnwdgykJrbjbp17nYqN2FnWp25o
         BQ5Nlkrq6myYput9SqJCjP3C9kc52PL3OJSXYOt0wTiGRjxVlHoxI/0+x03ggSxKg+bW
         02VdJdvpfX57k/D0vI0Fks43t0ZArz2G3Z4/OUC9lmp2e7baN8mjnpdkn0Mc0UOBK9cl
         8DUw==
X-Gm-Message-State: ANoB5pn66zpcMAhjuT48WQQhaD818hYhtmjLOLS6YRwoFOpmaql+erHq
        iioLH+Q8LX8Kfbn+uowKtuAaCg6Xx24=
X-Google-Smtp-Source: AA0mqf6Rbt5qUR214ge8oHEjp44YUbyohMlXBWGjODlqN4eXUysJ9g63F0r5nYSXmv8UnXrbMv7Gmg==
X-Received: by 2002:a05:6638:480e:b0:38a:1a3:d5ac with SMTP id cp14-20020a056638480e00b0038a01a3d5acmr4255298jab.256.1669906019686;
        Thu, 01 Dec 2022 06:46:59 -0800 (PST)
Received: from stargate ([2620:72:0:a40:ae86:2b20:51ed:d36d])
        by smtp.gmail.com with ESMTPSA id ch11-20020a0566383e8b00b00375783003fcsm1663187jab.136.2022.12.01.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 06:46:59 -0800 (PST)
References: <878rjry5a7.fsf@gmail.com>
 <40ffe56e-cec2-7130-ca4f-2186a1b7681c@dunelm.org.uk>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What are cherry-pick's exit codes?
Date:   Thu, 01 Dec 2022 08:45:16 -0600
In-reply-to: <40ffe56e-cec2-7130-ca4f-2186a1b7681c@dunelm.org.uk>
Message-ID: <87v8mvw599.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Phillip Wood <phillip.wood123@gmail.com> writes:
> One can get exit code 1 without conflicts. One example is when it
> cannot cherry-pick a commit because it would overwrite an untracked
> file. Another example is when a picked commit would be empty because
> the changes are already in HEAD.

These are good cases to know/test, thank you!

--
Sean Allred
