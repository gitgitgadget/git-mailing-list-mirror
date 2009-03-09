From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep: cast printf %.*s "precision" argument explicitly to
 int
Date: Sun, 08 Mar 2009 18:24:31 -0700
Message-ID: <7vljrfij3k.fsf_-_@gitster.siamese.dyndns.org>
References: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com>
 <20090308234141.GJ12880@zoy.org> <7vtz63ijoz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Sam Hocevar <sam@zoy.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgUFy-0005Dm-Kx
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbZCIBYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753913AbZCIBYq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:24:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbZCIBYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:24:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 35992488F;
	Sun,  8 Mar 2009 21:24:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 849E9488E; Sun, 
 8 Mar 2009 21:24:40 -0400 (EDT)
In-Reply-To: <7vtz63ijoz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 08 Mar 2009 18:11:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12042774-0C49-11DE-A2BF-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112665>

On some systems, regoff_t that is the type of rm_so/rm_eo members are
wider than int; %.*s precision specifier expects an int, so use an explicit
cast.

A breakage reported on Darwin by Brian Gernhardt should be fixed with
this patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Brian, would this patch help?

 A resend with a commit log message.

 grep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index cace1c8..be99b34 100644
--- a/grep.c
+++ b/grep.c
@@ -490,9 +490,9 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			printf("%.*s%s%.*s%s",
-			       match.rm_so, bol,
+			       (int)match.rm_so, bol,
 			       opt->color_match,
-			       match.rm_eo - match.rm_so, bol + match.rm_so,
+			       (int)(match.rm_eo - match.rm_so), bol + match.rm_so,
 			       GIT_COLOR_RESET);
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
-- 
1.6.2.206.g5bda76
