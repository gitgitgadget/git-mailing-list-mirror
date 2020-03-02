Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE2C3F2D2
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74365246BB
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUPoUd9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgCBEnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:43:39 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40362 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCBEnj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 23:43:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id m2so8844947qka.7
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 20:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=I/GgvU1Ls/sGi3FZoaPTP3kL0y5BfG46XOWnHs+cqDY=;
        b=CUPoUd9OpceUk9OoCjeYz9aOfSP+pNIPzg6FooBmm1yyw6CHRYJIebxIkNyONZnwKv
         Pg8ndy4HTT9alKYKu4H+Ns4nOsh16v40F6or6pIJulfEQ05CKNZEU9q3uaO7EVancQC8
         CrIHP2ZoWh/+LHCOtm/63LR2HLPJw4HsPXLYuhY8FpdaYNsraCEFsty4V3YOB+WoR1rx
         NaSokIpELau/VKA73/B4CdojhB+cPVoyNFABwcF6iAowYqXpFYhskcURy/siHEDI5IHm
         IIw3MtNiISpJzRbprxgc6AQIkY2FCg1N+IZT5utO39DeLMxBeBWWtpBWe8vm+g5IqCU2
         9hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=I/GgvU1Ls/sGi3FZoaPTP3kL0y5BfG46XOWnHs+cqDY=;
        b=k1MyVhn1/1luAwZjpV9yg+Egj708sL0nuWTRqeVehUwaC3EVxzMx7u2Em0g1aboJFL
         wmaxEMxnco0MTo1nCV2ELDTnJKtI5caRahCOpJ8Piteqh7kokCB91MVfhcGSx7xytwy5
         KJ+NTC5jbzwHCdZp3s+HzB6sRWl+WJM5rObu8Gzqu7K5heh2B3Cl7HEteJECYZdLRDsl
         UPG/DqhlIBXkHcC0hE09A8MfWoztkpkKmKEeKMdoL1dM08ZnletFQoie7wfLV6ys66GX
         3wTSsYBGXj2DlhagYVD46brbzkFTZV9zN56b7VTh91labOC2d5X6so7rRpMQDWyLQSAL
         D96w==
X-Gm-Message-State: APjAAAV6BvxMgE/5qalEE4geWZomcN2bDJKvxS19/x7jDeEfkge+S1Oc
        UgH0uyrL9tonKTuaUrbNG4I=
X-Google-Smtp-Source: APXvYqwPptAz1Yyw/JZCFpfE2yGjIYHibzvNnrAQjKWr45lAWZVfbRahXCKiVOk1IinWH4ws54rU/g==
X-Received: by 2002:a05:620a:16b8:: with SMTP id s24mr14635869qkj.104.1583124218447;
        Sun, 01 Mar 2020 20:43:38 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id s3sm5750168qtq.19.2020.03.01.20.43.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Mar 2020 20:43:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/4] doc: list all commands affected by recurse.submodule
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200228103558.1684937-2-damien.olivier.robert+git@gmail.com>
Date:   Sun, 1 Mar 2020 23:43:35 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C13DF7D-2999-4C91-882F-B899CEBD7C29@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200228103558.1684937-2-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>,
        git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI Damien,

The commit title has the option name reversed: it=E2=80=99s =
submodule.recurse and not recurse.submodule

> Le 28 f=C3=A9vr. 2020 =C3=A0 05:35, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Note that `ls-files` is not affected, even though it has a
> `--recurse-submodules` option, so list it as an exception too.

Good find.

>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/config/submodule.txt | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

I=E2=80=99d also add the same list to the "Implementation details" =
section of the gitsubmodules guide [1], which just mentions `checkout`
at the moment.

[1] https://git-scm.com/docs/gitsubmodules#_implementation_details

>=20
> diff --git a/Documentation/config/submodule.txt =
b/Documentation/config/submodule.txt
> index b33177151c..5962f41ead 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -59,8 +59,9 @@ submodule.active::
>=20
> submodule.recurse::
> 	Specifies if commands recurse into submodules by default. This
> -	applies to all commands that have a `--recurse-submodules` =
option,
> -	except `clone`.
> +	applies to all commands that have a `--recurse-submodules` =
option
> +	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, =
`reset`,
> +	`restore` and `switch`) except `clone` and `ls-files`.
> 	Defaults to false.
>=20
> submodule.fetchJobs::
> --=20
> Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)
>=20

