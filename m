From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 6 Dec 2007 12:03:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061201580.27959@racer.site>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 
 <20071205.202047.58135920.davem@davemloft.net> 
 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 
 <20071205.204848.227521641.davem@davemloft.net>
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 13:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0FSz-0005JQ-7B
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 13:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbXLFMEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 07:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbXLFMEN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 07:04:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:35160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752298AbXLFMEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 07:04:11 -0500
Received: (qmail invoked by alias); 06 Dec 2007 12:04:09 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp046) with SMTP; 06 Dec 2007 13:04:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ufas1LBVUEYfsaktUYXuvbSoa/T0o04EcYMyddf
	U6G8XX0HZLOZB/
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67275>


The default was not to change the window or depth at all.  As suggested
by Jon Smirl, Linus Torvalds and others, default to

	--window=250 --depth=250

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 5 Dec 2007, Linus Torvalds wrote:

	> On Thu, 6 Dec 2007, Daniel Berlin wrote:
	> > 
	> > Actually, it turns out that git-gc --aggressive does this dumb 
	> > thing to pack files sometimes regardless of whether you 
	> > converted from an SVN repo or not.
	> 
	> Absolutely. git --aggressive is mostly dumb. It's really only 
	> useful for the case of "I know I have a *really* bad pack, and I 
	> want to throw away all the bad packing decisions I have done".
	>
	> [...]
	> 
	> So the equivalent of "git gc --aggressive" - but done *properly* 
	> - is to do (overnight) something like
	> 
	> 	git repack -a -d --depth=250 --window=250

	How about this, then?
	
 builtin-gc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 799c263..c6806d3 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -23,7 +23,7 @@ static const char * const builtin_gc_usage[] = {
 };
 
 static int pack_refs = 1;
-static int aggressive_window = -1;
+static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 20;
 
@@ -192,6 +192,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (aggressive) {
 		append_option(argv_repack, "-f", MAX_ADD);
+		append_option(argv_repack, "--depth=250", MAX_ADD);
 		if (aggressive_window > 0) {
 			sprintf(buf, "--window=%d", aggressive_window);
 			append_option(argv_repack, buf, MAX_ADD);
-- 
1.5.3.7.2157.g9598e
