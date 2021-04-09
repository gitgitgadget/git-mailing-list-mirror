Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627EEC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 23:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FECF610A6
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 23:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhDIXPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 19:15:12 -0400
Received: from mx.99rst.org ([52.22.122.190]:43133 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhDIXPL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 19:15:11 -0400
Received: from [IPv6:2607:fb90:a63a:57dc:3489:9654:aa5e:28e5] (unknown [172.58.35.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.99rst.org (Postfix) with ESMTPSA id 85D2B4458B;
        Fri,  9 Apr 2021 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1618010097;
        bh=GFb29KqPTV6mQA1SAyENIPgVdMkc2W+ibNs739Pn0Lk=;
        h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
        b=NmvP8WeKybrI5oj6k6MBhPerY5Ym+mlM1ztjxDm33z2EIPIkP4F/h0UE6HtrR0yVh
         yCvMYSmNcJhRVG4g8zLEvrhOMQ6ELAv3hsX/IPa7C693C1DwIYlSaH3PCL7/mHi69t
         CwE5Sw9S3zBvc4cs4OpVVjskAU8KKck/lp70h38PiueMq8cJ1v3oj/Q0t+X3vCTW4Z
         J7cu5rL6vIKtwwN52VKQb3vvJnzo4NOQJTxQM/WxarXy1L535Q174ztw9EBgbkJeKN
         qkA+Jz94ChTzuUKIeiCzovat0Bz3KOLPGsEwp0HhdyJfLNZFKRaNYBS/qjI6GgV8e4
         7W2NvdSw4u/pA==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Georgios Kontaxis <geko1702+firehose@99rst.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
Date:   Fri, 9 Apr 2021 16:14:54 -0700
Message-Id: <07869D2B-1962-4602-915E-78AE931B34C2@99rst.org>
References: <20210409211812.3869-1-sir@cmpwn.com>
Cc:     git@vger.kernel.org
In-Reply-To: <20210409211812.3869-1-sir@cmpwn.com>
To:     Drew DeVault <sir@cmpwn.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Apr 9, 2021, at 14:18, Drew DeVault <sir@cmpwn.com> wrote:
>=20
> =EF=BB=BFThe present options are misleading; "ssl" enables generic, "moder=
n" SSL
> support, which could use either SSL or TLS; and "tls" enables the
> SMTP-specific (and deprecated) STARTTLS protocol.
>=20
> This changes the canonical config options to "ssl/tls" and "starttls",
> updates the docs to explain the options in more detail, and updates
> git-send-email to accept either form.
> ---
> Documentation/git-send-email.txt | 11 ++++++++---
> git-send-email.perl              |  4 ++--
> 2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-ema=
il.txt
> index 93708aefea..3597935e41 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -168,9 +168,14 @@ Sending
>    unspecified, choosing the envelope sender is left to your MTA.
>=20
> --smtp-encryption=3D<encryption>::
> -    Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -    value reverts to plain SMTP.  Default is the value of
> -    `sendemail.smtpEncryption`.
> +    Specify the encryption to use, either 'ssl/tls' or 'starttls', whiche=
ver
> +    is recommended by your email service provider.  SSL/TLS is typically
> +    used on port 465 and is preferred if available.  STARTTLS is typicall=
y
> +    used on port 25 or 587. Any other value reverts to plain SMTP.  The
Weird that we fail open (no encryption) on typos.
Any chance we can fix that in this patch?

> +    default is the value of `sendemail.smtpEncryption`.
> ++
> +For legacy reasons, 'ssl' is accepted for 'ssl/tls' and 'tls' is accepted=
 for
> +'starttls'.
>=20
> --smtp-domain=3D<FQDN>::
>    Specifies the Fully Qualified Domain Name (FQDN) used in the
> diff --git a/git-send-email.perl b/git-send-email.perl
> index f5bbf1647e..34fdf587bd 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1503,7 +1503,7 @@ sub send_message {
>        my $use_net_smtp_ssl =3D version->parse($Net::SMTP::VERSION) < vers=
ion->parse("2.34");
>        $smtp_domain ||=3D maildomain();
>=20
> -        if ($smtp_encryption eq 'ssl') {
> +        if ($smtp_encryption eq 'ssl' || $smtp_encryption eq 'ssl/tls') {=

>            $smtp_server_port ||=3D 465; # ssmtp
>            require IO::Socket::SSL;
>=20
> @@ -1538,7 +1538,7 @@ sub send_message {
>                         Hello =3D> $smtp_domain,
>                         Debug =3D> $debug_net_smtp,
>                         Port =3D> $smtp_server_port);
> -            if ($smtp_encryption eq 'tls' && $smtp) {
> +            if (($smtp_encryption eq 'tls' || $smtp_encryption eq 'startt=
ls') && $smtp) {
>                if ($use_net_smtp_ssl) {
>                    $smtp->command('STARTTLS');
>                    $smtp->response();
> --=20
> 2.31.1
>=20

