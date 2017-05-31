Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB27020D0A
	for <e@80x24.org>; Wed, 31 May 2017 10:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdEaKmd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 06:42:33 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:38303 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdEaKmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 06:42:32 -0400
Received: from lindisfarne.localdomain ([92.22.34.189])
        by smtp.talktalk.net with SMTP
        id G154d4KIzcpskG15Cd2uBh; Wed, 31 May 2017 11:42:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1496227351; bh=hqBqzDP+uBLw/A+i5Bh1AfGlygsofo+p1Z+qhbx5vx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=tQFQ5gnLbtvBk8DhodN3XNJloBXAisMGV2XPe1W9IRQQxprS7RHzvCujEH8cXKlBc
         ubhWBHfHkFTl+NYeGa9oyEW9/8s5x7uCtnJ85MO5CMPcuqH9sJzkNgjSYJoJvUO+7h
         moo8yLcpLSLgUTzKo/DOm1eegfH0TKTmQKrXNmlc=
X-Originating-IP: [92.22.34.189]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=vjpdqwq13QoU7KiiDtdC/A==:117
 a=vjpdqwq13QoU7KiiDtdC/A==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=970QDgzxqFXETTk3HUgA:9 a=zLAaYpBrg55ssmIo:21 a=bKb7gWxdw7c9gNXN:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/3] rebase: Add tests for console output
Date:   Wed, 31 May 2017 11:42:12 +0100
Message-Id: <20170531104213.16944-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170531104213.16944-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLSUERm0rKSBZi0W1vBbl3oK73Iu1j3r6/E1E7SqZWU/xO0RzJAZgxJAFecoSXdlXt3ivrT2Mx+yN3uNqnWbne8tintOEumkRKq8RAKNHxjPHHiMo2gY
 JhM9rwY3mq7Hg3DgbNBIjtwuPsC0AtnUcHmLEF0GMr/gOVVs5DB21ENPU2j2JrzxzrC7vsIaPf8nk6ahzd3kZRFypxAXr30fViB0Bo+xIzsqYjuvXi6Hf9zp
 SV1gnSfe73XvnXR6MKtEsD9WphJyV110ub8TyJBDNFkYdP7AIbHqpFADFi28mgL9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check the console output when using --autostash and the stash applies
cleanly is what we expect. To avoid this test depending on commit and
stash hashes it uses sed to replace them with XXX. The sed script also
replaces carriage returns in the output with '\r' to avoid embedded
'^M's in the expected output files. Unfortunately this means we still
end up with an embedded '^M' in the sed script which may not be
preserved when sending this. The last line of the sed script should be
+s/^M/\\r/g

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3420-rebase-autostash.sh          | 10 +++++++++-
 t/t3420/expected-success-am          |  6 ++++++
 t/t3420/expected-success-interactive |  4 ++++
 t/t3420/expected-success-merge       | 30 ++++++++++++++++++++++++++++++
 t/t3420/remove-ids.sed               |  6 ++++++
 5 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index ab8a63e8d6dc643b28eb0c74ba3f032b7532226f..886be63c6d13e1ac4197a1b185659fb3d7d7eb26 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -53,12 +53,20 @@ testrebase() {
 		git checkout -b rebased-feature-branch feature-branch &&
 		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
-		git rebase$type unrelated-onto-branch &&
+		git rebase$type unrelated-onto-branch >tmp 2>&1 &&
 		grep unrelated file4 &&
 		grep dirty file3 &&
 		git checkout feature-branch
 	'
 
+	test_expect_success "rebase$type --autostash: check output" '
+		suffix=${type#\ -} && suffix=${suffix:--am} &&
+		sed -f $TEST_DIRECTORY/t3420/remove-ids.sed tmp \
+			>actual-success$suffix &&
+		test_cmp $TEST_DIRECTORY/t3420/expected-success$suffix \
+			actual-success$suffix
+	'
+
 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
 		test_config rebase.autostash true &&
 		git reset --hard &&
diff --git a/t/t3420/expected-success-am b/t/t3420/expected-success-am
new file mode 100644
index 0000000000000000000000000000000000000000..c18ded04f703ed2aa83d5e62589a908d0a44cf7e
--- /dev/null
+++ b/t/t3420/expected-success-am
@@ -0,0 +1,6 @@
+Created autostash: XXX
+HEAD is now at XXX third commit
+First, rewinding head to replay your work on top of it...
+Applying: second commit
+Applying: third commit
+Applied autostash.
diff --git a/t/t3420/expected-success-interactive b/t/t3420/expected-success-interactive
new file mode 100644
index 0000000000000000000000000000000000000000..b31f71c95ddc9c18ce9956c1aadf53cedd966801
--- /dev/null
+++ b/t/t3420/expected-success-interactive
@@ -0,0 +1,4 @@
+Created autostash: XXX
+HEAD is now at XXX third commit
+Rebasing (1/2)\rRebasing (2/2)\rSuccessfully rebased and updated refs/heads/rebased-feature-branch.
+Applied autostash.
diff --git a/t/t3420/expected-success-merge b/t/t3420/expected-success-merge
new file mode 100644
index 0000000000000000000000000000000000000000..66386f7cb5242a255d9cc64aad741e651ec7ec1e
--- /dev/null
+++ b/t/t3420/expected-success-merge
@@ -0,0 +1,30 @@
+Created autostash: XXX
+HEAD is now at XXX third commit
+First, rewinding head to replay your work on top of it...
+Merging unrelated-onto-branch with HEAD~1
+Merging:
+XXX unrelated commit
+XXX second commit
+found 1 common ancestor:
+XXX initial commit
+[detached HEAD XXX] second commit
+ Author: A U Thor <author@example.com>
+ Date: Thu Apr 7 15:14:13 2005 -0700
+ 2 files changed, 2 insertions(+)
+ create mode 100644 file1
+ create mode 100644 file2
+Committed: 0001 second commit
+Merging unrelated-onto-branch with HEAD~0
+Merging:
+XXX second commit
+XXX third commit
+found 1 common ancestor:
+XXX second commit
+[detached HEAD XXX] third commit
+ Author: A U Thor <author@example.com>
+ Date: Thu Apr 7 15:15:13 2005 -0700
+ 1 file changed, 1 insertion(+)
+ create mode 100644 file3
+Committed: 0002 third commit
+All done.
+Applied autostash.
diff --git a/t/t3420/remove-ids.sed b/t/t3420/remove-ids.sed
new file mode 100644
index 0000000000000000000000000000000000000000..9e9048b02bd04d287461543d85db0bb715b89f8c
--- /dev/null
+++ b/t/t3420/remove-ids.sed
@@ -0,0 +1,6 @@
+s/^\(Created autostash: \)[0-9a-f]\{6,\}$/\1XXX/
+s/^\(HEAD is now at \)[0-9a-f]\{6,\}\( .* commit\)$/\1XXX\2/
+s/^[0-9a-f]\{6,\}\( .* commit\)$/XXX\1/
+s/\(detached HEAD \)[0-9a-f]\{6,\}/\1XXX/
+s/\(could not apply \)[0-9a-f]\{6,\}/\1XXX/g
+s//\\r/g
-- 
2.13.0

