From: Jeff King <peff@peff.net>
Subject: Re: Make ref resolution saner
Date: Tue, 12 Sep 2006 01:36:16 -0400
Message-ID: <20060912053616.GA6706@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org> <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> <Pine.LNX.4.64.0609112008500.27779@g5.osdl.org> <Pine.LNX.4.64.0609112010340.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 07:36:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN0wZ-0005pp-77
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 07:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWILFgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 01:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWILFgT
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 01:36:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:49366 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750820AbWILFgS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Sep 2006 01:36:18 -0400
Received: (qmail 2508 invoked from network); 12 Sep 2006 01:35:28 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 12 Sep 2006 01:35:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Sep 2006 01:36:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609112010340.27779@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26881>

On Mon, Sep 11, 2006 at 08:17:35PM -0700, Linus Torvalds wrote:

> The old code used to totally mix up the notion of a ref-name and the path 
> that that ref was associated with.  That was not only horribly ugly (a

I assume your patch is against master; it looks like there's exactly one
call to resolve_ref that's in next but not master. One-liner fix below.

-Peff

-- >8 --
wt-status: use simplified resolve_ref to find current branch

---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ec2c728..e2f49c7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -41,7 +41,7 @@ void wt_status_prepare(struct wt_status 
 
 	s->is_initial = get_sha1("HEAD", sha1) ? 1 : 0;
 
-	head = resolve_ref(git_path("HEAD"), sha1, 0);
+	head = resolve_ref("HEAD", sha1, 0);
 	s->branch = head ?
 		    strdup(head + strlen(get_git_dir()) + 1) :
 		    NULL;
-- 
1.4.2.g39f1
