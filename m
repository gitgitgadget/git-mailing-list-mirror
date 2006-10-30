X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 16:07:51 -0500
Message-ID: <20061030210751.GB20236@delft.aura.cs.cmu.edu>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home> <20061030202611.GA5775@spearce.org> <20061030205200.GA20236@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 21:13:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061030205200.GA20236@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30523>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeeMS-0004sG-AD for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422660AbWJ3VH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWJ3VH4
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:07:56 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:43749 "EHLO
 delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP id S1422660AbWJ3VHz
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:07:55 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
 (envelope-from <jaharkes@cs.cmu.edu>) id 1GeeMJ-0006Po-Co; Mon, 30 Oct 2006
 16:07:51 -0500
To: Shawn Pearce <spearce@spearce.org>, Nicolas Pitre <nico@cam.org>, Junio C
 Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Mon, Oct 30, 2006 at 03:52:00PM -0500, Jan Harkes wrote:
> On Mon, Oct 30, 2006 at 03:26:11PM -0500, Shawn Pearce wrote:
> > Do the above so you have everything in one pack.  Now use rev-list
> > to simulate the object list construction in pack-objects as though
> > we were doing a 'git repack -a -d':
> > 
> >   git-rev-list --objects --all \
> >     --unpacked=.git/objects/pack/pack-*.pack \
> > 	| wc -l
> > 
> > gives me 102 (WRONG WRONG WRONG WRONG!!!!!!)
> 
...
> 
> The following patch does fix the problem Nicolas reported, but for some
> reason I'm still getting only 102 objects (only tags and the commits
> they refer to?) with your test.

Seems to be operator error, I guess the shell can't (won't) expand
--unpacked=.git/objects/pack/pack-*.pack and there is no pack named
pack-*.pack, so rev-list will actually find every object in one of the
packs and skip them.

The following works correctly,

    $ git-rev-list --objects --all --unpacked=.git/objects/pack/pack-234f8136e45fb34d118bb346c15267535e80e5f0.pack --unpacked=.git/objects/pack/pack-aceb4c6394c586abaf65d76dd6cf088f50a5b806.pack | wc -l
    28713

    $ ~/git/git/git-rev-list --objects --all | wc -l
    28713

Jan
