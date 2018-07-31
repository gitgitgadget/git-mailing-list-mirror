Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A0F1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 21:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeGaXAx (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 19:00:53 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:48027 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGaXAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 19:00:52 -0400
Received: by mail-ua0-f201.google.com with SMTP id g19-v6so5714248uan.14
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=89YRay/Qdaks9Xymz51IGBJLE/CfHEV2nXh4KWHmM2g=;
        b=peXcCc6Bny9qnVSIKBtTlVdg/WFCYeYzNR5P1K2qfalSWGjV186wl3vSWml/dp6MyV
         UtoFUNxM5W/8EIY7QrkiZSugEHDo5m4Q6aylt4aEP4QgbHqX+b0+Dnj+D41nHxiymyiV
         bXjVy7puderEn2K6Q8pjEjXyLQd2/1gI+WFO74WmbuT9cdKFIA3uGvzU+EHXH1tAgmf9
         YyRTlaN9t7OX6WpdS/D5Zcu1yFgwuUGrSVNtrPMLDpAuqAdo5O3/ifSDEKOXFLRtBhdg
         Gn8yHYCOpVfCKlcWRI55dUMC5zSjwOlKWPisTni9a2lhB9RbR/cj763tgWkRDgAbbS+1
         6kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=89YRay/Qdaks9Xymz51IGBJLE/CfHEV2nXh4KWHmM2g=;
        b=sGOAdgYLfSYcwLWAygUeQNNN2Cx6U5BfEQWfCwF9qBJTvYc2NKxwn1utFDyLHuz7cg
         lBNmZymhTi1ZyaO+d6reINOruwQdmRhNV+oSqI38reVysIt0gUKwjlhXDrgRyjfnGl11
         IgaUeJWbm9NYE5Ny+aA5/4RYoBNjN401/oImllGobZt4e+r0DZijnEcZU3MHuEWSUAe9
         gbn3xbLPM4ES0FZyT2wAC4+Jm+LB/j17lQD1kvLZQQRyEddl6V0to3SSPfLY1Ab5Q5n8
         6/J3a+/hvBUs/XQDFsfY+/hguajS5wjIEs4tUOL9SMqdizVMDtrP3RH/X54OfQoS9NzJ
         vrgg==
X-Gm-Message-State: AOUpUlHfyBD+VIHWh5JnFz9XqQY8x7j8ULbjW+4L73E7BoDmrdzlTCpm
        +YdmkthcRD+m/2A9LU9fgBZLA1Jr6YVFXiEdbZWHPtCh2UuVhjGFo3x1z2DsP5Xw8M9Pd46J8uD
        YdSogkogSKJ97UJaqivSKi0klMPZHP3iWRniTcqHap3R9A0pfEXknJMTnvprPyd6HaY9fec6d1u
        Fx
X-Google-Smtp-Source: AAOMgpdsI3Ji+sy4V8j2qhJQBKaBNRyfNsMJm+79EQZvFaoxOs0rixNO+PbVjYojBI4owQWGK30BOGnEUU1EDXM7Ldtl
X-Received: by 2002:a1f:3de:: with SMTP id f91-v6mr11269192vki.1.1533071917071;
 Tue, 31 Jul 2018 14:18:37 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:18:32 -0700
Message-Id: <20180731211832.142014-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] remote: prefer exact matches when using refspecs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When matching a non-wildcard LHS of a refspec against a list of refs,
find_ref_by_name_abbrev() returns the first ref that matches using the
DWIM rules used by refname_match() in refs.c, even if an exact match
occurs later in the list of refs.

This causes unexpected behavior when (for example) fetching using the
refspec "refs/heads/s:<something>" from a remote with both
"refs/heads/refs/heads/s" and "refs/heads/s". (Even if the former was
inadvertently created, one would still expect the latter to be fetched.)

This problem has only been observed when the desired ref comes after the
undesired ref in alphabetical order. However, for completeness, the test
in this patch also checks what happens when the desired ref comes first
alphabetically.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote.c         |  7 +++++--
 t/t5510-fetch.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 3fd43453f..eeffe3488 100644
--- a/remote.c
+++ b/remote.c
@@ -1687,12 +1687,15 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 
 static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
 {
+	const struct ref *best_match = NULL;
 	const struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (refname_match(name, ref->name))
+		if (!strcmp(name, ref->name))
 			return ref;
+		if (refname_match(name, ref->name))
+			best_match = ref;
 	}
-	return NULL;
+	return best_match;
 }
 
 struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e402aee6a..da88f35f0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -535,6 +535,34 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	)
 '
 
+test_expect_success 'LHS of refspec prefers exact matches' '
+	mkdir lhs-exact &&
+	(
+		cd lhs-exact &&
+		git init server &&
+		test_commit -C server unwanted &&
+		test_commit -C server wanted &&
+
+		git init client &&
+
+		# Check a name coming after "refs" alphabetically ...
+		git -C server update-ref refs/heads/s wanted &&
+		git -C server update-ref refs/heads/refs/heads/s unwanted &&
+		git -C client fetch ../server refs/heads/s:refs/heads/checkthis &&
+		git -C server rev-parse wanted >expect &&
+		git -C client rev-parse checkthis >actual &&
+		test_cmp expect actual &&
+
+		# ... and one before.
+		git -C server update-ref refs/heads/q wanted &&
+		git -C server update-ref refs/heads/refs/heads/q unwanted &&
+		git -C client fetch ../server refs/heads/q:refs/heads/checkthis &&
+		git -C server rev-parse wanted >expect &&
+		git -C client rev-parse checkthis >actual &&
+		test_cmp expect actual
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
2.18.0.345.g5c9ce644c3-goog

