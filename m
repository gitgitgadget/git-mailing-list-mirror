Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6648C20966
	for <e@80x24.org>; Mon,  3 Apr 2017 00:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdDCAt4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 20:49:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36446 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdDCAt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 20:49:56 -0400
Received: by mail-pg0-f65.google.com with SMTP id 81so26083930pgh.3
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=NHta9kGDijJvHwNqGxYSLW42XZqzQHbAnKMkBso1YPQ=;
        b=mZaH2kMGkqRK0CFkc5Hc56dUhdCX+djSJQz+YAlGSU/iuqONcKEsds+Ycj63q7qOQf
         znFA95X/mTf9MvnMbCETj1kG89uHkPuDsrR8stATKzFLldXYlc3Z8JBOXFjx+0YXlpYi
         h6qKvlFjf8U/MA+mbay2yh1TDxACzJcw0bmUVHpCEU7llZCQmFCRI+MQTEyVKcj0gasr
         pl7o8pdErPTCeNAaD7gbpBMWbMazEmLeHAH7oleJSSzg/6bA93oIjRNFaMnzCbY0/ZnZ
         69zueqseI/U8zN/Rbq6BV9gtbgkJtyYeWjreoYnZOILV3fspXfS63YTUDZB1onXULBNH
         Nolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=NHta9kGDijJvHwNqGxYSLW42XZqzQHbAnKMkBso1YPQ=;
        b=GdvWLCv5abZ3Qft1ASSxsTP4PnpCeaDiL5qNdKvolYIFZIL5bWCNiVreJtOQxxWnYM
         I1oRSLQPYPdloHGD2t7DpjvXZ0VXVF+0bFNNB/G20sPS2UwNlBC45wmW5AGEnD2rmr7t
         1a4J/qUbGZQyxqD5JdPxMUpvQ9qgYcogsdozbJaqKmMJAak/uP51NqS6QaY4oF7+1TgK
         ctvkxra+dslB34CKGZFpDDb7e87zhH2x4GlSBa46AC4Oia/qqYKl/3Rep1iLUmMuYHsp
         LBM4untyur/lEnlDWs9JjpR/nqCf1Fh8WGfIuHAHKc+WW5/PW5Ud+B3ZOMVQRj9u+/9O
         enTQ==
X-Gm-Message-State: AFeK/H3np6f5PeytG6u2SRxSIqVy5DkNDodx2NtuHz39q6jFbVGPKfJp1eZJW80CsrHbLA==
X-Received: by 10.84.173.228 with SMTP id p91mr18281565plb.18.1491180595319;
        Sun, 02 Apr 2017 17:49:55 -0700 (PDT)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id j188sm21956238pfg.27.2017.04.02.17.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Apr 2017 17:49:54 -0700 (PDT)
Date:   Sun, 2 Apr 2017 17:49:54 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] Fix 'git am' in-body header continuations
Message-ID: <alpine.LFD.2.20.1704021746180.22832@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Apr 2017 12:14:39 -0700
Subject: [PATCH] Fix 'git am' in-body header continuations

An empty line should stop any pending in-body headers, and start the
actual body parsing.

This also modifies the original test for the in-body headers to actually
have a real commit body that starts with spaces, and changes the test to
check that the long line matches _exactly_, and doesn't get extra data
from the body.

Fixes:6b4b013f1884 ("mailinfo: handle in-body header continuations")
Cc: Jonathan Tan <jonathantanmy@google.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

On Sun, 2 Apr 2017, Junio C Hamano wrote:
> 
> And that is exactly your patch does.  The change "feels" correct to
> me.

Ok, resent with the test-case for the original behavior changed to be 
stricter (so it fails without this fix), and with Signed-off lines etc.

I didn't really test the test-case very much, but it seemed to fail 
without this patch (because the "Body test" thing from the body becomes 
part of the long first line), and passes with it.

But somebody who is more used to the test-suite should double-check my 
stupid test edit.

 mailinfo.c    | 7 ++++++-
 t/t4150-am.sh | 6 ++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index a489d9d0f..68037758f 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -757,8 +757,13 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	assert(!mi->filter_stage);
 
 	if (mi->header_stage) {
-		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
+		if (!line->len || (line->len == 1 && line->buf[0] == '\n')) {
+			if (mi->inbody_header_accum.len) {
+				flush_inbody_header_accum(mi);
+				mi->header_stage = 0;
+			}
 			return 0;
+		}
 	}
 
 	if (mi->use_inbody_headers && mi->header_stage) {
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 89a5bacac..44807e218 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -983,7 +983,9 @@ test_expect_success 'am works with multi-line in-body headers' '
 	rm -fr .git/rebase-apply &&
 	git checkout -f first &&
 	echo one >> file &&
-	git commit -am "$LONG" --author="$LONG <long@example.com>" &&
+	git commit -am "$LONG
+
+    Body test" --author="$LONG <long@example.com>" &&
 	git format-patch --stdout -1 >patch &&
 	# bump from, date, and subject down to in-body header
 	perl -lpe "
@@ -997,7 +999,7 @@ test_expect_success 'am works with multi-line in-body headers' '
 	git am msg &&
 	# Ensure that the author and full message are present
 	git cat-file commit HEAD | grep "^author.*long@example.com" &&
-	git cat-file commit HEAD | grep "^$LONG"
+	git cat-file commit HEAD | grep "^$LONG$"
 '
 
 test_done
-- 
2.12.2.578.g5c4e54f4e

