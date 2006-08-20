From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository
Date: Sun, 20 Aug 2006 20:44:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608202038430.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060820105452.GA19630@nospam.com>
 <Pine.LNX.4.63.0608201519360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060820152404.GA5679@nospam.com> <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060820172458.GA21362@nospam.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 20:44:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEsHj-0001YP-98
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 20:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWHTSob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWHTSob
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 14:44:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:2724 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751142AbWHTSoa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 14:44:30 -0400
Received: (qmail invoked by alias); 20 Aug 2006 18:44:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 20 Aug 2006 20:44:29 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rutger Nijlunsing <git@wingding.demon.nl>
In-Reply-To: <20060820172458.GA21362@nospam.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25763>

Hi,

On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:

> On Sun, Aug 20, 2006 at 06:09:34PM +0200, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:
> > 
> > > On Sun, Aug 20, 2006 at 03:20:19PM +0200, Johannes Schindelin wrote:
> > > > Hi,
> > > > 
> > > > On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:
> > > > 
> > > > > You can also find it on http://www.wingding.demon.nl/git-rev-size.rb
> > > > 
> > > > Ruby is _so_ mainstream. Could I have a Haskell version, pretty please?
> > > 
> > > I _knew_ it... Please go bug someone else. The only thing I did was
> > > help someone, and for that I choose my own tools since I do it for
> > > fun.
> > 
> > Fair enough.
> > 
> > -- 8< --
> > [PATCH] Add git-rev-size
> > 
> > This tool spits out the number of trees, the number of blobs, and the total
> > bytes of the blobs for a given rev range.
> > 
> > Most notably, it adds an object hash map structure to the library.
> > 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> 
> [Hm, the itch seems to be contagious. Better watch out...]
> 
> Small comments:
> 
> The 'git-rev-size' name was chosen because originally it understood
> the same arguments as git-rev-list. You might want to add this popen()
> back, or have some other way to share those (might be simple in C). Or
> is setup_revisions() enough to have the power of git-rev-list?

It is enough. That is the beauty of setup_revisions().

> If seperate commits have to be given on the command line instead of a
> range, the command line limit is hit quite quickly (~780 commits). And
> if you'll be using xargs, the hash / cache will be less of an advantage.

Certainly. But I doubt that you'll use this command all that often. 
However, it was a nice example of how easy it is to write a git builtin ;-)

> The original request was 'for each commit' to get an idea of the size
> growth during a project.

Since the arguments are the same as for git-rev-list, this is easy enough.

> 'builtin_rev_size_usage' is not referred to in the patch, only defined.

True.

-- 8< --
[PATCH] rev-size: actually show usage

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-rev-size.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-size.c b/builtin-rev-size.c
index ad88e48..184f926 100644
--- a/builtin-rev-size.c
+++ b/builtin-rev-size.c
@@ -78,6 +78,9 @@ int cmd_rev_size(int argc, const char **
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
+	if (revs.pending.nr == 0)
+		usage(builtin_rev_size_usage);
+
 	prepare_revision_walk(&revs);
 
 	while ((commit = get_revision(&revs))) {
-- 
1.4.2.ga5e8f-dirty
