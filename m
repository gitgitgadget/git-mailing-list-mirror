Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569E3200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbcL0QXg (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:36 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35821 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755384AbcL0QX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:29 -0500
Received: by mail-pg0-f65.google.com with SMTP id i5so12839515pgh.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aYjKqMKKD7PWdgE0NX0hpzW2co4fu3xJcQ3TIfyVNAM=;
        b=Q+P575todF4Tp5hHce/dcblEver+Gu5GsECUKXMCt7xOyvZN7h7lp9a4zW6YZBdiYh
         rtfXjF11Yp3LKkmwxcRl0dDbCLJJ1j3ZMxolaHWbJEmnVGCRKXpmqmFyFfPPmtTHdJ+j
         Xdxr9QwJ+x7vqfbdtpbO5gEPIOsbo5wGJJ9r2TlLfxR7lzmcmYD23qByG5XrxB+wPlnB
         s7kziMkSI3xlLSoznhkmPlsTRapWYQzp+84o2ZwuOl2p/0+f83tI4uCO05naJivjtcap
         rvTDIglKByUL8SFXmJ755PpC9k0n9F3Yx7VMCPOKuB1wuKfrgKc+PUCacCkIRNkmk7jd
         Mg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYjKqMKKD7PWdgE0NX0hpzW2co4fu3xJcQ3TIfyVNAM=;
        b=CUy/fGi8iLCLTgsAk6+GwBlyiixhwYeJ74Rpuap9w11/6WGBmh4TvdM85o+5vJG+B9
         Bj5gXNBO7ksgnqMPWGo/JKVBNfcai11sXTt5vvk3swtz5Y+lOVkUc5lSM0a04Pkothqi
         oUYaVYzX+tqJVOR9yhwwzXyLQ2eZhbALp5lFig0x8MW+92LhXpBas4TZEys690RLJLDm
         RQ17+z23qyG4Bid0CXTS1GdOmyVyu5oGncDo1bPz4pDxA/b1XI0Us7uUuCsMGgIodXMh
         vn5bZAXZrp4e0tETSCenqJS+tOfioNbKOWMV8+3++IS+C6IZbtPNDNvaMsKLeXoFyom4
         lHmg==
X-Gm-Message-State: AIkVDXI3SZI+CoMgO+bL9mX3FVKQ7n+wEuGCIhJO7kFiTFglXuHN13CtlrqiV2dAFDxlAA==
X-Received: by 10.84.196.164 with SMTP id l33mr68222844pld.150.1482855809252;
        Tue, 27 Dec 2016 08:23:29 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:28 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 07/20] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date:   Tue, 27 Dec 2016 21:53:44 +0530
Message-Id: <20161227162357.28212-8-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh and
Documentation/git-for-each-ref.txt to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by : Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 4 +++-
 t/t6300-for-each-ref.sh            | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c2cc03c..24a1679 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -121,7 +121,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 47b521c..9989918 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1073,8 +1073,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL)) {
+			*s = "[gone]";
 			return;
+		}
 
 		if (!num_ours && !num_theirs)
 			*s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e67c694..a2e3f55 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.10.2

