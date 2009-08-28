From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 07/15] sequencer: add "do_fast_forward()" to perform a fast
	forward
Date: Fri, 28 Aug 2009 06:47:37 +0200
Message-ID: <20090828044746.4307.88217.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZo-0006Ec-MG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbZH1E7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbZH1E7k
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:40 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49764 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbZH1E7N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:13 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D05B38180F0;
	Fri, 28 Aug 2009 06:59:03 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C93CC818080;
	Fri, 28 Aug 2009 06:59:00 +0200 (CEST)
X-git-sha1: c88754622a426322ce931c6a56327df0109b7d79 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127262>

From: Stephan Beyer <s-beyer@gmx.net>

This function is a thin wrapper around "reset_almost_hard()".
It is usefull because it will help reduce a little the shell
code line count.

This code is taken from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

but the messages have been changed a little to be the same as
those displayed by "git-rebase--interactive.sh".

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-sequencer--helper.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index be030bc..0cd7e98 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -171,6 +171,15 @@ static struct commit *get_commit(const char *arg)
 	return lookup_commit_reference(sha1);
 }
 
+static int do_fast_forward(const unsigned char *sha)
+{
+	if (reset_almost_hard(sha))
+		return error("Cannot fast forward to %s", sha1_to_hex(sha));
+	if (verbosity > 1)
+		printf("Fast forward to %s\n", sha1_to_hex(sha));
+	return 0;
+}
+
 static int set_verbosity(int verbose)
 {
 	char tmp[] = "0";
-- 
1.6.4.271.ge010d
