Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326AE211B3
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLIUFN (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53248 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIUFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so8874582wmi.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cs57XMhhnD3KJ2N17/GozYJKucxi7bms2I7nY+6b5bM=;
        b=tFIwkG8pl5REylpKpEZYIHs10FehCvyxy5w/fg4164yZeFgwFbqINFA5LdNm2UyD2v
         p23M26cXOHmxzDWLrLApg8xAr+99UVoa6dtsCwFzyvuGIHxL22uffTXjOZPe+96s/zNR
         Tl5LArFb7IiNmimeYhR5U7mKaD4wPJUVtycnzomQBgCbXujKsuCdgDzvT63aK/jLRo0q
         puEpCydBo5v4eoSFDZS2T2xpZDu9+uM/GrG5a39OIOxt6RLowMoTDCFx1nzjd75mak4d
         4OhVte6bG+ddJHFjMBQ4KBuPK5dWK2BhrSxgY3pkA0AB8p8okUSDd/J/BJr2GFpAHjps
         0wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cs57XMhhnD3KJ2N17/GozYJKucxi7bms2I7nY+6b5bM=;
        b=rLAlmgmJyyo+TAjJkj9jabeHA4k2Sr4Z2e/hjGmR/5fb7N0REpDP4iqcdxwga7dAq2
         SrzZKE+QEpjwiOMJgUUsj+zAJZtjFevVB/fg86ytmekd8/6e9sRd0486ZFX0CWR42ChI
         O8678vhBE1t//7+VGV3kttN2CwCPVHYJxgTOyWqmTqviUBDURosjq8g2QWfpWhW5rzcZ
         gB1o30krIVpfJEYM6pmGMvOl29+lWg6czMmpq3en2K1KdAa4cKFzTvli793zytzker+h
         KVaAfsZ4uPbPvCNRAOyXVzc7FOMgzTDbAUcFwLC4Z+HdudEOrIbbjaHBEknbf6XiPkiD
         Jm3w==
X-Gm-Message-State: AA+aEWZ6U3PwMTRXTnwMXvt6m0tdbLVYKEps0iTmJIDZcFpqYxBD1odf
        +Gbe2LyX58/OOtlkt6VssWL03W7J
X-Google-Smtp-Source: AFSGD/Uk7aCoTQn7WIJMtq5U7JzBCF0XR9G2uVSU/9tuy3f7HLjZySUPxdsw0zfNcK7HGewwCZQ3+w==
X-Received: by 2002:a1c:1593:: with SMTP id 141mr2235820wmv.85.1544385909050;
        Sun, 09 Dec 2018 12:05:09 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id y145sm7001647wmd.30.2018.12.09.12.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:05:08 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 8/8] stash: use git checkout --no-overlay
Date:   Sun,  9 Dec 2018 20:04:49 +0000
Message-Id: <20181209200449.16342-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have 'git checkout --no-overlay', we can use it in git
stash, making the codepaths for 'git stash push' with and without
pathspec more similar, and thus easier to follow.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

As mentioned in the cover letter, not sure if we want to apply this
now.  There are two reasons I did this:
- Showing the new functionality of git checkout
- Increased test coverage, as we are running the new code with all git
  stash tests for free, which helped look at some cases that I was
  missing initially.

 git-stash.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 94793c1a91..67be04d996 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -314,19 +314,15 @@ push_stash () {
 
 	if test -z "$patch_mode"
 	then
-		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
-		if test -n "$untracked" && test $# = 0
+		test "$untracked" = "all" && CLEAN_X_OPTION=-X || CLEAN_X_OPTION=
+		if test -n "$untracked"
 		then
-			git clean --force --quiet -d $CLEAN_X_OPTION
+			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
 		if test $# != 0
 		then
-			test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
-			test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
-			git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
-			git diff-index -p --cached --binary HEAD -- "$@" |
-			git apply --index -R
+			git checkout --quiet --no-overlay --ignore-unmatched HEAD -- "$@"
 		else
 			git reset --hard -q
 		fi
-- 
2.20.0.405.gbc1bbc6f85

