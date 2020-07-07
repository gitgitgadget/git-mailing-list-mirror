Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA7CC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986A020675
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="f5JrcPoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgGGGoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGGoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:44:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627DC061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:44:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a14so13436742pfi.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=PBBI5V+/rw8gyDC3JZRUDjBKIi/c1rR0sI44GnInC4Q=;
        b=f5JrcPocA7S49NWQogzg/wHS69W1TXUjTh2yc6Tf4ltJLRMMltLM/ra/v13LZhud6z
         mRlkIB+2616T8q0uTkCH6LZP6qZMT3lzg1IKPxSPjsqq1gkwv+31SKniTXEY8VTezeJx
         uVq2QpyyXoOUnlUs/DImyo1/j+6CR2Na/UgeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=PBBI5V+/rw8gyDC3JZRUDjBKIi/c1rR0sI44GnInC4Q=;
        b=kDAMJwnPGN67Aaic+pwQPKUBNJow4xF+1SZVQqDZtYkfbjCpAewJ2ipz2jaKktqkSn
         yt/vFb32y23LvVIfS7nsbcw/W6eakk/5jzuAU/nvgjVcE7B+SKY68F5ezRejz7x+a/9K
         mGM0VpldpE0Oflri9nvzUJDUOVyod4pojyOMss5nlRPcgEImqZYQdHDj5KYdWQj+sooU
         mkIR/s/FYpseYBSkuM/eBIkmwE45xubtOmKbB4zDBjRVZ1NecU7wnpO6cUSrB8Oun3Nz
         JnepeBN4s4s9OQsEx0BzVFYlt2xcnuELJ+NvbR9gr4QURVbwpIBp1md0TevgzPC2XO5n
         Beiw==
X-Gm-Message-State: AOAM530QWZpBqdzde92nAbEK/qaYZtipIIVYZjxr4DTAnJyyflojTzKY
        Cq/q4tCPhpWb9DZaZnnyyax2HGPM7jgBU4sTJlRsqmcYnWD84JJw/UOvqYRguoOZugOdeka7qUi
        vz38DpJyB0wiUa8iuiFpos4cMiAylKsFqwke+OZQcUKC/Y9Im9rZKEqi5SA==
X-Google-Smtp-Source: ABdhPJwn8d5e1WWREM5/Q4P2N8Sfl2sV8Cpkal6cUKkUmDjGI/u1ufSkChAe8sIdolRCKs0wZb75CQ==
X-Received: by 2002:a62:794e:: with SMTP id u75mr34265675pfc.298.1594104246593;
        Mon, 06 Jul 2020 23:44:06 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id n137sm21664442pfd.194.2020.07.06.23.44.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 23:44:05 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>  <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com> <xmqqd0577sei.fsf@gitster.c.googlers.com> <31ba101d65429$40d37300$c27a5900$@zoom.us>
In-Reply-To: <31ba101d65429$40d37300$c27a5900$@zoom.us>
Subject: RE: [PATCH v10] Support auto-merge for meld to follow the vim-diff behavior
Date:   Tue, 7 Jul 2020 14:44:01 +0800
Message-ID: <31ba201d6542a$01c510a0$054f31e0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLuUIqG788ynUJZ7nl3TmDbGcenNAI7+pCTAgnZjF8CAcWDr6aZdeFw
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I got your points now, I will upload another patch soon.
Thank you.

Regards
Lin

-----Original Message-----
From: lin.sun@zoom.us <lin.sun@zoom.us>=20
Sent: Tuesday, July 7, 2020 14:39
To: 'Junio C Hamano' <gitster@pobox.com>; 'sunlin via GitGitGadget' =
<gitgitgadget@gmail.com>
Cc: git@vger.kernel.org; 'sunlin' <sunlin7@yahoo.com>
Subject: RE: [PATCH v10] Support auto-merge for meld to follow the =
vim-diff behavior

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


