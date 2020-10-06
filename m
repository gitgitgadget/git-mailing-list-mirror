Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED0C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BFB208E4
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXPuexN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgJFWFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgJFWFV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43BBC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l11so353884wmh.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=02D01SreVWC3QQ327aPFNuK9f8RLXupMf7UWyHd6hwE=;
        b=XXPuexN4Km6v5tc3WRoi3oNcJ37J/x7PFRYq+k+CIVBietDkvoZVPQTkUgYzZo2oq3
         cUPsb+bZJ363s3O/JpBw3vgOQN2Zv9q0MaUNxodm4Ls9nhhCK5dVoAC68fXaxDvcQ/S+
         KMqVS/Df1gT+K0YykizkubenNZX6igB1atGF/sZos70oPmb7efN5kZde6Oun3Wv6smik
         qMMNhOwlp2VUR/n4QXwEC6vY1Qrk1xBVyol6/vg1y9ySSgUIZwdW6a1OQxkqFvu2Cxx1
         drwhZxzQF+NoPM+v0toBSB5APipUzjMvTGYdpZrsPr1Pq4dFQqK25/wUrTHZz0D91IzT
         WcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=02D01SreVWC3QQ327aPFNuK9f8RLXupMf7UWyHd6hwE=;
        b=OAhXpM/sjT7Ua0meWW7nFW3oOZXrGe+cBai/PNcZxIorXYfOTNOZ9bdZpAsdoxGS9i
         g4T2zK+N5cOVrftdiCFyBTLvXfQ7RbvWOPpCH7DziqPLFyGt0KnEt2gwerrQikymLEpT
         oQeWQUaXyGggscbfTkRaTcixgDFZoZBbzTcCcO5A9+ahIyBNpOV8DoXVQAz4Cy7n5uji
         yQfjzMOmDVOk6n1AXvT73ojOd4Fpc2mgHMMe6kuJ74oXskxo7iAJ9cpz2yTazm7h4Wwz
         aaoLCowYEUNqiSWt04ji/4m86m7GSHQ31wC/mk95MV1DWo2CNXVx2S2wpTlcMdJLejBj
         uQJg==
X-Gm-Message-State: AOAM5332hCfm3OxXWz7Ch6+pY9ZqCgK9LuGrZq7YlZYTWzCsPXP8KPnL
        wKRyZqzZU2YWvtVXB05DDNYUXeE2T5A=
X-Google-Smtp-Source: ABdhPJwyHapIcNB4z1Bfy85eVkteDdDaYQhX74HGSSuCKeqsauwKa2qmriKwFDvibj1uVmMUQRpIOQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr46880wme.148.1602021919290;
        Tue, 06 Oct 2020 15:05:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n65sm120029wmb.12.2020.10.06.15.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:18 -0700 (PDT)
Message-Id: <a7aaedfed3785c6ca693f60f05e76156f68a5d39.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:12 +0000
Subject: [PATCH v2 6/7] subtree: more robustly distinguish subtree and
 mainline commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>, Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Prevent a mainline commit without $dir being treated as a subtree
commit and pulling in the entire mainline history. Any valid subtree
commit will have only valid subtree commits as parents, which will be
unchanged by check_parents.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index e56621a986..fa6293b372 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -224,8 +224,6 @@ cache_setup () {
 	fi
 	mkdir -p "$cachedir" ||
 		die "Can't create new cachedir: $cachedir"
-	mkdir -p "$cachedir/notree" ||
-		die "Can't create new cachedir: $cachedir/notree"
 	debug "Using cachedir: $cachedir" >&2
 }
 
@@ -255,18 +253,11 @@ check_parents () {
 	local indent=$(($2 + 1))
 	for miss in $missed
 	do
-		if ! test -r "$cachedir/notree/$miss"
-		then
-			debug "  unprocessed parent commit: $miss ($indent)"
-			process_split_commit "$miss" "" "$indent"
-		fi
+		debug "  unprocessed parent commit: $miss ($indent)"
+		process_split_commit "$miss" "" "$indent"
 	done
 }
 
-set_notree () {
-	echo "1" > "$cachedir/notree/$1"
-}
-
 cache_set () {
 	oldrev="$1"
 	newrev="$2"
@@ -719,11 +710,18 @@ process_split_commit () {
 	# vs. a mainline commit?  Does it matter?
 	if test -z "$tree"
 	then
-		set_notree "$rev"
 		if test -n "$newparents"
 		then
-			cache_set "$rev" "$rev"
+			if test "$newparents" = "$parents"
+			then
+				# if all parents were subtrees, this can be a subtree commit
+				cache_set "$rev" "$rev"
+			else
+				# a mainline commit with tree missing is equivalent to the initial commit
+				cache_set "$rev" ""
+			fi
 		else
+			# no parents with valid subtree mappings means a commit prior to subtree add
 			cache_set "$rev" ""
 		fi
 		return
-- 
gitgitgadget

