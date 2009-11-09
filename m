From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/24] Show usage string for 'git commit-tree -h'
Date: Mon,  9 Nov 2009 09:04:44 -0600
Message-ID: <1257779104-23884-4-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VeY-0002Sr-KI
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbZKIOzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755398AbZKIOzN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:13 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:10055 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbZKIOzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:10 -0500
Received: by ey-out-2122.google.com with SMTP id 25so182698eya.19
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=z0rSVtOOV6qstHWLadXoP+kPA8kNxbEIE6IjQKgEet4=;
        b=S7sZ/0WXbUyuhxQSQGwQ/W6ma5KI3963F0gtigvi8olCeLmXbaQUSHALiHX9HQQdYd
         AsUAFos/6c7m+2ulcmy9eL/gvh9diusNOQGCwd5wGf+iAi3x/AE4LeXRfu5l8M0xHWmC
         Fm0LWrVKstHQGes1VoreH6ezfcu2qfm0dJxe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W3u5TZ1dMA5oRezpBMM3AxTsqn39zWZEKSERUMl3JnmTZa+T4Hd2zGSnup+7Z31zdJ
         avtc3VJaXdEHblSJpw5l3G9EmVcYH2tH8WUGhJz5iDgqw9718DBwQZoefZl3EyzXCN1e
         AQw3/T2TOXLsnVSL5rzV8sjSTEe0tlvgcOX74=
Received: by 10.216.86.83 with SMTP id v61mr365471wee.80.1257778514865;
        Mon, 09 Nov 2009 06:55:14 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:14 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132467>

Treat an "-h" option as a request for help, rather than a "Not a
valid object name" error.

"commit-tree -h" could be asking to create a new commit from a
treeish named "-h".  Strictly speaking, such a pathological ref
name is possible, but the user would have to had said something
like "tags/-h" to name such a pathological already.  commit-tree
is usually used in scripts with raw object ids, anyway.

For consistency, the "-h" option uses its new meaning even if
followed by other arguments.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-commit-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 6467077..ddcb7a4 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -105,7 +105,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	if (argc < 2)
+	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
 	if (get_sha1(argv[1], tree_sha1))
 		die("Not a valid object name %s", argv[1]);
-- 
1.6.5.2
