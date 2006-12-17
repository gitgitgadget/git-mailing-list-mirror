X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 01:32:14 +0100
Message-ID: <200612170132.14276.Josef.Weidendorfer@gmx.de>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <7v64cbeeiv.fsf@assigned-by-dhcp.cox.net> <20061216225810.GD12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 00:32:36 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, skimo@liacs.nl,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <20061216225810.GD12411@admingilde.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34671>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjxA-0006eK-Ic for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750931AbWLQAcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWLQAcZ
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:32:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:37720 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1750931AbWLQAcZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 19:32:25 -0500
Received: (qmail invoked by alias); 17 Dec 2006 00:32:23 -0000
Received: from p5496AE8F.dip0.t-ipconnect.de (EHLO noname) [84.150.174.143]
 by mail.gmx.net (mp033) with SMTP; 17 Dec 2006 01:32:23 +0100
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Saturday 16 December 2006 23:58, Martin Waitz wrote:
> > If the plumbing layer does not have to (although I haven't
> > thought it through, it does feel like it even shouldn't) unwrap
> > "link" and let the Porcelain layer to deal with it, that would
> > certainly make rev-list/revision.c part simpler.
> 
> Yes.  However, it makes other things more complicated.
> If the plumbing does not do all the subproject stuff and you don't have
> everything in one database

Even without plumbing doing the subproject stuff, we could use the
same, unified database for the objects. Or do I miss something?

As you said: the problem are submodule commit in superproject trees which
are not reachable by refs of the submodule. However, we only need these
commits when cloning/fetching the submodule in the scope of cloning/fetching
the superproject; we simply can not use here a normal repository of the
submodule, as these commits would be not available there.

We should add a plumbing command for "Give me the minimal set of commits
(from all submodules) which have all the submodule link object ids as ancestors
which appear in the history of a given commit (from a superproject)".
With this, building the set of objects to pack/fetch/clone into a unified
object database for a superproject with its submodules should be easy.

It is also needed for pruning the unified object database.
Pruning in submodules simply would print out an error "Pruning in submodules
not supported. Prune in the superproject instead".

Josef
