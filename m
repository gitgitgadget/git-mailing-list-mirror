Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DD4C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 22:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0124C206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 22:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvzkL5Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfL3WwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 17:52:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39201 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfL3WwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 17:52:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so26026295lfb.6
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 14:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4sqqC2sEXvTUmB6HuPWr1hxkmS0LKVL0Aa0liDgNpnk=;
        b=FvzkL5AgtKrF6hkO4nOvdUzq3rC6svIdCMrcnEdG0QPACfr63v/4A4k/bmuWjzjRjf
         XoKIrmhGPV97R3DSOk0RFXURNqXlKUt5NsihqBjQOD3b2FxSibyUg0XFAp7G/4KuqMUN
         83x/ITq8PRrI0FrcTtU3BQaKJUe1KFENaWByC8Vv66RAL4hfBrMR/KPh0YvUuxu5Kut9
         +haUoYJW4tBT3zOY7wZZcBG3OmgU3sYjkJnvf4fwCUi5xY2J6EbQtS4rXzo5Sd/V0mYq
         IZ0zjdBvSWWRRN/v4McRkLi6QLG3oxXcLJ9H0aHYAP6arX+/MV0eIMXfelUEgvwB5xxX
         MHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=4sqqC2sEXvTUmB6HuPWr1hxkmS0LKVL0Aa0liDgNpnk=;
        b=gQ7R3xXF0DTaYPt7OT+59Su+UnhkJTUpsn3dWoKobsfJewo0d7vkO1m48lqZd0y51I
         MZw8+gSF7peiYJ0LfRt0yYI6qisoXC3j6GBGbD4POMTyVtMQAYDGwy/HCwtYlqx83iTQ
         i3gHBub+8oTamM0JG0sgly8pkrEktPYz/m3xV06HsbcIfM9cPn76OkVz5KnbHULB0KD0
         pDhWp7Y+SMZ/zsBq8peFi8D6vTryM3QLA5FUejOs+heIU4sUOXcXHTSqNuaW4D2gTR2p
         TRARaAeRQj37oWjZtjHZw3SNW2qFZ6oWtr7jM3Iiv4Rw2d0WL7PyKM2RwG4LELiYEluJ
         r2WQ==
X-Gm-Message-State: APjAAAWUlOJSJLjFDRApctz/Z+EL/InIIE/5SGKZKSC36plUzpYHoyMC
        FcjbsO3ayUxIF56Q6CA1E3TfLy4QbL4=
X-Google-Smtp-Source: APXvYqy1ZK3+Y0ChpdqRrgUv76Ij+BlLyY3VPSGU0K+4u2bkvijqJwTJht5ZlsySlUL4cD/DVHwM+g==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr39817183lfm.140.1577746329362;
        Mon, 30 Dec 2019 14:52:09 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id a15sm13098183ljn.50.2019.12.30.14.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 14:52:08 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 16/16] t4124: let sed open its own files
References: <cover.1577454401.git.liu.denton@gmail.com>
        <54315fecfe373d8020f2172b9b43e02c0dae137d.1577454401.git.liu.denton@gmail.com>
Date:   Mon, 30 Dec 2019 23:52:06 +0100
In-Reply-To: <54315fecfe373d8020f2172b9b43e02c0dae137d.1577454401.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 27 Dec 2019 08:47:25 -0500")
Message-ID: <868smt2zqh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In one case, we were using a redirection operator to feed input into
> sed. However, since sed is capable of opening its own files, make sed
> open its own files instead of redirecting input into it.

Could you please write in the commit message what advantages does this
change bring?

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t4124-apply-ws-rule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 21a4adc73a..2b19ef9811 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -42,7 +42,7 @@ apply_patch () {
>  		shift
>  	fi &&
>  	>target &&
> -	sed -e "s|\([ab]\)/file|\1/target|" <patch |
> +	sed -e "s|\([ab]\)/file|\1/target|" patch |
>  	$should_fail git apply "$@"
>  }

--=20
Jakub Nar=C4=99bski
