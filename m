From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/7] run_command: report system call errors instead of returning error codes
Date: Sun, 5 Jul 2009 21:01:13 +0200
Message-ID: <200907052101.13741.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org> <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org> <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 21:01:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNWxm-0008RH-4I
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 21:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbZGETBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbZGETBM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 15:01:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:50596 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbZGETBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 15:01:11 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DE05DCDF87;
	Sun,  5 Jul 2009 21:01:14 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D34445BADA;
	Sun,  5 Jul 2009 21:01:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122748>

On Samstag, 4. Juli 2009, Johannes Sixt wrote:
> +	if (status >= 0 || errno != ENOENT)
> +		exit(status & 0xff);

With my replacement patch 1/7 this '& 0xff' is no longer necessary. Would you
kindly squash this in?

-- Hannes

diff --git a/git.c b/git.c
--- a/git.c
+++ b/git.c
@@ -418,7 +418,7 @@ static void execv_dashed_external(const char **argv)
 	 */
 	status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE);
 	if (status >= 0 || errno != ENOENT)
-		exit(status & 0xff);
+		exit(status);
 
 	argv[0] = tmp;
 
