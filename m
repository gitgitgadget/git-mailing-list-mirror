Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04EB202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 17:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdGERf4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:35:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35608 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbdGERf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:35:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so7570613pfq.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MpmY/tz66NQJs8VTW3q6sGXDdRu/lzbAurdHO9ptODQ=;
        b=jr8jg2/b11CpQaR2WRkWzsldkq6mPhK79KHDftbhos8zFiL2MGNGztmhCDnG7nL1uw
         +B0XMyRQallBfT5WidL/PaOs5HUYAJshB7RrJqQdC0KmE+to/8vqiBV9zZ9seavbfud0
         bzVMxLNjoaT+E25WcUJIsh996/lu48pvE5ieM0MTvKiVgvY9VG1whYACYXMCxzMmC0GB
         CJa/xDDUhmfCVwuTo9bb9wtg2DQtziSBcyKh0spjGZHUTkYR30bSW5YpmAHZrrPHqXVh
         3y9XfQgNtvJxKqB+9BKryC8sv11pIQwE75DLGsvx9w9XA/jnOc4VVUoUiYg5f+23RCzb
         BXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MpmY/tz66NQJs8VTW3q6sGXDdRu/lzbAurdHO9ptODQ=;
        b=Pdfl7HdjkI2SFxw8PAKLy8WnfDWQCzZNyqlc0fmYQ0iOVgwVOe2eMQxW4CuRt5oBG8
         0n4MNOnbNrBpvp46Omsu9gYfEx66qwUZfF95CpYEXSy4Y2uqdd0qrBQEjg8ov7ufW1lA
         G9QGQBQ1JoI0zV9lwvbSLAtWAFAUAJWAKUJHIsHKUgg6oIzhDtwrSYUJIzeJ9V0w//q5
         NGfn2MiVoktfKa7iuZDmenswZxmYds/9MAxTdhdR2EfjscpFEDRYUdZTHYQ9AuTCVKLA
         0+Xo3yIjazZComxW4aGtFigZnlI/7HiW/OT1pFAZuNLLbjtpUsaiaJyA7CoPPIbYy8A0
         Nuog==
X-Gm-Message-State: AIVw112qTgKuarbT9gOo05qKZgv/UAfVUuIYRF5ZV7yS02u2gr93Chd9
        PYHH5fdWfv/UAuV7nTf55g==
X-Received: by 10.84.248.66 with SMTP id e2mr23665287pln.118.1499276155236;
        Wed, 05 Jul 2017 10:35:55 -0700 (PDT)
Received: from localhost.localdomain ([117.209.204.103])
        by smtp.gmail.com with ESMTPSA id g184sm50251058pfb.3.2017.07.05.10.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 10:35:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] hooks: add signature using "interpret-trailers"
Date:   Wed,  5 Jul 2017 23:05:08 +0530
Message-Id: <20170705173508.28711-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.1.78.gbaba0bc7d
In-Reply-To: <20170705170034.20899-1-kaarticsivaraam91196@gmail.com>
References: <20170705170034.20899-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sample hook to prepare the commit message before
a commit allows users to opt-in to add the signature
to the commit message. The signature is added at a place
that isn't consistent with the "-s" option of "git commit".
Further, it could go out of view in certain cases.

Add the signature in a way similar to "-s" option of
"git commit" using git's interpret-trailers command.

It works well in all cases except when the user invokes
"git commit" without any arguments. In that case manually
add a new line after the first line to ensure it's consistent
with the output of "-s" option.

While at it, name the input parameters to improve readability
of script.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Added a close quote that got missed in the previous patch.

 templates/hooks--prepare-commit-msg.sample | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..4ddab7896 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -20,17 +20,28 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2,$3" in
+COMMIT_MSG_FILE=$1
+COMMIT_SOURCE=$2
+SHA1=$3
+NEW_LINE='\
+'
+SED_TEMP_FILE='.sed-output.temp'
+
+case "$COMMIT_SOURCE,$SHA1" in
   merge,)
-    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
+    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$COMMIT_MSG_FILE" ;;
 
 # ,|template,)
 #   @PERL_PATH@ -i.bak -pe '
 #      print "\n" . `git diff --cached --name-status -r`
-#	 if /^#/ && $first++ == 0' "$1" ;;
+#	 if /^#/ && $first++ == 0' "$COMMIT_MSG_FILE" ;;
 
   *) ;;
 esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
-# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+# git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
+# if [ -z "$COMMIT_SOURCE" ]
+# then
+#  sed -e "1i$NEW_LINE" "$COMMIT_MSG_FILE" >"$SED_TEMP_FILE" && mv "$SED_TEMP_FILE" "$COMMIT_MSG_FILE"
+# fi
-- 
2.13.1.78.gbaba0bc7d

