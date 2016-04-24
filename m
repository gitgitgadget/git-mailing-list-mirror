From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 53/83] builtin/apply: make find_header() return -1 instead of die()ing
Date: Sun, 24 Apr 2016 15:33:53 +0200
Message-ID: <1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCo-0008GD-SH
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbcDXNgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:07 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33657 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDXNgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:01 -0400
Received: by mail-wm0-f45.google.com with SMTP id 127so17918510wmz.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wxDDlblSkTv7Ss15mSjIY5YAyS1p8LtnlnCyE5Fufro=;
        b=Vi2ClkbdP7ZCaXsmx2J2+mnwUx7k0Wb7mOlZ2fgwW5qYdouo7PequKNE2b8T/vUbtR
         UifqK72JNBgu05L9lItbD2xML3wiXPPojMjS9fsNOqImqc7I3yWuZ7x7DHYrTsLTrpgc
         uATgNO0/2lko6uQS320hfTCQIa5eYWlDfy4tx3OIJuUmQwxbwkJn4g6lFk8eOJFtxXDh
         p0qIdjqocjgGQSHKRxQl70RwdhLBPyz1+9xrOFX4sfLgeIB/XozJZGFhH9aDM2OlNQCf
         JnHUU4lobH6kBghJo3HOS+Owse23PvhqSk1cnnburzOD3kbBo0q7S7gmsxAM0Tywsr/p
         OcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wxDDlblSkTv7Ss15mSjIY5YAyS1p8LtnlnCyE5Fufro=;
        b=FP9Vx02GYwKsiCJTGf3BGr5+mvoeUzpehpFQ0NxG8pTpkEBGqsSQDnh4EKQpQFDvdZ
         pVlCNyZwXe/yPj/4L++8VTn3aqIOC/YBZ9rqd8gUrfQTRauVat+f4K8q9FSopblUMtEX
         znVJmWOxeyR8AOTiWNT3y5UyG/RA1TyBCkSOWwXpMHBY8iYG+kfraNoUdoLN86V7QTLL
         BFMmATZiyDCyO07iYnDNWl3Xt4uRPPHHDl7X/jyxFncuXGnpTptOm0AarrYPg0Hhjx8s
         5j72g4gK+7XCVcUxU11/hnbphdG+2dUxjHmMLUUabgDhnP4Zjp97TLphGRNMgjicPiRi
         CJrA==
X-Gm-Message-State: AOPr4FWn1Vej6hFvWzT9TDhj10h8tM74gcU587QBXkw5G+5sr2rIBH/MVMrHjq5DhWsRpg==
X-Received: by 10.28.135.200 with SMTP id j191mr7273118wmd.54.1461504960340;
        Sun, 24 Apr 2016 06:36:00 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:59 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292349>

To be compatible with the rest of the error handling in builtin/apply.c,
find_header() should return -1 instead of calling die().

Unfortunately find_header() already returns -1 when no header is found,
so let's make it return -2 instead in this case.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c       | 33 ++++++++++++++++++++++-----------
 t/t4254-am-corrupt.sh |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c0bb24c..825ffe9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1538,6 +1538,14 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
 	return offset;
 }
 
+/*
+ * Find file diff header
+ *
+ * Returns:
+ *  -1 in case of error
+ *  -2 if no header was found
+ *   the size of the header in bytes (called "offset") otherwise
+ */
 static int find_header(struct apply_state *state,
 		       const char *line,
 		       unsigned long size,
@@ -1571,8 +1579,8 @@ static int find_header(struct apply_state *state,
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			die(_("patch fragment without header at line %d: %.*s"),
-			    state->linenr, (int)len-1, line);
+			return error(_("patch fragment without header at line %d: %.*s"),
+				     state->linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1588,18 +1596,18 @@ static int find_header(struct apply_state *state,
 				continue;
 			if (!patch->old_name && !patch->new_name) {
 				if (!patch->def_name)
-					die(Q_("git diff header lacks filename information when removing "
-					       "%d leading pathname component (line %d)",
-					       "git diff header lacks filename information when removing "
-					       "%d leading pathname components (line %d)",
-					       state->p_value),
-					    state->p_value, state->linenr);
+					return error(Q_("git diff header lacks filename information when removing "
+							"%d leading pathname component (line %d)",
+							"git diff header lacks filename information when removing "
+							"%d leading pathname components (line %d)",
+							state->p_value),
+						     state->p_value, state->linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
 			if (!patch->is_delete && !patch->new_name)
-				die("git diff header lacks filename information "
-				    "(line %d)", state->linenr);
+				return error("git diff header lacks filename information "
+					     "(line %d)", state->linenr);
 			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
@@ -1624,7 +1632,7 @@ static int find_header(struct apply_state *state,
 		state->linenr += 2;
 		return offset;
 	}
-	return -1;
+	return -2;
 }
 
 static void record_ws_error(struct apply_state *state,
@@ -2115,6 +2123,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
 
+	if (offset == -1)
+		exit(1);
+
 	if (offset < 0)
 		return offset;
 
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 85716dd..9bd7dd2 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -29,7 +29,7 @@ test_expect_success 'try to apply corrupted patch' '
 '
 
 test_expect_success 'compare diagnostic; ensure file is still here' '
-	echo "fatal: git diff header lacks filename information (line 4)" >expected &&
+	echo "error: git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
 	test_cmp expected actual
 '
-- 
2.8.1.300.g5fed0c0
