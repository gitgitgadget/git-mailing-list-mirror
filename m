From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Make mktag a builtin.
Date: Sun, 11 May 2008 10:36:45 -0700
Message-ID: <7vprrs4uaa.fsf@gitster.siamese.dyndns.org>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <1210299589-10448-2-git-send-email-drafnel@example.com>
 <7689656.1210299528037.JavaMail.teamon@b301.teamon.com>
 <7v63tk6992.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Sun May 11 19:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvFUk-00085K-DP
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbYEKRg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbYEKRg4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:36:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbYEKRgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:36:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6047C3E47;
	Sun, 11 May 2008 13:36:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 529DC3E43; Sun, 11 May 2008 13:36:48 -0400 (EDT)
In-Reply-To: <7v63tk6992.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 May 2008 10:28:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8291326-1F80-11DD-9091-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81802>

Junio C Hamano <junio@pobox.com> writes:

> drafnel@gmail.com writes:
>
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>
>> @@ -306,6 +305,7 @@ BUILT_INS += git-fsck-objects$X
>>  BUILT_INS += git-get-tar-commit-id$X
>>  BUILT_INS += git-init$X
>>  BUILT_INS += git-merge-subtree$X
>> +BUILT_INS += git-mktag$X
>>  BUILT_INS += git-peek-remote$X
>>  BUILT_INS += git-repo-config$X
>>  BUILT_INS += git-show$X
>> @@ -423,6 +423,7 @@ LIB_OBJS += log-tree.o
>>  LIB_OBJS += mailmap.o
>>  LIB_OBJS += match-trees.o
>>  LIB_OBJS += merge-file.o
>> +LIB_OBJS += mktag.o
>
> This is unusual for a builtin.  Why didn't it migrate to builtin-mktag?

That is, something along this line, instead.

-- >8 --
From: Brandon Casey <drafnel@gmail.com>
Date: Thu, 8 May 2008 21:19:46 -0500
Subject: [PATCH] Make mktag a builtin

Signed-off-by: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                   |    2 +-
 mktag.c => builtin-mktag.c |    4 +---
 builtin.h                  |    1 +
 git.c                      |    1 +
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename mktag.c => builtin-mktag.c (98%)

diff --git a/Makefile b/Makefile
index 9d84c8d..3980dc9 100644
--- a/Makefile
+++ b/Makefile
@@ -282,7 +282,6 @@ PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
 PROGRAMS += git-merge-tree$X
-PROGRAMS += git-mktag$X
 PROGRAMS += git-mktree$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
@@ -510,6 +509,7 @@ BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
+BUILTIN_OBJS += builtin-mktag.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
 BUILTIN_OBJS += builtin-pack-objects.o
diff --git a/mktag.c b/builtin-mktag.c
similarity index 98%
rename from mktag.c
rename to builtin-mktag.c
index a45a5e7..1596900 100644
--- a/mktag.c
+++ b/builtin-mktag.c
@@ -149,7 +149,7 @@ static int verify_tag(const char *buffer, size_t size)
 
 #undef PD_FMT
 
-int main(int argc, char **argv)
+int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf;
 	unsigned char result_sha1[20];
@@ -157,8 +157,6 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage("git-mktag < signaturefile");
 
-	setup_git_directory();
-
 	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, 0, 4096) < 0) {
 		die("could not read from stdin");
diff --git a/builtin.h b/builtin.h
index 95126fd..a8d3a11 100644
--- a/builtin.h
+++ b/builtin.h
@@ -58,6 +58,7 @@ extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+extern int cmd_mktag(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 89b431f..81aa31c 100644
--- a/git.c
+++ b/git.c
@@ -325,6 +325,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "mktag", cmd_mktag, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-- 
1.5.5.1.295.g4c42f
