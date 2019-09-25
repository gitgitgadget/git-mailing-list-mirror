Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927601F463
	for <e@80x24.org>; Wed, 25 Sep 2019 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411364AbfIYBkP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 21:40:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37950 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbfIYBkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 21:40:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so2262653pgi.5
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzKAdVEBv8q/JAjAnX30HMBM8oMKpklxXex4+Wui2dM=;
        b=sFgHzcNH2N97GufRvc28nOGHmGvXnh1R/6TXHGcqU2ecR2Flb/7Ae1POkSIL0SYFge
         6kPz2k1BvMYBE2lKMFZWq88nTUwzU0wKXBxcHMpPyCuHcZHu5ecmJhsfWMjxzhhd30MK
         ZlNjyFLqP1dswFsuDyWupcAWDMD7MdAqSzQkbf6xyRzdynQvZtfWAvba8TH/Hn6b+XYM
         NSuNLuGiSG3Kv1vVTl4HVZ0rspRBs+BhBkKUoxHFrfJxCTYV+2TOzxt1T5bkUk90+VGU
         i9dftEtfqOGK4MfDs5wp8o7BDEYQPQxeWaIJnbFpXFDdSa8GTBOgLWwFU+xWu+hQQ8dJ
         xzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzKAdVEBv8q/JAjAnX30HMBM8oMKpklxXex4+Wui2dM=;
        b=DfnpgsecU4GdwqRUY4LCx06cK793E6IJ/ZskG48Ur/FwBNnG00vy9Zrblj6vOKUMFy
         mRh95rsoyaU8umJQwoz1mHG59wxBtcOWjunMhd161BmbCJOY8eUUjFGP9WTwVWKaqR81
         K8izZiKugy4J5rcwsA2zJ+//+vcXCEVJbnf3/LEJqpyqsldP4y/F9cpMgaEWK/PvMiHX
         rnfbVoQEfkJyvnm163XbPKBj9oLVF3azJCMudXhBVZLxGU/PrMG7YLEBaxhtg3+iZLO2
         AUMRP/6aJ2yvR9PQnDxzAqLKhQJSxOPob1Bp03bCPGrJHweXrCtfEF3/o0Tz+A4/hnkt
         n2Pg==
X-Gm-Message-State: APjAAAXDZaH74JzykxVdmg+uUay2Q0JIc/QfVTfZ4r8EFML0EkOXG7PZ
        Pk9rWFqKH8WL4QZ9nlD8LMnFiyQP5JU=
X-Google-Smtp-Source: APXvYqzgAJPME6TXCOROwpk8vgqmoJKWb7P6viMOFt5eafzC3xxmgzlMGHaXGLbHZViFRpfUhmng2A==
X-Received: by 2002:a63:506:: with SMTP id 6mr2228017pgf.397.1569375613481;
        Tue, 24 Sep 2019 18:40:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h4sm3759050pgg.81.2019.09.24.18.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 18:40:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/8] fast-export: fix exporting a tag and nothing else
Date:   Tue, 24 Sep 2019 18:39:58 -0700
Message-Id: <20190925014005.17056-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.177.g8af0b3ca64
In-Reply-To: <20190925014005.17056-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export allows specifying revision ranges, which can be used to
export a tag without exporting the commit it tags.  fast-export handled
this rather poorly: it would emit a "from :0" directive.  Since marks
start at 1 and increase, this means it refers to an unknown commit and
fast-import will choke on the input.

When we are unable to look up a mark for the object being tagged, use a
"from $HASH" directive instead to fix this problem.

Note that this is quite similar to the behavior fast-export exhibits
with commits and parents when --reference-excluded-parents is passed
along with an excluded commit range.  For tags of excluded commits we do
not require the --reference-excluded-parents flag because we always have
to tag something.  By contrast, when dealing with commits, pruning a
parent is always a viable option, so we need the flag to specify that
parent pruning is not wanted.  (It is slightly weird that
--reference-excluded-parents isn't the default with a separate
--prune-excluded-parents flag, but backward compatibility concerns
resulted in the current defaults.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  |  7 ++++++-
 t/t9350-fast-export.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f541f55d33..5822271c6b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -860,7 +860,12 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (starts_with(name, "refs/tags/"))
 		name += 10;
-	printf("tag %s\nfrom :%d\n", name, tagged_mark);
+	printf("tag %s\n", name);
+	if (tagged_mark)
+		printf("from :%d\n", tagged_mark);
+	else
+		printf("from %s\n", oid_to_hex(&tagged->oid));
+
 	if (show_original_ids)
 		printf("original-oid %s\n", oid_to_hex(&tag->object.oid));
 	printf("%.*s%sdata %d\n%.*s\n",
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b4004e05c2..d32ff41859 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -53,6 +53,19 @@ test_expect_success 'fast-export | fast-import' '
 
 '
 
+test_expect_success 'fast-export ^muss^{commit} muss' '
+	git fast-export --tag-of-filtered-object=rewrite ^muss^{commit} muss >actual &&
+	cat >expected <<-EOF &&
+	tag muss
+	from $(git rev-parse --verify muss^{commit})
+	$(git cat-file tag muss | grep tagger)
+	data 9
+	valentin
+
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'fast-export master~2..master' '
 
 	git fast-export master~2..master >actual &&
-- 
2.23.0.177.g8af0b3ca64

