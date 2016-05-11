From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 53/94] builtin/apply: make find_header() return -1 instead of die()ing
Date: Wed, 11 May 2016 15:17:04 +0200
Message-ID: <20160511131745.2914-54-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:23:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6c-0006fJ-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbcEKNWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:22:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33456 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932278AbcEKNUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so9413393wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oxBQMPbpA+CmznX+UqLSBUG2YmsPzOJNDUOznPnmX9g=;
        b=nNaSemBqwqXHO5c/qxdPxCMys/33c3JpV7vZLMYIkQZgdzks24Z1NEK8cHJtIraEMx
         JVYsp+9AwdPOiR1iqdJe3C2wQzcehxc24BmPN2XDSCWu4bgrSLGlGTeW7syhK/BVFxcr
         Zp7VZFU4eGSkSZvTdpJwytALdQ3cIlZOfu4alRBpl7mS39T15xutN/Gf/mQML2Jjv1dR
         /oHu8AnhTBl9/GBSWcWaLr9fmRLRucKHXpKKByu4gQsXd4uBCfXmubZSaWBiCptfgkvw
         8p7US0Lbnb1X9NDdm7q1AgVJZonkF9rLJTu+X+jZsOSRhmDNzd46KXvt34UIVjZWz9EH
         Fa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oxBQMPbpA+CmznX+UqLSBUG2YmsPzOJNDUOznPnmX9g=;
        b=I7pu0aXpG2gkFUDhCGF3goRZnveUP35+GqYIaA4j4shyGC4Z5LduMW5qXqEcac2XPf
         VILOMixn0/7XFUaLgIfwgJSdbtrUAGtaVKLpejbXfWCRx7dHsmbAAeCyjozN/AP2sT4g
         YZKbjJKlXvvfeBKoLMjcKuX6kQC9QVQ8Xl6b5jZ1iQ0W1p+MuodXPBD2HMT9LR7E4tH5
         bJ8zy4/CTu/Mp9HHn+mHYw654BMD0Le3LmBGlvnGXQe0gHZhuqcM8yfdjsovOqYC2AHo
         jetyQsF+Nojrtcz5a4BVEMnE4g7fmTn9g5gJruFHiEXuVqFGDG7ootAvgPf0F0kJP4Hn
         8ypg==
X-Gm-Message-State: AOPr4FUKPfxJUUhcety6NU2Cj96fXD+wfBVj05okR89RtC4BB13WGGivCO9U17tjIVyxLw==
X-Received: by 10.194.242.167 with SMTP id wr7mr3735245wjc.145.1462972815149;
        Wed, 11 May 2016 06:20:15 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:14 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294321>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, find_header() should return -1 using error()
instead of calling die().

Unfortunately find_header() already returns -1 when no header is found,
so let's make it return -2 instead in this case.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c       | 33 ++++++++++++++++++++++-----------
 t/t4254-am-corrupt.sh |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a166d70..4212705 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1529,6 +1529,14 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
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
@@ -1562,8 +1570,8 @@ static int find_header(struct apply_state *state,
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			die(_("patch fragment without header at line %d: %.*s"),
-			    state->linenr, (int)len-1, line);
+			return error(_("patch fragment without header at line %d: %.*s"),
+				     state->linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1579,18 +1587,18 @@ static int find_header(struct apply_state *state,
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
@@ -1615,7 +1623,7 @@ static int find_header(struct apply_state *state,
 		state->linenr += 2;
 		return offset;
 	}
-	return -1;
+	return -2;
 }
 
 static void record_ws_error(struct apply_state *state,
@@ -2106,6 +2114,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
2.8.2.490.g3dabe57
