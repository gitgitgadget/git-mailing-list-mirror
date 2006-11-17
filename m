X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 11:11:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611171103150.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org>
 <20061115230252.GH24861@spearce.org> <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
 <87fycjs5yg.wl%cworth@cworth.org> <f2b55d220611160957s2e68059dk99bbe902e7e1f416@mail.gmail.com>
 <87r6w3b68p.wl%cworth@cworth.org> <7vu00ysbwi.fsf@assigned-by-dhcp.cox.net>
 <87ejs2qvmb.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 10:11:35 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87ejs2qvmb.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31686>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl0gx-0003s8-DF for gcvg-git@gmane.org; Fri, 17 Nov
 2006 11:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755652AbWKQKLX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 05:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbWKQKLX
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 05:11:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:36748 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755647AbWKQKLW (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 05:11:22 -0500
Received: (qmail invoked by alias); 17 Nov 2006 10:11:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp044) with SMTP; 17 Nov 2006 11:11:21 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 17 Nov 2006, Carl Worth wrote:

> 1. Making clone do the --use-separate-remotes behavior by default

Fully agree.

> 2. Taking advantage of that consistently for all branches instead of a
>    special master:origin mapping in clone

Fully agree, too.

> 3. Enhancing git-fetch (or other) to modify .git/remotes, (or was
>    there a desire for some other branch-specific section in the config
>    file?)

I introduced the remote.<nick>.{url,fetch,push} entries into the config 
with the goal to enhance -fetch to remember the current command line with 
a setting. I was the only one to find that useful.

BTW I still would argue that it is better to write the remote information 
into the config, because you have a saner way to manipulate that from 
scripts than .git/remotes/<nick>.

> 4. Making git-fetch handle the disappearance of a remote branch
>    gracefully

I think a message like "This remote branch no longer exists. Maybe you 
want to use 'git branch -d <branch>' to remove it locally?" should 
suffice.

> 5. Adding something like git-fetch --all to allow it to pick up all new
>    branches

IIRC this idea was rejected, but I would find it useful. Especially with 
what Han-Wen said: you can store the branches you fetch with "git fetch 
--all <nick>" under .git/refs/remotes/<nick>/<branchname>.

> 6. Adding a "git update" that does a fetch for all appropriately
>    marked remotes.
> 
> On this last point, maybe we do something like:
> 
> 	update=no|yes|all
> 
> in .git/remotes. Then git-clone would set this up with update=all for
> origin so git-update would do a "fetch --all" on the origin
> repository. Then step 3 above would have to provide for setting this
> update option as appropriate.

First thought was: it is only useful if you want to track multiple 
repositories. But next thought: if you mark the correct remotes in every 
of your local repositories, you don't have to remember which nick your 
upstream has. Yeah, I like it. But maybe do it as "git fetch --update" to 
avoid more cluttering of the bindir?

Ciao,
Dscho
