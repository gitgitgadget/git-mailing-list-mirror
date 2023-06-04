Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88195C77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 04:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjFDEcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 00:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFDEcI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 00:32:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D471B4
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 21:32:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b01d912924so34022705ad.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2023 21:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685853126; x=1688445126;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pez8WWyacFgiC2+O52WlNsuPDqapKOI1vprq6SkmlvM=;
        b=KohPiXANN9+C6GmUYjMJZWY1QDJ+BiSB+bHcuu7MRaxMjZEsLTA8G94Nnj9qnD/N8u
         Qnn4IiQo368dxH8gwV8dmw+Kt1ZjgXgglJNhT4Gy0EJqZkG4J2kbqoI3USb9rU9VWxJb
         sG9L+sFfat+Ut9Bhwwqnz7cjoR+bUNPa4J8+YC2WFYhwT/DwYbzRaS1Z8NZ5WILiqWfF
         ety3vIAX09VHCVJ9341J9Uxk1VVBgIDGDlTkeJChSPnFls3+hiip+lr8SIpQNGrKEvCz
         Kfklaf09G+gBQUs5+8dOgXsO/6NPIKscgKz6C565avoIfna/o6V/FivypdcH9y98yrML
         aCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685853126; x=1688445126;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pez8WWyacFgiC2+O52WlNsuPDqapKOI1vprq6SkmlvM=;
        b=OUZY7jSChfCrZQ6DPCUzr7whyaS04b7xL8smkJOTMTAWAQpYPOUjyoOgDL1Z8bXV1p
         5C6H6bgszfm11nfBeVhlGJF7R5TRS9AwSFsblmo3AXfz8NBn5qP6JAtVJQx5wfo43ydg
         aY4POZGcdGUUgmenldCEHPt3E48R5vL/ljehJVJVWb9nUF20Ha+z785IlxUi5874GEAZ
         7tzoYaqkgaYjfo02kNseFL216vmvqb0Q9++KKaDZvnNpuuoLzDwzYBM5QOqKbzbxGgvp
         g52Q1fmQGHi5bywzrkUMElYF7vbS1GiEXkVd2wv6gvZU1M3jGhZ+nGZ+JomsBgroBO67
         umKg==
X-Gm-Message-State: AC+VfDymMTztLOYtqtRAp0k0fejq6j4f5fV6G8phpbO/wUDJ26JL7LE6
        RAsZQCep2jZUMW3iPEJSCwjQQfBigY4Ofg==
X-Google-Smtp-Source: ACHHUZ4HkfKov6RXUenOJ5bdVrDg2XjQevSF9wCjPs3fivY0+9v6VsJvnZ4HUgl3nXnmiV49hFUvkQ==
X-Received: by 2002:a17:902:ce90:b0:1b1:a829:e2b5 with SMTP id f16-20020a170902ce9000b001b1a829e2b5mr4894408plg.52.1685853126371;
        Sat, 03 Jun 2023 21:32:06 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001a060007fcbsm3966247plk.213.2023.06.03.21.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 21:32:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH v2] cherry-pick: use trailer instead of free-text for `-x`
References: <pull.1519.git.git.1685815011553.gitgitgadget@gmail.com>
        <pull.1519.v2.git.git.1685816463240.gitgitgadget@gmail.com>
Date:   Sun, 04 Jun 2023 13:32:05 +0900
In-Reply-To: <pull.1519.v2.git.git.1685816463240.gitgitgadget@gmail.com> (Sean
        Allred via GitGitGadget's message of "Sat, 03 Jun 2023 18:21:03
        +0000")
Message-ID: <xmqqfs776e62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Allred <allred.sean@gmail.com>
>
> When recording the origin commit during a cherry-pick, the current label
> used is not understood by git-interpret-trailers. Standardize onto the
> 'normal' trailer format that can be reasonably/reliably parsed and used
> by external tooling leveraging git-interpret-trailers.

I am somewhat negative on going in this direction, as we originally
added these "cherry-picked-from" by default, but stopped doing so
for a reason [*1*].  I'd be hesitant to see us spend any engineering
resources on a feature we discourage (not even to deprecate and to
remove).  It is a different story if we change the previous stance
on the "cherry-picked-from" information, though.

I admit I've suggested "Cherry-picked-from:" long time ago [*2*], as
an aside in a discussion, but the discussion was more about treating
the line as a very distinct thing that is different from any other
"trailer" lines.  The last time this was brought up, I thought that
it was deemed unnecessary because interpret-trailer code already
understood by the trailer code [*3*], and we _could_ teach the
interpret-trailer code to rewrite it to "Cherry-picked-from:".  Any
renewed efforts should build on the discussion there, addressing
points raised during the discussion, I think.

Thanks.

[Footnotes and references]

*1* Unlike "revert", "cherry-pick" is done from an unrelated and
    often not even published history, and referring to such a commit
    that the end-user cannot do "git show" does not add much value
    to the history.

*2* https://lore.kernel.org/git/xmqqtwcycqul.fsf@gitster.mtv.corp.google.com/
*3* https://lore.kernel.org/git/20181106221118.GA9975@sigill.intra.peff.net/
