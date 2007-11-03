From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] git-format-patch: Number patches when there are more than one
Date: Sat,  3 Nov 2007 16:44:54 +0100
Message-ID: <1194104694-12530-1-git-send-email-mh@glandium.org>
References: <Pine.LNX.4.64.0710221044080.25221@racer.site>
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 16:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoLCy-0004go-DY
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 16:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbXKCPqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 11:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbXKCPqb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 11:46:31 -0400
Received: from vawad.err.no ([85.19.200.177]:34275 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbXKCPqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 11:46:30 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoLCb-0005pf-9Q; Sat, 03 Nov 2007 16:46:27 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoLB8-0003GM-Nn; Sat, 03 Nov 2007 16:44:54 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <Pine.LNX.4.64.0710221044080.25221@racer.site>
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63285>

Automagically enable numbering if we output more than one patch.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

On Mon, Oct 22, 2007 at 10:44:12AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 21 Oct 2007, Andreas Ericsson wrote:
> 
> > [PATCH 1/1] looks a bit silly, and automagically handling this in 
> > git-format-patch makes some scripting around it a lot more pleasant.
> 
> I think you should not use "-n" if you do not want to have the numbers.  
> In circumstances as yours, where you can have patch series larger than 
> one, I imagine that the "[PATCH 1/1]" bears an important information, 
> which is not present in "[PATCH]": this patch series contains only one 
> patch.
> 
> IOW I do not like your patch: too much DWIDNS (Do What I Did NOT Say) for 
> me.

How about the contrary ?


 Documentation/git-format-patch.txt |    3 ++-
 builtin-log.c                      |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f0617ef..b77daed 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -56,7 +56,8 @@ If -o is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
 
 If -n is specified, instead of "[PATCH] Subject", the first line
-is formatted as "[PATCH n/m] Subject".
+is formatted as "[PATCH n/m] Subject". This is the default when
+there is more than one commit to prepare patches for.
 
 If given --thread, git-format-patch will generate In-Reply-To and
 References headers to make the second and subsequent patch mails appear
diff --git a/builtin-log.c b/builtin-log.c
index 8b2bf63..640d6e7 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -642,6 +642,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+	if (!keep_subject && total > 1)
+		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
 	rev.add_signoff = add_signoff;
-- 
1.5.3.5
