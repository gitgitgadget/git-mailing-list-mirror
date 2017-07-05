Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480F9202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdGERAt (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:00:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36781 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbdGERAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:00:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so32862703pgn.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=smGJbqGkXyGpFu8qTvAdQtqgNP6uMpYQCSjlkeX5HCc=;
        b=a6vbCKduMrTp6saTfV02oo+D2S36L9zrj2z6AynvJO4RjojwcMluoK/xWDzgxnpV8V
         NBPXu4mwpY2fsd+32tWu7EA3x1DFN/GRAGS7oFr3h7I5szPwHHi8wHpThz9txs/qlD5Q
         pA1FoBHnpMfYwTzbcKt6q1fQjOxqTFzhwHJRGo/hh9YYmOT+Ej0IzR+NLG06ksSRvABm
         XxORjOwmro7GRLIMYbp5GODSs/tdr/xnd6fWagC3zp8OluyJDetpA8ox1sv55fHgjfgz
         pS8PrJRDOzNie0THvrG3OcXZXNoYSMSIy1KLC0GAo+RI4JwaJvB+SdE+n6qwCyw7EMrM
         1gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=smGJbqGkXyGpFu8qTvAdQtqgNP6uMpYQCSjlkeX5HCc=;
        b=areUQ74xORXwBOwum70j0fUgXYfhzQqoS7jdV2W4Ziq0gAowcPjkvsCrevu0oVwuvy
         7zV/rEKKhAA/WCa5+LS6ZF9sif0DWXxONYfdVfBdL2gz+r3pz9p2+978hYsEci+7y7n5
         KaxU/1tRS2Wh8gKFDSSSzd93JSlPB8EGjTRMgOgXnN4I7PQC5p16Ks9BrJe4iok7KCWU
         GbpIBTlBYXHlfgvtd2T4veMhlqFae1JSwusrAAVuPgdak3bNJu9qaO7XN3BJNw4krOch
         aOOD68synFs34EQCE7g5pZMbGYCeSkARq/6M72uBfyTjTJ2WbIO+OH4wbivEGcbHrKbu
         VLAw==
X-Gm-Message-State: AIVw113M/FBG8ovoJcRbWVRlbYXSIgry7a3GPs0fOhdEhzw4jMGJF/lZ
        5qN45DiScyENPA==
X-Received: by 10.84.232.198 with SMTP id x6mr17450214plm.139.1499274047638;
        Wed, 05 Jul 2017 10:00:47 -0700 (PDT)
Received: from localhost.localdomain ([117.209.150.242])
        by smtp.gmail.com with ESMTPSA id r9sm52697613pfi.114.2017.07.05.10.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 10:00:45 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] hooks: add signature using "interpret-trailers"
Date:   Wed,  5 Jul 2017 22:30:34 +0530
Message-Id: <20170705170034.20899-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.29.g419244dab
In-Reply-To: <1499195804.6428.2.camel@gmail.com>
References: <1499195804.6428.2.camel@gmail.com>
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
  Removed the GNUism in sed command. In case no other changes are
  required this one's the final patch.

 templates/hooks--prepare-commit-msg.sample | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f22..f404f8f 100755
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
+#  sed -e "1i$NEW_LINE" "$COMMIT_MSG_FILE" >"$SED_TEMP_FILE" && mv "$SED_TEMP_FILE "$COMMIT_MSG_FILE"
+# fi
-- 
2.7.4

