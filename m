Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DF6C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 13:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBJNLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 08:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBJNLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 08:11:33 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A497C23877
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:11:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gr7so15723350ejb.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh6E1Ue6slwknTiW8TC+RdfSKz8QU/DFvwrebRrgcD0=;
        b=J7tN1Ad97OPqkQwd3F1+wDTA/D3PcXFsGWOkFlvV98Xk6aranX1nTqlWODdof/aB/W
         BkXx29Q334Nol/ysxdDCevE7Lw6jzndRHBmlWKtQjsIzYhy4OsStQ/DPwh3+SBFxkm5y
         I71IXqlrmV6lc7Z0ZNOWtrsxclQu3oDJ6g5R7fa+TLadKM8FrZbkXVTEhL7PayvTH3G4
         qEdoT/GFVwE6gUEp3VUuW597BtKVowM7yEbA7EHrggzP1CxefGzy1aGenw8h6TsqyDKg
         V+fOh0zRBJg070a/YWS6l5DkYMWqq2H5EiP5RWJ7fdkEVKpu2VETlBcrDUdKL423+qS1
         sPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh6E1Ue6slwknTiW8TC+RdfSKz8QU/DFvwrebRrgcD0=;
        b=TlBBh+c5MqtmQ5140xn06ZXrrbzVguAiXS/FZ93YTLghQH6I6CYEhkn6wFHsvC2TpU
         kHh8/VjAJ40jCir2LgmSWDCuaGOCpQe0RxoC/EQVfHxbdOYkWYNMhoqt34DtT2s5EYuI
         XfloH9U5SdUmWWWASbI9XqXqxpociQgqUbBQdG+HgT88IbolMU8Wx5VCCaE7O560WTuF
         4zpNF+Rh2hqJm6zvdDdVQUNBgXEP/t+VfY+cafDrEc56osBKCEJKws1NVCJ4Zqh+Y7Re
         Zvx/mm/Cdpza475EXQLCzCHuVTxojdTx+HAR3heg/9wmqPX+qBQiyMwQiKUEp5IskJPa
         rg5g==
X-Gm-Message-State: AO0yUKUwxmA7iDbljBfOYpiXviTab8LLIDG0xRq7MdLlMZPS9LAz40uj
        Lzy7av+NhBcjw9AIxWf6Ev8=
X-Google-Smtp-Source: AK7set+NHhXjtRbsuFCpa+jY6tYXA5l+xn1AzbNsWghKYMMcFI4nMhnza9iUhCdWKfNfcLLMrLk4kA==
X-Received: by 2002:a17:906:1e8f:b0:870:baa6:6762 with SMTP id e15-20020a1709061e8f00b00870baa66762mr14684236ejj.14.1676034690122;
        Fri, 10 Feb 2023 05:11:30 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id i10-20020a1709063c4a00b008af21450420sm2369132ejg.85.2023.02.10.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:11:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQTBY-001vSZ-38;
        Fri, 10 Feb 2023 14:11:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/5] wildmatch: use char instead of uchar
Date:   Fri, 10 Feb 2023 14:09:34 +0100
References: <20230210075939.44949-1-masahiroy@kernel.org>
 <20230210075939.44949-5-masahiroy@kernel.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230210075939.44949-5-masahiroy@kernel.org>
Message-ID: <230210.86a61lwtq7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 10 2023, Masahiro Yamada wrote:

> dowild() casts (char *) and (uchar *) back-and-forth, which is
> ugly.
>
> This file was imported from rsync, which started to use (unsigned char)
> since the following commit:
>
>  | commit e11c42511903adc6d27cf1671cc76fa711ea37e5
>  | Author: Wayne Davison <wayned@samba.org>
>  | Date:   Sun Jul 6 04:33:54 2003 +0000
>  |
>  |     - Added [:class:] handling to the character-class code.
>  |     - Use explicit unsigned characters for proper set checks.
>  |     - Made the character-class code honor backslash escapes.
>  |     - Accept '^' as a class-negation character in addition to '!'.
>
> Perhaps, it was needed because rsync relies on is*() from <ctypes.h>.
>
> GIT has its own implementations, so the behavior is clear.
>
> In fact, commit 4546738b58a0 ("Unlocalized isspace and friends")
> says one of the motivations is "we want the right signed behaviour".
>
> sane_istest() casts the given character to (unsigned char) anyway
> before sane_ctype[] table lookup, so dowild() can use 'char'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  wildmatch.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/wildmatch.c b/wildmatch.c
> index 93800b8eac..7dffd783cb 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -12,21 +12,19 @@
>  #include "cache.h"
>  #include "wildmatch.h"
>  
> -typedef unsigned char uchar;
> -
>  #define CC_EQ(class, len, litmatch) ((len) == sizeof (litmatch)-1 \
>  				    && *(class) == *(litmatch) \
> -				    && strncmp((char*)class, litmatch, len) == 0)
> +				    && strncmp(class, litmatch, len) == 0)
>  
>  /* Match pattern "p" against "text" */
> -static int dowild(const uchar *p, const uchar *text, unsigned int flags)
> +static int dowild(const char *p, const char *text, unsigned int flags)
>  {
> -	uchar p_ch;
> -	const uchar *pattern = p;
> +	char p_ch;
> +	const char *pattern = p;
>  
>  	for ( ; (p_ch = *p) != '\0'; text++, p++) {
>  		int matched, match_slash, negated;
> -		uchar t_ch, prev_ch;
> +		char t_ch, prev_ch;
>  		if ((t_ch = *text) == '\0' && p_ch != '*')
>  			return WM_ABORT_ALL;
>  		if ((flags & WM_CASEFOLD) && isupper(t_ch))
> @@ -50,7 +48,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  			continue;
>  		case '*':
>  			if (*++p == '*') {
> -				const uchar *prev_p = p - 2;
> +				const char *prev_p = p - 2;
>  				while (*++p == '*') {}
>  				if (!(flags & WM_PATHNAME))
>  					/* without WM_PATHNAME, '*' == '**' */
> @@ -90,10 +88,10 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  				 * with WM_PATHNAME matches the next
>  				 * directory
>  				 */
> -				const char *slash = strchr((char*)text, '/');
> +				const char *slash = strchr(text, '/');
>  				if (!slash)
>  					return WM_NOMATCH;
> -				text = (const uchar*)slash;
> +				text = slash;
>  				/* the slash is consumed by the top-level for loop */
>  				break;
>  			}
> @@ -160,13 +158,13 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  					if (t_ch <= p_ch && t_ch >= prev_ch)
>  						matched = 1;
>  					else if ((flags & WM_CASEFOLD) && islower(t_ch)) {
> -						uchar t_ch_upper = toupper(t_ch);
> +						char t_ch_upper = toupper(t_ch);
>  						if (t_ch_upper <= p_ch && t_ch_upper >= prev_ch)
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

This looks good to me. I independently wrote much the same a while ago
for another reason, in: https://github.com/avar/git/commit/079f555375a

I.e. this happens to be the only bit in-tree that's stopping us from
running the xlc compiler in the c99 mode.

My solution was different, but I like yours better. I had not done your
analysis to discover that we didn't need this to be unsigned in the
first place, I merly converted the "uchar" to an "unsigned char".

