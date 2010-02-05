From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH 3/3] make git push --dry-run --porcelain exit with
 status 0 even if updates will be rejected
Date: Fri, 5 Feb 2010 15:05:24 -0500
Message-ID: <20100205200524.GA24027@cthulhu>
References: <20100205150638.GB14116@coredump.intra.peff.net>
 <1265398462-17316-3-git-send-email-larry@elder-gods.org>
 <20100205195644.GE24474@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUQk-0003D5-8O
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab0BEUFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:05:25 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:35868 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0BEUFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:05:25 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 5D0D4822180; Fri,  5 Feb 2010 15:05:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100205195644.GE24474@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139076>

* Jeff King (peff@peff.net) [100205 14:56]:
> On Fri, Feb 05, 2010 at 02:34:22PM -0500, Larry D'Anna wrote:
> 
> > diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> > index 76c7206..dfd7470 100644
> > --- a/builtin-send-pack.c
> > +++ b/builtin-send-pack.c
> > @@ -478,6 +478,11 @@ int send_pack(struct send_pack_args *args,
> >  		return ret;
> >  	for (ref = remote_refs; ref; ref = ref->next) {
> >  		switch (ref->status) {
> > +		case REF_STATUS_REJECT_NONFASTFORWARD:
> > +		case REF_STATUS_REJECT_NODELETE:
> > +			if (args->porcelain && args->dry_run)
> > +				break;
> > +			return -1;
> >  		case REF_STATUS_NONE:
> >  		case REF_STATUS_UPTODATE:
> >  		case REF_STATUS_OK:
> 
> Why just these two status flags? Based on your reasoning elsewhere, I
> would assume the logic should be:
> 
>   - if we had some transport-related error, return failure
> 
>   - if not, then return success, as any ref's failure is already
>     indicated in the porcelain output
> 
> So shouldn't it just be:
> 
>   if (args->porcelain && args->dry_run)
>           return 0;
> 
> after we check for transport errors but before the loop that you are
> modifying.

I don't know what the deal is with REF_STATUS_EXPECTING_REPORT, so I didn't want
to modify the behavior in the case that ref->status was that.  What does
expecting report mean?

          --larry
