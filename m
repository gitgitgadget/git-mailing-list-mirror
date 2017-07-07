Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83ED202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 16:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdGGQIM (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 12:08:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33008 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdGGQHm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 12:07:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so5154363pfh.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9okjQvURh3BIbWwboKb6C7nggMUrmpquA0zfp5kZl7Q=;
        b=Gdo0ZhFlmr6YzOr24HdkiUfblbQL/OQaVwn7ARy9gfpBxgKa52mYlBc/1fNrpob2Ga
         7Ee44hGpwfru7ZjnARxKmgwMb2YgJbDw8Y1lcbABdlai1leLgUZXsJWDhrgrBHSS8Bkt
         0iG66fkqrI4EX4YZJFrCoKt+hzjyuzT0tJ1jscgOLvn3CFNJczFLObnRfrfNgsqRlSN4
         x75d7Itm+iWE5k4WA1XFp5LmnLqu99/MjQU7EoF8ors9oD0+Z0yGvLDZZ2VYl1EEN2ZR
         gwmHTfSv3VUi9gi3f36sVlh6ye2hJOMrEqZwwGXXDKktrlaI+DmrqbJ9XMyza9sVL0Ke
         5HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9okjQvURh3BIbWwboKb6C7nggMUrmpquA0zfp5kZl7Q=;
        b=K/Ic19jVwXFffvf6GK2E+GulWiSj1XSgVWaumyJgjzxowGxMkxOoKVSlanlWuUybQc
         kvkGY4SD3Z5pirOPLNIc/K/P+PSaO1DPlFvCieuycoZlwxRx0YcgSPk9rAKNS8h3Lmdo
         h3okuJzan1Vyph7LjgIEke/Mq+zQ1pfMSk47KoPzIP4BVUQuuPt3A4DpAPew7qDeCZ/X
         Guzt0ukWLQfoaO/yQ1isBxjGXAOVbAPsChFjSYBY+tU+UrGNNl38v0rbAjelxnwQ+uCC
         adtZaj5znFbzeNTe1Ku/WZk+XR1gt+kLpmH0lgTTFj9frGSozBNsERRx14w1IEWm2hFe
         /mSw==
X-Gm-Message-State: AIVw111GNevzmk2h/OaJKpqtMocWpglw+qObH8tdBj6j1ZcFzB4Oz0OX
        MdZ8av3cH4goTQ==
X-Received: by 10.99.113.76 with SMTP id b12mr2167947pgn.114.1499443661281;
        Fri, 07 Jul 2017 09:07:41 -0700 (PDT)
Received: from localhost.localdomain ([117.243.19.92])
        by smtp.gmail.com with ESMTPSA id 10sm7778603pfo.134.2017.07.07.09.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 09:07:40 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] hooks: add signature using "interpret-trailers"
Date:   Fri,  7 Jul 2017 21:37:40 +0530
Message-Id: <20170707160740.9748-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.879.g2ab69f31a.dirty
In-Reply-To: <20170707160740.9748-1-kaarticsivaraam91196@gmail.com>
References: <1499441062.6829.1.camel@gmail.com>
 <20170707160740.9748-1-kaarticsivaraam91196@gmail.com>
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
 templates/hooks--prepare-commit-msg.sample | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 5a638ebda..7495078cb 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -21,7 +21,12 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-sed -e '/^. Please enter the commit message /,/^#$/d' "$1" >'.sed-output.temp' && mv '.sed-output.temp' "$1"
+COMMIT_MSG_FILE=$1
+COMMIT_SOURCE=$2
+SHA1=$3
+
+SED_OUTPUT_TEMP='.sed-output-temp'
+sed -e '/^. Please enter the commit message /,/^#$/d' "$COMMIT_MSG_FILE" >"$SED_OUTPUT_TEMP" && mv "$SED_OUTPUT_TEMP" "$1"
 
 # case "$2,$3" in
 # ,|template,)
@@ -32,5 +37,14 @@ sed -e '/^. Please enter the commit message /,/^#$/d' "$1" >'.sed-output.temp' &
 #  *) ;;
 # esac
 
+# TEMP_FILE='.template-temp'
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
-# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+# git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
+# if test -z "$COMMIT_SOURCE"
+# then
+#   {
+#     echo
+#     cat "$COMMIT_MSG_FILE"
+#   } >"$TEMP_FILE"
+#   mv "$TEMP_FILE" "$COMMIT_MSG_FILE"
+# fi
-- 
2.13.2.879.g2ab69f31a.dirty

