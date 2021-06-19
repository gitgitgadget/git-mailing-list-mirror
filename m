Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC01C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 05:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05413610C7
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 05:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhFSF3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbhFSF3b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 01:29:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC131C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 22:27:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e33so9599488pgm.3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 22:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LaFZvNDAvjqGK4XVcCYW1ldg1jmd6b1hprCS3VlCnm0=;
        b=IeL761o8QbRf8rju+0dwEtvDdVnBpqkA2owRaldPHcG90J1dC2am+XQ3+eVrYWaE+2
         G+ppIpqjX7jjWv8vAjVyWAivzGeRyGWchXeSpPJ8Yk9VT1401M/fE2g20fl5NUdj3OGd
         vVSIPuFVg/YCXcUpu1EHO8V0yByleduh8zDUoF4qfyXJVvW4bU9TYqEkrsfi9kXfl8Sx
         Oo72Ff+aKvQNbsFWviU5ZFEeBD0AsLhYrIRXUB9mZjXKeS7pE0ho17r74WBQh3v+nZQ/
         1kqWicUgLlQAr1OfDrc4DYXQQ1st2rvqevtykJJyPKU2Sev8urv3U5m8UD+r2GB42oAl
         5q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LaFZvNDAvjqGK4XVcCYW1ldg1jmd6b1hprCS3VlCnm0=;
        b=lJ69PJ4PTP+UlJJvrS0wmYS8qgGnoUPr3ie7HD9x3ushu+IgY89LphFx5jA0WhSpl7
         BIHIyzoVx1iUfs/fkE0oTn2Y6GQpyB7AdwLbUIJp3AZbZH1L+CptfnwVx2FN7ILqxekZ
         gc72UmqKeijt1LyThJL8Xlr/SodirbyUG1fBqRUltmTMuQmtm1DG0U5tqlaN7YIizxY7
         8MvJ8YvJGB2JD8tkRLtdlIuCuuLHfH70+0yt+T1ojcsba1PGAfA5ZEcm02uHl0j0+/1M
         ZG7odSWJPKd7KTauejsHttqJmmjRlDwwQrFiLvRzjz1BphUYmZIeKU5BAhEJLPZ1sRJ7
         +QWg==
X-Gm-Message-State: AOAM532bTG7hQgRu1qwgrfLoMK8Y7ahym+zvjolFvLPiToLRFVRYIPuC
        lF72qmsOW4grDnmJiKbHueQ=
X-Google-Smtp-Source: ABdhPJwODhXycR6z+dqL1Ghvd/WHYOJQOubFWiZRJ2yvAiLb+MjlCCiakJCmyYDLjBAIUfeoYzepEA==
X-Received: by 2002:a63:4b59:: with SMTP id k25mr13385935pgl.252.1624080439129;
        Fri, 18 Jun 2021 22:27:19 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-55.three.co.id. [116.206.12.55])
        by smtp.gmail.com with ESMTPSA id n11sm9286180pfu.29.2021.06.18.22.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 22:27:18 -0700 (PDT)
Subject: Re: [PATCH] blame: fix typo in documentation
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Cc:     Barret Rhoden <brho@google.com>
References: <20210618221104.42260-1-rybak.a.v@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8921ac50-e628-9a60-2a8d-1b8cc2a5a056@gmail.com>
Date:   Sat, 19 Jun 2021 12:27:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618221104.42260-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 19/06/21 05.11, Andrei Rybak wrote:
> As can be seen in files "Documentation/blame-options.txt" and
> "builtin/blame.c", the name of this configuration variable is
> "blame.markUnblamableLines".
> 
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>   Documentation/config/blame.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
> index 9468e8599c..4d047c1790 100644
> --- a/Documentation/config/blame.txt
> +++ b/Documentation/config/blame.txt
> @@ -27,7 +27,7 @@ blame.ignoreRevsFile::
>   	file names will reset the list of ignored revisions.  This option will
>   	be handled before the command line option `--ignore-revs-file`.
>   
> -blame.markUnblamables::
> +blame.markUnblamableLines::
>   	Mark lines that were changed by an ignored revision that we could not
>   	attribute to another commit with a '*' in the output of
>   	linkgit:git-blame[1].
> 

That above is not typo fixing; that is correcting configuration variable 
name.

PS: I have to download mbox of this thread and reply from it because I 
didn't receive the thread on my Thunderbird, regardless of CCing Git ML.

-- 
An old man doll... just what I always wanted! - Clara
