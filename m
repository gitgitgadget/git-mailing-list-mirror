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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA187C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16F061378
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhFNRbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:31:45 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:42608 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhFNRbo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:31:44 -0400
Received: by mail-ej1-f49.google.com with SMTP id k25so17940100eja.9
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaTgvwGC5gjhJ+1yxPA5/bJv9SfrZUUN9KcSdzn3RLI=;
        b=rJzvAfK1g6nkOTFYiOpxq/F60DOFsrM4IzKXYfUw4jiTkhtVoQrdUTzvSJ53oAiySv
         jCnn54AnOJDLI/a3XCxhgCczTb7NqbvRqeOgibNCr7jVyUwcYoOEhErudFLyyEl9wsUM
         i/ygtYsdWqj8aUydIpXyI47QnsjvdR+8heIviBOkzg03KMI9dKjBHs4cuoZwDls65OLa
         qbS0RGVZd7r6lebqL1n2uQKVMJqWdRjSML/QuWVecAtLiz7VqoGpGSHOJJhhhxUL74Q4
         qRjR6h3/M7dz4mqkPvmp3Sq3OAB2xWzavs2d8mkWxiWQUn1vg1JnB2jsS3mHdL1lJMTt
         sE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaTgvwGC5gjhJ+1yxPA5/bJv9SfrZUUN9KcSdzn3RLI=;
        b=Ej4DUIg9AyQuXfzCX3ijmlPnPHUrBHTbv28BI8MN6c3smgk4RwnJtqOhGuxP2JZ7m8
         UsB8ESWGEqbN3qGgbzdbj36JXXIPsn4oew4d61uIxgsrGwtOXHMeY6ltxy00z9kbW0YW
         3CrLv8CEBg2LyS3VEhltqVw9AVtl85TZ3U4fiBQvWH/PIMHB/j/55VnDjudM8U3uvL6H
         0Oe32gN1qr6zgXqnv8dECPqwlkwn76jTQg1awYiw04qmrQkSKKKwtFGLKXQgoG60dToK
         xHZQ3iD+8EKYM8EulxhooLJbZx3ierhDVLRzQpiKCO+/9qB4hDkqDu98v0/akxqvMVMi
         WvGg==
X-Gm-Message-State: AOAM533bA2++AF5L7JiS9EDbzG1UqfNhrgLJW30m8us55luh9jaf9l/c
        wJAyuz0eSxJ/fvyC6NT1lortig2KoK9tDg==
X-Google-Smtp-Source: ABdhPJwtzxswpFjGh2pePyOvpD4haRAGgAI5czxGvJxDduMC4ZySJVJgteHgQPRlkDtBeowpSSfOQw==
X-Received: by 2002:a17:906:6d51:: with SMTP id a17mr16485060ejt.543.1623691706167;
        Mon, 14 Jun 2021 10:28:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm9376233edt.96.2021.06.14.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:28:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] mktag tests: test more exhaustively
Date:   Mon, 14 Jun 2021 19:28:17 +0200
Message-Id: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] I suggested that we could catch the segfault fixed in
c6854508808 (ref-filter: fix NULL check for parse object failure,
2021-04-01) (and possibly other future bugs) my extending the mktag
tests.

Junio wanted the more isolated bug fix first[2], which is fair
enough. But now that the dust has settled I figured I'd submit this
test-only series which stresses mktag, fsck and various commands that
might deal with the broken objects the mktag tests creates.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqeefs4dge.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (6):
  mktag tests: parse out options in helper
  mktag tests: invert --no-strict test
  mktag tests: test hash-object --literally and unreachable fsck
  mktag tests: test update-ref and reachable fsck
  mktag tests: test for-each-ref
  mktag tests: test fast-export

 t/t3800-mktag.sh | 112 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 15 deletions(-)

-- 
2.32.0.555.g0268d380f7b

