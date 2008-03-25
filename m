From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] git-init: autodetect core.ignorecase
Date: Tue, 25 Mar 2008 13:49:31 +0300
Message-ID: <20080325104931.GJ25381@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <1206428273-15926-1-git-send-email-dpotapov@gmail.com> <alpine.LSU.1.00.0803251056520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Frank <streamlake@tiscali.it>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6jX-0002o0-3i
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbYCYKtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbYCYKtj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:49:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:45754 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbYCYKti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:49:38 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3442948fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=13x5g6LDgnIzPNJiQWmKsMgEz5LoiqRKuxviHvifL/w=;
        b=XqRg2aUnNtiUmLx/voYFvOpjMI9AKQVdQsYQExiUTyBnSTinNJWB0WqIqe+hDqHYnU19GQiN1NbA9nAMzwbbXJzwBFJPDBx2HIEz8pv+IwqXLz1sN/PGE5zTBmzIyYah10kPlmZUaKdkO+pNLstZ0Y7q8J4kRgA/E16HFLkYOR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QhjVnLGv0GP5xG7dE3xfT8NByAI/JDE2hmSAcBrSXtxJzt8f7u1JIo4rnVace/s1HujYdJ+3/izE98wdh9nJchbLA9cnfM17/EslTMlNyPQowhItYY4az3trz8O04n1HOmKwgESnnXzUFh2pL0yqQByZwLvMHUr5XLWvz5f55xc=
Received: by 10.86.61.13 with SMTP id j13mr5343463fga.48.1206442174940;
        Tue, 25 Mar 2008 03:49:34 -0700 (PDT)
Received: from localhost ( [83.237.187.35])
        by mx.google.com with ESMTPS id 3sm9266543fge.7.2008.03.25.03.49.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Mar 2008 03:49:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803251056520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78176>

We already detect if symbolic links are supported by the filesystem.
This patch adds autodetect for case-insensitive filesystems, such
as VFAT and others.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

There was a stupid mistake in a previous patch...  (Inadvertantly,
I sent the old version of my patch, which was incorrect, and did not
realize that until saw Johannes' reply to my email.)

 builtin-init-db.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 79eaf8d..62f7c08 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -254,8 +254,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 			git_config_set("core.worktree", work_tree);
 	}
 
-	/* Check if symlink is supported in the work tree */
 	if (!reinit) {
+		/* Check if symlink is supported in the work tree */
 		path[len] = 0;
 		strcpy(path + len, "tXXXXXX");
 		if (!close(xmkstemp(path)) &&
@@ -266,6 +266,12 @@ static int create_default_files(const char *git_dir, const char *template_path)
 			unlink(path); /* good */
 		else
 			git_config_set("core.symlinks", "false");
+
+		/* Check if the filesystem is case-insensitive */
+		path[len] = 0;
+		strcpy(path + len, "CoNfIg");
+		if (!access(path, F_OK))
+			git_config_set("core.ignorecase", "true");
 	}
 
 	return reinit;
-- 
1.5.5.rc1.10.g3948
