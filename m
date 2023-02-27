Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448AC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 20:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjB0UH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 15:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjB0UHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 15:07:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBFB2914B
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 12:07:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so12142460pjn.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wei25lxJ1TUz75+ycVLSoBOvy3zqn8JhPimMlT22cZ4=;
        b=XCiJ+rjPwZHoxy5uZrKJTn3X8UMaJdrcGnXpLZDS1cA22ueGEG/ScRc4h/wf3BYMqz
         jhJDpKtsSoOclFGjZjJ/LJe+7U9h5r7aQ+6pKoAYL+3rloxsZotyUpwCOdBwNejzsHqu
         dYuEJiXRoYyPSJ4Z32okYpmFDzUbxdR9s2gAmxsGH2JzJM/93oeP5GM1UKPPQ76tc5VE
         tOEMnMuq2XEoq1j3KrfWpm3Hq9U/dQa9i63fNiBCvUPHXFpIo5SlCKmGH7DeGS0IMQGN
         Zg1aefpCBIkGeZWH2kL6M7nDG47vkgTwKXJxyAeEWSqrq5K99euaMtkpnBGRRU3YgR3B
         UW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wei25lxJ1TUz75+ycVLSoBOvy3zqn8JhPimMlT22cZ4=;
        b=TEC9DYs+iNrmVn8bG64fFm+9aiAv+qUlF4uloFBOetXBwlcx1at4JMiwxAKqdegsM2
         LNU3tEdcJIRee4yR6Nz9d+d3iQii2Ax+VNYfuatg6upKiHpAs+OkMTzvztx1WBcOn2H4
         So29ChMguHKGi8eusiAcVOWSmgyN2lB+tqC6nx5zU9CdMEOC+8nuBl+qhSI8//evJryh
         jUswn6dl7Cz/xPouP1CYjtgbujA5DLfyCMaurpachO9DApALozO5Z44CcOgrZnrnhDxx
         HEHcJBcTMhvrzNG/fFniIO7FjuBJcJeBYs3FwgqnsAtLA7CHfWQGrmlpQCR2Xm3lQ93I
         wTVw==
X-Gm-Message-State: AO0yUKWOVw9jnhoNoCYC8Llfx9t7+bo1kAvsZMkEk79iCMbHBAq4oc6l
        l5Cuusj6PEUd6Grshqnq5mLT/EqkaMA=
X-Google-Smtp-Source: AK7set80NHOxOT5zlRnjM/5t4oWhYxzonLpucYMxF7T6Nt+OKyxXaSS2pb9+ob0a6Xksbw9zp9WBQw==
X-Received: by 2002:a17:90b:1804:b0:234:8950:6d1f with SMTP id lw4-20020a17090b180400b0023489506d1fmr504655pjb.11.1677528434101;
        Mon, 27 Feb 2023 12:07:14 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id l20-20020a639854000000b0050301521335sm4325295pgo.11.2023.02.27.12.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 12:07:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/5] wildmatch: use char instead of uchar
References: <20230226115021.1681834-1-masahiroy@kernel.org>
        <20230226115021.1681834-5-masahiroy@kernel.org>
Date:   Mon, 27 Feb 2023 12:07:13 -0800
In-Reply-To: <20230226115021.1681834-5-masahiroy@kernel.org> (Masahiro
        Yamada's message of "Sun, 26 Feb 2023 20:50:20 +0900")
Message-ID: <xmqqh6v6swi6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> GIT has its own implementations, so the behavior is clear.
>
> In fact, commit 4546738b58a0 ("Unlocalized isspace and friends")
> says one of the motivations is "we want the right signed behaviour".
>
> sane_istest() casts the given character to (unsigned char) anyway
> before sane_ctype[] table lookup, so dowild() can use 'char'.

Use of values taken from a char/uchar in sane_istest() is designed
to be safe, and between using char*/uchar* to scan pieces of memory
would not make much difference, so changes like ...

>  		case '*':
>  			if (*++p == '*') {
> -				const uchar *prev_p = p - 2;
> +				const char *prev_p = p - 2;

... this is safe, and so is ...

> -				const char *slash = strchr((char*)text, '/');
> +				const char *slash = strchr(text, '/');

... this.

But does the comparison between t_ch_upper and prev_ch behave the
same with and without this patch?

> -						uchar t_ch_upper = toupper(t_ch);
> +						char t_ch_upper = toupper(t_ch);
>  						if (t_ch_upper <= p_ch && t_ch_upper >= prev_ch)

Here t_ch is already known to pass islower(), so t_ch_upper would be
within a reasonable range and "char" should be able to store it
safely without its value wrapping around to negative.  Do we have a
similar guarantee on prev_ch, or can it be more than 128, which
would have caused the original to say "t_ch_upper is smaller than
prev_ch" but now because prev_ch can wrap around to a negative
value, leading the conditional to behave differently, or something?

>  							matched = 1;
>  					}
>  					p_ch = 0; /* This makes "prev_ch" get set to 0. */
>  				} else if (p_ch == '[' && p[1] == ':') {
> -					const uchar *s;
> +					const char *s;
>  					int i;
>  					for (s = p += 2; (p_ch = *p) && p_ch != ']'; p++) {} /*SHARED ITERATOR*/
>  					if (!p_ch)
> @@ -237,5 +235,5 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  /* Match the "pattern" against the "text" string. */
>  int wildmatch(const char *pattern, const char *text, unsigned int flags)
>  {
> -	return dowild((const uchar*)pattern, (const uchar*)text, flags);
> +	return dowild(pattern, text, flags);
>  }
