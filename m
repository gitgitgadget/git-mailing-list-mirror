Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C5C1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDTWNj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:13:39 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36987 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeDTWNi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:13:38 -0400
Received: by mail-wr0-f193.google.com with SMTP id f14-v6so26498577wre.4
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 15:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XAn5ruR4YvMfgvFtU+gf0fBVSBuUyr1Hh3/nq7RN5I=;
        b=Yskuh+tt5WM8HlruIX+56mLT8enDOLi3DWbHriLYRFX5qpgkvZ3wpOdrRENKh3jflD
         /OltQzTXrgZOsacbKoNVRd5vci6MQw6zInwNSn4lG9rcu5a/mN2qokElUT73nqqubGln
         TVtLX/r7OynX9/c+4H+V1MCH13obOv511KWhpzf6k3VUqE5RBHAO6xlsFX0GYIGXqlyC
         m85q+8ZZ39RFuP8XQvHxSmMl0mVDZ4dSZXrj89CLRy+jNVPq1XZoTo6f5jqLLOhSzfN8
         UoSfViBgEbjvv/T2O6cbwzWIYlGAkBV7nZBuCa6mnwm5bLPCMsb2MFx99zLLB6IwbD7w
         IbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XAn5ruR4YvMfgvFtU+gf0fBVSBuUyr1Hh3/nq7RN5I=;
        b=FLExCh7M1YUNTVl5Ti4jxEV7lS5E877Os/bh2IMxeLOZFbqv8anGyoP5lRr/2qjxJs
         kPNZsVUrgd7jPGlCjhI2bYrppDc56K5hUvvlmS7L+XVAZ6t1cUmP8SSMWg+eruDAAeB9
         ZDvHgWi/iSFgzM9kSgsk5bDraZ8ZHvhepl9dU02pjdvwbJADEpjYorVaLu/IhLz8iHOb
         pNhFeMG8wHYtg6OHZc9igVrdyo3WYmuM5QinHQyy8g7j89j2d4eu4f6isvzRnLeU4QO2
         qdZg0HEYYIqG/fEP2tv6Gu+Sjt4yBARoAnnqfedx9W0Xwq4qt0BZdkvDSNwktJKpgTWp
         5omQ==
X-Gm-Message-State: ALQs6tBtCMOrGEYF962ZpGODUBka2dU2Q2+xoVpED0OoufvSxzyvw08j
        X/8VuLU58tpnAducaHfoWfXnv51Q
X-Google-Smtp-Source: AIpwx4/xbB5jVxLcKIg50P13/OG2MofoVOcdJr7fWOgY0ZrFHucVnr5ApIFQcZCOU7vzOaxi50bsTA==
X-Received: by 10.28.55.129 with SMTP id e123mr2859326wma.141.1524262417210;
        Fri, 20 Apr 2018 15:13:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p128sm3661840wmd.45.2018.04.20.15.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Apr 2018 15:13:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Isaac Chou <Isaac.Chou@microfocus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3] fast-export: fix regression skipping some merge-commits
Date:   Sat, 21 Apr 2018 00:12:31 +0200
Message-Id: <20180420221231.4131611-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

7199203937 (object_array: add and use `object_array_pop()`, 2017-09-23)
noted that the pattern `object = array.objects[--array.nr].item` could
be abstracted as `object = object_array_pop(&array)`.

Unfortunately, one of the conversions was horribly wrong. Between
grabbing the last object (i.e., peeking at it) and decreasing the object
count, the original code would sometimes return early. The updated code
on the other hand, will always pop the last element, then maybe do the
early return without doing anything with the object.

The end result is that merge commits where all the parents have still
not been exported will simply be dropped, meaning that they will be
completely missing from the exported data.

Re-add a commit when it is not yet time to handle it. An alternative
that was considered was to peek-then-pop. That carries some risk with it
since the peeking and poping need to act on the same object, in a
concerted fashion.

Add a test that would have caught this.

Reported-by: Isaac Chou <Isaac.Chou@microfocus.com>
Analyzed-by: Isaac Chou <Isaac.Chou@microfocus.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
This v3 is similar in spirit to v1/v2, but with a reworked test and a
different fix approach, both based on Dscho's suggestions.

>> Between you cleaning up the test and providing a different
>> implementation, there's not much left for me to take credit for. Can I
>> forge your From: and Signed-off-by: on this?
>
> I disagree, all I did was to play a variation of your tune. You are the
> composer of this patch, you performed all the hard work (analysis,
> implementation & testing), and you deserve the credit.

Ok.

> It would please my ego a bit, of course, if you could add a "Helped-by:
> Dscho" line... ;-)

That's a given! Again, thanks for really helpful suggestions.

Martin

 t/t9350-fast-export.sh | 18 ++++++++++++++++++
 builtin/fast-export.c  |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 866ddf6058..c699c88d00 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -540,4 +540,22 @@ test_expect_success 'when using -C, do not declare copy when source of copy is a
 	test_cmp expected actual
 '
 
+test_expect_success 'merge commit gets exported with --import-marks' '
+	test_create_repo merging &&
+	(
+		cd merging &&
+		test_commit initial &&
+		git checkout -b topic &&
+		test_commit on-topic &&
+		git checkout master &&
+		test_commit on-master &&
+		test_tick &&
+		git merge --no-ff -m Yeah topic &&
+
+		echo ":1 $(git rev-parse HEAD^^)" >marks &&
+		git fast-export --import-marks=marks master >out &&
+		grep Yeah out
+	)
+'
+
 test_done
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 27b2cc138e..7b8dfc5af1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -651,8 +651,11 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
 	struct commit *commit;
 	while (commits->nr) {
 		commit = (struct commit *)object_array_pop(commits);
-		if (has_unshown_parent(commit))
+		if (has_unshown_parent(commit)) {
+			/* Queue again, to be handled later */
+			add_object_array(&commit->object, NULL, commits);
 			return;
+		}
 		handle_commit(commit, revs, paths_of_changed_objects);
 	}
 }
-- 
2.17.0

