From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH v2 1/2] Make lock local to fetch_pack
Date: Tue, 18 Dec 2012 14:03:54 -0800
Message-ID: <1355868235-23173-2-git-send-email-kraai@ftbfs.org>
References: <1355868235-23173-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 23:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl5H4-0005ru-Fk
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 23:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab2LRWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 17:04:11 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:59272 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab2LRWEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 17:04:09 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tl5Gi-00062c-9e; Tue, 18 Dec 2012 14:04:08 -0800
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1355868235-23173-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211790>

From: Matt Kraai <matt.kraai@amo.abbott.com>

lock is only used by fetch_pack, so move it into that function.

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 builtin/fetch-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index e644398..9bc10b3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -875,8 +875,6 @@ static int fetch_pack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static struct lock_file lock;
-
 static void fetch_pack_setup(void)
 {
 	static int did_setup;
@@ -1069,6 +1067,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	ref_cpy = do_fetch_pack(fd, ref, sought, pack_lockfile);
 
 	if (args.depth > 0) {
+		static struct lock_file lock;
 		struct cache_time mtime;
 		struct strbuf sb = STRBUF_INIT;
 		char *shallow = git_path("shallow");
-- 
1.8.0.2.8.gc42826d.dirty
