From: Jeff King <peff@peff.net>
Subject: Re: Git blame only current branch
Date: Mon, 12 Dec 2011 21:14:42 -0500
Message-ID: <20111213021442.GA4244@sigill.intra.peff.net>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
 <d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
 <20111212165542.GA4802@sigill.intra.peff.net>
 <8739cpteat.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Bash <bash@genarts.com>,
	git discussion list <git@vger.kernel.org>
To: Vijay Lakshminarayanan <laksvij@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 03:14:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaHtJ-0000SW-UX
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 03:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab1LMCOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 21:14:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48458
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab1LMCOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 21:14:45 -0500
Received: (qmail 9047 invoked by uid 107); 13 Dec 2011 02:21:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 21:21:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 21:14:42 -0500
Content-Disposition: inline
In-Reply-To: <8739cpteat.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186997>

On Tue, Dec 13, 2011 at 07:37:22AM +0530, Vijay Lakshminarayanan wrote:

> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index 80febbe..c19a8cd 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -1191,6 +1191,8 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
> >  {
> >  	int cnt;
> >  	struct commit_list *l = first_scapegoat(revs, commit);
> > +	if (revs->first_parent_only)
> > +		return l ? 1 : 0;
> >  	for (cnt = 0; l; l = l->next)
> >  		cnt++;
> >  	return cnt;
> 
> I just spent 30s staring at this wondering why you needed to do 
> 
>     return 1 ? 1 : 0;
> 
> which always returns 1 anyway before I realized it was a lowercase L.
> 
> The code reads fine when there's no numeral 1 around but now it doesn't
> read well.  I think refactoring
> 
>     struct commit_list *l
> 
> to 
> 
>     struct commit_list *lst
> 
> is justified.  Thoughts?

Sure, that would help. I wasn't planning to push this forward as a
"real" patch, but if somebody wants to do some testing and, more
importantly read through the code to make sure I am not violating some
assumptions, then it might be worth including upstream.

-Peff
