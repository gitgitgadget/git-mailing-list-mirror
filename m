Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA2C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701F460EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhHKE5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhHKE5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:57:52 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FDC061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:29 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id s21-20020a4ae5550000b02902667598672bso355195oot.12
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61X2C4zwXoZEOmIp7H+BwanCCa6l53bBwYIVd7LACqo=;
        b=kXG9qmYRqOw3aUNUJJ47aWWCi/VX5udTLf8tjrohAKzqvwFDTInivMkB/aGHnijka2
         VhAvPtqA8N0ACKwX52fuxkwnT3OlnKa660ErIQPahCQI/oXadL2CRyJOD4xnyBGRXHBC
         HU3RAaOfsvrZiBO7rCgHrW3vNSC3NDLuYUuI3cxItl8AIGeZ0pZ1SGIAOnTyz8L5SzH8
         N5X2lkBrOF8WbHNgySCgKHTXdGBCPssgTAi8X2NLZjyR+kv2441JUdUbSoekMBvRN0bP
         wf5h8xOzpLLN/anuv/vS7oYppo5ZKGENNJg1I3jsGBZPkRdH0CA0Ln5Uo/MYDSisWYTs
         ij7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61X2C4zwXoZEOmIp7H+BwanCCa6l53bBwYIVd7LACqo=;
        b=TFQ/5HijEEWP9qF42tBMxCn8vvGYFBGzRVgdt+KriOAXGSCW9m98IUj8TWPW+FWxkr
         WIm8iS19vTxlxLJCMkFODDE39fQmQChwxqsStJ1pN0FkGs6EohFo5GL8KJjzEegQj31q
         GqElwD3szrJAD0ujGOu0b/fIzWl312MtmQVgBthzSue8oBKqan6fhvyk8BuLdhCcX4js
         ktbD2spu+LEiCIktCDyWPQ50s+N0sSpT5541d/VI5ZPnJLQqq1+u+msDzaJkpDQWAMjp
         NooZYdoAfEfjIxUl4ya62DeYsUo6oFQe4pwgUQbft2NtJMqdFh4sr5v2B4FOrBvZLTFl
         bzQg==
X-Gm-Message-State: AOAM532ccxquxY5bcQi6qwdajsdA4E1Hoch+XThUK36YMkJ9t2iul2aU
        gjSgeuP0LCsAeEx/Ass4G9OYbi3mrsbrzA==
X-Google-Smtp-Source: ABdhPJxCkqpyst0J4kcqxTwNB73P1XuS1j2Sz34GwFL3UoPjwdByAxsZ5hiRjwU5yNJ2Og/8p7FxHw==
X-Received: by 2002:a4a:cb8c:: with SMTP id y12mr2486368ooq.52.1628657848893;
        Tue, 10 Aug 2021 21:57:28 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id y12sm1953390oiv.55.2021.08.10.21.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/7] [un]stage: officially start moving to "staging area"
Date:   Tue, 10 Aug 2021 23:57:20 -0500
Message-Id: <20210811045727.2381-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the last 13 years of discussions virtually *everyone* has agreed that
the term "the index" is not a good approximation to how most users
perceive and utilize this feature. For a summary of the discssions see
my blog post [1].

This is particularly true of newcomers, which is why everyone that
teaches git uses the term "staging area".

Among all the proposals for a better name "staging area" is by far the
one with the most consensus.

Everyone except two people agreed that "the index" is not a good term.

All non-official documentation already uses the term "staging area" [2]
[3] [4], including what is considered by most people the best
documentation out there: the Pro Git book.

There is absolutely no reason not to start using the term "staging area"
officially.

Let's start by making the staging area a first-class citizen and making
'git stage' a prominent command, similar to 'git branch'. Additionally
add 'git unstage' too.

Only *one* person expressed discontent with the term "staging area".

In favor:

* Felipe Contreras
* Scott Chacon
* Jonathan Nieder
* Matthieu Moy
* Jeff King
* Miles Bader
* Ævar Arnfjörð Bjarmason
* Jay Soffian
* Pete Harlan
* Aghiles
* Piotr Krukowiecki
* Phil Hord
* Victor Engmark
* David (bouncingcats)
* Alexey Feldgendler
* Alexei Sholik
* Zbigniew Jędrzejewski-Szmek
* Sebastien Douche
* Thiago Farina
* Mark Lodato
* Philip Oakley
* William Swanson
* Ping Yin
* Hilco Wijbenga
* Lars Vogel
* David A. Wheeler

[1] https://felipec.wordpress.com/2021/08/10/git-staging-area-rename/
[2] https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository
[3] https://www.atlassian.com/git/tutorials/saving-changes
[4] https://coderefinery.github.io/git-intro/04-staging-area/

Felipe Contreras (7):
  stage: add proper 'stage' command
  stage: add helper to run commands
  stage: add 'add' subcommand
  stage: add 'remove' subcommand
  unstage: add 'unstage' command
  stage: add 'diff' subcommand
  stage: add 'edit' command

 Documentation/git-stage.txt            |  38 ++++++-
 Documentation/git-unstage.txt          |  25 +++++
 Makefile                               |   2 +-
 builtin.h                              |   2 +
 builtin/stage.c                        | 147 +++++++++++++++++++++++++
 contrib/completion/git-completion.bash |   5 +
 git.c                                  |   3 +-
 t/t3710-stage.sh                       |  51 +++++++++
 8 files changed, 267 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/git-unstage.txt
 create mode 100644 builtin/stage.c
 create mode 100755 t/t3710-stage.sh

-- 
2.32.0.48.g096519100f

