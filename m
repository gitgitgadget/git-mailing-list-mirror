Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBE6C64EC4
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjB1Xo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Xo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:44:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F1367E8
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:44:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id oj5so7573316pjb.5
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQLfpJ79+yWBTLSVxk8TB8Q8coakQgFCOkqbjTnRWP8=;
        b=MxTJNde6GpDVxccWbZwP2XSMT0KZwsFOKW+osvVwmoGL99osLy8ldhCZHhl3qrTZTh
         KWkJBOabKjoyRfAqu7zFGa+aT/jtkjwuHqQovGnBFB5lOal+OKIlqd7s5lHh01BQG/vL
         5ExjFP3ggWulFS4H/Qbww1HZJ573Lr7poYNDUn982YNRrD0Sj8V0EP7fj7kmIzr6WdKc
         O7Gr7LRx7bnDeFMo+QAo12JIIs/0g9l8vhThiXyGLjVXEmhNWBJIzB2Hg/SAp3js2h0r
         SIX/+HQs7P/J5ce+OyfT9gAJijTLKM//ByMU43hQdylUpZuOG8EX+t/r9Fvw8OFIAFIa
         JIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQLfpJ79+yWBTLSVxk8TB8Q8coakQgFCOkqbjTnRWP8=;
        b=MwlQjBI259bPih+0qerUEZSSFfXxmdwbqspmn5svGRK+yIXsoRKPuGc5PEUF2/MicC
         IwwWODaRUQ6CCw4aGKNAYf+cMsKWJOQwJE9kaIjgbT8pciytxe+Bzxt+2w5IxQn41LZz
         1dmt1gTQxpFQq6qelH2wKVQ0ScyrTYdHON/iVf/vYMpEKaWUWexquOgsFzcdQKW/6IDM
         AvtuA/FekVnvXazx9dfpW0BW9naXR3IPX/wegAQMNiWxekYcYKvEkP3bOaB6FCYUAcYM
         aYVoyTf6YpcWiZL7ZctrIxAFEPLbIIaRFokLT+NPMMACV0NatfwbVmm2U5Op1Y706zxh
         ZqzA==
X-Gm-Message-State: AO0yUKUwN8juOyp+ALxWYTkrELtthmN++PBRhiu+hZ03+k6jGhqarm63
        sCfWGG2X4GTqIFW0/HwFUL4=
X-Google-Smtp-Source: AK7set9KTKpAxlhFC2Gc9CMnn3d6Rp46yPpKHzp0VnkSLNcqfOH/v0ZTqYKMOi3dbCTMxHYPial0aA==
X-Received: by 2002:a17:90b:4d04:b0:234:d42:1628 with SMTP id mw4-20020a17090b4d0400b002340d421628mr4930074pjb.10.1677627895163;
        Tue, 28 Feb 2023 15:44:55 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090adb8100b002348bfd3799sm8448334pjv.39.2023.02.28.15.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:44:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH] range-diff: avoid compiler warning when char is unsigned
References: <20230220142444.18739-1-tenglong.tl@alibaba-inc.com>
        <20230220142444.18739-2-tenglong.tl@alibaba-inc.com>
        <1156586e-9dbe-335e-7e33-74eea7913e86@web.de>
Date:   Tue, 28 Feb 2023 15:44:54 -0800
In-Reply-To: <1156586e-9dbe-335e-7e33-74eea7913e86@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 28 Feb 2023 17:13:27 +0100")
Message-ID: <xmqqh6v5pd6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Since 2b15969f61 (range-diff: let '--abbrev' option takes effect,
> 2023-02-20), GCC 11.3 on Ubuntu 22.04 on aarch64 warns (and errors
> out if the make variable DEVELOPER is set):
>
> range-diff.c: In function ‘output_pair_header’:
> range-diff.c:388:20: error: comparison is always false due to limited range of data type [-Werror=type-limits]
>   388 |         if (abbrev < 0)
>       |                    ^
> cc1: all warnings being treated as errors
>
> That's because char is unsigned on that platform.  Use int instead, just
> like in struct diff_options, to copy the value faithfully.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  range-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Very clearly explained.  The patch does make sense.

Thanks.

> diff --git a/range-diff.c b/range-diff.c
> index 086365dffb..4bd65ab749 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -383,7 +383,7 @@ static void output_pair_header(struct diff_options *diffopt,
>  	const char *color_new = diff_get_color_opt(diffopt, DIFF_FILE_NEW);
>  	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
>  	const char *color;
> -	char abbrev = diffopt->abbrev;
> +	int abbrev = diffopt->abbrev;
>
>  	if (abbrev < 0)
>  		abbrev = DEFAULT_ABBREV;
> --
> 2.34.1
