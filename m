Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B4DC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2C76137D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFPDpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 23:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDpq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 23:45:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B6C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 20:43:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q25so1076689pfh.7
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 20:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Vi3cd03aYC10btZo+3RRHcZun2Z3nAtfFu8IQFaXQA=;
        b=hPErxw/Ku2sKkSS4+2mU8YztwIUQ8w/1pRj/9MaYnPBOyjaKGedX4xZ1ZXliQA2EBb
         rjx/I3q0rqgPG8wrn02wDK8EdImS9FBXYowWnsSeyNcIdNGx1fBIwfLIgfEQFPCB8+9L
         s2cBTCBXg90Owyq5tflhsGWljm7LO7dTdUXh5WsEZEwojhLRQIIn/dynfLFMjTGwpvkW
         spGRy0o8BY30yb0B7wd+QzUJzOsZsoqGarmoJxAeexA8osJ9flpIeUiGg7b6nKKwD+DT
         FgYhOUqJW7fhXxm3JkFhYeKTjEkCOMsw/joBnHnPy6XD2U7eFE9QFTA7fwNGqmzHt6/J
         v/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Vi3cd03aYC10btZo+3RRHcZun2Z3nAtfFu8IQFaXQA=;
        b=Ed2C1soYAGtf0TTwhS0vdbThREudNybqXTZpz22tifmXFIgQyeDQ4Lcd8hHishVYWQ
         9FQBTa2dJArK8Wm44Sc1HPUtRpvyd8B0KlC9/LM9ohfKCqsYpRjYFP7e98wcZJlOKAtY
         ZdleEyqmlV8AtfB2ToqaQqGknQDgtFlo81wFXm1qwDxi0uYCBk7yerIwtWon740SOX8p
         MAThnl5RcOgr22zbOfMUkaaRPzjJUQX8QrxRSD4FhlngTp2piRVN7xgpm6QxX2Lv+WGl
         FfYVPreh25MVqIsoEFZGy4zLm/WPwwgxWwbtym0KJOdDlw5tf6Ycax4z9eGwNHWB/Ed7
         rYhg==
X-Gm-Message-State: AOAM5325+eLd/0Hyn7o4W+40LysP6n5E7iwBeoTjX5/e6Pjn98AdeUX5
        zpkZb2d5vMbpMvyDXTQ5VYVs6zVPS99+3w==
X-Google-Smtp-Source: ABdhPJzawC5CyNqvPaZC90sPnMqQYW6SrMDOrzQd4HQW9joDznQUZVYvZYJvQah8k0+lJMGj/lB3Zw==
X-Received: by 2002:a63:5760:: with SMTP id h32mr2838727pgm.367.1623815021031;
        Tue, 15 Jun 2021 20:43:41 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-12.three.co.id. [180.214.233.12])
        by smtp.gmail.com with ESMTPSA id x20sm498617pfu.205.2021.06.15.20.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 20:43:40 -0700 (PDT)
Subject: Re: [PATCH 1/6] gittutorial doc: replace "alice" and "bob" with "you"
 and "www-data"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8250d8af-2d52-321c-36a7-d71c29fc1ef1@gmail.com>
Date:   Wed, 16 Jun 2021 10:43:32 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/21 23.17, Ævar Arnfjörð Bjarmason wrote:
> -Suppose that Alice has started a new project with a Git repository in
> -/home/alice/project, and that Bob, who has a home directory on the
> -same machine, wants to contribute.
> +Suppose that you've started a new project with a Git repository in
> +/home/you/project, and you'd like another user on the same local
> +machine to be able to contribute to it. E.g. a www-data user to serve
> +the content up with a webserver.
>   
> -Bob begins with:
> +As the `www-data` user do:
>    >   ------------------------------------------------
> -bob$ git clone /home/alice/project myrepo
> +www-data$ git clone /home/you/project /var/www-data/deployment
>   ------------------------------------------------
> 

This assumes that we're on Debian or its derivatives, however many users 
run Git on other distributions (Fedora, Arch, Gentoo, openSUSE, etc.), 
so `www-data` user may not be present there. Also, `www-data` is system 
account, as opposed to normal user account, so you can't log in to it; 
you need as root `chown -R www-data:www-data /somewhere/`.

This also assumes that we use Apache HTTPD. The setup for other 
webservers may be different. For example, if NGINX is used (installed 
from upstream packages rather than from Debian package repository), you 
need to make site root (the path specified in `root` directive) readable 
by `nginx` user.

> -This creates a new directory "myrepo" containing a clone of Alice's
> +This creates a new directory "deployment" containing a clone of your
>   repository.  The clone is on an equal footing with the original
>   project, possessing its own copy of the original project's history.
>  

But the scenario is we're cloning from local repo, so `git clone` here 
implies --local (and bypasses normal Git transport mechanism), so to get 
clone experience similar to when using remote repo, we can use 
--no-local instead.

> -Bob then makes some changes and commits them:
> +As `www-data` you then makes some changes and commit them:
>   
>   ------------------------------------------------
>   (edit files)
> -bob$ git commit -a
> +www-data$ git commit -a
>   (repeat as necessary)
>   ------------------------------------------------
>   
> -When he's ready, he tells Alice to pull changes from the repository
> -at /home/bob/myrepo.  She does this with:
> +You can then pull those changes to the checkout in your home directory
> +at /home/you/project:
>   
>   ------------------------------------------------
> -alice$ cd /home/alice/project
> -alice$ git pull /home/bob/myrepo master
> +you$ cd /home/you/project
> +you$ git pull /var/www-data/deployment master
>   ------------------------------------------------
>   

The resulting rewrite until this point makes no sense for me. Previously 
we have Alice and Bob working the project, but now you do the same, one 
as normal user account and one as system user `www-data`. Honestly I 
would like keeping the status quo.

-- 
An old man doll... just what I always wanted! - Clara
