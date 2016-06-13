From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 04/40] builtin/apply: make find_header() return -1 instead of die()ing
Date: Mon, 13 Jun 2016 18:09:06 +0200
Message-ID: <20160613160942.1806-5-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:12:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUT5-0004vN-Ge
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424803AbcFMQKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36773 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424770AbcFMQKE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so15997068wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3dhIRV/xx1kcgv4ifMQvGraq1psSJciIT+ItgFBcZo=;
        b=guN0HHhp/9Ly3OfFRyesM60qE9yxW0T4vp5Mli+s4vXDA4Y6ka2cg19WVThSQfDdsO
         OO7NVAZDauS2DK2s+fYrRyVuh12bs2B50bf/X3z0a0+ulfGEMeVe8JK2R35PvvHOn2k+
         pDmv1cLVJVVUA9FvCkwUr1nRxmW8mU31IODV+O4kneq5MtLe4yFA4Aa5v8vaK5BGn2/2
         9LKYcL5pV7ZW3hy+pTlJn9NEChqo39AwfoV0LBg/lSGhIlSidQGZWqUvBYU7Gmu5MAbG
         QrJXpXGCbFrveuqRm8MPy3bzQVm4h8Gm3uHnbnJpphiwT5gaFPUyeHcdkkE0WMcHSqBN
         eqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3dhIRV/xx1kcgv4ifMQvGraq1psSJciIT+ItgFBcZo=;
        b=csD8APIYDjBDvOV8No2wtHX1jGRUq9kE0Tpz6MYhVjJRNY9RHe8AlIs0rZb/gOkJwe
         fwUXS2icXWfGoECO7mh8dO138wzplUs5c+/PxZid7gwzNzkNIuC+pFI4ApR1rPDmvUeh
         JcgKSvcIlK9xKBSWn1J1r6RKe3SnHSvR70UE1oLcXD8KeAolyvRbic9yBCvbnLpaN5rq
         Tx6XXhHt/gBJtpyjHVWHSKWzbNzdqEhiQYtLyPq+Qmz3iNPtZ0+DCeAma9+ZyGyC+nTH
         REk3GnrsWqTmMuBiqGGqZVTTdrb/uRPkkY4tSVcQ5IlX9kcZKAgBKZ/HlOlij8ocZtzB
         ULJg==
X-Gm-Message-State: ALyK8tJLTV7LfBjm+DsmYh83rvAtSGH6F2TJEM7HyBDGjD8PVNR/vv+WW6Mb5JWzVTMnbQ==
X-Received: by 10.194.86.70 with SMTP id n6mr2157136wjz.154.1465834202558;
        Mon, 13 Jun 2016 09:10:02 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:01 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297231>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, find_header() should return -1 instead of calling
die().

Unfortunately find_header() already returns -1 when no header is found,
so let's make it return -2 instead in this case.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c       | 33 ++++++++++++++++++++++-----------
 t/t4254-am-corrupt.sh |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2ff8450..630c01c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1419,6 +1419,14 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
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
@@ -1452,8 +1460,8 @@ static int find_header(struct apply_state *state,
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			die(_("patch fragment without header at line %d: %.*s"),
-			    state->linenr, (int)len-1, line);
+			return error(_("patch fragment without header at line %d: %.*s"),
+				     state->linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1469,18 +1477,18 @@ static int find_header(struct apply_state *state,
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
@@ -1505,7 +1513,7 @@ static int find_header(struct apply_state *state,
 		state->linenr += 2;
 		return offset;
 	}
-	return -1;
+	return -2;
 }
 
 static void record_ws_error(struct apply_state *state,
@@ -1996,6 +2004,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
2.9.0.rc2.411.g3e2ca28
