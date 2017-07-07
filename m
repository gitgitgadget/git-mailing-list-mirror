Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6647C20357
	for <e@80x24.org>; Fri,  7 Jul 2017 21:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbdGGVHk (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 17:07:40 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:32945 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdGGVHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 17:07:39 -0400
Received: by mail-ua0-f182.google.com with SMTP id w19so27486085uac.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DLwCopP9udGaMGlI1hOnGGc0oC5qOAaQeFnkzrZDDxM=;
        b=Y/wXEYhL67RNWcB1qj0hMSi0h7JEljhUV37QB7U9pzFMLxKS9BS7UDwCsbiT662nC5
         00dyeDl7oLF8b2ShyV5A+TLedR6yWwTJ75XACa7uErp9okrT8tNAgPz588HdDthdoxtg
         06hXHzzRR1gS3pY4tHldclZCT+iL/372kdLs9EmoCR3bYd+TldLnTiw+cTJG5IBz4bN1
         rTavP0YiZnAP49F4ORBDJcgLBO2y3W3DfFiwm8d3nZvL0liIi4Hl2Cgtf/3kS8nvi4yc
         yeDJvzNcOPjg5wqnXJ8egDWhtpP95lQF+yG6m6OXqzZYy6KRmuJSvkbM6Li0yxw1zAZh
         X2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DLwCopP9udGaMGlI1hOnGGc0oC5qOAaQeFnkzrZDDxM=;
        b=Tyx7XsnW01ze9QExGr+gq6IGZ2DKNYwRVQeGs5/co3S7tTSJbY62hvzmrrrDeZW27J
         ewcN2O8Sv1/1wcZexJMrymVqhDhcmLrUtWT4j+Cz/18z4yGGVU9gOcsj/f9FE8i5L4NY
         miQ5rGfcOkwo7a9/HEpIcPjG5kMol3dwqktJo3X0sJ/yOsYvJsGlapjwHs2eWO31fImI
         NrsXBlsrEbSQgEQWPPTV3ysj60SxVYom2qbU/utqwX32Jert6TKT+fDgjeQcpqT82fgC
         bdLrnoDUNqFWFClvKtk/lURCqQfSdPRZyfsPazET6gA1znmlWjphEgyu1LhyCsdUjfRc
         OCzg==
X-Gm-Message-State: AIVw110Oo9ryV5ecK/G+7K5o2mzO1SvjDv5+DL9TNLqCmFZdtCGmES45
        LpaEWaYGyScAvfXaUbO3cm2/orFk4A==
X-Received: by 10.159.48.156 with SMTP id j28mr1847199uab.42.1499461658531;
 Fri, 07 Jul 2017 14:07:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.91.2 with HTTP; Fri, 7 Jul 2017 14:07:18 -0700 (PDT)
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Fri, 7 Jul 2017 17:07:18 -0400
Message-ID: <CACPiFC+Lc+ewmPe6u=dUo4rJRcgLqRfG-EG+vudg8mapnH-d9w@mail.gmail.com>
Subject: Dropping a merge from history -- rebase or filter-branch or ...?
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git-folk!

long time no see! I'm trying to do one of those "actually, please
don't" things that turn out to be needed in the field.

I need to open our next "for release" development branch from our
master, but without a couple of disruptive feature branches, which
have been merged into master already. We develop in github, so I'll
call them Pull Requests (PRs) as gh does.

So I'd like to run a filter-branch or git-rebase --interactive
--preserve-merges that drops some PRs. Problem is, they don't work!

filter-branch --commit-filter is fantastic, and gives me all the
control I want... except that it will "skip the commit", but still use
the trees in the later commits, so the code changes brought in by
those commits I wanted to avoid will be there. I think the docs/help
that discuss  "skip commit" should have a big warning there!

rebase --interactive --preserve-merges  --keep-empty made a complete
hash of things. Nonsense conflicts all over on the merge commits; I
think it re-ran the merge without picking up the conflict resolutions
we had applied.

The changes we want to avoid are fairly localized -- a specific module
got refactored in 3 stages. The rest of the history should replay
cleanly. I don't want to delete the module.

My fallback is a manually constructed revert. While still an option, I
think it's better to have a clean stat without sizable feature-branch
reverts.

cheers,



m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
