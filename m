From: Rudolf Polzer <divVerent@alientrap.org>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 15:00:48 +0100
Message-ID: <20100115140048.GB30986@rm.endoftheinternet.org>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix> <op.u6haiiiog402ra@nb-04> <7vvdf33onp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 15:01:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVmjV-0006nF-K7
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 15:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab0AOOAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756455Ab0AOOAw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 09:00:52 -0500
Received: from rm.endoftheinternet.org ([94.23.21.40]:55952 "EHLO
	r23604.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755570Ab0AOOAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 09:00:52 -0500
Received: from rpolzer by r23604.ovh.net with local (Exim 4.69)
	(envelope-from <divVerent@alientrap.org>)
	id 1NVmjI-0002Q4-IX; Fri, 15 Jan 2010 15:00:48 +0100
Content-Disposition: inline
In-Reply-To: <7vvdf33onp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137071>

On Thu, Jan 14, 2010 at 09:47:22PM -0800, Junio C Hamano wrote:
> I have a feeling that it is more appropriate to have the additional code
> in transport_push(), which gets ls-remote information, runs match_refs()
> and finally calls transport->push_refs().  I think the extra branch
> configuration would fit better inside the if block immediately after all
> that happens, i.e.
> 
> 	if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
> 		struct ref *ref;
> 		for (ref = remote_refs; ref; ref = ref->next)
> 			update_tracking_ref(transport->remote, ref, verbose);
> +		if (flags & TRANSPORT_PUSH_RECONFIGURE_FORK)
> +			configure_forked_branch(...);
> 	}
> 
> in transport.c

I thought about this place when making my patch, but didn't put it there
because this function is not called in the rsync protocol (which defines
transport->push). So I instead did the logical step and went into the caller of
that function. Functionality-wise, it also isn't really a "transport" function
but part of pushing.

> > +		if(!(flags & TRANSPORT_PUSH_DRY_RUN))
> > +		if(!match_refs(local_refs, &remote_refs, refspec_nr, refspec, match_flags))
> 
> Yuck; hiding the fact that you have an over-nested logic is not a way to
> fix it.

This was accidental.

But well. Why bother with this, if this feature was rejected before already
anyway.

Rudolf
