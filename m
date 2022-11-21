Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64EC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 23:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiKUXik (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKUXie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 18:38:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BA132BAA
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:38:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k5so11766295pjo.5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/+HgYFERThCXUx0EmImdQO299cgoLMgrz2ICK9glc4=;
        b=Ias/DHQInAMhWnE4pXD73Fdu+QZ9acsKZOU6J/YnuOB3IBOgSEKt8vAPjU0qTKFCJ7
         D3m2YsF0bRbwwKd7AUX9FzTytz7zY5CJ7OXJcaG/SS6GoLLqZV1PQADKmqx93baa/xao
         5sV3qkWlVuoqUmHvGJ4kE0zqkBXVMhlwDQyDQ+ZsDZZz0m6Qwa+8QRDbkd2Sv5zN1MrE
         QXFXMuCfvOSNBv+l+nnwMubi4Ro63tOCokMHcHPLdY23zeIiVJmDr1Dry0E3/u376aBJ
         u67APWjHtSnYYH+vMaKxg/0tD5Wi5FTgmcCCAUCewJ2oyEJHC+gYO2T+vUB4lTsrK6y+
         Gkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/+HgYFERThCXUx0EmImdQO299cgoLMgrz2ICK9glc4=;
        b=puzgDaQrL+hsdRxgh7ge1LCK3c0SC7xTyLz+u86gFit91Z09AWMlpi5O8ssVO6bKKi
         YAsU30hxQA1pUzhcyYWuicwojjzG+LoR5MivmLx9KzopgJ4aPC5xcgDBc3WPofVyICCy
         Mis7MD/7XdDjWolLBNzgDqkroeXG9sv4LLs4Yy2bgGO5NT/ya5Zv1ralEtMSVnr+GNEb
         MU4ZBKRvhtn6kztEZogFPrxexZxzK7NnfnmNLdD2Xgc9qBmbeenoPA1jCioZbnN2PUbo
         VDt0D2NQGXNgNh6fJeFUqh7CrmR9OEgCyaL8w2xEVfecWUKd77+l7rB9ma6rjaGvG4SQ
         QVRQ==
X-Gm-Message-State: ANoB5plFBo38tJQY2fzu73QrAqNzF8uk5uqowOr0lWedSv2hTA7IxCc9
        P2uENZqvlYTNNImSeOphDJM=
X-Google-Smtp-Source: AA0mqf6cghEvtjv//XC+QiIcZsVATPX267ORhdf1zHs7SraAx0gB6KN8cE6pXhEXehvxQglFU7xbWQ==
X-Received: by 2002:a17:902:e94e:b0:186:5613:becf with SMTP id b14-20020a170902e94e00b001865613becfmr1199890pll.46.1669073910349;
        Mon, 21 Nov 2022 15:38:30 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ei7-20020a17090ae54700b0021806f631ccsm8392142pjb.30.2022.11.21.15.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:38:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v3 1/2] git-jump: add an optional argument '--stdout'
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
        <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
        <ccfea26de333ac5a08a5df4c9b790811067bd437.1669033620.git.gitgitgadget@gmail.com>
        <Y3vFpNbWswu/8gjb@coredump.intra.peff.net>
Date:   Tue, 22 Nov 2022 08:38:29 +0900
In-Reply-To: <Y3vFpNbWswu/8gjb@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 21 Nov 2022 13:38:28 -0500")
Message-ID: <xmqq35abvpxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 21, 2022 at 12:26:59PM +0000, Yoichi Nakayama via GitGitGadget wrote:
>
>> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
>> 
>> It can be used with M-x grep on Emacs.
>
> Thanks, I like what this feature is doing overall, but I have some small
> nits about the implementation.
>
>> +You can use the optional argument '--stdout' to print the listing to
>> +standard output instead of feeding it to the editor. You can use the
>> +argument with M-x grep on Emacs:
>> +
>> +--------------------------------------------------
>> +# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
>> +Run grep (like this): git jump --stdout diff
>> +--------------------------------------------------
>
> This example confused me because it says "run grep", but then runs a
> diff jump. But maybe this is because it means to run the emacs grep
> command? I don't use emacs, so it may make more sense to somebody who
> does.

Yes.  "M-x" gives Emacs users a command line prompt to type (and tab
complete) an Emacs command, and in the above explanation, the user
is running the "grep" command of Emacs, which in turn prompts for a
shell command that produces series of <filename>:<lineno>:<cruft> to
jump around [*].

"M-x grep<RET>git jump --stdout diff<RET>" is what I would have
written on the second line instead of "Run grep (like this)...".

[Footnote]

* People often run "grep -n -r -e <pattern>" but you can run things
like "git grep -n -e <pattern> -- <pathspec>" and "find -name \*.h |
xargs grep -n -e <pattern>".
