Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B3C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9672B20702
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="fgj0MRnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGGGio (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGGio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:38:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE0C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:38:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t11so13145984pfq.11
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=jFLpruxM4G/5aA4+C/MLyB/JqDDY/VU1apJiBNUa+qc=;
        b=fgj0MRnbiLFWLKn0yVRE54mC3aCR++Evh5/h0dGau+PHNB/P8t2/MW8MKBsbaskrY5
         0bBZPN3W3Z7OLYVJU8TftvVHDphUtQWmGcDHg/DNekHG9bOX5Ur4Dn2YmuxYql2djtwS
         QnTbjTEbatqcLzzdDq3cHvHK8/HyL9aba/BlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=jFLpruxM4G/5aA4+C/MLyB/JqDDY/VU1apJiBNUa+qc=;
        b=fxrHID7cHhj6WtkyYJ99gTDvkcnix40eaHGQRrM2VrgSQtU6EOzXeVggKQjNfEfmNu
         PuUr6Cd24vxRsfB6tAhl5UJsw5HPnW9AD5ymDf6S2aCitKFfZiOTO6lVPmH9XUSI5cNK
         9KMhckDW+a4UBPyKia4fT+C4G7YulKWfHiUQEORp73ugbVTm72pMaZQrx6v+JDYyRp/T
         CLf7lzuLia0sLChHFJ73qGSOltt0cmybWuYy3LrZYHbq8GAfbT3fo7iME0W9+cZgqlK2
         UW7nLUk3sDL8MLY1izOLyUdVvD4Em+0zLvX3W8uAUb8abWjvpxxaeWainzOzlZTgl8ES
         GPyg==
X-Gm-Message-State: AOAM53063vf2isQzXPJe+om9g3/624OuywvvTaNcMk6Y6j8or37F/W7R
        lxy4uWnXUj0vL00ISn17Mbnp8QfwoY6G4TAk45j/XVfG5Sn94gYt18CU2jehgmW326HhIzotUyX
        AoZqD2qf/lgXC4wGUQyTGroOHWbVH1mkBOnZaavnCKoIU0Sv2Gg9ILLcSWQ==
X-Google-Smtp-Source: ABdhPJwO4/r21x3nl741u55qnvk7LrQKIMd8QDAD+K5c38AVWAL9neLKtj/N/GX81vrSln+p7iXESg==
X-Received: by 2002:a63:5461:: with SMTP id e33mr33465336pgm.321.1594103922520;
        Mon, 06 Jul 2020 23:38:42 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id v15sm21308917pgo.15.2020.07.06.23.38.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 23:38:41 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>  <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com> <xmqqd0577sei.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd0577sei.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v10] Support auto-merge for meld to follow the vim-diff behavior
Date:   Tue, 7 Jul 2020 14:38:37 +0800
Message-ID: <31ba101d65429$40d37300$c27a5900$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLuUIqG788ynUJZ7nl3TmDbGcenNAI7+pCTAgnZjF+mqYI80A==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

It seems our mails crossed. I'll read your comments in this mail and =
reply you later.

Lin

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Tuesday, July 7, 2020 14:26
To: sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org; sunlin <sunlin7@yahoo.com>; Lin Sun =
<lin.sun@zoom.us>
Subject: Re: [PATCH v10] Support auto-merge for meld to follow the =
vim-diff behavior

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		meld_use_auto_merge_option=3D$(git config =
mergetool.meld.useAutoMerge)
> +		case "$meld_use_auto_merge_option" in
> +		"")
> +			meld_use_auto_merge_option=3Dfalse
> +			;;

I somehow thought that I already pointed out that this is wrong, didn't =
I?  You cannot tell between a "[section] var" (which is
"true") and not having any "[section] var =3D val" (which I think you =
are trying to treat as "not configured---do not use") from the output of =
"git config section.var".

Perhaps our mails crossed?

> +		[Tt]ure|TRUE)
> +			meld_use_auto_merge_option=3Dtrue
> +			;;
> +		[Ff]alse|FALSE)
> +			meld_use_auto_merge_option=3Dfalse
> +			;;

These are probably premature optimizations.

> +		[Aa]uto|AUTO)

Sigh.  I somehow thought that I already said we shouldn't do this =
"aCCEpt AnY CaSES" unless all other variables that take 'auto' take it =
case insensitively.

> +			# testing the "--auto-merge" option only if config is "auto"
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--auto-merge"*)
> +				meld_use_auto_merge_option=3Dtrue
> +				;;
> +			*)
> +				meld_use_auto_merge_option=3Dfalse
> +				;;
> +			esac
> +			;;
> +		*)
> +			# try detect boolean for 'on'||'yes'||numberic value
> +			bool_value=3D$(git config --bool mergetool.meld.useAutoMerge =
2>/dev/null)
> +			if test -n "$bool_value"
> +			then
> +				meld_use_auto_merge_option=3D"$bool_value"
> +			else
> +				meld_use_auto_merge_option=3Dfalse

I think this case (i.e. set to a non-bool value, and we do not recognise =
because it is not 'auto') should be flagged as an error, instead of =
treated as a silent "do not use", as it would leave the user scratching =
his or her head without realizing that there is a typo in the =
configuration file.

> +			fi
> +			;;
> +		esac
>  	fi
>  }
>
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17

