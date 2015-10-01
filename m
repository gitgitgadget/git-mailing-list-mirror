From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] submodule-parallel-fetch: make some file local symbols static
Date: Thu, 1 Oct 2015 13:02:42 +0100
Message-ID: <560D20E2.4060601@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 14:02:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhcZY-0001fO-T8
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 14:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371AbbJAMCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 08:02:48 -0400
Received: from avasout07.plus.net ([84.93.230.235]:36882 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933125AbbJAMCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 08:02:47 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout07 with smtp
	id Po2h1r0082FXpih01o2jXE; Thu, 01 Oct 2015 13:02:43 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=Jn1YZTiMlr1_j7aOfjMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278892>


Commits 0fc1fdb0 ("fetch_populated_submodules: use new parallel job
processing", 28-09-2015) and 60f24f52 ("run-command: add an asynchronous
parallel child processor", 28-09-2015) both introduce external symbols
which only require file scope visibility. In order to reduce the
visibility, apply the static keyword to their declarations.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

No, despite the same subject, this is not the same patch that I sent
you last week! :-D

Could you please squash parts of this into the patches corresponding
to the above mentioned commits.

Thanks!

BTW, I would once again suggest that you could move the definition of
get_next_submodule() to be above/before fetch_populated_submodules()
so that you can remove the forward declaration.

ATB,
Ramsay Jones

 run-command.c | 2 +-
 submodule.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index 341b23b..347d22e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -865,7 +865,7 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	return finish_command(cmd);
 }
 
-struct parallel_processes {
+static struct parallel_processes {
 	void *data;
 
 	int max_processes;
diff --git a/submodule.c b/submodule.c
index bd6e208..638efb5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -622,8 +622,8 @@ struct submodule_parallel_fetch {
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
 
-int get_next_submodule(void *data, struct child_process *cp,
-		       struct strbuf *err);
+static int get_next_submodule(void *data, struct child_process *cp,
+			      struct strbuf *err);
 
 static int fetch_start_failure(void *data, struct child_process *cp,
 			       struct strbuf *err)
@@ -682,8 +682,8 @@ out:
 	return spf.result;
 }
 
-int get_next_submodule(void *data, struct child_process *cp,
-		       struct strbuf *err)
+static int get_next_submodule(void *data, struct child_process *cp,
+			      struct strbuf *err)
 {
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
-- 
2.6.0
