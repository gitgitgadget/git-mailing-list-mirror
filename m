Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA783C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 17:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCMRbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCMRbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 13:31:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9996F495
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 10:31:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h8so13768984plf.10
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678728665;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OH7jXjiPdehZwunZVkccfhJtq2nqXwJsiJk/x83prXw=;
        b=ZsaYCr8kSB/PFfTWwBeV8dlnj5TuXDzznZ8JLCh5GivLhFDiVp97g8O06haanT0W7B
         VGC9xA9OfhyM2tX1eHSnwO7gXTuXEoynCYZFmwo6FOIoWN+WCNWWR5rrOD71f/R92baf
         +XqLFNGyjN8sZ+AmtMZSRG/FLUwtQ2C2WyldlpOSdoMljDQbsiyuvMlBsBFDNB3G8j6F
         0UTLLmq2dch1p23xcOCF51RgKRJP7WinmsKNEz9IQHLOvUC2CbHzjgFrO4oxte8Ehxx9
         xjKlpeaUxgf1WuT/udPQdrHh+hE26DCIWtxO7utcd+jNeklgPGokKW9QQ8ruwTGkiC6m
         QH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678728665;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OH7jXjiPdehZwunZVkccfhJtq2nqXwJsiJk/x83prXw=;
        b=mVlfzncA43m06RCLm/GuNA+im1y+ElgcZdwEoZY+LtUS1KAbDhZ++Ap9fmdZ7s2K4T
         0y05y/Cv/jyYGNxzXG2j4rqpZkhj4RQjNTkFt0fVlxPEOmivY4U/Be7BCxUGaDUvrQg6
         OyHi4Gk8uK4q1Wwgj1yVk5L2ZxJR6ZHys6E3zBfcFl0B/WfIDIvFbIjOPFA0tbSpE6Uv
         ohncav5kMwJedubiL7shpYLYj4U64j0v6qbubIlWAdEJ+eQjvlvEugST4tCPQ+F9iLJ1
         +iZiHSDgOOgkqrnU/KikL8Djk6Rmprj1Ai1CTBYuaabd1JMDUWxrfn3xT/NfAvRjxFiw
         3Zxw==
X-Gm-Message-State: AO0yUKXcNZcFkEeiHdTf4SNsRgevhd4sicRfan2RESbDYBj5QXKKlJKV
        VxM4cxlBSS61WJ2fT6EWXkg=
X-Google-Smtp-Source: AK7set9OSdperPEPLjkTdK09KxiBKfv0J8xWlRE2466JqNi/c8npkiMIB/5AQMxor7ozSLzKeCppfA==
X-Received: by 2002:a17:90b:1b4e:b0:233:ee67:8eb3 with SMTP id nv14-20020a17090b1b4e00b00233ee678eb3mr36047868pjb.24.1678728665477;
        Mon, 13 Mar 2023 10:31:05 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b0019a773419a6sm141886plb.170.2023.03.13.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:31:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
        <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
        <xmqq5yb9q42e.fsf@gitster.g>
        <ZAr7+zW+pkOXoIfL@coredump.intra.peff.net>
        <xmqqcz5g7d2i.fsf@gitster.g>
        <ZA9SmZaUyrgbH2fb@coredump.intra.peff.net>
Date:   Mon, 13 Mar 2023 10:31:04 -0700
In-Reply-To: <ZA9SmZaUyrgbH2fb@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 13 Mar 2023 12:43:05 -0400")
Message-ID: <xmqqpm9cv9rb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> By the way, we might also want something like this:
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index dd31d5ab91e..5b7b908b66b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -661,7 +661,7 @@ static int run_am(struct rebase_options *opts)
>  	format_patch.git_cmd = 1;
>  	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
>  		     "--full-index", "--cherry-pick", "--right-only",
> -		     "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
> +		     "--default-prefix", "--no-renames",
>  		     "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
>  		     "--no-base", NULL);
>  	if (opts->git_format_patch_opt.len)
>
> which uses --src-prefix to (you may have guessed it!) counteract
> diff.noprefix in the user's config. (It would still be necessary even
> with my series because the user might have set format.patch).

Oh, you grepped around ;-)?  Good find.

Of course, nothing breaks without the above one-liner so it is
somewhere between a "Meh" and a "clean-up we should do before we
forget".

