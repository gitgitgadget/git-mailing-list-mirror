From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-clone --quiet broken?
Date: Mon, 7 Jul 2008 00:56:49 +0200
Message-ID: <20080706225649.GD17659@steel.home>
References: <20080705211616.GA3874@codemonkey.org.uk> <7vmykvrfta.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Jones <davej@codemonkey.org.uk>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 00:58:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFdB6-0001Nl-O6
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 00:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895AbYGFW44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 18:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755854AbYGFW4z
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 18:56:55 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:21212 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbYGFW4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 18:56:55 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44h+5V
Received: from tigra.home (Fa915.f.strato-dslnet.de [195.4.169.21])
	by post.webmailer.de (fruni mo5) (RZmta 16.47)
	with ESMTP id Y032bck66KtW2k ; Mon, 7 Jul 2008 00:56:50 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0BF8D277BD;
	Mon,  7 Jul 2008 00:56:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C1B2256D27; Mon,  7 Jul 2008 00:56:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmykvrfta.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87563>

Junio C Hamano, Sun, Jul 06, 2008 02:56:17 +0200:
> Dave Jones <davej@codemonkey.org.uk> writes:
> 
> > The server I run various git snapshots on recently got upgraded to git 1.5.6,
> > ...
> > I could run the clone with 2>/dev/null, but I'd really like to get
> > mail when something breaks instead of it being totally silent.
> >
> > I'm assuming this was an unintentional side-effect of some other recent change?
> 
> Yeah, I would assume so, too ;-)
> 
> Daniel, is this enough?  From re-reading the scripted version of
> git-clone, it appears that we *might* need to squelch no-progress if the
> stdout is not tty;  I do not offhand if you got that right when you
> rewrote this in C.

While at it, could we please have the first "Initialize" message
removed?

    Initialize git/.git
    Initialized empty Git repository in /home/davej/git-trees/git/.git/

The default output looks redundant (that of init_db too, but the full
path can be useful sometimes). Something like this, perhaps:

diff --git a/builtin-clone.c b/builtin-clone.c
index 643c7d4..4a0f1ab 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -421,7 +421,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die("could not create leading directories of '%s'", git_dir);
 	set_git_dir(make_absolute_path(git_dir));
 
-	fprintf(stderr, "Initialize %s\n", git_dir);
 	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
 
 	/*
