Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461FDC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0120CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+Ihpl+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgAaWSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:18:23 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:56016 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgAaWSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 17:18:23 -0500
Received: by mail-pj1-f73.google.com with SMTP id s6so5038441pjr.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rqTlNeKSIVcc/wijbGHnrvlXmpLJX2aep02ZogehKKU=;
        b=U+Ihpl+TcLg1i1ljRBjz2yVwR5Cuph3ID35wRbQjfnLjMF7nVXUEYyW335xx6wnQ8F
         6NInpQ0XAhrusMzJW4yV60OGa3FWcT8elhzaXI+litfJEwulxaXzbtcp+WOU0hySJNma
         T1zK8hMqy66SZFvQM//yGkuQQPz6lk2TTvOWBMGUBZ1hHxlhIswymktpYMbl93DtkzTL
         SNNpLTJWvBpQqTu2v4PdHeqoBY+1M/MfaW3UDyGhXd8U9+21w1zpPOB8+RhyZrmiu1N0
         vDNjHSX0/CZSTmffB218uR5JLupcZgfnmnsvNHfn7eME/zbhhtR+7cAN+BaMzoW7SSrI
         5hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rqTlNeKSIVcc/wijbGHnrvlXmpLJX2aep02ZogehKKU=;
        b=RpaLIULx08PGtvxONX5QIWSKn3u7Sm3MQZhNALfx/wSd+2Jbg19udE91vtnMtnEjK1
         qKCkI5VSUFr0VbmVk8yfPto2I5KcF46MLXqnBYMbnPAWzidbpA9zq0Gg6GKt+M5q9nq5
         d8As6LPPFHxPdG17zhZEiwWt/27a/kuE6tz9pxi6Eyjm/AHGi8hXEBU9BPoxq8ENf56n
         mSwMdQhSjtSpqN0gfdJ1RuGwY4/oudqka1p6bFDoNH+4nsB3AunVkGQZjlt//pAVfxHy
         oTKzJa72PTNbVBxDhgDYk0XoPbX8QGCkXL8W3b7/x4jf0O9MKoWSrWgXh7DbcoqMyhCN
         b/TA==
X-Gm-Message-State: APjAAAX/XYSFTNqo76RKACHxjx0AzD6SL7gky7gTfVS9J9tK/iQANLRy
        xymGfiVed1B+v/UCK4vRbzqC4o8FFYyZLHC3x+3LN/dUXCdCytphQ2ZtuSMs2UMiluvImddxiGs
        NIBf90jHVYQxNp6j6EOScpt8hDbO2R9FjdRvadmzEptZti9wUBF7atWY57eukAbYmi0xB7QJeuQ
        ==
X-Google-Smtp-Source: APXvYqyDCSkrB8ghm/zLTMdNG8znizXYHBCgBp5oY5Kv8J9uWpQPTJDBlXwaeU5u9CThHbE96TiL/geUhvcElazSiL0=
X-Received: by 2002:a63:e809:: with SMTP id s9mr1523200pgh.108.1580509100712;
 Fri, 31 Jan 2020 14:18:20 -0800 (PST)
Date:   Fri, 31 Jan 2020 14:18:00 -0800
In-Reply-To: <20200130225818.193825-1-masayasuzuki@google.com>
Message-Id: <20200131221800.240352-1-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20200130225818.193825-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] doc: describe Git bundle format
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bundle format was not documented. Describe the format with ABNF and
explain the meaning of each part.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
Changes from v1:

* Update the ABNF definition so that prerequisites come before references.
* Adopt Junio's suggestion on the semantics section.
* State that the receiver MUST ignore the comments in the prereqs.
* Change "you" to "the receiver" and "the sender" (I wonder if this should be
  "writer" and "reader").

 Documentation/technical/bundle-format.txt | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/technical/bundle-format.txt

diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
new file mode 100644
index 0000000000..f568fcd7d1
--- /dev/null
+++ b/Documentation/technical/bundle-format.txt
@@ -0,0 +1,41 @@
+= Git bundle v2 format
+
+The Git bundle format is a format that represents both refs and Git objects.
+
+== Format
+
+We will use ABNF notation to define the Git bundle format. See
+protocol-common.txt for the details.
+
+----
+bundle    = signature *prerequisite *reference LF pack
+signature = "# v2 git bundle" LF
+
+prerequisite = "-" obj-id SP comment LF
+comment      = *CHAR
+reference    = obj-id SP refname LF
+
+pack         = ... ; packfile
+----
+
+== Semantics
+
+A Git bundle consists of three parts.
+
+* "Prerequisites" lists the objects that are NOT included in the bundle and the
+  receiver of the bundle MUST already have, in order to use the data in the
+  bundle. The objects stored in the bundle may refer to prerequisite objects and
+  anything reachable from them and/or expressed as a delta against prerequisite
+  objects.
+
+* "References" record the tips of the history graph, iow, what the receiver of
+  the bundle CAN "git fetch" from it.
+
+* "Pack" is the pack data stream "git fetch" would send, if you fetch from a
+  repository that has the references recorded in the "References" above into a
+  repository that has references pointing at the objects listed in
+  "Prerequisites" above.
+
+In the bundle format, there can be a comment following a prerequisite obj-id.
+This is a comment and it has no specific meaning. The sender of the bundle MAY
+put any string here. The receiver of the bundle MUST ignore the comment.
-- 
2.25.0.341.g760bfbb309-goog

