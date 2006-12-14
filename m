X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 15:02:45 -0500
Message-ID: <20061214200245.GP1747@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org> <20061214120518.GL1747@spearce.org> <Pine.LNX.4.64.0612141251520.18171@xanadu.home> <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 20:03:21 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34390>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuwnR-0007AP-KI for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932671AbWLNUCv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWLNUCv
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:02:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60366 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932755AbWLNUCu (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:02:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Guwms-0006Rb-Jl; Thu, 14 Dec 2006 15:02:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2BB9D20FB65; Thu, 14 Dec 2006 15:02:45 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > I'd say screw that.  The solution should really be this patch:
> >
> > diff --git a/environment.c b/environment.c
> > index 84d870c..98275b2 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -15,7 +15,7 @@ int use_legacy_headers = 1;
> >  int trust_executable_bit = 1;
> >  int assume_unchanged;
> >  int prefer_symlink_refs;
> > -int log_all_ref_updates;
> > +int log_all_ref_updates = 1;
> >  int warn_ambiguous_refs = 1;
> >  int repository_format_version;
> >  char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
> >
> 
> That changes what the command does to existing repositories,
> which is somewhat impolite.

Yes, but users are forgetting to enable them.  They will work in
a new repository having that feature, move to an older one and not
have it, but expect it to be there.

As I recall the primary objection to enabling them by default
when I first introduced them was that core.logAllRefUpdates=true
meant that refs/tags/<name> were also being logged.  This was not a
great idea as tags generally did not change once they were created.
You fixed that and now it just makes sense to enable it for branch
heads all of the time.

> I am not opposed too much to an updated version of the tool that
> sets the configuration on by default for newly created
> repositories, though.

I almost did that in my patch - but decided against it for the
reason I just noted above.

Does anyone on the mailing list really have an objection to having
reflogs on by default?

About the only trouble that can cause is a failed push when
git-receive-pack needs to generate the reflog entry but cannot
get the user's committer data because their gecos information
doesn't exist.

-- 
