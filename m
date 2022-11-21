Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAD0C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 05:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKUFnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 00:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKUFnx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 00:43:53 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437A24BD4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:43:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f9so5997513pgf.7
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LF20kOxZEP9up71DTfxLEBEcHZDiPqV5Q7s5PkLRNlU=;
        b=h5W56I7IFJdlDhpNfyJJW2vlVRCDd2hcrJ/XPqJbygn4cFReI56if7id8jlFa1luOU
         CPJH4mv1Ch1Tl9UjfHyqWRqwW/kl2anUDq9LnxPldfjYio/XPlqsp4NvsAl9mZMWnlMx
         BFYMwMKF2wquU5My4kQ727L4o1C5CxrhQDJ4NerfPN/o9UAUbjS/Euu/M8cD3N7qXDEi
         K4UVDBJ7Hv/5g7LKe+QV4zZFN2kiSfoCz8B0X/j//LxulD9Lrt8cWuBDPHUCv10A/aRw
         6dLXigdALsXF1h3nAnlD9znOIV46xv6t5U4b9UHDx+bvSpszFRRE4A/bB09/tt/6fjqn
         eVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LF20kOxZEP9up71DTfxLEBEcHZDiPqV5Q7s5PkLRNlU=;
        b=2SfRZkvUy6CwJ55r2/M4oh6JUVZ69rfWHlMjPiXJwWz1D1VvJnY/CW8qOQ/JnoXyRl
         1soCqw87veGffJVPYMP7KxKDpKNgONwr7vHzC59aqqpPwMkonIYP4vCcfGpmGsahHUWa
         NgpX421E8by9bvqy1sgLbBDm8IN0akW3lWTpOuxu+tSb/DOSNKATVj27/kV0rDosVM20
         38tw/gePQJt3y3q50XldFgWQka56SLwrhStr9Czmdnia/eZdFizNHdQXyO4wiV5PlOvW
         5Jr0NMGQGQG387WnqBFLI+ayamn1q6Qpo1dLuxpPYk0P/mjJMZqtrbz9TjrFvNyDWsKn
         BKuw==
X-Gm-Message-State: ANoB5plXI6EzA/TwSi5xoJYSj7He5qNMVzIr0Uid51muF182G9cgweZ4
        Fa/7spm0U3kP3RJc0lzVodU=
X-Google-Smtp-Source: AA0mqf7igobetRDGwkTNxrgY/MOlvIZb2/J+gVC+AogzRUBa7bfEOo5FV0li77DLNvFv3Fz7ygvOaw==
X-Received: by 2002:a63:f5a:0:b0:43c:428d:1701 with SMTP id 26-20020a630f5a000000b0043c428d1701mr6073136pgp.307.1669009432313;
        Sun, 20 Nov 2022 21:43:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c30-20020a056a00009e00b0056b3c863950sm7724735pfj.8.2022.11.20.21.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:43:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2 1/2] git-jump: add an optional argument 'stdout'
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
        <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
        <e56858a3eb212dcd0b8f71bdbf8db96f51c5d648.1668907644.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 14:43:51 +0900
In-Reply-To: <e56858a3eb212dcd0b8f71bdbf8db96f51c5d648.1668907644.git.gitgitgadget@gmail.com>
        (Yoichi Nakayama via GitGitGadget's message of "Sun, 20 Nov 2022
        01:27:23 +0000")
Message-ID: <xmqqedtwyi94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +You can use the optional argument 'stdout' to print the listing to
> +standard output. You can use it with M-x grep on Emacs.

It is unclear what happens when you do not give 'stdout' from the
above description.  You say 'stdout' is a way to tell the command
"to print the listing to standard output", but what is expected to
follow that sentence is left unsaid (i.e. "you can give 'stdout' to
print to stdout, INSTEAD OF DOING X").

Also, 

> +--------------------------------------------------
> +# In Emacs, M-x grep and invoke "git jump stdout <mode>"
> +Run grep (like this): git jump stdout diff

the command line structure of "git jump" being

    git jump <mode> [<args>]

where <mode> is one of 'diff', 'merge', 'grep', it somehow feels
very strange to insert an optional new word, that is not a dashed
option, before the <mode>.  "git jump --stdout diff" might be less
surprising, but I dunno.

But I think this is a good idea.  In fact, it almost feels that the
interface to produce the list of "$file:$line: <blah>" that this
"stdout" mode gives should have been in the command as the lowest
level basic primitive, upon which the feature to drive a specific
editor using such an output file should have been built, and the
current code is backwards in that sense.  Exposing that lower level
primitive directly is a welcome addition.


