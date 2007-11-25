From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-add: fix command line building to call interactive
Date: Sun, 25 Nov 2007 10:07:55 -0800
Message-ID: <7vd4tynqpw.fsf@gitster.siamese.dyndns.org>
References: <1195996542-86074-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 19:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwLuI-00037c-TP
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 19:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbXKYSIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 13:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbXKYSIG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 13:08:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53701 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbXKYSIC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 13:08:02 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 471F02F0;
	Sun, 25 Nov 2007 13:08:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C41A7999D0;
	Sun, 25 Nov 2007 13:08:20 -0500 (EST)
In-Reply-To: <1195996542-86074-1-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Sun, 25 Nov 2007 14:15:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65977>

The earlier 7c0ab4458994aa895855abc4a504cf693ecc0cf1 (Teach builtin-add
to pass multiple paths to git-add--interactive) did not allocate enough,
and had unneeded (void*) pointer arithmetic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-add.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index dd895df..7c6a296 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -138,9 +138,10 @@ static void refresh(int verbose, const char **pathspec)
 int interactive_add(int argc, const char **argv)
 {
 	int status;
-	const char **args = xmalloc(sizeof(const char *) * (argc + 1));
+	const char **args = xcalloc(sizeof(const char *), (argc + 2));
+
 	args[0] = "add--interactive";
-	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * argc);
+	memcpy(&(args[1]), argv, sizeof(const char *) * argc);
 	args[argc + 1] = NULL;
 
 	status = run_command_v_opt(args, RUN_GIT_CMD);
-- 
1.5.3.6.2014.g7500f
