From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] submodule-parallel-fetch: make some file local symbols static
Date: Fri, 25 Sep 2015 16:15:24 +0100
Message-ID: <5605650C.2000809@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 17:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfUio-0004M2-Fg
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 17:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbbIYPPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 11:15:32 -0400
Received: from avasout08.plus.net ([212.159.14.20]:43485 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949AbbIYPP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 11:15:28 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout08 with smtp
	id MTFP1r0052FXpih01TFQt9; Fri, 25 Sep 2015 16:15:27 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=BC3y6SkikOJ_VT76StwA:9
 a=0fW5uuJjzOlxzKqt:21 a=mrkfK_iZLdD3XHIn:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278661>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

When you next re-roll the patches for your
'sb/submodule-parallel-fetch' branch, could you please squash
parts of this into the relevant patches. [which would correspond
to commits a93fb7a ("run-command: add an asynchronous parallel
child processor", 22-09-2015) and 58713c8 ("fetch_populated_submodules:
use new parallel job processing", 22-09-2015).]

Thanks!

Also, you might consider renaming some (file local) functions with
really long names, to something a little shorter, like (say):

  handle_submodule_fetch_start_err -> fetch_start_failure
  handle_submodule_fetch_finish -> fetch_finish

(but, as I have said several times, I'm not good at naming things ... ;-)

Also, you could move the definition of get_next_submodule() to be
above/before fetch_populated_submodules() so that you can remove the
forward declaration.

[Note these issues were spotted by sparse and static-check.pl]

HTH

ATB,
Ramsay Jones


 run-command.c      | 12 ++++++------
 submodule.c        | 12 ++++++------
 test-run-command.c |  6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/run-command.c b/run-command.c
index 528a4fb..6ca0151 100644
--- a/run-command.c
+++ b/run-command.c
@@ -902,9 +902,9 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
-void default_start_failure(void *data,
-			   struct child_process *cp,
-			   struct strbuf *err)
+static void default_start_failure(void *data,
+				  struct child_process *cp,
+				  struct strbuf *err)
 {
 	int i;
 	struct strbuf sb = STRBUF_INIT;
@@ -915,9 +915,9 @@ void default_start_failure(void *data,
 	die_errno("Starting a child failed:%s", sb.buf);
 }
 
-void default_return_value(void *data,
-			  struct child_process *cp,
-			  int result)
+static void default_return_value(void *data,
+				 struct child_process *cp,
+				 int result)
 {
 	int i;
 	struct strbuf sb = STRBUF_INIT;
diff --git a/submodule.c b/submodule.c
index f362d6a..d786a76 100644
--- a/submodule.c
+++ b/submodule.c
@@ -620,16 +620,16 @@ struct submodule_parallel_fetch {
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
 
-int get_next_submodule(void *data, struct child_process *cp,
-		       struct strbuf *err);
+static int get_next_submodule(void *data, struct child_process *cp,
+			      struct strbuf *err);
 
-void handle_submodule_fetch_start_err(void *data, struct child_process *cp, struct strbuf *err)
+static void handle_submodule_fetch_start_err(void *data, struct child_process *cp, struct strbuf *err)
 {
 	struct submodule_parallel_fetch *spf = data;
 	spf->result = 1;
 }
 
-void handle_submodule_fetch_finish( void *data, struct child_process *cp, int retvalue)
+static void handle_submodule_fetch_finish( void *data, struct child_process *cp, int retvalue)
 {
 	struct submodule_parallel_fetch *spf = data;
 
@@ -673,8 +673,8 @@ out:
 	return spf.result;
 }
 
-int get_next_submodule(void *data, struct child_process *cp,
-		       struct strbuf *err)
+static int get_next_submodule(void *data, struct child_process *cp,
+			      struct strbuf *err)
 {
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
diff --git a/test-run-command.c b/test-run-command.c
index 94c6eee..2555791 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -16,9 +16,9 @@
 #include <errno.h>
 
 static int number_callbacks;
-int parallel_next(void *data,
-		  struct child_process *cp,
-		  struct strbuf *err)
+static int parallel_next(void *data,
+			 struct child_process *cp,
+			 struct strbuf *err)
 {
 	struct child_process *d = data;
 	if (number_callbacks >= 4)
-- 
2.5.0
