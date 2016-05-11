From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 19/94] builtin/apply: move 'diffstat' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:30 +0200
Message-ID: <20160511131745.2914-20-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:25:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U8l-0000t2-3T
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbcEKNZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:25:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35477 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbcEKNTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so9402174wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6JfzfWAe4lYLCtUoUTVtaisKLTqGyQop7Zrj0ske4A=;
        b=wJT4FCq9UZQsrYkwTh5gZD+UJt0U5mHnPguY69KEH3eJhkVco/YCJGBVayH5oIYDkT
         BU2gkXxt+olqz/zAsS0UTHBY9Bm7S1yT7r7p4AsAaTlnLbA3eVpTjPihOyQpsBRk55F9
         n3MfFDrQmCnB8zDzjNhTkGmmv7V+Iiywn9x1YHN8+1SS/xElTuigVH/nxuxkjojFae2T
         zCE/wz44dJHdRmXsn0OCnQOvNtmkUsVnNh7ARzWhcKPoB5VY/gVeMLVq5nxoFhR3P7Qh
         PY1JhbH0J4PASij2SUMiMbmr1HXrve3iA5C8N6uBfoTN26Bkmx5Kbhg12F+wiAlJ63Id
         Sc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6JfzfWAe4lYLCtUoUTVtaisKLTqGyQop7Zrj0ske4A=;
        b=iqdGIMU2/jbXkG55O09TkUtwo7UH8d6YinpWgJW1bbauWGeiCUBCzkrnd7jNuwOeFc
         4omR5mA0D65UpDwh9Oi5HF0cyAawm6BkEzvicDkTUGTJdZC796fM6ZnRcqK5LSWyzA3b
         7ijC3C3cYO7UouDLpwWSDg2X8XfxrXfca7fTHQdqHqTwCRw9xi3GalVrKxXf5mlKxkNv
         mIx1x9lyFSRHsU5xrZuL2Zo05YHZqgymyIYrFwyZH/bGfBBgoURPKDDPhKzBRXj5nX2+
         HDcl1omcwWiCt8OQPQy8I9wszVVfpvcXzqoeA/HQrwKegZHk2CUpXGYqTd6CRi+8KYzM
         1pjQ==
X-Gm-Message-State: AOPr4FUZGaPVNa9Qae9dXCbeME85utx8LmLpZJYfIXpLjNX8q3XhSHe8agok90SeGsPJ4Q==
X-Received: by 10.28.23.138 with SMTP id 132mr4508621wmx.50.1462972744822;
        Wed, 11 May 2016 06:19:04 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:03 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294337>

To libify the apply functionality the 'diffstat' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 09af5dc..43c7198 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -33,6 +33,9 @@ struct apply_state {
 	/* --cached updates only the cache without ever touching the working tree. */
 	int cached;
 
+	/* --stat does just a diffstat, and doesn't actually apply */
+	int diffstat;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -47,7 +50,6 @@ struct apply_state {
 };
 
 /*
- *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
@@ -55,7 +57,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
@@ -4493,7 +4494,7 @@ static int apply_patch(struct apply_state *state,
 	if (fake_ancestor)
 		build_fake_ancestor(list, fake_ancestor);
 
-	if (diffstat)
+	if (state->diffstat)
 		stat_patch_list(list);
 
 	if (numstat)
@@ -4604,7 +4605,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			0, option_parse_p },
 		OPT_BOOL(0, "no-add", &no_add,
 			N_("ignore additions made by the patch")),
-		OPT_BOOL(0, "stat", &diffstat,
+		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
@@ -4677,7 +4678,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.2.490.g3dabe57
