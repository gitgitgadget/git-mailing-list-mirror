From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] git add --intent-to-add: do not let an empty blob
	committed by accident
Date: Sun, 30 Nov 2008 14:14:44 -0500
Message-ID: <20081130191444.GC10981@coredump.intra.peff.net>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de> <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de> <20081128192033.GF23984@spearce.org> <7voczz4cfb.fsf@gitster.siamese.dyndns.org> <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org> <7vvdu72nq9.fsf@gitster.siamese.dyndns.org> <7vk5an2nil.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 20:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6rlz-00053d-UP
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 20:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbYK3TOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 14:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbYK3TOr
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 14:14:47 -0500
Received: from peff.net ([208.65.91.99]:2011 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbYK3TOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 14:14:46 -0500
Received: (qmail 9519 invoked by uid 111); 30 Nov 2008 19:14:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Nov 2008 14:14:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Nov 2008 14:14:44 -0500
Content-Disposition: inline
In-Reply-To: <7vk5an2nil.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101982>

On Fri, Nov 28, 2008 at 07:56:34PM -0800, Junio C Hamano wrote:

> Subject: Re: [PATCH 3/3] git add --intent-to-add: do not let an empty blob
>	committed by accident

Minor nit: grammatical error in the subject.

> This implies that you cannot "git commit" from such a state; however "git
> commit -a" still works.

I was going to provide a test for "git commit -a" to squash in, but it
looks like the version in 'pu' already has one.

>  	case WRITE_TREE_UNMERGED_INDEX:
> -		die("%s: error building trees; the index is unmerged?", me);
> +		die("%s: error building trees", me);

This caught me by surprise while reading, but I assume the rationale is
"now there is a new, different reason not to be able to build the trees,
so our guess is less likely to be correct". I wonder if we can do better
by actually passing out a more exact error value (though it looks like
we will already have said "foo: not added yet" by that point anyway, so
maybe it is just pointless to say more).

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh

Why in t3701? These don't have anything to do with interactive add, and
there is a already a t2203-add-intent.

-Peff
