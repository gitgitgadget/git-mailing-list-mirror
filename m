Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED0B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965108AbdCWP3y (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33306 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965089AbdCWP3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11so17294082wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwGqDbAvy+glEgIQKtISu5TIVePy2qX41+3KlC9AQvg=;
        b=MOgZSXWXnGsm+NHl2blOKq+fyiPnOcXXc4rpCn1gSH1H96arEQIqbXuzkWBtwMHcMO
         wpsxGvS4eBuJQGvG1EhxwllB5m9MyUYwChvNtz7KpLt13f7g5ORPnapnLiLidlpJRSE3
         hxJVPMafhUHU3mAnz2cNkGbIXywGNPUmtI5ePA0NuQPvp0acy2oNfD4RJdBNUusR77Pg
         gSXKwpHn/0CGV7YMRwxz5TnHBNa7G+7VFlVWMauEowgR3ECSOB4t+TF7a0AG2hqIeJaN
         qQWMSY16jvXWrcfX6toHEX/L7Y75aSSkHRabj8QLQLPnx0zWHpYoQtRR4pW4B5Y9R5xD
         SP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwGqDbAvy+glEgIQKtISu5TIVePy2qX41+3KlC9AQvg=;
        b=hAcF+NSa6dABMH3vPIhk0GCssh/rvjic3GA6Kv1L0lDop1c60hEbKyp5oRWKwocY5Q
         PhPaCQxLqUz/Mx72zm0qzEtOq40W8adRgCADRhIWKfo49bbxZr6Y78QmQ6QQohvyPu6K
         oHpvoGnA6XXQoIeQ0ERhmBjgvGj20dYkrgQWg3kGEfe8lbsMXgfJjm/mG9xcpm+TTWVC
         nliftX8eCBbK2tyOjwTBE3aRL2S2ewAIVsa4o8m4Pll/+SXjbAd3rvffHHt8Nl1o1S/I
         414jh8V4Oob6Tw7/ekTIln9h0pX8e5i8AEQE4s3FSfCNmDvXWN1HtkJasTzvhr0fT9zL
         yNrw==
X-Gm-Message-State: AFeK/H1WaPJZwnZ1EQtQ2S0YZRWBnyhdB1OPCQFO4ZjwSq71+J6gk4pHJoNt3esY7Gl2gw==
X-Received: by 10.28.172.7 with SMTP id v7mr13674155wme.78.1490282987976;
        Thu, 23 Mar 2017 08:29:47 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 14/14] completion: speed up branch and tag completion
Date:   Thu, 23 Mar 2017 16:29:24 +0100
Message-Id: <20170323152924.23944-15-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modify __git_heads() and __git_tags() and the few callsites they have,
so we can let 'git for-each-ref' do all the hard work and these
functions' output won't need any further processing or filtering
before being handed over to Bash, resulting in faster branch and tag
completion.  These are some of the same tricks used in the previous
commits to speed up refs completion, namely:

  - Extend both functions to accept prefix, current word and suffix
    positional parameters, all optional and all empty by default to
    keep the parameterless behavior unaltered.

  - Specify appropriate globbing patterns to 'git for-each-ref' to
    list only branches or tags matching the given current word
    parameter.

  - Modify the 'git for-each-ref --format=<...>' to include the given
    prefix and suffix.

  - Adjust all callsites to specify the proper prefix, current word
    and suffix parameters, and to fill COMPREPLY using
    __gitcomp_direct().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 86c7d93b8..bd07d9a74 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -352,14 +352,27 @@ __git_index_files ()
 	done | sort | uniq
 }
 
+# Lists branches from the local repository.
+# 1: A prefix to be added to each listed branch (optional).
+# 2: List only branches matching this word (optional; list all branches if
+#    unset or empty).
+# 3: A suffix to be appended to each listed branch (optional).
 __git_heads ()
 {
-	__git for-each-ref --format='%(refname:strip=2)' refs/heads
+	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+
+	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
 }
 
+# Lists tags from the local repository.
+# Accepts the same positional parameters as __git_heads() above.
 __git_tags ()
 {
-	__git for-each-ref --format='%(refname:strip=2)' refs/tags
+	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+
+	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
 }
 
 # Lists refs from the local (by default) or from a remote repository.
@@ -1183,7 +1196,7 @@ _git_branch ()
 		;;
 	*)
 		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
-			__gitcomp_nl "$(__git_heads)"
+			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
 		else
 			__git_complete_refs
 		fi
@@ -2178,7 +2191,7 @@ _git_config ()
 		;;
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
-		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
+		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autosetupmerge\nautosetuprebase\n' "$pfx" "$cur_"
 		return
 		;;
@@ -2824,7 +2837,7 @@ _git_tag ()
 		i="${words[c]}"
 		case "$i" in
 		-d|-v)
-			__gitcomp_nl "$(__git_tags)"
+			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
 			return
 			;;
 		-f)
@@ -2839,7 +2852,7 @@ _git_tag ()
 		;;
 	-*|tag)
 		if [ $f = 1 ]; then
-			__gitcomp_nl "$(__git_tags)"
+			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
 		fi
 		;;
 	*)
-- 
2.12.1.485.g1616aa492

