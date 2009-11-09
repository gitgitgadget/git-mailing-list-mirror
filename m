From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/24] Show usage string for 'git merge-ours -h'
Date: Mon,  9 Nov 2009 09:04:45 -0600
Message-ID: <1257779104-23884-5-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:55:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VeZ-0002Sr-4p
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbZKIOzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZKIOzS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:18 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:16749 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbZKIOzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:12 -0500
Received: by ey-out-2122.google.com with SMTP id 25so182710eya.19
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=f1bko/zx15kXIctDFDV9he0JFwK51eodYhn5mfaHLf4=;
        b=fgxy0lqXUZQlqdwYK6FUB5RLeg2rG3n6/9/RrjHseGbnXeRLkpFdagaG868DHAeApu
         D8JJhUbXpiz+ej5kfWUD9aPin0OAtbKL0UK5MnjCRlONBjOhnUJFpFUHCtIkUDykRU4Y
         xsfdo8SCKSBXyKRGKA2YuPN8/rxC3eJzLG3TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bEhONFRJOTIBh4si1DPmMFv7WuuiTBZd0eRKi0ES1pT3o0VGarO40XI5nd7JhF0YY4
         n0KcZj8zHeVxlEhPE5hFtO8xsuGY6EZHUbilz2v7QaONXnIsaggPdPTqp6jWuV+PAQ3M
         EIDNtkBXOfunoQXBb1jU0n6TS+WrlpOcf9Y38=
Received: by 10.216.86.7 with SMTP id v7mr2420580wee.203.1257778516841;
        Mon, 09 Nov 2009 06:55:16 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:16 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132466>

This change is strictly about 'git merge-ours -h' without
any other options and arguments.

This change cannot break compatibility since merge drivers are
always passed '--', among other arguments.

Any usage string for this command is a lie, since it ignored its
arguments until now.  Still, it makes sense to let the user know
the expected usage when asked.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-merge-ours.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-merge-ours.c b/builtin-merge-ours.c
index 8f5bbaf..6844116 100644
--- a/builtin-merge-ours.c
+++ b/builtin-merge-ours.c
@@ -10,6 +10,9 @@
 #include "git-compat-util.h"
 #include "builtin.h"
 
+static const char builtin_merge_ours_usage[] =
+	"git merge-ours <base>... -- HEAD <remote>...";
+
 static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "--cached", "HEAD", "--", NULL
 };
@@ -17,6 +20,9 @@ static const char *diff_index_args[] = {
 
 int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 {
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(builtin_merge_ours_usage);
+
 	/*
 	 * We need to exit with 2 if the index does not match our HEAD tree,
 	 * because the current index is what we will be committing as the
-- 
1.6.5.2
