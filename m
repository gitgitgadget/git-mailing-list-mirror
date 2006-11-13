X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: should git download missing objects?
Date: Mon, 13 Nov 2006 21:03:58 +0100
Message-ID: <20061113200358.GF7201@pasky.or.cz>
References: <ej7fgp$8ca$1@sea.gmane.org> <7vwt60bggs.fsf@assigned-by-dhcp.cox.net> <20061113194532.GA4547@steel.home> <20061113195414.GD17244@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 20:04:28 +0000 (UTC)
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061113195414.GD17244@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31316>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gji2I-0003Wq-5k for gcvg-git@gmane.org; Mon, 13 Nov
 2006 21:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933055AbWKMUEB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 15:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933057AbWKMUEB
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 15:04:01 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23206 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S933055AbWKMUEA (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 15:04:00 -0500
Received: (qmail 31162 invoked by uid 2001); 13 Nov 2006 21:03:58 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, Nov 13, 2006 at 08:54:14PM CET, Shawn Pearce wrote:
> Alex Riesen <fork0@t-online.de> wrote:
> > Junio C Hamano, Sun, Nov 12, 2006 20:41:23 +0100:
> > > Since this is not everyday anyway, a far easier way would be to
> > > clone-pack from the upstream into a new repository, take the
> > > pack you downloaded from that new repository and mv it into your
> > > corrupt repository.  You can run fsck-objects to see if you got
> > > back everything you lost earlier.
> > 
> > I get into such a situation annoyingly often, by using
> > "git clone -l -s from to" and doing some "cleanup" in the
> > origin repository. For example, it happens that I remove a tag,
> > or a branch, and do a repack or prune afterwards. The related
> > repositories, which had "accidentally" referenced the pruned
> > objects become "corrupt", as you put it.
> >
> > At the moment, if I run into the situation, I copy packs/objects from
> > all repos I have (objects/info/alternates are useful here too), run a
> > fsck-objects/repack and hope nothing is lost. It works, as I almost
> > always have "accidental" backups somewhere, but is kind of annoying to
> > setup. A tool to do this job more effectively will be very handy (at
> > least, it wont have to copy gigabytes of data over switched windows
> > network. Not often, I hope. Not _so_ many gigabytes, possibly).

cg-fetch -f locally or over HTTP should be able to fix that up, if used
cleverly.

> One of my coworkers recently lost a single loose tree object.
> We suspect his Windows virus scanner deleted the file.  :-(
> 
> Copying the one bad object from another repository immediately fixed
> the breakage caused, but it was very annoying to not be able to run a
> "git fetch --missing-objects" or some such.  Fortunately it was just
> the one object and it was also still loose in another repository.
> scp was handy.  :-)

If it's over ssh, this is still where the heavily dusty (and heavily
"plumby") git-ssh-fetch command is useful, since it can get passed an
undocumented --recover argument and then it will fetch _all_ the objects
you are missing, not assuming anything.

Perhaps I should reintroduce support for git-ssh-fetch to cg-fetch to be
used in case of -f over SSH. But it would be silly if I did that and
next Git would remove the command from its suite. Junio, what's its life
expectancy? I guess this usage scenario is something to take into
account when thinking about removing it, I know that I wanted to get rid
of it in the past but now my opinion is changing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
