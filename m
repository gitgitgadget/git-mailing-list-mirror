Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DD2C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 19:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBKTsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 14:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBKTsV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 14:48:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D9EB54
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 11:48:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d8so8693255plr.10
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqspB92OfJQ75nrQDWwawLEKQ03k+yqWZgFSpK7wx5c=;
        b=Nr7+/D5QvDbIRmH/jckbmvQsi+HMu7zD8xsjd10/M724HELpVnTcUFj4aT1G0L6Fz7
         I+6paYwQ/liXl9fiQVyOzZWWSBe6zhGeTDbRrkQZiNrWf9Gi6lXMLFTJQQw3lSMtDsR3
         AHqF279xrfahCIFkx4C8DMtAv8b+o3KWnRx/ypuADuwe5/dA+bRPrxB1f6WJ6+UTt5bJ
         KjYpl8Fa2oI7RbSTi8LnkH3lZ8Yj8dyj30uliyyhAxxC8nmtI7fRUU7zbeiVuYjbEjN7
         kSjO4oxq0yuaW9sXOhhDTmEQU1V1TWzM8CgulX2H42i4Jv8gvWfYvtQMaXxR+iY3MQsB
         1t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqspB92OfJQ75nrQDWwawLEKQ03k+yqWZgFSpK7wx5c=;
        b=tjQONjY4GlFujcKjQmLHCdXVzVXc1G1aDfeWLsdnn20sbSN1hlrDmJtAqg0WywzEUT
         +GuAqijVAoNt3sqeU4GIPGE1EnQuL/PFT3kXn2MByhDov48R4rMHO7SIcd8LQ0ZFmBH0
         JrFMTbULDUXrg5P3GIZsjrqX4dQkS8fOHH25UNhOBQQ1BGxv0O6WHQN08lDnueSIX2+E
         Xf868yX3HRpd4x9gn+xgo/9YKmDsSTG6unTsTa+IHYESBI7pnjs4m0hcOi1d83P5y8xE
         cAml6/3uXepn+68tPhYH3IhKbHKJ1Lc1nccWigzmgbkRX+b99m9195ppwX+tsPNP1gf+
         /+tQ==
X-Gm-Message-State: AO0yUKUKF6PCF+p4NDE9VnEtVDngWMu2CCVwKXfYO6Hd7ISrv1QODDmo
        Eu3yzjZszs+xVeICloQ3Dbg=
X-Google-Smtp-Source: AK7set/FGLQ8wmidZfUCHzpQLY1LWgIK1Z/1hqgGuCzEgiTwq1FZpkIKFoZSGtgOhiXgkvq+vCauow==
X-Received: by 2002:a17:903:32ca:b0:19a:8398:3362 with SMTP id i10-20020a17090332ca00b0019a83983362mr3219856plr.13.1676144899518;
        Sat, 11 Feb 2023 11:48:19 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902a60600b00198fcb1b2c2sm5299576plq.218.2023.02.11.11.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 11:48:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 1/3] test-ctype: test isascii
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
        <21f316ab-714a-58f6-a8d2-466d738b4ed3@web.de>
Date:   Sat, 11 Feb 2023 11:48:18 -0800
In-Reply-To: <21f316ab-714a-58f6-a8d2-466d738b4ed3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 11 Feb 2023 14:12:49 +0100")
Message-ID: <xmqqr0uwdlvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Test the character classifier added by c2e9364a06 (cleanup: add
> isascii(), 2009-03-07).  It returns 1 for NUL as well, which requires
> special treatment, as our string-based tester can't find it with
> strcmp(3).  Allow NUL to be given as the first character in a class
> specification string.  This has the downside of no longer supporting
> the empty string, but that's OK since we are not interested in testing
> character classes with no members.

I wonder how effective a test we can have by checking a table we use
in production (i.e. ctype.c::sane_ctype[]) against another table we
use only for testing (i.e. string literals in test-ctype.c), but
that is not something new in this series.

I do not offhand know if the string literal prefixed with NUL is
safe against clever compilers; my gut feeling says it should
(i.e. allowing such an "optimization" does not seem to have much
merit), but my gut has been wrong many times in this area, so...

>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  t/helper/test-ctype.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
> index 92c4c2313e..caf586649f 100644
> --- a/t/helper/test-ctype.c
> +++ b/t/helper/test-ctype.c
> @@ -11,9 +11,14 @@ static void report_error(const char *class, int ch)
>
>  static int is_in(const char *s, int ch)
>  {
> -	/* We can't find NUL using strchr.  It's classless anyway. */
> +	/*
> +	 * We can't find NUL using strchr. Accept it as the first
> +	 * character in the spec -- there are no empty classes.
> +	 */
>  	if (ch == '\0')
> -		return 0;
> +		return ch == *s;
> +	if (*s == '\0')
> +		s++;
>  	return !!strchr(s, ch);
>  }
>
> @@ -28,6 +33,15 @@ static int is_in(const char *s, int ch)
>  #define DIGIT "0123456789"
>  #define LOWER "abcdefghijklmnopqrstuvwxyz"
>  #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +#define ASCII \
> +	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> +	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> +	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
> +	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
> +	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
> +	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
> +	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
> +	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
>
>  int cmd__ctype(int argc, const char **argv)
>  {
> @@ -38,6 +52,7 @@ int cmd__ctype(int argc, const char **argv)
>  	TEST_CLASS(is_glob_special, "*?[\\");
>  	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
>  	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
> +	TEST_CLASS(isascii, ASCII);
>
>  	return rc;
>  }
> --
> 2.39.1
