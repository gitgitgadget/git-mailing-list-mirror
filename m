Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A612E7E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E0D57
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:36:56 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E70F7241CE;
	Fri, 20 Oct 2023 05:36:54 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qtlw6-s5o-00; Fri, 20 Oct 2023 11:36:54 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/3] rebase: move parse_opt_keep_empty() down
Date: Fri, 20 Oct 2023 11:36:54 +0200
Message-ID: <20231020093654.922890-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <20231020093654.922890-1-oswald.buddenhagen@gmx.de>
References: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
 <20231020093654.922890-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves it right next to parse_opt_empty(), which is a much more
logical place. As a side effect, this removes the need for a forward
declaration of imply_merge().

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 builtin/rebase.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4a093bb125..13ca5a644b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -376,19 +376,6 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 	return ret;
 }
 
-static void imply_merge(struct rebase_options *opts, const char *option);
-static int parse_opt_keep_empty(const struct option *opt, const char *arg,
-				int unset)
-{
-	struct rebase_options *opts = opt->value;
-
-	BUG_ON_OPT_ARG(arg);
-
-	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
-	opts->keep_empty = !unset;
-	return 0;
-}
-
 static int is_merge(struct rebase_options *opts)
 {
 	return opts->type == REBASE_MERGE;
@@ -982,6 +969,18 @@ static enum empty_type parse_empty_value(const char *value)
 	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
 }
 
+static int parse_opt_keep_empty(const struct option *opt, const char *arg,
+				int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+
+	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
+	opts->keep_empty = !unset;
+	return 0;
+}
+
 static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
 {
 	struct rebase_options *options = opt->value;
-- 
2.42.0.419.g70bf8a5751

