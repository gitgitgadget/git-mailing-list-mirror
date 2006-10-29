X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Sun, 29 Oct 2006 00:38:19 -0400
Message-ID: <20061029043818.GA3650@spearce.org>
References: <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org> <20061028084001.GC14607@spearce.org> <7vfyd88d6s.fsf@assigned-by-dhcp.cox.net> <20061029035025.GC3435@spearce.org> <7vejsr68y9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 04:38:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vejsr68y9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30413>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge2RM-0000GR-3l for gcvg-git@gmane.org; Sun, 29 Oct
 2006 05:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964990AbWJ2EiX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 00:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWJ2EiX
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 00:38:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56793 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S964990AbWJ2EiW
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 00:38:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge2RU-00026a-AZ; Sun, 29 Oct 2006 00:38:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5467020E45B; Sun, 29 Oct 2006 00:38:19 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > The issue is --unpacked= uses the path of the pack name, which
> > includes $GIT_OBJECT_DIRECTORY, whatever that may be.  This makes it
> > impossible for the shell script to hand through a proper --unpacked=
> > line for the active packs without including $GIT_OBJECT_DIRECTORY
> > as part of the option.
> 
> Yeah, I realize that; you need to know how to build shell script
> that is properly shell quoted to be eval'ed, which is not hard
> but is not usually done and is cumbersome.

Too much work.  :-)

> I would suspect it is probably easier to just say --unpacked
> (without packname) means "unpacked objects, and objects in packs
> that do not have corresponding .keep".  However, that would be a
> change in semantics for --unpacked (without packname), which is
> not nice.
> 
> So how about pack-X{40}.volatile that marks an eligible one for
> repacking?

Then anyone who has an existing pack would need to create that
file first as soon as they got this newer version of Git... not
very upgrade friendly if you ask me.
 
> Then we can make "pack-objects --unpacked" to pretend the ones
> with corresponding .volatile as if the objects in them are
> loose, without breaking backward compatibility.

Currently I'm changing --unpacked= to match without needing quoting.
I'm allowing it to match an exact pack name or if it starts with
"pack-" and matches the last 50 ("pack-X{40}.pack") of the pack name.

I figure this should work fine as probably anyone who has a pack
name that matches 50 characters and starts with "pack-" is using a
pack file name which has the SHA1 of the object list contained in
it and is thus probably unique.
 
-- 
