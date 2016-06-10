From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 04/44] builtin/apply: make find_header() return -1 instead of die()ing
Date: Fri, 10 Jun 2016 22:10:38 +0200
Message-ID: <20160610201118.13813-5-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmb-00039B-K1
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbcFJULt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:11:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34826 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbcFJULr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so1046948wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4ncTk4lqKBs7yRz5Rj/nlQWGiTUaYZqGZz+niTb1yY=;
        b=ZFqujDT3U/vewFm6hIuGjdZhl+vTHdcZl7cvjQwkekM9FlTj1h46gB4KdyzF7mDSK5
         Y+5Pfb6pcK90jKEj6E+gopIh7Y9NmoDYvrQLXhKFR0JK3i2JEKoJTK1mzm7fPKVlki5S
         ZBSWAvHm/I3QDIJY+Io1ADEYiE40/aFdALgid1wlVgfSU34dPPQ25QktxeOKUA7DkwNp
         1DclreVN4Op7kWdo6e5APce+ULqDpIfU0hSYv0EgIfwC9EI8O47PZeeuKCFG43VQ+TIx
         j5DnYYLGkfnRwecvw613rCtVn+RuArk/atLP+JswNBRONeqJ4dUGJXBP+jjEUyrYguv6
         ispQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4ncTk4lqKBs7yRz5Rj/nlQWGiTUaYZqGZz+niTb1yY=;
        b=QMuN4LVJCOjDlREOEXCv727QB9P1OGwXzdcD1hxKFZCgpTRQcm9cpFzDSBzx/sO2x0
         ssjDjXIzGik7uEuwxBlL0x7fv9SXiOmrS83he8HFpjVvckuhAp4KNYo7RmUu3Kmly++Z
         Yl8XWI8uudr8wy5iyyKWR5ecOkXaPjAoHOtqX3Pg6D3whpUqzNvg4+m791kz3DLr2nMV
         ReJdIsV5UU4E97WdmukfQS9LinrOgdfpWmUMyURh/nt9BK+9wfC8sQ4WyG+GjR6Ezyp7
         hYXMRogfyobrvUamSuesOIwY00ADVTT1hixaT0eVbOR5qi2LhW/Y1hYHD5G2LvNTpVzv
         rqYA==
X-Gm-Message-State: ALyK8tLrNykwfr8SbDrG9hN96kuYW1wBKqsgPDs9iXiLtQhNSlmivNh7rwZ7lGrZbss/0Q==
X-Received: by 10.28.101.134 with SMTP id z128mr631019wmb.71.1465589505469;
        Fri, 10 Jun 2016 13:11:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:44 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297029>

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
2.9.0.rc2.362.g3cd93d0
