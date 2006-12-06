X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 10:26:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> 
 <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net> <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 09:26:51 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33408>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grt39-0003ft-9A for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760364AbWLFJ0k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760369AbWLFJ0k
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:26:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:35087 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760364AbWLFJ0j
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 04:26:39 -0500
Received: (qmail invoked by alias); 06 Dec 2006 09:26:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 06 Dec 2006 10:26:37 +0100
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Aneesh Kumar wrote:

> On 12/6/06, Junio C Hamano <junkio@cox.net> wrote:
> 
> >         $ cat >.git/remotes/origin <<\EOF
> >         URL: ...kernel.org/pub/scm/git/git.git
> >         Pull: refs/heads/master:refs/remotes/origin/master
> >         Pull: refs/heads/next:refs/remotes/origin/next
> >         Pull: +refs/heads/pu:refs/remotes/origin/pu
> >         EOF
> 
> Okey what i was looking for was a .git/config that will imply as a
> part of git pull origin that local
> 
> master is to track remotes/origin/master
> pu  should track remotes/origin/pu.

You can have the same effect as what Junio wrote with the config:

$ git repo-config remote.origin.url git://git.kernel.org/pub/scm/git/git.git
$ git repo-config remote.origin.fetch \
	refs/heads/master:refs/remotes/origin/master
$ git repo-config remote.origin.fetch \
	refs/heads/next:refs/remotes/origin/next ^$
$ git repo-config remote.origin.fetch \
	+refs/heads/pu:refs/remotes/origin/pu ^$

But if you clone with recent git, that will already be set up for you 
(well, except that the "+" is missing in front of the "pu" thing, which 
says that it is okay if that particular ref is not fast-forwarding).

> I almost felt the branch.<name>.merge was for that.

No. This tells git which _default_ branch to merge with. I.e.

$ git repo-config branch.master.remote origin
$ git repo-config branch.master.merge next

means that if your current branch is "master", a "git pull" _without_ 
parameters will default to the branch "next" of the remote "origin" you 
just set up like above.

Hth,
Dscho
