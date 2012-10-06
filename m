From: Jeff King <peff@peff.net>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Sat, 6 Oct 2012 08:57:35 -0400
Message-ID: <20121006125735.GA11712@sigill.intra.peff.net>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
 <7v391ux7im.fsf@alter.siamese.dyndns.org>
 <7vvceqvses.fsf@alter.siamese.dyndns.org>
 <7vmx01x3s4.fsf@alter.siamese.dyndns.org>
 <7vehlcu091.fsf@alter.siamese.dyndns.org>
 <20121005232108.GA7996@sigill.intra.peff.net>
 <7vobkgrxay.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 14:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKTx3-0000f5-MT
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 14:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab2JFM5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 08:57:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42877 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313Ab2JFM5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 08:57:43 -0400
Received: (qmail 6348 invoked by uid 107); 6 Oct 2012 12:58:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 08:58:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 08:57:35 -0400
Content-Disposition: inline
In-Reply-To: <7vobkgrxay.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207143>

On Fri, Oct 05, 2012 at 10:20:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> > @@ -617,6 +618,8 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
> >> >  
> >> >  	one->object.flags |= PARENT1;
> >> >  	commit_list_insert_by_date(one, &list);
> >> > +	if (!n)
> >> > +		return list;
> >> >  	for (i = 0; i < n; i++) {
> >> >  		twos[i]->object.flags |= PARENT2;
> >> >  		commit_list_insert_by_date(twos[i], &list);
> >
> > This seems like an obvious optimization, but does it really have
> > anything to do with the patch at hand?
> 
> The function picks one and paints it against all others, but the
> logic assumes there must be at least one other to paint against;
> otherwise the traversal will not ever find a node that is painted
> with both PARENT1 and PARENT2 to stop, leading us to traverse all
> the way down to root.

Ah, OK. I was thinking it was just a way to skip the further logic,
which would come to the same answer (it does, just not quickly). Makes
sense.

-Peff
