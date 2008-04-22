From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] remote add: disallow --master and --mirror with non-bare
 repositories
Date: Tue, 22 Apr 2008 18:23:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221823010.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local>
 <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <7vd4ohzvda.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:24:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMDx-0000R6-9o
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbYDVRXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756072AbYDVRXU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:23:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:55647 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756059AbYDVRXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:23:19 -0400
Received: (qmail invoked by alias); 22 Apr 2008 17:23:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp018) with SMTP; 22 Apr 2008 19:23:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2cbgBHX+2HW4CYg2pjTKZVCmSu2SUTSRXA3ORHY
	iU35/hA+5NPyGc
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vd4ohzvda.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80147>


In most cases, --master or --mirror in a non-bare repository is an
error.  In those cases where it is not, the user is most likely editing
the config herself anyway.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Tue, 22 Apr 2008, Junio C Hamano wrote:

	> I personally do not think --mirror option makes sense with 
	> --track, nor it makes sense in a non-bare repository for that matter.

	Obviously meant for application together with Peff's patch.

 builtin-remote.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d4f2132..63f025c 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -79,6 +79,12 @@ static int add(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
+	if (mirror && is_bare_repository())
+		die("--mirror with non-bare repository.");
+
+	if (master && is_bare_repository())
+		die("--master with non-bare repository.");
+
 	if (argc < 2)
 		usage_with_options(builtin_remote_usage, options);
 
