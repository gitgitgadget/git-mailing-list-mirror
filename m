X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] allow deepening of a shallow repository
Date: Sat, 18 Nov 2006 13:58:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611181356300.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302009390.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7qeze0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611141150010.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7qaqw12.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611171050440.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu00ymhk1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 18 Nov 2006 12:58:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vu00ymhk1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31771>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlPmG-0000OM-1w for gcvg-git@gmane.org; Sat, 18 Nov
 2006 13:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756341AbWKRM6X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 07:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756340AbWKRM6X
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 07:58:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:52457 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1756339AbWKRM6W (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 07:58:22 -0500
Received: (qmail invoked by alias); 18 Nov 2006 12:58:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 18 Nov 2006 13:58:21 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 17 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Although I am reasonably sure we can eventually make it work, it
> >> is very subtle and fragile -- somebody touching this code can
> >> easily break it.
> >
> > I fully agree. Even the OA did not understand the code fully ;-)
> >
> > How about adding "int force_reparse" to the signature of 
> > unregister_shallow()? (Just like we added "int cleanup" to 
> > get_merge_bases() to avoid pilot errors.)
> 
> I do not think that's where its fragility lies.  It is that any
> random place can later call parse_object() on the commit, after
> you elaborately pre-parsed it with shallow so that it appears to
> have fewer parents, with the expectation that nobody ever would
> clear the parsed bit and cause it to be reparsed again.  With
> that assumption, find_common() manipulated the shallow entry
> after setting that scheme up.  A mechanism to prevent the commit
> >from getting re-parsed would have made it more robust.

How about putting yet more meaning into nr_parents: if it is negative, it 
is a shallow commit, but write_shallow_commits() only writes the SHA1 if 
nr_parents is -1. Hmm?

Ciao,
Dscho
