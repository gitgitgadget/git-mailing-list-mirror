Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC402095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbdCUWM1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:12:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34369 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758247AbdCUWMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:12:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so5589531wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 15:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KoFeKgxGXIkQ/A4a4ER1MWg1zkKeL9ajP/UIoH9CHEY=;
        b=HLIXGUbcEW18PzF3DcE6hVDVxGffe3mbrCNLwKLi2Uhj8p2lumHvwwh0J/bvXqX8Qi
         /f65fojDpIaE4FT09Wng/RcHG7YX/F0lZaAVk8tYftb4kWUGhGl5mhwfFozLteCxhL/s
         aOZf7zpwFE84FqveO6p48TspGhIv7sid962xXu9Jw5BQyQdcRu9YdlnfY6jvvWlkvH6O
         LAtIG0QwMmMz2D0US6RI8V+4dC9lgHY0ZFRR2nAPweN6mrLGS2FB1NVEskLybaRJ6GpJ
         5BDcTPWzT0E7lZ1ltZJZU7d22r1efjTQILFKCVO/vGkBzJTDBIcUhhXnzONXnJJlmGEr
         hrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KoFeKgxGXIkQ/A4a4ER1MWg1zkKeL9ajP/UIoH9CHEY=;
        b=UXtHZEjyGKCQgGpDO+zKqIbLnkVeNkzYE51szbnslrDcRvdp1HkDOcXzM4sKGtftpU
         Y9sJBPkTvz4xs9z3y5q6swxU9XpfwrzCz6enmmFmTGPETEw3g/OqR46sbiPE25W9T4vA
         Eyt1VHlgo7S9K6Uj03dSVScUHTe+3s9dGudnjMe9gaoaU9d6rftZ/fGCHev8Ixgo0qxV
         pK1IpFvGQHF0mOkOsnU+++NMzSejlKMOGw5hKziA3xAu2nIQiPl4uRZDD4im61BAdD/5
         95EoF73wOIzjqlrP3RKPHWWGvuPv8h1Kh9FIP/Km0r2+8jPgjpM2Nd/AGCxaYgZ73hDY
         4nCg==
X-Gm-Message-State: AFeK/H2KO8BvvACZHV0ZgKHWPPA/da4/kJ0aoY938FriNBjsB9Mhe9A6Tq1Vkt/tM1As5g==
X-Received: by 10.28.46.213 with SMTP id u204mr4557168wmu.136.1490134329752;
        Tue, 21 Mar 2017 15:12:09 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id r2sm19191881wmb.26.2017.03.21.15.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Mar 2017 15:12:09 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] stash: keep untracked files intact in stash -k
Date:   Tue, 21 Mar 2017 22:12:19 +0000
Message-Id: <20170321221219.28041-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.401.g98d3b1bb99.dirty
In-Reply-To: <20170321221219.28041-1-t.gummerer@gmail.com>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when there are untracked changes in a file "one" and in a file
"two" in the repository and the user uses:

    git stash push -k one

all changes in "two" are wiped out completely.  That is clearly not the
intended result.  Make sure that only the files given in the pathspec
are changed when git stash push -k <pathspec> is used.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     |  4 +++-
 t/t3903-stash.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 13711764a9..2fb651b2b8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -314,7 +314,9 @@ push_stash () {
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
 		then
-			git read-tree --reset -u $i_tree
+			git read-tree --reset $i_tree
+			git ls-files -z --modified -- "$@" |
+			git checkout-index -z --force --stdin
 		fi
 	else
 		git apply -R < "$TMP-patch" ||
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ea8e5c7818..6f6e31cc6d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -907,4 +907,18 @@ test_expect_success 'stash without verb with pathspec' '
 	test_path_is_file bar
 '
 
+test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
+	git reset &&
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	git commit -m "test" &&
+	echo "foo" >foo &&
+	echo "bar" >bar &&
+	git stash -k -- foo &&
+	test "",bar = $(cat foo),$(cat bar) &&
+	git stash pop &&
+	test foo,bar = $(cat foo),$(cat bar)
+'
+
 test_done
-- 
2.12.0.401.g98d3b1bb99.dirty

