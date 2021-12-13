Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD6C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhLMGcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhLMGcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:03 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94570C06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:02 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id k21so17344753ioh.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kI8fkABdM70wgQK17c7ffmtqSac2r0ZWGOzSGY/4HbU=;
        b=Gkk2lJK+qKwQ642qh1Ur3Y6T21ui2gQ931W9omL2Jnl8VLuNIelQobP1XfFb/o2G5n
         Em9vOZsgeZm348heYYcCKoGP92eOWXwbpaKeqD1Vmb1iwml6HqMeEBT8tFAAIu1rYwB+
         7VLumQd+rI8oxTtryxC8OKUbC8yzBBRt3UeXVn/43o8txfT5lTdu6NSCuoAXzTEzD/Qf
         h6TZhiERCGG9/NyWrFQqzf96ET49V8/JnUl2rs47rT+Cl40XvvFu11XC5IlUJInf0x6h
         LmxgrqleCFQk/d1/jbUEIqYeW2HUc5CgSUMq0X+7leZnA7AQks98VWLDqvJ2ME6Rc2H0
         Y4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kI8fkABdM70wgQK17c7ffmtqSac2r0ZWGOzSGY/4HbU=;
        b=TcomrruLWWu1grtcyQs8o4sSOnVI+e0CTn4LVR5wpN1LD2kkNr517rE5mLvJqE+9R4
         wO5b/86EdUwCESxs5CoyyVFLl1urGIa+RmGGOlqxiJ/u625ao7qgWDxO770QBlrKJ2aW
         +u+1TGirdW2axaRym/7wpC9W81a7IEZO/kuqKhZrGeqX9tUW06KpBf+fp6CYA4pGrOvH
         J9wdM4IyhMDlf6l6WCOVx1iG2TuqPJtLPXbJqx6xNF6abqAFB41gGk3+7AI2zLbURt4J
         pw4WZ+fyENbdTRxfaGrmB3TgCt+2x5FS53rqtk3Vg9ZvnHxqe0dHJGEJKVSG1vYrHCFZ
         hUXg==
X-Gm-Message-State: AOAM531x41GPRA4/6y0ZzmhIyiOjpXORT9v5iJWf5X9JfMLSKJ2/Wb/T
        Nagn56C1U+A8KVfnHHhd7De1c+5PvP7OVQ==
X-Google-Smtp-Source: ABdhPJy2OCyR9GWouQ7Ho5BnjQv812QlMllp7GqFs9DAgguzrCCE0kB+AmnKcqBnfFDyf74ZlXu1yw==
X-Received: by 2002:a05:6638:12d6:: with SMTP id v22mr31165435jas.6.1639377121848;
        Sun, 12 Dec 2021 22:32:01 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:01 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Date:   Mon, 13 Dec 2021 01:30:49 -0500
Message-Id: <20211213063059.19424-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than running `chainlint` and `diff` once per self-test -- which
may become expensive as more tests are added -- instead run `chainlint`
a single time over all tests bodies collectively and compare the result
to the collective "expected" output.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 882d26eee3..f4ae40be46 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -71,12 +71,10 @@ clean-chainlint:
 
 check-chainlint:
 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
-	err=0 && \
-	for i in $(CHAINLINTTESTS); do \
-		$(CHAINLINT) <chainlint/$$i.test | \
-		sed -e '/^# LINT: /d' >'$(CHAINLINTTMP_SQ)'/$$i.actual && \
-		diff -u chainlint/$$i.expect '$(CHAINLINTTMP_SQ)'/$$i.actual || err=1; \
-	done && exit $$err
+	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
+	cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
+	$(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual && \
+	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
-- 
2.34.1.397.gfae76fe5da

