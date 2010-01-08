From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 4/6] transport.c::transport_push(): make ref status affect return value
Date: Fri,  8 Jan 2010 10:12:43 +0800
Message-ID: <1262916765-3728-5-git-send-email-rctay89@gmail.com>
References: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
 <1262916765-3728-2-git-send-email-rctay89@gmail.com>
 <1262916765-3728-3-git-send-email-rctay89@gmail.com>
 <1262916765-3728-4-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:14:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4Ml-0005XW-0m
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab0AHCNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302Ab0AHCNv
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:13:51 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:35828 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab0AHCNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:13:49 -0500
Received: by mail-yx0-f188.google.com with SMTP id 26so18313338yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=po0AjtxclTOJp4k4UxFrSbR519PHmY1MrdZIWlNEaf0=;
        b=wwfZy+FK9DA7rz7pMlL0T91OT0CdOpxDsDUIiKsemQHk1WBbJHGDxgMrqML13hhzD3
         oHKbNNmdVY5LPGfFjbOSMWLlLai19o0QhdHHObXrfMWc73MWsjKS1iAB3YiarlXdXI/V
         +gQcjXFbzCxNkW5FJIabxQ2kZ7IdTAfH1Zqh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MwmHAbKOm4NQl3WcLvYFE1FzE28GvYOjGQAe5n4INzRq0W3p1Q/tSGTcV9L3JBNIKu
         pG/mLFJ8eMfnU9EwYkpegtMPOlDVXcxlQ7EEJez+KohBeowu7n/J8WXrHqmzFtbu/G7Z
         7eTm/InrtD7miT3qPvCte5ULDUvxFu1KOiM70=
Received: by 10.101.132.11 with SMTP id j11mr760883ann.107.1262916829041;
        Thu, 07 Jan 2010 18:13:49 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm10999449gxk.10.2010.01.07.18.13.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 18:13:48 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262916765-3728-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136409>

Use push_had_errors() to check the refs for errors and modify the
return value.

Mark the non-fast-forward push tests to succeed.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |    4 ++--
 transport.c          |    7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 6d92196..979624d 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -88,7 +88,7 @@ test_expect_success 'used receive-pack service' '
 	test_cmp exp act
 '
 
-test_expect_failure 'non-fast-forward push fails' '
+test_expect_success 'non-fast-forward push fails' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout master &&
 	echo "changed" > path2 &&
@@ -104,7 +104,7 @@ test_expect_success 'non-fast-forward push show ref status' '
 	grep "^ ! \[rejected\][ ]*master -> master (non-fast-forward)$" output
 '
 
-test_expect_failure 'non-fast-forward push shows help message' '
+test_expect_success 'non-fast-forward push shows help message' '
 	grep \
 "To prevent you from losing history, non-fast-forward updates were rejected
 Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
diff --git a/transport.c b/transport.c
index 12c4423..9b23989 100644
--- a/transport.c
+++ b/transport.c
@@ -875,7 +875,7 @@ int transport_push(struct transport *transport,
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
 		int quiet = flags & TRANSPORT_PUSH_QUIET;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
-		int ret;
+		int ret, err;
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -892,8 +892,11 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_FORCE);
 
 		ret = transport->push_refs(transport, remote_refs, flags);
+		err = push_had_errors(remote_refs);
 
-		if (!quiet || push_had_errors(remote_refs))
+		ret |= err;
+
+		if (!quiet || err)
 			print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
 					nonfastforward);
-- 
1.6.6.341.ga7aec
