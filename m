Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD233078
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PulumM5b"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F362D3
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40a5a444c3eso12294125e9.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699998268; x=1700603068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/kc7ebNtMDDu9lzaSnamPuvKSPnpDUgfJ/ax6Fg8rs=;
        b=PulumM5bS7ci4g2BhSQL2x3cuH6U4WyKqwcUcDUXArxsB0jdp/LNwNb7mi+RxYKyGR
         +wQ/Z0K+aG9KFa/HB032/izqrdEnA+jcnxeXZ4BZn4kwyQIroVys1dgdWeXTM5NKIHMH
         cPMZK9lcTFm7aNS0GH3zOrDwogbCwU7chf0pBX9Li77GwhpmfMossd4JK7jAnJcpdCZP
         ipQLzia/iCQSDU4Ig49C0zXPje9rUWfVqWPs+Nt/oGo3f/y3E8+2MJ1i9Cv8hJTz/1DQ
         coPzjnvrtm0rWlhm9mxaQiJoutw9Hol3Lq6qsq4KFuDlr9YMxBwBQ/vRBe+tErjat/O0
         otVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998268; x=1700603068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/kc7ebNtMDDu9lzaSnamPuvKSPnpDUgfJ/ax6Fg8rs=;
        b=uQFlWVNcMNZkufkjElnUopezj79U7yoHqy4kHKs6uX1MgoVEdh9bxkol+hgz6EqS2H
         TxKlpSRQfuVTbpWV0EEXqTNzHaLGYMhX2E4BJXLPymNiqVbFC2ws6Va+gqHw1S3lCQze
         UdZkoQJg6GMYLIPhz3ufc9t1vfUdQMYc+sK+FWR1V5xgX8eLulAxSVAQXaWmIS7rjTmZ
         ghhn/vu3i41peJK1oR83yZE78Fo03pzSchQSnApf0GSFMMx92Mkb+2Xu2FiQJIOG4/po
         /+ifWJ32dGT8Y4SNgiMKv/rp1DcxgJCxs1PGUL0wIBJog18ddCAo3Y5V2h85MKbeVleq
         Xk6Q==
X-Gm-Message-State: AOJu0YyA9aIFg3EEwMaeLioMpuTjDMESoEXqSouJF2QpLmDP9zZMVN3Y
	8q2SdPAL3FfOukRy92Cd84ugjQ2J4tm0TA==
X-Google-Smtp-Source: AGHT+IHwgN2DeJ2H3iukN01VAmcWEIeUSPimFDbEFfVs1JVagCJ6+KAyxitRc/K5kAn+ejWo6QZ7CQ==
X-Received: by 2002:a05:600c:350f:b0:3ff:233f:2cfb with SMTP id h15-20020a05600c350f00b003ff233f2cfbmr8234638wmq.23.1699998267722;
        Tue, 14 Nov 2023 13:44:27 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040651505684sm12804379wmq.29.2023.11.14.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:44:27 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 2/3] rebase: support --autosquash without -i
Date: Tue, 14 Nov 2023 21:43:38 +0000
Message-ID: <20231114214339.10925-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc2
In-Reply-To: <20231114214339.10925-1-andy.koppe@gmail.com>
References: <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231114214339.10925-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rebase --autosquash option is quietly ignored when used without
--interactive (apart from preventing preemptive fast-forwarding and
triggering conflicts with apply backend options).

Change that to support --autosquash without --interactive, by dropping
its restriction to REBASE_INTERACTIVE_EXCPLICIT mode. When used this
way, auto-squashing is done without opening the todo list editor.

Drop the -i requirement from the --autosquash description, and amend
t3415-rebase-autosquash.sh to test the option and the rebase.autoSquash
config variable with and without -i.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/git-rebase.txt |  2 +-
 builtin/rebase.c             |  4 +---
 t/t3415-rebase-autosquash.sh | 38 ++++++++++++++++++++++++++----------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b4526ca246..10548e715c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -592,7 +592,7 @@ See also INCOMPATIBLE OPTIONS below.
 	When the commit log message begins with "squash! ..." or "fixup! ..."
 	or "amend! ...", and there is already a commit in the todo list that
 	matches the same `...`, automatically modify the todo list of
