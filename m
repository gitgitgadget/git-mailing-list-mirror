From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk from subdirectory
Date: Thu, 30 Aug 2007 22:45:38 -0700
Message-ID: <7vejhk45q5.fsf@gitster.siamese.dyndns.org>
References: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 07:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQzKY-0001ax-V7
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 07:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbXHaFpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 01:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXHaFpo
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 01:45:44 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXHaFpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 01:45:43 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EA3D129717;
	Fri, 31 Aug 2007 01:46:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 30 Aug 2007 22:08:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57116>

"git log" family of commands, even when run from a subdirectory,
do not limit the revision range with the current directory as
the path limiter, but with double-dash without any paths after
it, i.e. "git log --" do so.  It was a mistake to have a
difference between "git log --" and "git log" introduced in
commit ae563542bf10fa8c33abd2a354e4b28aca4264d7 (First cut at
libifying revlist generation).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 51fff0e..c193c3e 100644
--- a/revision.c
+++ b/revision.c
@@ -896,7 +896,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			continue;
 		argv[i] = NULL;
 		argc = i;
-		revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
+		if (argv[i + 1])
+			revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
 		seen_dashdash = 1;
 		break;
 	}
