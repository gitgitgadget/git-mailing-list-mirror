Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848B72018E
	for <e@80x24.org>; Mon, 22 Aug 2016 17:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756019AbcHVRfy (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 13:35:54 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33465 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756003AbcHVRfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 13:35:52 -0400
Received: by mail-lf0-f68.google.com with SMTP id f93so6573157lfi.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18CgWfyJrhG1MxthJDkxTGYqSFK4J8XcY/ZrNxhQKgo=;
        b=v6RqcYCzca+JReszq/8r6GuAHx2VZZ1HuP4uWtEVgZzLGp72y1vTePWRzkvHCfM5yC
         2Fc9Z4CJXeOg2DE36cHYKXa5zomsqbvRPLL6JpXuAS+mtd3wEBDCbGUlEVG1vmys22p5
         9WYIVhlQOtI7VQE6cp8dVGA0b5ueFW/jfq5TjyWT6F3EqM96YntpBPF8OrGTwum/ECNu
         y7Lr3pwyKszWa3fvTVHfQZzzQnitAczqmD3Otyj6xHMqx3TMIsn4WigftB+pPHHAWzX2
         /5d1fqAK2H0O7ToojWyA7fI5bIfgDhXkg+3PsUBThnJHO4FrqNvJD4LVRjKLlpDXyQX8
         fqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18CgWfyJrhG1MxthJDkxTGYqSFK4J8XcY/ZrNxhQKgo=;
        b=NiZ3D55TimeGSilTRxgytfLerM5xCx2778r2CCMViSPz3Vz7dl8YLTp2LtNhX3VxLp
         zPvkohg+l+j57ydw/78PpQFmbZTHCIyo3pdtnO7NWL8F/MiAtFZLPnXNhwM2xXYB8+ME
         +wGM3pLNVW5FYRi8iQTpEFC0l722iKT1X6nLGx1O/0Sx5mG/iSBOld5YAl840PoKf9lJ
         f4s62E0waO9GAMEHvLo+miWvfK84jB2U8MR05HMQshQMkVe0WNpISjw0lSNBs5DDGVjm
         s4D1bH3I8qxzpV3WZ1Yi/8Hq1eCe6SUTbyOU5CM6rroJAGnZ0YLy4EO/DMiE9T389FXJ
         OuTA==
X-Gm-Message-State: AEkoouvXxoSzUvsWJwxzamxt6aXMlr413Gn+p6YsQ9AjGX8RTUv26IZyW4V2b+26Uajzcw==
X-Received: by 10.25.5.205 with SMTP id 196mr6053453lff.6.1471887349815;
        Mon, 22 Aug 2016 10:35:49 -0700 (PDT)
Received: from localhost.localdomain (118.222.202.84.customer.cdi.no. [84.202.222.118])
        by smtp.gmail.com with ESMTPSA id h203sm3903612lfh.46.2016.08.22.10.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 10:35:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH v2] for-each-ref: add %(upstream:gone) to mark missing refs
Date:   Mon, 22 Aug 2016 19:35:28 +0200
Message-Id: <20160822173528.755-1-oystwa@gmail.com>
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
I took the liberty of sending in a v2 on my own. Removed the last argument to
stat_tracking_info() and used test_config instead of test_when_finished.

 Documentation/git-for-each-ref.txt |  5 +++--
 ref-filter.c                       |  9 ++++++++-
 t/t6300-for-each-ref.sh            | 11 +++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

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
index bc551a7..757f473 100644
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
@@ -923,6 +925,11 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
+	} else if (atom->u.remote_ref == RR_GONE) {
+		if (stat_tracking_info(branch, &num_ours, &num_theirs, NULL) < 0)
+			*s = "gone";
+		else
+			*s = "";
 	} else /* RR_NORMAL */
 		*s = refname;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 19a2823..f99bfd0 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -383,6 +383,17 @@ test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Check that :gone produces expected results' '
+	cat >expected <<-\EOF &&
+gone
+	EOF
+	test_config branch.master.merge refs/heads/does-not-exist &&
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

