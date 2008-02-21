From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix amending of a commit with an empty message
Date: Thu, 21 Feb 2008 21:38:02 +0100
Message-ID: <20080221203802.GB20143@steel.home>
References: <20080221195438.GA6973@steel.home> <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org> <20080221203506.GA20143@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSIBq-00020x-Bd
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933954AbYBUUiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933929AbYBUUiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:38:09 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45562 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933856AbYBUUiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:38:07 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFhynk=
Received: from tigra.home (Fad6a.f.strato-dslnet.de [195.4.173.106])
	by post.webmailer.de (klopstock mo51) (RZmta 16.8)
	with ESMTP id a03fd7k1LJrcbU ; Thu, 21 Feb 2008 21:38:05 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1D37B277BD;
	Thu, 21 Feb 2008 21:38:03 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 5A3A556D24; Thu, 21 Feb 2008 21:38:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080221203506.GA20143@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74654>

This change probably does even more than that: it allows amending of
anything, even of a commit which does not change anything.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Thu, Feb 21, 2008 21:35:06 +0100:
> Junio C Hamano, Thu, Feb 21, 2008 21:23:10 +0100:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> > >
> > > Well, it fails... In current master
> > 
> > Then please mark it with test_expect_failure.
> 
> That's because I expect it to be fixed (in the next mail)
> 

In this one. I am a bit unsure regarding the change (it looks a little
too strong), even though it passes the test suite.

 builtin-commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 065e1f7..ab3fd7b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -520,6 +520,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 
 		if (get_sha1(parent, sha1))
 			commitable = !!active_nr;
+		else if (amend)
+			commitable = 1;
 		else {
 			init_revisions(&rev, "");
 			rev.abbrev = 0;
-- 
1.5.4.2.204.g6d0ab
