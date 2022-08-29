Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E14ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 07:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiH2H5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiH2H4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 03:56:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF051404
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 00:56:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso13838415pjk.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=+r5UPrKwTKl4RRwqwDK1dT1NqykkK9m6ToNVEHUUNXE=;
        b=U4vGAM0pIxzye3RphoNMmRM5a5EGLtkYMogmKInGNWcZss20sunv8dVYA0gawpZ4B3
         5A7l+AtozQc6cfuA0XLu1dITAwItQRWbM5QjBpuXDhDfCDjFeicX9jPGE3r9OgN5wvQ4
         dtzHZq+PD3lrYM88SD8hVpHUx6j4KMj5dmyM6CGLJjLtveSqhyGl3fE0QKoAh37LRN4+
         NrfO/5h66G/LvDDg/Zl8uFQvF3LeGkBEE27yF+kf00tOGmTOKBHheNYzaFSUyGD2vMUh
         Qj3KHUwe+lhKOoKo9/DK4/md9W6BflnbsPU1LoySrypHNMMfPL9KygzFUCAfrvSdTOr7
         L//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=+r5UPrKwTKl4RRwqwDK1dT1NqykkK9m6ToNVEHUUNXE=;
        b=ss86RoDOwggNwWGeicGxLpe30rOJHRoSsntxhwVplzmGq2ev8Obr5mJhSZNEXPNcOt
         lj8+sE83UsUNRqfpd/vF3oajERlH0FYSYvAcg8eGavlOVY3rKXo6M1LEz/1RmDHHG40l
         Naz1JwaVKAezHeEsdIqA6vT73iVnjKxRV3WsceOJ8M8kiOeVwpXhPoLnXzGHS1HF2KSC
         JfxxAk/mxoiXNLyOdCwWwWSGTfGubENY09Czg40IRZsb5TpPBmDQzczZnnRHOW901jiz
         tZRdx6Sz6CEDseGmstYe1Ara4z9DNNbKI4Hi3Vd9imUNrnp3FEFfRJaEGV0TlMAN0jju
         Aajw==
X-Gm-Message-State: ACgBeo0VhWntIuVhZoBxQtP0nZjoRnR0gCwHF/7MDFFbhmZS9/KSp6RL
        wt7HIKLfVls+TRkex4fxz9Qldn+R6PE=
X-Google-Smtp-Source: AA6agR4kdFFMofzUNLBF8tAxZPcWNQo28dab61lvOZ2N72lylhkNEa0AEd+IdE6Fr2ubDwdDgoILHA==
X-Received: by 2002:a17:902:b68f:b0:173:188f:5fa1 with SMTP id c15-20020a170902b68f00b00173188f5fa1mr14992608pls.155.1661759784148;
        Mon, 29 Aug 2022 00:56:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001749f37e50fsm2793966plg.185.2022.08.29.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 00:56:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/4] add -p: gracefully ignore unparseable hunk
 headers in colored diffs
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <b07f85a035954bb9145a0fe034e6f17aeb128f52.1661376112.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 00:56:23 -0700
Message-ID: <xmqqbks3qy8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..f2fffe1af02 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -357,16 +357,13 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
>  	eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
>  	if (!eol)
>  		eol = s->colored.buf + s->colored.len;
> -	p = memmem(line, eol - line, "@@ -", 4);
> -	if (!p)
> -		return error(_("could not parse colored hunk header '%.*s'"),
> -			     (int)(eol - line), line);
> -	p = memmem(p + 4, eol - p - 4, " @@", 3);
> -	if (!p)
> -		return error(_("could not parse colored hunk header '%.*s'"),
> -			     (int)(eol - line), line);
>  	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
> -	header->colored_extra_start = p + 3 - s->colored.buf;
> +	p = memmem(line, eol - line, "@@ -", 4);
> +	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
> +		header->colored_extra_start = p + 3 - s->colored.buf;
> +	else
> +		/* could not parse colored hunk header, showing nothing */
> +		header->colored_extra_start = hunk->colored_start;
>  	header->colored_extra_end = hunk->colored_start;

OK.  We keep two copies s->plain and s->colored of the line in the
patch, and the real information on the hunk header has already been
parsed out of the "plain" version.

Here, w want to find the end of "@@ -<range>, +<range> @@"" on the
colored variant, presumably because that is where the "funcname"
may appear and more useful pieces of information can be gleaned.

The original code assumed that we should be able to find such a
place (after all, we successfully parsed the "corresponding" plain
version to find it) and threw an error otherwise.  Otherwise,

 * hunk->colored_start is set to the beginning of the next line.

 * header->colored_extra_start is set to the byte after the " @@",
   i.e. where the "funcname" ought to begin.

 * header->colored_extra_end is set to the beginning of the next
   line (i.e. "funcname" is the remainder of the line starting at
   "colored_extra_start").

The new code loosens the requirement that colored one has the same
hunk header on the line (presumably prefixed by some color codes).
When the colored line does not look like a hunk header and we cannot
tell where the "funcname" part begins, we can pretend that the entire
line was just the hunk header without "funcname" part by setting the
extra_start and extra_end both at the end of the line.

There is nothing "structurally" important on the "funcname" part, so
presumably we will only use the information to show to the display
and nothing else, so I think this is perfectly OK to do.

Another obvious possibility is to show everything on that
unparseable line.  We know it corresponds to the hunk header in the
"real" patch (i.e. s->plain), and it may have something human can
understand.  Perhaps that may be changed in the later part of this
series (I haven't looked, but if that happens "showing nothing"
comment needs to be updated).

So far, looking good.

