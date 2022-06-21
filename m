Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A08FC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354673AbiFUWeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354526AbiFUWep (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB23192D
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g27so14204272wrb.10
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHjHBrnJ9yL8cs8HygyLBsO4SU8yrNNllBswIAnUnqQ=;
        b=qj+BAbX4eF6IDWc8ygC6NNfoWte6nw5BGvzRdUAQ7k7yrLcfLRdgrX8fX2ofUahE5a
         dX91qBJMNZcttz2AtELbiWVALzTRCdhw8BqUENzErpEuv8g+4nb4+PFbYdBSxBYls53Q
         1rQlFKVeJAMpl23c2f6LMHpXofhak0vUxRiRHh+5SpgDdr0hWG7lWmXTRUXn4bWlE04N
         mlfbe6Yk/G36FpVi+XbiNrP3HMw0pAqkpuWkWXAHi7+bLLP3bl+YftlsRzNr7F3LH55f
         xlflOHXwkcM0wfD0Yi5q9JVzVucsCSuY7WjFrOR/BTRUAGgtBl+aJdPE+I1qR/zGds9D
         VMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHjHBrnJ9yL8cs8HygyLBsO4SU8yrNNllBswIAnUnqQ=;
        b=OVsQeVQAT67wPqmDiwwunK31POD9UTHN91uVHe1NhA/uV1GY3zg4ctaw6wEB4f2pWV
         OFd/0PEjriR9twr05rtB5BHZ/QIHDHzx2jyIxwHr7rHSlQz6ixMzS2+RQyVGNkQIH5hR
         8WmT+V2zAkY+XUiTFbXjcjdJOcAPzYf1cYxInMCDtU18gsE3FJ8swrM8SiYmBHQQhyMN
         PA+R/0J4HooFYzoz0E+xBx8ban0U/C81LjcCuLoMeVnw/LlqMOVQmd0RcFwnqIDbBt4B
         9oqGi+czmFIce4OEzX3GwNi6QaKbwwJr3o8oIyVQ70f3fR1r1rySFpxBIWLMxkeRWyl+
         Svkg==
X-Gm-Message-State: AJIora9sa5lzegjspz7MD5rAUMapeSYHdPQR5HaKTPn46ajKGDPrm6ZA
        YiMAlLjCD8NOGb+AfdT1nT1/8Mf9n6rQSg==
X-Google-Smtp-Source: AGRyM1stDGZnfyfD086gmvD75B3IQYgiCSe+/fNkmgbuVdTjFdO9MkTFToatJWDSXLxqKrAS7zKiNQ==
X-Received: by 2002:adf:d1c6:0:b0:218:4fc3:a805 with SMTP id b6-20020adfd1c6000000b002184fc3a805mr219969wrd.228.1655850874405;
        Tue, 21 Jun 2022 15:34:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] fetch tests: stop implicitly adding refspecs
Date:   Wed, 22 Jun 2022 00:34:21 +0200
Message-Id: <patch-09.10-99832815abd-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the implicit behavior added in 97716d217c1 (fetch: add a
--prune-tags option and fetch.pruneTags config, 2018-02-09) of
providing the heads/tags refspecs and the "$remote_url" for tests that
needed the "--mode link".

In that case we need the URI on the command-line, and would then add
these refspecs.

Note that this was added in other cases, but these are the only ones
where it mattered, i.e. we redundantly modified the command-line
before.

Yes, the "\"$remote_url\"" quoting here is buggy, but so is the
pre-image in the same way, but removing this edge case will make it
easier to eventually deal with that. So let's make that variable
non-local for now and pass it in.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 54c7c86e5ca..73964bebced 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -848,7 +848,7 @@ test_configured_prune_type () {
 	shift 6 &&
 	local cmdline="$@" &&
 
-	local remote_url="file://$TRASH_DIRECTORY/." &&
+	remote_url="file://$TRASH_DIRECTORY/." && # NOT local yet!
 	local cmdline_setup="\"$remote_url\" \"$refspec_heads\""
 
 	if test "$mode" = 'link'
@@ -862,15 +862,6 @@ test_configured_prune_type () {
 			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
 		fi &&
 
-		if test "$fetch_prune_tags" = 'true' ||
-		   test "$remote_origin_prune_tags" = 'true'
-		then
-			if ! printf '%s' "$cmdline\n" | grep -q refs/remotes/origin/
-			then
-				new_cmdline="$new_cmdline refs/tags/*:refs/tags/*"
-			fi
-		fi &&
-
 		cmdline="$new_cmdline"
 	fi &&
 
@@ -990,19 +981,36 @@ test_configured_prune true  true  unset unset pruned pruned \
 # --prune-tags on its own does nothing, needs --prune as well, same
 # for fetch.pruneTags without fetch.prune
 test_configured_prune unset unset unset unset kept kept     --prune-tags
-test_configured_prune unset unset true unset  kept kept
-test_configured_prune unset unset unset true  kept kept
+test_configured_prune_type --mode name unset unset true unset  kept kept
+test_configured_prune_type --mode link unset unset true unset  kept kept \
+	origin "refs/tags/*:refs/tags/*"
+test_configured_prune_type --mode name unset unset unset true  kept kept
+test_configured_prune_type --mode link unset unset unset true  kept kept \
+	origin "refs/tags/*:refs/tags/*"
 
 # These will prune the tags
 test_configured_prune unset unset unset unset pruned pruned --prune --prune-tags
-test_configured_prune true  unset true  unset pruned pruned
-test_configured_prune unset true  unset true  pruned pruned
+
+test_configured_prune_type --mode name true  unset true  unset pruned pruned
+test_configured_prune_type --mode link true  unset true  unset pruned pruned \
+	"\"$remote_url\"" \
+	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
+test_configured_prune_type --mode name unset true  unset true  pruned pruned
+test_configured_prune_type --mode link unset true  unset true  pruned pruned \
+	"\"$remote_url\"" \
+	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 
 # remote.<name>.pruneTags overrides fetch.pruneTags, just like
 # remote.<name>.prune overrides fetch.prune if set.
-test_configured_prune true  unset true unset pruned pruned
-test_configured_prune false true  false true  pruned pruned
-test_configured_prune true  false true  false kept   kept
+test_configured_prune_type --mode name true  unset true unset pruned pruned
+test_configured_prune_type --mode link true  unset true unset pruned pruned \
+	"\"$remote_url\"" \
+	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
+test_configured_prune_type --mode name false true  false true pruned pruned
+test_configured_prune_type --mode link false true  false true pruned pruned \
+	"\"$remote_url\"" \
+	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
+test_configured_prune true  false true false kept kept
 
 # When --prune-tags is supplied it's ignored if an explicit refspec is
 # given, same for the configuration options.
-- 
2.36.1.1239.gfba91521d90

