Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE0C8B4D4
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC4020855
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOyDsuFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKPMhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKPMhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:37:54 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D53C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 04:37:54 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id m16so3666174edr.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=HP/d+/6SCkfQR0NKDOhZi3R0/ZUDGD0hDVA4Ltdvb6Q=;
        b=FOyDsuFDYUVUHoBmhMlbZY+yD+rdIVZfPu5qSSI0ZnecJd2KXSV1ZADIZA9/zjilHr
         R60MUk08v2A7TwkXQp0QA6dxMmLOmq+2Bryy7Qe+1eviRKlsXH+usPm6qucKzs8iKYeI
         mjr162ggLKdk51gzQZAorpsLXp2jQaNYs4cAmkDS3GxEXrlBfC1qA3gf7y6zh1bYilBA
         6tpjuJ1WB782gM5YatZehN9ssOqV+QqECzj2v5VpI6W8byL0moTpsLf0sGzWX3l/85gu
         pa7Pyl0Kmp/M213VkN2NmKpUMuKE2TKNiAceLLJ3HDOOHI5MXOTl++7/UoLGcy3Xwuo7
         1xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=HP/d+/6SCkfQR0NKDOhZi3R0/ZUDGD0hDVA4Ltdvb6Q=;
        b=o5ucVDttViDoBbC9iZ/twU5DERE4lRTpkLvDEwZKHbCJwA5SdxtI+DgUEBtWLAB/LW
         /v4b98PSMJX5qAG+UZkcnPisn626jx2OWhjAIpbXaqb1R33TrhGTW1eZpqw4ImxvtKH5
         r0V4lRC74lpRq6bxpIPZw7d+JGGfzN6nZUuL3JfUIUL0z096Sv9ZTcdz8a8uPkkDGBnT
         ItmMbrKDrd7E2csIjHWMf9nTwZJccfcVmniAFQUTwblU1F1HsS/qVQkg9+33MhLPBAJg
         py7M+G/2sJeMjx1w8XXDfEDtaW8erp5n4E1KiQfz4GUdp16Mq4Uctb4Z0zILAkMlpNMh
         4AJQ==
X-Gm-Message-State: AOAM531PC3ViwhWTLJBum6liBe1Wny9K7eT3VrIU9EsYhQ+eimLbHL3O
        54zs9G1zCO1ThnfBg66RA6UDz30qykg=
X-Google-Smtp-Source: ABdhPJyqlGHENPF2x7+a31b94qnKdGcsmMHNwx0hJDuAme46R1MKUjJrZulUy4fJ6rcOon60jUHvhA==
X-Received: by 2002:a50:f604:: with SMTP id c4mr15080813edn.117.1605530272673;
        Mon, 16 Nov 2020 04:37:52 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id 22sm10378639ejw.27.2020.11.16.04.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 04:37:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Adam Spiers <git@adamspiers.org>
Cc:     git mailing list <git@vger.kernel.org>
Subject: Re: git-log: documenting pathspec usage
References: <20201116122230.eyizwe2bmqkmftch@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201116122230.eyizwe2bmqkmftch@gmail.com>
Date:   Mon, 16 Nov 2020 13:37:50 +0100
Message-ID: <878sb1fpep.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 16 2020, Adam Spiers wrote:

> Hi all,
>
> I just noticed that git-log.txt has: 
>
>     SYNOPSIS
>     --------
>     [verse]
>     'git log' [<options>] [<revision range>] [[--] <path>...]
>
> and builtin/log.c has: 
>
>     static const char * const builtin_log_usage[] = {
>             N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
>
> IIUC, the references to <path> should actually be <pathspec> instead,
> as seen with other pathspec-supporting commands such as git add/rm
> whose man pages are extra helpful in explicitly calling out how
> pathspecs can be used, e.g.:
>
>     OPTIONS
>     -------
>     <pathspec>...::
>             Files to add content from.  Fileglobs (e.g. `*.c`) can
>             be given to add all matching files.  Also a
>             leading directory name (e.g. `dir` to add `dir/file1`
>             and `dir/file2`) can be given to update the index to
>             match the current state of the directory as a whole (e.g.
>             specifying `dir` will record not just a file `dir/file1`
>             modified in the working tree, a file `dir/file2` added to
>             the working tree, but also a file `dir/file3` removed from
>             the working tree). Note that older versions of Git used
>             to ignore removed files; use `--no-all` option if you want
>             to add modified or new files but ignore removed ones.
>     +
>     For more details about the <pathspec> syntax, see the 'pathspec' entry
>     in linkgit:gitglossary[7].
>
> Would it be fair to say the git-log usage syntax and man page should
> be updated to match?  If so perhaps I can volunteer for that.

It seems like a good idea to make these consistent, if you're feeling
more ambitious than just git-log's manpage then:
    
    $ git grep '<pathspec>' -- Documentation/git-*.txt|wc -l
    54
    $ git grep '<path>' -- Documentation/git-*.txt|wc -l
    161

Most/all of these should probably be changed to one or the other.

I've also long wanted (but haven't come up with a patch for) that part
of gitglossary to be ripped out into its own manual page,
e.g. "gitpathspec(5)". And if possible for "PATTERN FORMAT" in
"gitignore" to be unified with that/other docs that describe how our
wildmatch.c works.

There's also the "Conditional includes" section in git-config(1) that
repeats some of that, and probably other stuff I'm forgetting
#leftoverbits.