-	`rebase -i`, so that the commit marked for squashing comes right after
+	`rebase`, so that the commit marked for squashing comes right after
 	the commit to be modified, and change the action of the moved commit
 	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
 	matches the `...` if the commit subject matches, or if the `...` refers
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a73de7892b..9f8192e0a5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -710,10 +710,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	if (opts->type == REBASE_MERGE) {
 		/* Run sequencer-based rebase */
 		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
-		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
+		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT))
 			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
-			opts->autosquash = 0;
-		}
 		if (opts->gpg_sign_opt) {
 			/* remove the leading "-S" */
 			char *tmp = xstrdup(opts->gpg_sign_opt + 2);
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index a364530d76..fcc40d6fe1 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -43,7 +43,7 @@ test_auto_fixup () {
 
 	git tag $1 &&
 	test_tick &&
-	git rebase $2 -i HEAD^^^ &&
+	git rebase $2 HEAD^^^ &&
 	git log --oneline >actual &&
 	if test -n "$no_squash"
 	then
@@ -61,15 +61,24 @@ test_auto_fixup () {
 }
 
 test_expect_success 'auto fixup (option)' '
-	test_auto_fixup final-fixup-option --autosquash
+	test_auto_fixup fixup-option --autosquash &&
+	test_auto_fixup fixup-option-i "--autosquash -i"
 '
 
-test_expect_success 'auto fixup (config)' '
+test_expect_success 'auto fixup (config true)' '
 	git config rebase.autosquash true &&
-	test_auto_fixup final-fixup-config-true &&
+	test_auto_fixup ! fixup-config-true &&
+	test_auto_fixup fixup-config-true-i -i &&
 	test_auto_fixup ! fixup-config-true-no --no-autosquash &&
+	test_auto_fixup ! fixup-config-true-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto fixup (config false)' '
 	git config rebase.autosquash false &&
-	test_auto_fixup ! final-fixup-config-false
+	test_auto_fixup ! fixup-config-false &&
+	test_auto_fixup ! fixup-config-false-i -i &&
+	test_auto_fixup fixup-config-false-yes --autosquash &&
+	test_auto_fixup fixup-config-false-i-yes "-i --autosquash"
 '
 
 test_auto_squash () {
@@ -87,7 +96,7 @@ test_auto_squash () {
 	git commit -m "squash! first" -m "extra para for first" &&
 	git tag $1 &&
 	test_tick &&
-	git rebase $2 -i HEAD^^^ &&
+	git rebase $2 HEAD^^^ &&
 	git log --oneline >actual &&
 	if test -n "$no_squash"
 	then
@@ -105,15 +114,24 @@ test_auto_squash () {
 }
 
 test_expect_success 'auto squash (option)' '
-	test_auto_squash final-squash --autosquash
+	test_auto_squash squash-option --autosquash &&
+	test_auto_squash squash-option-i "--autosquash -i"
 '
 
-test_expect_success 'auto squash (config)' '
+test_expect_success 'auto squash (config true)' '
 	git config rebase.autosquash true &&
-	test_auto_squash final-squash-config-true &&
+	test_auto_squash ! squash-config-true &&
+	test_auto_squash squash-config-true-i -i &&
 	test_auto_squash ! squash-config-true-no --no-autosquash &&
+	test_auto_squash ! squash-config-true-i-no "-i --no-autosquash"
+'
+
+test_expect_success 'auto squash (config false)' '
 	git config rebase.autosquash false &&
-	test_auto_squash ! final-squash-config-false
+	test_auto_squash ! squash-config-false &&
+	test_auto_squash ! squash-config-false-i -i &&
+	test_auto_squash squash-config-false-yes --autosquash &&
+	test_auto_squash squash-config-false-i-yes "-i --autosquash"
 '
 
 test_expect_success 'misspelled auto squash' '
-- 
2.43.0-rc2

