Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB2C54E4A
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4698E20735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksmSTWJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEKFuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728800AbgEKFuJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F8FC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so4471730wmf.1
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0naDQ+6OKc2+xw84wsszb9MRxDVQm+FSZOo0IFHU8PA=;
        b=ksmSTWJdyB3OR8zfyE+QICEKR0lO5iFDkO8rPYTtxYtb595NHliwqy7kNYD4qSjkih
         k7V4Tge/028EJjwIdcAfnTlSeq357Rd4UsvgQ/VP0wUPY/N3stQCvErCbfYu3y7ylapT
         NPXrxese7WTMJZR0RtS4S0ifFe3HprLZ4prDotXVmJ08QDUhJBsVAwvme48nbXYgHmFz
         jXOX+jIlMgXdczI41csV5URyFEfHZvC5QlbC5Yk3+v80SM+gGDAxyJJNv/pmPfFxiIVC
         jtOOrOyvlQAx3Rqe9Ym08OOTokDrV35IovPCjO4arHcGywT1qGbi3ota+EKsSXlrlcB8
         8SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0naDQ+6OKc2+xw84wsszb9MRxDVQm+FSZOo0IFHU8PA=;
        b=EXKnr0ecI4+jrMxV80lnCNS+IqMeQcussxE9qhdmsuxhFiBNAXkTqdIBAz8WCpC2Xm
         OHauqjkQTORwBxYJaZyjvi2mPSJK08rboZZQ4/VFDzmiU9CaWYXqngchnDzfHaYK6ZtL
         MxdIDDOQjLMAy/JPnAV2LUG957G9NFaaXSX/yW2pp5Mqxp7n7S59epXBnQqC4ARiLOct
         JCrGcniRxMAaDL/C2eCw5tvlHd4Cpfa4lI0soC3Vode+j2W1jyinzoNHMK9lnOoqsPAW
         aM5CPf68+3fFWnIRIlPgXb8FBE5J+xZc2txQxb21ubv9IrAjmLzvx6rQAgE26LvTDyvT
         gl0w==
X-Gm-Message-State: AGi0Pua+szl6ilDFwayCS1L3jmZw9XESskLMXz40OOk9S/1AuQUA7wsi
        UbA0WNtql/lsSdk35wmoEwDXL7Fw
X-Google-Smtp-Source: APiQypI68FNtnFPwtKHXzP/SUStYawfTfsa7iGHvhUVyXT9D+8ipUhGtuOD6ESqk5CwLrpmtKVy7Mg==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr29416449wma.122.1589176208075;
        Sun, 10 May 2020 22:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 81sm7839435wme.16.2020.05.10.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:07 -0700 (PDT)
Message-Id: <27a43ea2c4d608192b22474800db645a52f2991b.1589176202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:50:00 +0000
Subject: [PATCH 6/7] subtree: more robustly distinguish subtree and mainline
 commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Sender: git-owner@vger.kernel.org
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
index 1ca8b2f1101..320e51b7e1a 100755
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
@@ -721,11 +712,18 @@ process_split_commit () {
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

