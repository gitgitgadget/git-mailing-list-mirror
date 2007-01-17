From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-format-patch: make --binary on by default
Date: Wed, 17 Jan 2007 14:41:43 -0800
Message-ID: <7vwt3lp97c.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net>
	<7vac0hqq33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 17 23:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7JTY-0002Ri-2h
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 23:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbXAQWlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 17:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbXAQWlp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 17:41:45 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51211 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbXAQWlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 17:41:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117224144.PWFW97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 17:41:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CNi11W00h1kojtg0000000; Wed, 17 Jan 2007 17:42:01 -0500
To: git@vger.kernel.org
In-Reply-To: <7vac0hqq33.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 17 Jan 2007 13:51:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37045>

It does not make much sense to generate a patch that cannot be
applied.  If --text is specified on the command line it still
takes precedence.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I would opt not to make "git am --binary" the default for
   now.  Even with this change, sending binary patch over e-mail
   is unusual as it is harder to review --- I think it makes
   sense to error out by default and draw attention from the
   person who is applying the patch rather than accepting binary
   patch automatically as if nothing unusual happened.

 builtin-log.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index c32a1df..930cc04 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -470,6 +470,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
 
+	if (!rev.diffopt.text)
+		rev.diffopt.binary = 1;
+
 	if (!output_directory)
 		output_directory = prefix;
 
-- 
1.5.0.rc1.gde38
