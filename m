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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D7DC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84670610E9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhDKORj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKORh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:17:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F585C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:17:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l4so15917202ejc.10
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Z4npkVgkXnBoLU3nO3SksKaQOBT7AOttTam6h6uU7zw=;
        b=hMME/ooaL7xMQobmJPvh3MsUPY5QxyqCpchsDYUyv9F9QbmXYgyFjUl3e+OwEyignJ
         i0O9LvtIjii242s3lPI+7i9qOMBLoctT3B6iwz+pzaQM7p4Wq8paEas4SfSENs6490Bj
         S2GKCDcgv5Ylwc85ec/srs+xQcFjVYtgsWkeX64umhYbfJDFvaCgvqxnKXNyENxc0jwG
         0M2HatTmH4zYqC4wqrhWZB74Aoi7T+eZZDcQqRh4lAh6IYc6mTtOd8LSCwdwQLLQ9kX7
         CPINBkq3mgtRwqqK9i8G16B8X+wkDA3YFdvWEitpMdF1B0DHQ1trYbBXnqRMHTsuuCN/
         zVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Z4npkVgkXnBoLU3nO3SksKaQOBT7AOttTam6h6uU7zw=;
        b=O5djUstF0lySQIogCFv9ra+bj5LpZccPjFcnT0bIHkvckKKDFThUxhXPPdGWqliR/V
         fvyEhZdfWU0I5MXwwslT6vo5y+QsVfgqq7KfpNbpgp9NuntnmqBrvHFvtvhPISKetwpK
         ddv2tFzfranlIVcJVYGucpjHPfGoNVJideW6nVrlLSR4DeWPnBfhLcp83DDa9yeAcKPa
         OJzuE670fEwTY8fXqm0A2Nl3Yf4Hi6+p2eu4IsdEOLugqJkf54K5QBfTNlesPLeYuGNt
         NW6OqvpaqCyPfhbZJSP5dfAf4S7WkY9RCpwH0HOj4CVBNOOWZZZBPv9zjrDJkLxvANjC
         6iLA==
X-Gm-Message-State: AOAM531tWdxFf1RyI6ftlfKVlYKKSwp34GqY3QWowIn4YKKpxiztF0BA
        po0MOwzpeeSUZrOz8aPQfpcXuGQfYQo=
X-Google-Smtp-Source: ABdhPJzd8Ot9HTlvzsKAzX1DHMvJZ9Q3vEdWDHsWGkjvvdspHO4knx9Rkw3W6wyJBDrqtFiFKK+cIQ==
X-Received: by 2002:a17:906:6d01:: with SMTP id m1mr24287854ejr.501.1618150639133;
        Sun, 11 Apr 2021 07:17:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e5sm4752495edr.64.2021.04.11.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:17:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] git-send-email: rename 'tls' to 'starttls'
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-4-sir@cmpwn.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210411125431.28971-4-sir@cmpwn.com>
Date:   Sun, 11 Apr 2021 16:17:17 +0200
Message-ID: <87eefggb2q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, Drew DeVault wrote:

> The name 'tls' is misleading. The 'ssl' option enables a generic
> "modern" encryption stack which might very well use TLS; but the 'tls'
> option enables STARTTLS support, which works entirely differently.
>
> This renames the canonical option to 'starttls', to make this
> distinction more obvious, and adds 'tls' as an alias for starttls, to
> avoid breaking config files.
>
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
>  Documentation/git-send-email.txt |  6 ++++--
>  git-send-email.perl              | 10 +++++++---
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 520b355e50..f8cea9e1f9 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -168,12 +168,14 @@ Sending
>  	unspecified, choosing the envelope sender is left to your MTA.
>  
>  --smtp-encryption=<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'. 'ssl' enables
> -	generic SSL/TLS support and is typically used on port 465.  'tls'
> +	Specify the encryption to use, either 'ssl' or 'starttls'. 'ssl' enables
> +	generic SSL/TLS support and is typically used on port 465.  'starttls'
>  	enables in-band STARTTLS support and is typically used on port 25 or
>  	587.  Use whichever option is recommended by your mail provider.  Leave
>  	empty to disable encryption and use plain SMTP.  Default is the value of
>  	`sendemail.smtpEncryption`.
> ++
> +'tls' is an alias for 'starttls' for legacy reasons.
>  
>  --smtp-domain=<FQDN>::
>  	Specifies the Fully Qualified Domain Name (FQDN) used in the
> diff --git a/git-send-email.perl b/git-send-email.perl
> index bda5211f0d..3f125bc2b8 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -495,8 +495,12 @@ sub read_config {
>  
>  # 'default' encryption is none -- this only prevents a warning
>  $smtp_encryption = '' unless (defined $smtp_encryption);
> -if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encryption ne "tls") {
> -	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls', or nothing.\n");
> +if ($smtp_encryption eq "tls") {
> +	# "tls" is an alias for starttls for legacy reasons
> +	$smtp_encryption = "starttls";
> +};

Needless trailing ";".

This and the preceding patch would be more readable if it was
re-arranged in some way as to not rewrite the newly introduced lines
between 2 and 3, maybe:

{
	my $tls_name = "tls";
        if (....)
}

Then you'd only need to change "tls" to "starttls" there.

> +if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encryption ne "starttls") {
> +	die __("Invalid smtp_encryption configuration: expected 'ssl', 'starttls', or nothing.\n");
>  }
>  
>  # Set CC suppressions
> @@ -1541,7 +1545,7 @@ sub send_message {
>  						 Hello => $smtp_domain,
>  						 Debug => $debug_net_smtp,
>  						 Port => $smtp_server_port);
> -			if ($smtp_encryption eq 'tls' && $smtp) {
> +			if ($smtp_encryption eq 'starttls' && $smtp) {

And this could use the same variable.
