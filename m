Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D3920958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755959AbdCTStM (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:49:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:47945 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755886AbdCTStC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:49:02 -0400
Received: (qmail 16224 invoked by uid 109); 20 Mar 2017 18:48:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:48:59 +0000
Received: (qmail 4702 invoked by uid 111); 20 Mar 2017 18:49:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:49:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:48:55 -0400
Date:   Mon, 20 Mar 2017 14:48:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC 1/3] stash: show less information for stash push --
 <pathspec>
Message-ID: <20170320184855.x7m2gxwdqdt3lnet@sigill.intra.peff.net>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170319202351.8825-2-t.gummerer@gmail.com>
 <xmqqk27jx2ej.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk27jx2ej.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 10:51:16AM -0700, Junio C Hamano wrote:

> > diff --git a/git-stash.sh b/git-stash.sh
> > index 9c70662cc8..59f055e27b 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -299,10 +299,10 @@ push_stash () {
> >  	then
> >  		if test $# != 0
> >  		then
> > -			git reset ${GIT_QUIET:+-q} -- "$@"
> > +			git reset -q -- "$@"
> >  			git ls-files -z --modified -- "$@" |
> >  			git checkout-index -z --force --stdin
> > -			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
> > +			git clean --force -q -d -- "$@"
> >  		else
> >  			git reset --hard ${GIT_QUIET:+-q}
> >  		fi
> 
> Yup, we only said "HEAD is now at ..." in the non-pathspec case (and
> we of course still do).  We didn't report changes to which paths
> have been reverted in (or which new paths are removed from) the
> working tree to the original state (and we of course still don't).
> 
> The messages from reset and clean that reports these probably do not
> need to be shown by default to the users (they can always check with
> "git stash show" when they are curious or when they want to double
> check).

I'm not sure if you are arguing here that the non-pathspec case should
move to an unconditional "-q", too, to suppress the "HEAD is now at"
message.  But I think that is a good suggestion. It would make the two
cases consistent, and it is not really adding anything of value (it is
always just HEAD, and if you do not provide a custom message, the
short-sha1 and subject are already in the "Saved..." line above).

-Peff
