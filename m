Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8B12E7A
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E1D51
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:36:56 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E5A93240C7;
	Fri, 20 Oct 2023 05:36:54 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qtlw6-s5i-00; Fri, 20 Oct 2023 11:36:54 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/3] rebase: handle --strategy via imply_merge() as well
Date: Fri, 20 Oct 2023 11:36:53 +0200
Message-ID: <20231020093654.922890-3-oswald.buddenhagen@gmx.de>
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

At least after the successive trimming of enum rebase_type mentioned in
the previous commit, this code did exactly what imply_merge() does, so
just call it instead.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 builtin/rebase.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 44cc1eed12..4a093bb125 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1490,18 +1490,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.strategy) {
 		options.strategy = xstrdup(options.strategy);
-		switch (options.type) {
-		case REBASE_APPLY:
-			die(_("--strategy requires --merge or --interactive"));
-		case REBASE_MERGE:
-			/* compatible */
-			break;
-		case REBASE_UNSPECIFIED:
-			options.type = REBASE_MERGE;
-			break;
-		default:
-			BUG("unhandled rebase type (%d)", options.type);
-		}
+		imply_merge(&options, "--strategy");
 	}
 
 	if (options.root && !options.onto_name)
-- 
2.42.0.419.g70bf8a5751

