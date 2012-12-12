From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 12 Dec 2012 09:44:32 +0100
Organization: Bertin Technologies
Message-ID: <20121212094432.6e1e48c8@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:44:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tihvt-0006bV-6v
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 09:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab2LLIoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 03:44:32 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:39401 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab2LLIoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 03:44:32 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id B2959A0F7D
	for <git@vger.kernel.org>; Wed, 12 Dec 2012 09:44:30 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 77B54A0F81
	for <git@vger.kernel.org>; Wed, 12 Dec 2012 09:44:30 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MEW00CJ7TM5L350@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 12 Dec 2012 09:44:30 +0100 (CET)
In-reply-to: <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19442.001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211333>

On Tue, 11 Dec 2012 10:15:23 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> 
> > There seems to be some bad interactions between git-push and grafts.
> > The problem seems to occur when a commit that exists in the remote
> > repo is subject to a graft in the local repo, and we try to push one
> > of the fake parents.
> 
> History tweaking by grafts is only visible inside your local
> repository and objects are not rewritten, and grafts are not
> transferred across repositories.  They were invented to be used as a
> stop-gap measure until you filter-branch the history before
> publishing (or if you do not publish, then you can keep using your
> local grafts).
> 
> Isn't this well known?  Perhaps we would need to document it better.

I am well aware of that, and did not intend to push any grafted commit.
I am attempting to push a well-formed commit, which happens to be used as
a grafted commit's fake parent, and my interpretation is that git reacts
as if it was considering that the remote already had that commit, possibly
because it would not ignore grafts when deciding which commits are already
known to the remote.

> What you can do is to use "replace" instead and publish the replace
> refs, I think.  Object transfer will then follow the true parenthood
> connectivity and people who choose to use the same replacement as
> you do can fetch the replace ref from you (this will grab objects
> necessary to complete the alternative history) and install it.

I am only using grafts as a temporary and lightweight drafting area,
before setting the results in stone - although in my case it will be
with filter-branch rather than replace, but the idea is the same.  I just
got bitten when attempting to push a valid branch while the grafts were in
effect, when in fact they should have had no influence at all.

In fact, I even looked for a way to specify an alternate (or supplementary)
grafts file for this drafting work, so only well-controlled git invocations
would see them, whereas the others would just ignore them, and could not find
any - nor could I identify an existing way of disabling the use of grafts by
other means than moving it out of the way.  In this respect, they seem to be
lacking a few features, when compared to "replace" refs, but they have different
uses, and just using the latter as a drafting area is just not adequate.

I thought about adding support for a GIT_GRAFTS_FILE envvar, which would
default to $GITDIR/info/grafts, or maybe with a more general addition of a
GIT_EXTRA_GRAFT_FILES envvar, but I'm not sure the latter would be that useful.

-- 
Yann Dirson - Bertin Technologies
