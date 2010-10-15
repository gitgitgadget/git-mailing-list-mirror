From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2 2/5] grep: output the path from cwd to worktree
Date: Fri, 15 Oct 2010 16:26:41 -0700
Message-ID: <1287185204-843-3-git-send-email-judge.packham@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, gitster@pobox.com,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 01:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tgS-0001CE-HY
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab0JOX1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 19:27:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63588 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab0JOX1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:27:05 -0400
Received: by mail-pw0-f46.google.com with SMTP id 4so245540pwj.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ei2kDpkb7jaJMaQpxJolF6hSo8kAUAKhZeF5Qd5u5Yg=;
        b=uEb5hV7i4CbWdnX3AaPD5AduyTEpsh+llAxxxkbAZUiSucVRZEucBqW5Ah8OUpg4TS
         AAlk3gekQTBJUU+/OubyX7BAgAcRlBR66dARua/GHJoP56UnNLC7sxhckTQUc8wpEsCZ
         C708RguHg/DYR0h6R6wdE63T4SwyunhR0nCX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nL8qNlddRuFEn9YlI7TPPZrh4dYtKPOOV3Zw9dSd6Vs7BLbX+3sHa2/5thovlqv/nm
         kE3Odf6LGWVDofpaqCgDnbEoeqnCDE8Upau7OSLbI1tVberyNcZjVNt3hm0+6MQSF63p
         i5JTK1BHgOLKmOV8Es3tNnyrO4Mt6KlBi/e7k=
Received: by 10.142.109.16 with SMTP id h16mr1166238wfc.166.1287185225574;
        Fri, 15 Oct 2010 16:27:05 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id y42sm10506678wfd.10.2010.10.15.16.27.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 16:27:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159145>

If we have detected that our worktree is not the cwd.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 builtin/grep.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..a51eb2c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -531,6 +531,8 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct strbuf buf = STRBUF_INIT;
 	char *name;
 
+	if (startup_info->cwd_to_worktree)
+		strbuf_addstr(&buf,startup_info->cwd_to_worktree);
 	if (opt->relative && opt->prefix_length)
 		quote_path_relative(filename, -1, &buf, opt->prefix);
 	else
@@ -646,6 +648,8 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(entry.path, entry.sha1);
 		pathbuf.len = len;
+		if (startup_info->cwd_to_worktree)
+			strbuf_addstr(&pathbuf,startup_info->cwd_to_worktree);
 		strbuf_add(&pathbuf, entry.path, te_len);
 
 		if (S_ISDIR(entry.mode))
-- 
1.7.3.1
