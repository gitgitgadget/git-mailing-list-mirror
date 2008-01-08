From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] "git-apply --check" should not report "fixed"
Date: Tue, 08 Jan 2008 15:46:18 -0800
Message-ID: <7vejcrrid1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 00:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCO9s-0005QR-5Z
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 00:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbYAHXqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756282AbYAHXqa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 18:46:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbYAHXq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 18:46:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 523323AB9;
	Tue,  8 Jan 2008 18:46:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 856693AB5;
	Tue,  8 Jan 2008 18:46:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69936>

When running "git apply --check" while --whitespace=fix is
enabled (either from the command line or via the configuration),
we reported that "N line(s) applied after _fixing_", but --check
by itself does not apply and this message was alarming.

We could even reword the message to say "N line(s) would have
been applied after fixing...", but this patch does not go that
far.  Instead, we just make it use the "N lines add whitespace
errors" warning, which happens to be a good diagnostic message a
user would expect from the --check option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 5e3b4a1..d57bb6e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2907,7 +2907,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			    whitespace_error,
 			    whitespace_error == 1 ? "" : "s",
 			    whitespace_error == 1 ? "s" : "");
-		if (applied_after_fixing_ws)
+		if (applied_after_fixing_ws && apply)
 			fprintf(stderr, "warning: %d line%s applied after"
 				" fixing whitespace errors.\n",
 				applied_after_fixing_ws,
