Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFAAC433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACBD22D01
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbhAWNB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbhAWNBr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:01:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F9C061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c127so6703090wmf.5
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGf5sS5nnzZQN8HV8K7brEHNmd6buqHIlJBcMDeFDP0=;
        b=ecO3/4/Mx1TjMnNmxF6foTBjE2V60dywjPXtvDhSxAMXi32PjeF6djxBlNGHbAkrcq
         THifqrxXc7xFMUW7i+qDaXsERbRmZKAEWOytOKcLCokFlsZk/KQLrxrrC8VXTeeFC9G3
         fjHz5KXebjoR0PGYgrGNT4o17EuxLJzVaglC/FhTuvuoEQAxNhmx8yI7ZxvUwebFruaa
         FxsKwjF5IRMQbFl0yPKtOaC5XMHZWcbmaiLPbhMrjlcubJLPguBzzikHiGHnSfIVjtL6
         QJJDWJaZckz0VTzICFz7o3FdNJCLKVQ3msaUxrzhhzXmcum4ZiYrG0kGOOySknt3uomj
         LY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGf5sS5nnzZQN8HV8K7brEHNmd6buqHIlJBcMDeFDP0=;
        b=DVKCNd7p+4JueOAbruRAxiVhMznraUlL8Mll7YRr2Fz5Gwds+rRzKUZig5pewd8Sf2
         ki4/g+3RSSVykU/YIypOiQ6bXz6xyE3AUR9hiMFCOjy/3Yxti/vAAhPpDikSgJ5QsnUH
         AL89G8cCQcWQEz6/5pDHzvaHt7oaL7e1UglXgCwKxHFIqQxDQ46g86PcaXld7p/m48Fc
         Asq9XBFnyEebdr2in2I8W0oF1QOPpWncEOGBNt/tJNmHQGl+MRkWVdj8iKkMDtMsDijW
         Qxi8qBH7Y7sUNrFbL9OOmtzGck7QYZzOxqunw1dh4fFDsqxKnUeEFRFPK/4ndx8IsUjw
         H4aw==
X-Gm-Message-State: AOAM532O3mNbxOuWHcABlVhT0RUMV5jOZMBa1W+euHDOgrkLez2hiCU6
        a35dmOZ7HrWB8fJLkBEehETuymnJ95wkvA==
X-Google-Smtp-Source: ABdhPJzkKaH7irX6SXCnJ5nE3oMSe9nkvmAna1cavJp6bo85f/+JGTRgq/DLShFllypgU2HK9XoAUA==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr57104wmd.128.1611406865933;
        Sat, 23 Jan 2021 05:01:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] cache-tree tests: remove unused $2 parameter
Date:   Sat, 23 Jan 2021 14:00:38 +0100
Message-Id: <20210123130046.21975-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $2 paramater. This appears to have been some
work-in-progress code from an earlier version of
9c4d6c0297 (cache-tree: Write updated cache-tree after commit,
2014-07-13) which was left in the final version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 45e1cc82ed..7ff7f04719 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -19,7 +19,6 @@ cmp_cache_tree () {
 # correct.
 generate_expected_cache_tree_rec () {
 	dir="$1${1:+/}" &&
-	parent="$2" &&
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
 	git ls-files >files &&
@@ -30,10 +29,9 @@ generate_expected_cache_tree_rec () {
 	for subtree in $subtrees
 	do
 		cd "$subtree"
-		generate_expected_cache_tree_rec "$dir$subtree" "$dir" || return 1
+		generate_expected_cache_tree_rec "$dir$subtree" || return 1
 		cd ..
-	done &&
-	dir=$parent
+	done
 }
 
 generate_expected_cache_tree () {
-- 
2.29.2.222.g5d2a92d10f8

