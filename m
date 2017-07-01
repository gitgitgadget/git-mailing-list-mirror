Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8938320209
	for <e@80x24.org>; Sat,  1 Jul 2017 17:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbdGARdG (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:33:06 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34203 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdGARdF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 13:33:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so18674917pge.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pfUx4LW1eqf3m6n+8sU4zU0qGKNBsWaKQSwO4Pxgxg8=;
        b=XQL7Y+ZiHL60JSEDtvfT0p9KhgKRs9VV/7Y1N7ukiCt3IxnIGLRVDy/RSZ0SdM/uUM
         i47tAvMJajgMnSS+r1Cyt4tg85/ieKikfAVvsT7VoQnSNiDiyLP4Taxm8NRrP/lWAIxN
         1mNbzbHEUaxNXTkLox9pv8Nb70heWD15Hjh+ancumqg9R9EungRuuTx/hnFYarptY4+b
         Yr7q2NbbSYFUxcM7wB7Q3D6WbT/iRbc5xXGRfPvGA1cqbUFr+BV78o40LahbJenAGdcV
         JNMK/pa7ND28wiUnV0DHjFwkyFvKHloDGzr79bU10A15gDuQJxkGY6cNqZ6kGPRv74fF
         nn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pfUx4LW1eqf3m6n+8sU4zU0qGKNBsWaKQSwO4Pxgxg8=;
        b=tEPgOBmlv4Zm2EIUa9KXVIgITHINTsXmNmzac5KMM8gNU5NMWCZq+qAJt6ZWohKvmE
         0UEq1XhimNhAxxDXUFa8x3Dj+OofmGWLNL0rjh3HwkVSSXYAfYSZtNTgPST/1ByR3KN2
         /Nf0gFdefKQnqf9uMaepAmbXtvUumV+dfJ74m3r7osYgHoKNYoyheVaggTUoTAM99S8a
         01vvVOogoQyBQtpXZb8671lHr61XIGELPv2j/yXOySEEmZrR6ufSa+op+93EZhDi7xL3
         WQvHJcGNbefhMYtHwhgUSX3CYnswdyJqpJSdWmqcQWKLI1ami6O/6YfH2Cfxzj4rG9oL
         vD3w==
X-Gm-Message-State: AIVw112g5TekxOvE69hERhJW6GlNGaxdnmReNas1iiRZouIBxDEHfn0R
        ymqdeAm0/rTIqg==
X-Received: by 10.84.129.71 with SMTP id 65mr1660982plb.183.1498930385015;
        Sat, 01 Jul 2017 10:33:05 -0700 (PDT)
Received: from localhost.localdomain ([157.50.10.225])
        by smtp.gmail.com with ESMTPSA id e189sm24056963pfe.100.2017.07.01.10.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 10:33:04 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH/RFC] hooks: add signature using "interpret-trailers"
Date:   Sat,  1 Jul 2017 23:02:57 +0530
Message-Id: <20170701173257.11272-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1498925790.4321.7.camel@gmail.com>
References: <1498925790.4321.7.camel@gmail.com>
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
 I've tried the various commands that I could think of and it 
 seems to work well. I guess it's safe to use.

 templates/hooks--prepare-commit-msg.sample | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..c44a0a056 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -20,17 +20,27 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2,$3" in
+COMMIT_MSG_FILE=$1
+COMMIT_SOURCE=$2
+SHA1=$3
+NEW_LINE='\
+'
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
+#  sed -i "1i$NEW_LINE" "$COMMIT_MSG_FILE"
+# fi
-- 
2.11.0

