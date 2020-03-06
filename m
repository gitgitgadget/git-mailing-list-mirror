Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A467CC3F2D9
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7962020728
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctza2Jkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCFEQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:16:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41068 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgCFEQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 23:16:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so830114qtr.8
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 20:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cJOh3oagnXOhvirKP5grT3wpFokKXhGMr7kcylPSHiw=;
        b=ctza2JkxW/tAT8h5jG9RJ7z/hk+c0C1kdM7MOFx2pykfNWrmnk4zeaWmUDwXcT072K
         IsXMlYs9fZEUuFAlCi0Nxv9A1UiZbQyMiprV0b28LHRpBm22owY/qnBX6GNjd8Or3rvo
         HSIJtJ3NCopGLNQY2OFJT9yftyy67AEcIbYR/AU6VbN+VWHH1gtk8k8At22hIUNzEkFx
         tJufYC/d6zlla3cIKBxA9cCeUGZQsJ4gIZQ24CVi1cE1MvABSWosYY2cEYerheyIPnVd
         Tl1ZdvuSFoj7MYNbZfj6I1AZ0U3b3yzuxqEzifOvrgS3RlgN4iLEE77332PN6jnXKK6R
         2FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cJOh3oagnXOhvirKP5grT3wpFokKXhGMr7kcylPSHiw=;
        b=kk03ksv5GrFoFlTmo6AAihJfZBuWt65B16D9BaehBgnb88Df4P/+enSjh3Wo3QyvHb
         XHreSNXv1Si6QZKdToEEMy9xFpM8nJqyZZ5AAxnw+1N9xSMuQNXq2Qh3DkQ6g5ORAFoN
         oNF0mAzvu66krOKSA0ut6YBoGyyFml+ByEF1itGikwz0jC0awzFtOWu+etVqaIXw09S1
         vBy+inH9poSPEG4lDTSj7QnR1O2jWliDTcz8dKohBwm83+mMCUZEcg3any8uw3LOY0cX
         OAlfYronqhrrqu329TL07UXhwaaYclDifTXnA3bfQaa/bjUvNYIecdKrbFaOXJjLAoEB
         lEfg==
X-Gm-Message-State: ANhLgQ0Vs4zOudj8k8oExo62Rllwiy9lBfXecnSyxBccOuEE79obQGMw
        2mghsSnl8BPHvP6bbweqdKfkqYkZ
X-Google-Smtp-Source: ADFU+vvDWN1XydZr9DhIigkO90FAqIEELqROoEb1373dr/tN2cOO9DjHp4fhFAFbXoycqdUu5xiETw==
X-Received: by 2002:ac8:2b8f:: with SMTP id m15mr1367417qtm.30.1583468207113;
        Thu, 05 Mar 2020 20:16:47 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m26sm4821787qtf.63.2020.03.05.20.16.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 20:16:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 2/5] doc: document --recurse-submodules for reset and restore
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200303170740.1879432-3-damien.olivier.robert+git@gmail.com>
Date:   Thu, 5 Mar 2020 23:16:45 -0500
Cc:     git <git@vger.kernel.org>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CED2197-7BFF-45DC-94D2-5CFDA7A70EFF@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com> <20200303170740.1879432-3-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 3 mars 2020 =C3=A0 12:07, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/git-reset.txt   |  6 ++++++
> Documentation/git-restore.txt | 10 ++++++++++
> 2 files changed, 16 insertions(+)
>=20
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 932080c55d..838c0f1101 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -87,6 +87,12 @@ but carries forward unmerged index entries.
> 	different between `<commit>` and `HEAD`.
> 	If a file that is different between `<commit>` and `HEAD` has =
local
> 	changes, reset is aborted.
> +
> +--[no-]recurse-submodules::
> +	When the working tree is updated, using --recurse-submodules =
will
> +	also recursively reset the content of all active submodules
> +	according to the commit recorded in the superproject, also =
setting
> +	the submodules HEAD to be detached at that commit.
> =E2=80=94

Maybe "working tree" instead of "content" ?

>=20
> See "Reset, restore and revert" in linkgit:git[1] for the differences
> diff --git a/Documentation/git-restore.txt =
b/Documentation/git-restore.txt
> index 5bf60d4943..5036f91132 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -107,6 +107,16 @@ in linkgit:git-checkout[1] for details.
> 	patterns and unconditionally restores any files in
> 	`<pathspec>`.
>=20
> +--recurse-submodules::
> +--no-recurse-submodules::
> +	If `<pathspec>` names a submodule and the restore location =
includes
> +	the working tree, the submodule will only be updated if this =
option
> +	is given, in which case it's working tree will be restored to =
the
> +	commit recorded in the superproject, and it's local =
modifications
> +	overwritten. If nothing (or `--no-recurse-submodules`) is used,
> +	the work trees of submodules will not be updated. Just like
> +	linkgit:git-checkout[1], this will detach `HEAD` of the =
submodule.
> +

both "it's" should be "its". In fact I'd personally prefer "any local =
modifications" instead of "its local modifications"=
