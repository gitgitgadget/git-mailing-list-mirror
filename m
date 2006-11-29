X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: can I remove or move a tag in a remote repository?
Date: Wed, 29 Nov 2006 10:54:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291040590.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87wt5rffbm.fsf@rho.meyering.net> <7virgz1bz7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 09:54:30 +0000 (UTC)
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7virgz1bz7.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32627>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpM91-0008Du-1z for gcvg-git@gmane.org; Wed, 29 Nov
 2006 10:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966410AbWK2JyN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 04:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbWK2JyN
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 04:54:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:64664 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758813AbWK2JyN (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 04:54:13 -0500
Received: (qmail invoked by alias); 29 Nov 2006 09:54:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp005) with SMTP; 29 Nov 2006 10:54:11 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 28 Nov 2006, Junio C Hamano wrote:

> Jim Meyering <jim@meyering.net> writes:
> 
> > Here's the problem:
> > When I try to push the new tags, git-push fails:
> >
> >   $ git-push -f --tags ssh+git://git.sv.gnu.org/srv/git/coreutils master:refs/heads/master
> >   updating 'refs/tags/cvs-head'
> >     from 2fd3fd29a8b40be695bc2327c8cd3bd33e521100
> >     to   db18f53ffb221e9957124d8af81c11a7e350ac3b
> >   ...
> >   Total 1, written 1 (delta 0), reused 0 (delta 0)
> >   Unpacking 1 objects
> >   error: denying non-fast forward; you should pull first
> >
> > I get the same error also when using --force.
> 
> I think this is due to overeager receive.denyNonFastForwards
> configuration setting at the repository you are pushing into.
> 
> I _think_ what receive-pack does in this case is totally wrong.
> It should either:
> 
>  (1) deny overwriting existing tags -- tags are meant to be
>      immutable so it should not allow them to be "updated"
>      regardless of fast-forwardness, or
> 
>  (2) allow overwriting things under refs/tags/ without any
>      fast-forward checking.  After all, a tag could point at a
>      tree or a blob, and there is no fast-forwardness among
>      trees.
> 
> The client side check in "git fetch" takes the latter viewpoint,
> and I think we should be consistent with it.
> 
> Johannes, what do you think?  Does the following patch look sane
> to you?

It does if you agree that (2) is correct.

But I don't agree. cvs-head really should be a head IMHO, not a tag, 
because cvs-head really tracks a branch.

I also think that git-fetch silently updating tags is wrong. Rather, it 
should warn that the tags are different. But I've been wrong before.

Ciao,
Dscho
