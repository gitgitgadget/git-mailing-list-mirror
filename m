Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA3DC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57694610CA
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhDKOUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKOUj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:20:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBCC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:20:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so15927846ejo.13
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=R+E+02Nfe9cUlMFJhBrVJJuYcue7CsDmmW9if8n9oSE=;
        b=R9Z85Im1X9g88jJrBq7b7v1Mj2Egy4m3HY8ntqlgmGpUOx6vNTk6xDwM0QOM5CA94A
         ss32FzuNP1aoHz/oyn5iTieUWZq1SMKJaac9uJJaNx+rggP6WobfHDbgtpJcG/R6Mmep
         lkH1pAWWt4t339dRD5iVE9w5Ph9xpV6riwNwjKDDIAwCGl/yqvKNVsOPm/n9J2VIHHSZ
         PA+oUO6cbMn9kP9RG+XrZAnryUrO9FqBDg98F7jdNNoqG48P5H9QpyBlU29Kmd9wTWrD
         mvwib2w6I2DR0cKUjRsgw7SXt3SEEgu3fSChiYAeYdov9C4Aa5lhCLRKknUEwy8Te1wB
         RdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=R+E+02Nfe9cUlMFJhBrVJJuYcue7CsDmmW9if8n9oSE=;
        b=Y4qgByuT4eBwtDvf9ILlMxFy6tPS0DN6klIIBSc2UOIwpd24dnExGMKYEFx5rdmV1D
         N2QEEDAXOS/BZqIc0uyQPPiveV0EzmhsOpdAj9LgRXlMHyFKHcFr7zw3p0f73wIlPkAi
         gNsalgyT60YDeoSVQUkc2In535a5GydRtktaBrG4lN0LYirY/R1JVtVy1RGd51fKbUaj
         H8F++ZpR2OSD/axV9czokRO8B4zTtt1IOlqxNmSWEav006jRS3EDhYOimZVvfDt//iTw
         xhVd0Q3wk3ixwKsuvacWuuF5Jd6w8Nq7+cgBfl4xDL8BwtNxWx/VJ6jL2HDiuGzeY6Ke
         etQw==
X-Gm-Message-State: AOAM532yA20gmpnr3ERi8lRwOVPVAw2bhWHN3aUnrRbn5TPOCKZcjvYH
        DcAcsDJDYai7EKWofwKMsI0=
X-Google-Smtp-Source: ABdhPJzF56Q0RFqaH2keAonf6sRj2p4N+lL/IBM03LIvETILWB8oQMfAdoOr/dkmBJ9BloYK7O+pbA==
X-Received: by 2002:a17:906:5da:: with SMTP id t26mr23111009ejt.21.1618150818646;
        Sun, 11 Apr 2021 07:20:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id nb29sm4011709ejc.118.2021.04.11.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:20:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210411125431.28971-3-sir@cmpwn.com>
Date:   Sun, 11 Apr 2021 16:20:16 +0200
Message-ID: <87blakgaxr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, Drew DeVault wrote:

> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
>  Documentation/git-send-email.txt | 4 ++--
>  git-send-email.perl              | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index c17c3b400a..520b355e50 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -171,8 +171,8 @@ Sending
>  	Specify the encryption to use, either 'ssl' or 'tls'. 'ssl' enables
>  	generic SSL/TLS support and is typically used on port 465.  'tls'
>  	enables in-band STARTTLS support and is typically used on port 25 or
> -	587.  Use whichever option is recommended by your mail provider.  Any
> -	other value reverts to plain SMTP.  Default is the value of
> +	587.  Use whichever option is recommended by your mail provider.  Leave
> +	empty to disable encryption and use plain SMTP.  Default is the value of
>  	`sendemail.smtpEncryption`.
>  
>  --smtp-domain=<FQDN>::
> diff --git a/git-send-email.perl b/git-send-email.perl
> index f5bbf1647e..bda5211f0d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -495,6 +495,9 @@ sub read_config {
>  
>  # 'default' encryption is none -- this only prevents a warning
>  $smtp_encryption = '' unless (defined $smtp_encryption);
> +if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encryption ne "tls") {
> +	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls', or nothing.\n");
> +}

Having not tested this but just eyeballed the code, I'm fairly sure
you're adding a logic error here, or is $smtp_encryption guaranteed to
be defined at this point?

We start with it as undef, then read the config, then the CLI
options. If we've got neither it'll still be undef here, no?

Thus the string comparison will emit a warning.

Maybe I'm overly used to regexen in Perl, but I'd also find this more
readable as:

    $smtp_encryption !~ /^(?:|ssl|tls)$/s

Or something like:

    my @valid_smtp_encryption = ('', qw(ssl tls));
    if (!grep { $_ eq $smtp_encryption } @valid_smtp_encryption) {
        ....
    }

