From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 11/49] builtin/apply: move 'check' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:48 +0200
Message-ID: <20160524081126.16973-12-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:12:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Ru-0000li-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbcEXIMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33109 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbcEXIMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so3638932wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ndYHm4ngZbCZZtZ0850y98SpAwDX8zAwt4wv6IxhhZU=;
        b=xaDNP/eZh/R8QEhLh7ypJpo8OQ5rbtXrRgX11XLwRZoz8opA0+m7unorbO6iZunkJV
         TwrKjE6+fLW6Ec3QhCmM3PHXZEHOdxHYlGa0t4Cr8EdqG6rSqCdUXtSBKA10Qcudjsat
         efu9yD6a43BN/TI9pax9zAFPYCZzK/69AOMMWFSEQfWQvJpQMBr33/rp21epzISBWAA0
         kRRF0pGLmY/0Mh8I4k4IGBeZACF5QF2MKESzMguq8P59a7Dqf2rYBgPADcLfW0nDh/SL
         +Ll6wfSYNlEfAjywbKah9YDAd6WxP2y81yhyrY2dPMWDe2yGOKBpBIU7Z3UkF9ZluyOg
         9kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndYHm4ngZbCZZtZ0850y98SpAwDX8zAwt4wv6IxhhZU=;
        b=H97B0TwU+Fc12pqH1BlZJxgkuWWKVE3iSVXiLyxaRAwZbjyMrEM6viaTsx8ywd9lUB
         +KNbp5quYcXWPi9veP7ugKoyzDjXgSE2XMFmwSBot7SKTsxGcQuBfEruCt+y9DJ1dqUE
         JWIkgmbAR0jx0rdGJV1xGxdjOkJ/5d7lUk09CaBGaYV530ZrsIlqXcalal3srxH2OCIJ
         /ZYSwMRBxK0oiylVwg9RplTnLRzwc7XBLEsaVu82b5UWvuMrjeOj4nE3pRUNzhfik7EN
         T1ZuI89lq5Nda0JJjQ6ur8tYwvblaD9XYnfHISNlKnc5szoWCrhcOslZEustB3riyt7e
         M8zg==
X-Gm-Message-State: AOPr4FXuUMzBzyRVuWpaJ1v6td3DKicl4gqICar8K0K/7HX0Fl7Da6htcwCpDblqAgCrBQ==
X-Received: by 10.28.232.24 with SMTP id f24mr21704853wmh.58.1464077521491;
        Tue, 24 May 2016 01:12:01 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:00 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295432>

To libify the apply functionality the 'check' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6c36898..55a5541 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,13 +25,14 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/* These control what gets looked at and modified */
+	int check; /* preimage must match working tree, don't actually apply */
+
 	/* These boolean parameters control how the apply is done */
 	int unidiff_zero;
 };
 
 /*
- *  --check turns on checking that the working tree matches the
- *    files that are being modified, but doesn't apply the patch
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
@@ -48,7 +49,6 @@ static int cached;
 static int diffstat;
 static int numstat;
 static int summary;
-static int check;
 static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
@@ -2053,7 +2053,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || check) &&
+		if ((apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), state_linenr);
 	}
@@ -4440,7 +4440,7 @@ static int apply_patch(struct apply_state *state,
 			die(_("unable to read index file"));
 	}
 
-	if ((check || apply) &&
+	if ((state->check || apply) &&
 	    check_patch_list(state, list) < 0 &&
 	    !apply_with_reject)
 		exit(1);
@@ -4579,7 +4579,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
-		OPT_BOOL(0, "check", &check,
+		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
@@ -4644,7 +4644,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	}
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || check || fake_ancestor))
+	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.3.443.gaeee61e
