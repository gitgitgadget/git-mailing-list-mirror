Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CDC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhLMGcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhLMGcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:14 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6B5C061372
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:07 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id s11so14126198ilv.3
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hn1CKW6++4/5+8GA6JoFYuRpEbYwp+GZI9pe0gFC6nM=;
        b=KbYzQodEBPTeJNlhjw0fPHQnrPkpyoZX2CvQaz7gaJhHkgYX3IlTTXMHBuu2SKT55J
         eX4US6u35I8FnhAc2poFifD1SUQP0zn9d7aALAo89lcP3kx4PS8vc/iOokFQnC6W1dew
         bI7FojgeAeE2Fp3PI6iFLnGNQWskWYGYAataTVKZMr4JF8UfGkuNryPBZbI+7cH+3v8d
         bWhckydrksDd+PPy/X0ixeZtE6Giu9gqAOFctjHD7BqP2KXOxtHb2ZKmAXkw2u7+gFu6
         mDnNfRbJmKutEVKHqNHxG2tpyj2cuYbXlHQQe1qNlIiBB/rd53K5NbBJXvEWutal/1Oc
         lKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Hn1CKW6++4/5+8GA6JoFYuRpEbYwp+GZI9pe0gFC6nM=;
        b=xigupVHvzGru6KXnuyk4YTENnF6qzXrcH8vdrRQCHY2piHSDzA/xv6kwPgGbqo4g1s
         Rx0JCmSqw9Vi77HRxViDX1DMgz6MpAoj0Qi9dHsY5HvjZhiimyaPcC2H4wTznnrd8e/w
         EP6vbFdMohO2R1JWVjjHIFJsI5TVH+lKDnLzl9k0e4eIixHK+Ci3TDIZze9E8ymxgmnY
         XWBEfXWRNllZl88tzEOPanPEvoCBWfBjb9k7t3sOIREGN2G8kKgJcwSLovWKoqlIHe2d
         LEhnGPv9woaK4FdsBBE0QNYrA9V9R/9A48PxMGuSamKEI/dqYv7HWqeP65MQc6G5Nd2K
         YRtw==
X-Gm-Message-State: AOAM533oPKbUpF6JFlPiAjkSnV/0JDqamatxomPc/n6gLFq8F6RUWBiC
        6Y7DsjndImYKmdDOdClsebZNUEnqokdgNQ==
X-Google-Smtp-Source: ABdhPJysLIJi1c+B+BLYmsYXLzdJzUU9HTy6vAQpJHNtoaTPwN5woXFyKSh2ZnQHcOAJ4PF7FvqKLg==
X-Received: by 2002:a92:c244:: with SMTP id k4mr29454456ilo.169.1639377127085;
        Sun, 12 Dec 2021 22:32:07 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:06 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/15] chainlint.sed: don't mistake `<< word` in string as here-doc operator
Date:   Mon, 13 Dec 2021 01:30:56 -0500
Message-Id: <20211213063059.19424-13-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tighten here-doc recognition to prevent it from being fooled by text
which looks like a here-doc operator but happens merely to be the
content of a string, such as this real-world case from t7201:

    echo "<<<<<<< ours" &&
    echo ourside &&
    echo "=======" &&
    echo theirside &&
    echo ">>>>>>> theirs"

This problem went unnoticed because chainlint.sed is not a real parser,
but rather applies heuristics to pretend to understand shell code. In
this case, it saw what it thought was a here-doc operator (`<< ours`),
and fell off the end of the test looking for the closing tag "ours"
which it never found, thus swallowed the remainder of the test without
checking it for &&-chain breakage.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                |  8 ++++++--
 t/chainlint/not-heredoc.expect | 14 ++++++++++++++
 t/chainlint/not-heredoc.test   | 16 ++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 t/chainlint/not-heredoc.expect
 create mode 100644 t/chainlint/not-heredoc.test

diff --git a/t/chainlint.sed b/t/chainlint.sed
index b382746526..2f786f890d 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -89,6 +89,7 @@
 # here-doc -- swallow it to avoid false hits within its body (but keep the
 # command to which it was attached)
 /<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/ {
+	/"[^"]*<<[^"]*"/bnotdoc
 	s/^\(.*\)<<-*[ 	]*[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 	s/[ 	]*<<//
 	:hered
@@ -100,6 +101,7 @@
 	s/^<[^>]*>//
 	s/\n.*$//
 }
+:notdoc
 
 # one-liner "(...) &&"
 /^[ 	]*!*[ 	]*(..*)[ 	]*&&[ 	]*$/boneline
@@ -151,8 +153,10 @@ s/.*\n//
 	/"[^'"]*'[^'"]*"/!bsqstr
 }
 :folded
-# here-doc -- swallow it
-/<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/bheredoc
+# here-doc -- swallow it (but not "<<" in a string)
+/<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/{
+	/"[^"]*<<[^"]*"/!bheredoc
+}
 # comment or empty line -- discard since final non-comment, non-empty line
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
diff --git a/t/chainlint/not-heredoc.expect b/t/chainlint/not-heredoc.expect
new file mode 100644
index 0000000000..2e9bb135fe
--- /dev/null
+++ b/t/chainlint/not-heredoc.expect
@@ -0,0 +1,14 @@
+echo "<<<<<<< ours" &&
+echo ourside &&
+echo "=======" &&
+echo theirside &&
+echo ">>>>>>> theirs" &&
+
+(
+	echo "<<<<<<< ours" &&
+	echo ourside &&
+	echo "=======" &&
+	echo theirside &&
+	echo ">>>>>>> theirs" ?!AMP?!
+	poodle
+) >merged
diff --git a/t/chainlint/not-heredoc.test b/t/chainlint/not-heredoc.test
new file mode 100644
index 0000000000..9aa57346cd
--- /dev/null
+++ b/t/chainlint/not-heredoc.test
@@ -0,0 +1,16 @@
+# LINT: "<< ours" inside string is not here-doc
+echo "<<<<<<< ours" &&
+echo ourside &&
+echo "=======" &&
+echo theirside &&
+echo ">>>>>>> theirs" &&
+
+(
+# LINT: "<< ours" inside string is not here-doc
+	echo "<<<<<<< ours" &&
+	echo ourside &&
+	echo "=======" &&
+	echo theirside &&
+	echo ">>>>>>> theirs"
+	poodle
+) >merged
-- 
2.34.1.397.gfae76fe5da

