X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Tue, 31 Oct 2006 01:39:41 -0500
Message-ID: <20061031063941.GB7375@spearce.org>
References: <20061030223615.GH5775@spearce.org> <7vlkmxtmln.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610302258400.11384@xanadu.home> <7v7iyhrsoi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 06:40:03 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v7iyhrsoi.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30570>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GenHt-0004av-Cw for gcvg-git@gmane.org; Tue, 31 Oct
 2006 07:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422804AbWJaGjt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 01:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbWJaGjs
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 01:39:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:25802 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422804AbWJaGjs
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 01:39:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GenHj-0008Jh-0r; Tue, 31 Oct 2006 01:39:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9D6CA20FB0C; Tue, 31 Oct 2006 01:39:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > Why not just parse the pack header in receive-pack / fetch-pack, and 
> > decide on the first-hand information?  Sure the pack header is then 
> > gone, but then the only thing that is needed is an extra flag to both 
> > unpack-objects and index-pack to tell them that we've already parsed the 
> > pack header and that the pack version is x and the number of objects is 
> > y.  Simply something like --pack_header=x,y.  No protocol extension 
> > needed, no extra rev-list, no reliance on the remote server providing 
> > the needed info.
> 
> I like it.
> 
> Because that approach assumes recieve-pack and unpack-objects
> and index-pack are from the same vintage (otherwise your
> receive-pack would need to have a way to see if unpack-objects
> and index-pack would grok --pack_header argument), we could even
> get away without passing the pack version if we wanted to.

Heh.  On Saturday I almost did exactly what Nico proposes above.
But I thought both of you would find the --pack_header=x,y option
too brittle and would reject the change.

But since all three of us liked the same idea I'll code it up
and resend my receive-pack patch using Nico's suggestion instead.
Hopefully I'll get it out tomorrow.

BTW I think we do need to pass the pack version in the option.
If we ever do increment the pack version its going to be after this
option is introduced so supporting the option does not imply that
the callee is able to parse the pack file without knowing what
version the file is, especially if the callee supports both the
current version and the new version.

-- 
