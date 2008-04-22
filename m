From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-remote: resurrect forced updates to tracked
 branches
Date: Tue, 22 Apr 2008 14:26:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221425310.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness>
 <20080422125618.GA27577@sigill.intra.peff.net> <alpine.DEB.1.00.0804221357420.4460@eeepc-johanness> <20080422130918.GB27878@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Galbraith <efault@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:27:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoIWc-0005r7-CO
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbYDVN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbYDVN0W
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:26:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:60303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754543AbYDVN0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:26:21 -0400
Received: (qmail invoked by alias); 22 Apr 2008 13:26:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 22 Apr 2008 15:26:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mmVJp1iXmVUfCguc7/YvprFebaJUSC6z0zh5w+P
	nzcAyE12hEPCro
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080422130918.GB27878@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80116>


During the rewrite of git-remote as a builtin, the ability to force
updating the tracked branches (i.e. forcing non-fast-forwards) was
lost.

This patch fixes that.

Noticed by Mike Galbraith, analyzed by Jeff King.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Tue, 22 Apr 2008, Jeff King wrote:

	> On Tue, Apr 22, 2008 at 02:03:43PM +0100, Johannes Schindelin wrote:
	> 
	> > Oh, that's right: only "git remote prune" will delete stale refs only.
	> > 
	> > But my other point about possibly interfering with local 
	> > branches still holds true.
	> 
	> In that case, I think that the '+' should come only without 
	> --mirror, and my complaint is then that "--mirror" is a horrible name 
	> for that option. Though when I saw it, I really expected it to do 
	> something about the _push_ line, since that is the only other place we 
	> have a --mirror option. It would make sense to me for it to set up 
	> remote.$x.mirror (which is newly added in next). But then, git-remote 
	> doesn't seem to be geared towards pushing at all.

	I still think that the --mirror option has merit, but I missed 
	that your patch did fix the behviour _without_ --mirror.

	This is my attempt.

 builtin-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d4f2132..117ff60 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -114,7 +114,7 @@ static int add(int argc, const char **argv)
 			strbuf_addf(&buf2, "refs/%s:refs/%s",
 					item->path, item->path);
 		else
-			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
+			strbuf_addf(&buf2, "+refs/heads/%s:refs/remotes/%s/%s",
 					item->path, name, item->path);
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return 1;
