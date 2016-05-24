From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 19/49] builtin/apply: move 'diffstat' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:56 +0200
Message-ID: <20160524081126.16973-20-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:16:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57VY-0002Bi-5E
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbcEXIPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36159 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbcEXIMN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id q62so3637284wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GLZF5lSeWcyBzxI/L2wxE3nm8vb4OhKGfJbQHmT88zE=;
        b=fs6JPYmkrT1yzGyXN6P7cWzExp7VHdpECwa4nI30nmlxEwDRih9BZn4tehu4xRY2Qh
         t6K2Wqi91+G0KKYsDxE0XPdLXgsh7AZBwT4XkAJxgw4iK1wtQcf+4L9w4713MdmHf1a3
         5C4n9nDq5Idq7Y+rqZBNtcTdA6m6q+R1lzOgTn4P78eGsdUUV7lmHFbtXwIEcZsqVn55
         QQo9sVNTQJkvLvBosAZpAZxjR0KLPMw7WufUbOhA6w7b5vlONa5l8t5ZZOc2ByQY4zW7
         qevc4QLH1SZ8IMSNjybesT2Z1SF6isrYkiNpo2YMTlH0pA89dkC5898B+5cekZj33j/C
         x33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GLZF5lSeWcyBzxI/L2wxE3nm8vb4OhKGfJbQHmT88zE=;
        b=ZgzcfjAwCIwm1/V15vg8U8/PIhF3pu3Xq/47YimY2ki9TcihMShi/wYthK697/Su/Q
         DQ6s/owp+vxfuBMXPRTyl9VMyGUBDniOArVOKk6XcDXEX5JwNFi7of5gHOz4c1KCScG4
         +uzjKqjrNSEhYQWjjtz9xpQzSnofb5WD10mJGnxOA6fIsFFXo8ZfwPVl7SD/7MtWCN/+
         xT4EvYjLllYP1+Akhvxm3ZfQYFmDLfjAjpbyp6JZAmTKgUpRTk6vFeAp/AHRXIXNsCoe
         NdyCStbS3sdMnsWfUF/jnntN/urbMzv27CvLoS77c2DCyGO7Xin2xH6iFbyWwNU88/UN
         fXYQ==
X-Gm-Message-State: ALyK8tK6MXQJlmx5CH4j6Gwut0EgP/UXUDT3Qx7KVuRCRnQqrPr1T/3ffHt1oKojQI759A==
X-Received: by 10.194.117.132 with SMTP id ke4mr2739471wjb.111.1464077532550;
        Tue, 24 May 2016 01:12:12 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:11 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295469>

To libify the apply functionality the 'diffstat' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9cba460..d940125 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -31,6 +31,9 @@ struct apply_state {
 	int check_index; /* preimage must match the indexed version */
 	int update_index; /* check_index && apply */
 
+	/* These control cosmetic aspect of the output */
+	int diffstat; /* just show a diffstat, and don't actually apply */
+
 	/* These boolean parameters control how the apply is done */
 	int allow_overlap;
 	int apply_in_reverse;
@@ -40,7 +43,6 @@ struct apply_state {
 };
 
 /*
- *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
@@ -48,7 +50,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
@@ -4486,7 +4487,7 @@ static int apply_patch(struct apply_state *state,
 	if (fake_ancestor)
 		build_fake_ancestor(list, fake_ancestor);
 
-	if (diffstat)
+	if (state->diffstat)
 		stat_patch_list(list);
 
 	if (numstat)
@@ -4602,7 +4603,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			0, option_parse_p },
 		OPT_BOOL(0, "no-add", &no_add,
 			N_("ignore additions made by the patch")),
-		OPT_BOOL(0, "stat", &diffstat,
+		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
@@ -4675,7 +4676,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.3.443.gaeee61e
