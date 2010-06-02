From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/8] revert: change help_msg() to take no argument
Date: Wed, 02 Jun 2010 07:58:37 +0200
Message-ID: <20100602055842.21504.19150.chriscool@tuxfamily.org>
References: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:59:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgzH-0006wW-42
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0FBF7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:59:30 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47968 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab0FBF73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:59:29 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DCF7E81806A;
	Wed,  2 Jun 2010 07:59:20 +0200 (CEST)
X-git-sha1: 7a01d511d87b21d6995e34af613b77bd00594085 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148212>

This is needed because the following commits will make it
possible to cherry-pick many commits instead of just one.

So it will be possible to pass for example ranges of commits
to "git cherry-pick" and this means that it will not be
possible to use the arguments passed to "git cherry-pick" in
the help message.

The help message will have to use the sha1 of the currently
processed commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index c2aee86..aee1069 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -239,7 +239,7 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
-static char *help_msg(const char *name)
+static char *help_msg(void)
 {
 	struct strbuf helpbuf = STRBUF_INIT;
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
@@ -255,7 +255,7 @@ static char *help_msg(const char *name)
 		strbuf_addf(&helpbuf, " with: \n"
 			"\n"
 			"        git commit -c %s\n",
-			name);
+			    sha1_to_hex(commit->object.sha1));
 	}
 	else
 		strbuf_addch(&helpbuf, '.');
@@ -357,7 +357,7 @@ static void do_recursive_merge(struct commit *base, struct commit *next,
 		}
 		write_message(msgbuf, defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
-			me, help_msg(commit_name));
+			me, help_msg());
 		rerere(allow_rerere_auto);
 		exit(1);
 	}
@@ -484,7 +484,7 @@ static int do_pick_commit(void)
 		free_commit_list(remotes);
 		if (res) {
 			fprintf(stderr, "Automatic %s with strategy %s failed.%s\n",
-				me, strategy, help_msg(commit_name));
+				me, strategy, help_msg());
 			rerere(allow_rerere_auto);
 			exit(1);
 		}
-- 
1.7.1.362.g8d752
