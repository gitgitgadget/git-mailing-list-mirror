Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31CE1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755697AbcHSVul (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:50:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35604 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755653AbcHSVuj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:50:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id l89so3589343lfi.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UOowFfcwUJDeTbkSrU48XoU953MnxZxXtfs8yg1uk4c=;
        b=lfcnsw5mxVFLXYJLPJbY/BFeG25oja6BUY62jqouWNjbXVEy9VBBEKZHqpnVqhar6p
         /Okr7ehw074q9r1sN3VQWYqhLwBTw+FIYg1btwW8YF/P4ZDNgNKu9j29yD6CTCGKRn8j
         MlOLQ3ct3frogNPOKs19kUEoCnZ5t3tg+i3aqfBf2Br7aBxt8CuNdeWbQf9NxLUBe+cg
         LnnNR1v3VbLkR4diG623otk3hCAzv39+jWfOHMpFg7utSlbOx5AnO7yBAC+L0IsJdVjz
         NN+EPcGSZq5pria8dFhIReWUjAmlGVj8bXXT9ArC60JfqMOTvO2yux7cEKIBoiITwTsT
         /qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UOowFfcwUJDeTbkSrU48XoU953MnxZxXtfs8yg1uk4c=;
        b=UqFrHEFgrxpVKRnp51GZqq2BI3cUdHwGkhJaXGDeMD1q+QOvv7D56yL9p2RO+JM7Zi
         MBWLxxww8gemfM0Z4unIpuI727b9bzYtiiwwzSRcouJo31Ik6EC4l+Mbvopxa+lgxbHE
         eMBU6YC1hyoh2EO6mYADT4TgvBSssckXAKklpX1Q8FWzuNYEbag8qdNusRzD6c0Nk/tr
         VOiBdYx/EebaS6wDKZXBBivMSmppoy18wCac2Sd8py0/70Z7XtmsLZlZi0iNdJGhQZRQ
         F4Ws2b3wB0HbZ+BgzyhxLuXR6FYXgouDJuIWTtqOP5+TrcYXepwwVR+EbUtGJVxr+qX1
         Yjwg==
X-Gm-Message-State: AEkoouthJCtWddZ0soBbzUlh3NBcbN/UVpjsFBFTulX3rTWrKQDiJY5mwKg3Ckv/d1HxgQ==
X-Received: by 10.25.38.149 with SMTP id m143mr2705002lfm.107.1471643437840;
        Fri, 19 Aug 2016 14:50:37 -0700 (PDT)
Received: from localhost.localdomain (118.222.202.84.customer.cdi.no. [84.202.222.118])
        by smtp.gmail.com with ESMTPSA id q73sm1539721lfg.17.2016.08.19.14.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 14:50:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] for-each-ref: add %(upstream:gone) to mark missing refs
Date:   Fri, 19 Aug 2016 23:50:23 +0200
Message-Id: <20160819215023.10770-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git branch -vv will show "gone" next to a remote tracking branch if it
does not exist. for-each-ref is suitable for parsing but had no way of
showing this information.

This introduces "%(upstream:gone)" to display "gone" in the formatted
output if the ref does not exist or an empty string otherwise, analogous
to git branch -vv.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++--
 ref-filter.c                       | 10 +++++++++-
 t/t6300-for-each-ref.sh            | 12 ++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f57e69b..039a86b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -114,8 +114,9 @@ upstream::
 	`refname` above.  Additionally respects `:track` to show
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	or "=" (in sync) and `:gone` to show "gone" if the remote ref
+	does not exist, or an empty string if it does. Has no effect if
+	the ref does not have tracking information associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index bc551a7..5402052 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,7 +37,7 @@ static struct used_atom {
 	union {
 		char color[COLOR_MAXLEN];
 		struct align align;
-		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
+		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_GONE }
 			remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
@@ -67,6 +67,8 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 		atom->u.remote_ref = RR_TRACK;
 	else if (!strcmp(arg, "trackshort"))
 		atom->u.remote_ref = RR_TRACKSHORT;
+	else if (!strcmp(arg, "gone"))
+		atom->u.remote_ref = RR_GONE;
 	else
 		die(_("unrecognized format: %%(%s)"), atom->name);
 }
@@ -923,6 +925,12 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
+	} else if (atom->u.remote_ref == RR_GONE) {
+		const char *upstream;
+		if (stat_tracking_info(branch, &num_ours, &num_theirs, &upstream) < 0)
+			*s = "gone";
+		else
+			*s = "";
 	} else /* RR_NORMAL */
 		*s = refname;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 19a2823..1fc5d1d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -383,6 +383,18 @@ test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Check that :gone produces expected results' '
+	cat >expected <<-\EOF &&
+gone
+	EOF
+	test_when_finished "git config branch.master.merge refs/heads/master" &&
+	git config branch.master.merge refs/heads/does-not-exist &&
+	git for-each-ref \
+		--format="%(upstream:gone)" \
+		refs/heads >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
-- 
2.9.2

