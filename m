X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 7 Dec 2006 23:15:03 +0100
Message-ID: <20061207221503.GA4990@steel.home>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com> <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 22:15:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: rfLuA6ZAZe3-XPv30fWPZQN7qSHztKi4Qo0sVmOKbNFoG5a+ljwrEn
X-TOI-MSGID: 18e1971b-d11a-4aae-85a5-5d3b49952924
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33640>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsRWV-0005Xm-4X for gcvg-git@gmane.org; Thu, 07 Dec
 2006 23:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163512AbWLGWPU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 17:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163501AbWLGWPT
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 17:15:19 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:42356 "EHLO
 mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1163516AbWLGWPR (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 17:15:17 -0500
Received: from fwd33.aul.t-online.de  by mailout06.sul.t-online.com with smtp
  id 1GsRWL-0006bT-00; Thu, 07 Dec 2006 23:15:13 +0100
Received: from tigra.home
 (rfLuA6ZAZe3-XPv30fWPZQN7qSHztKi4Qo0sVmOKbNFoG5a+ljwrEn@[84.163.120.110]) by
 fwd33.sul.t-online.de with esmtp id 1GsRWD-22TOds0; Thu, 7 Dec 2006 23:15:05
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 7FD55277AF; Thu,  7 Dec 2006 23:15:04 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GsRWB-000610-I2; Thu, 07 Dec 2006 23:15:03 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano, Thu, Dec 07, 2006 20:16:39 +0100:
> > I have a kind of awkward project to work with (~44k files, many binaries).
> >
> > The normal "git commit", which seem to be more than enough
> > for anything and anyone else, is a really annoying procedure
> > in my context. It spend too much time refreshing index and
> > generating list of the files for the commit message.
> >
> > At first I stopped using git commit -a (doing only update-index),
> 
> I am not sure what you are trying.  Do you mean stat() is slow
> on your filesystem?

incredibly slow. That and the matter of having 44000 files to process
with that slow stat().

> > Is there any simple way to modify git commit for such a workflow?
> > Failing that, any simple and _fast_ way to find out if the index
> > is any different from HEAD? (so that I don't produce empty commits).
> 
> Maybe you want "assume unchanged"?
> 

If that is core.ignoreState you mean, than maybe this is what I mean.
I haven't tried it yet (now I wonder myself why I haven't tried it).
But (I'm repeating myself, in <81b0412b0612060235l5d5f93d0hd1aaf34924f7783@mail.gmail.com>)
I do not really understand how it _can_ help: "I ask because it does
not ignore stat info, as the name implies. Because if it would,
there'd be no point of calling lstat at all, wouldn't it?" That last
question was about refresh_cache_entry - it calls lstat
unconditionally.

Still, I guess I'll have to try it.

But aside from me trying ignoreState, can anyone help me with that
question regarding checking if the index is any different from HEAD?
Because even on a very brocken filesystem and 40k files in a repo you
sometimes do want to call git-update-index --refresh just to be sure
you haven't missed anything. And than it'll quickly become annoying
flicking ignoreState back and forth.
