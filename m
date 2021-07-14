Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41D5C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD925613C3
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbhGNS3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGNS3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 14:29:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0BC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 11:27:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so2044100wmc.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=r6tbT+fX9tBtIcBYm28EOpk3c5gXGtYUWFAo74WOvCk=;
        b=M7DFrpBsf7hVEJ4ot2QhQthU5kyL/Bue5aSYWEjewuTrhb8mcdEOt4+tIVrqCfd5Vj
         4VdoFBLShwYsoalM8nCR6PwGCcsv4jRcTkJnlTmX32ikRRh0mjhj+tuPYqTlLAt+Q/oF
         P3wAdWKiaMfi25JUVJCcY8nxL3v3xlwIE6SfSnnfMDjWlvnrDGMwRxTvER8V1rGNmA66
         9GUvRvRdf85QZty80odkgWDkfNSJBfkbOiygH19I45fy4aQMHZibLlm1Ekf4WIbgaePR
         8/96u7y1aZKuUDB8wB73564vM9z3Szmro0v/Uznj+Fr6i5g42rnrLtRzkOd5qOoLgjCb
         +7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=r6tbT+fX9tBtIcBYm28EOpk3c5gXGtYUWFAo74WOvCk=;
        b=T7Uu0UZddVaLNtr+Ca4CdxaItv5Cv7csx52ZtLC2ZgY811PPtCAQfN5PcbienELTY9
         gzH3TfQzkNO993/a9ZVwddGOSdylB5+ZE/fsp9FGGQuSsiZ+dFuSApRfdTiR3SW17iuJ
         DuHDBin/EkK0K9VFXRxZGG/ER91KNTW+HGykpthBjW47nCtw0ATh4AmSkjhDvmHxwctN
         RKtV0acRkX8qawo58bOHOo2aC2hz89Eo3iT/LZpjoHIEhRgNZWpjZHoYRizA6L43QcuT
         kDSdkLDhofUJNeWhnk/ArtG0AHtS9hLf0V3/wUQjv4nzBUQ/fcbzNtIkFTLVhA9IcIYN
         BFNQ==
X-Gm-Message-State: AOAM53217/+Cd17NHdBeajZCHqeGSTbI9RdDUqaC6MIPGI5vEZAlK2jH
        LI3bmT8v9EhiqC3Hw21WZY8=
X-Google-Smtp-Source: ABdhPJxKvxFexOGI4dAK1Bi39W1SDQifRswxUw/Lp5tUSS45C73btzLKUoZop6ytyjNaLreNmIwpWg==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr5740752wmf.36.1626287219159;
        Wed, 14 Jul 2021 11:26:59 -0700 (PDT)
Received: from gec-zebradil-lenovo ([2a02:908:1347:ac20:1a08:8f6a:8172:9625])
        by smtp.gmail.com with ESMTPSA id w22sm6382308wmc.4.2021.07.14.11.26.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Jul 2021 11:26:58 -0700 (PDT)
Date:   Wed, 14 Jul 2021 20:26:57 +0200
From:   German Lashevich <german.lashevich@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "=?utf-8?Q?git=40vger.kernel.org?=" <git@vger.kernel.org>
Message-ID: <9A517A17-6BC6-4239-9CD5-F80C839C24F0@getmailspring.com>
In-Reply-To: <YO8ordiN18sNP6tA@coredump.intra.peff.net>
References: <YO8ordiN18sNP6tA@coredump.intra.peff.net>
Subject: Re: Bug report: GIT_CONFIG and user.email/name
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GIT_CONFIG is confusing, GIT_CONFIG_GLOBAL is what I need.

Thanks a lot! 

On Jul 14 2021, at 8:10 pm, Jeff King <peff@peff.net> wrote:

> On Wed, Jul 14, 2021 at 07:10:27PM +0200, German Lashevich wrote:
> 
>> I've faced an issue while trying to use a non-default .gitconfig file
>> via specifying
>> GIT_CONFIG environment variable.
>> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> 
>> ```
>> # use custom .gitconfig via GIT_CONFIG envvar:
>> mkdir -p /tmp/git-test/repo
>> cat <<EOT > /tmp/git-test/.gitconfig
>> [user]
>>     name = John Doe
>>     email = john@doe.me
>> EOT
>> cd /tmp/git-test/repo
>> git init
>> export GIT_CONFIG=/tmp/git-test/.gitconfig
>> echo Hi > readme.txt
>> git add readme.txt
>> git commit -m 'Initial commit'
>> ```
> 
> The GIT_CONFIG variable doesn't work that way. It is not a general
> mechanism used by all of Git, but rather a specific feature of the
> git-config program (and even there it is a historical wart; you should
> use "git config --file" instead).
> 
> One of these variables is probably more helpful:
> 
>  $ man git | sed -n '/GLOBAL/,/^$/p'
>  GIT_CONFIG_GLOBAL, GIT_CONFIG_SYSTEM
>    Take the configuration from the given files instead from global or
>    system-level configuration files. If GIT_CONFIG_SYSTEM is set, the
>    system config file defined at build time (usually /etc/gitconfig)
>    will not be read. Likewise, if GIT_CONFIG_GLOBAL is set, neither
>    $HOME/.gitconfig nor $XDG_CONFIG_HOME/git/config will be read. Can
>    be set to /dev/null to skip reading configuration files of the
>    respective level.
> 
> Note that they're new in v2.32.0.
> 
> -Peff
> 
