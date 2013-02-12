From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: support 'git config --local'
Date: Tue, 12 Feb 2013 16:11:40 -0500
Message-ID: <20130212211140.GA29358@sigill.intra.peff.net>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
 <1360671642-10272-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vzjz9h1w0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Dasa Paddock <dpaddock@esri.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:12:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5N9L-00056T-9i
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759316Ab3BLVLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:11:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45505 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759427Ab3BLVLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:11:43 -0500
Received: (qmail 5834 invoked by uid 107); 12 Feb 2013 21:13:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Feb 2013 16:13:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2013 16:11:40 -0500
Content-Disposition: inline
In-Reply-To: <7vzjz9h1w0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216199>

On Tue, Feb 12, 2013 at 09:34:39AM -0800, Junio C Hamano wrote:

> I see the second hunk is new.  Comments?
> [...]
> > @@ -1676,7 +1676,7 @@ _git_config ()
> >  	case "$cur" in
> >  	--*)
> >  		__gitcomp "
> > -			--global --system --file=
> > +			--system --global --local --file=
> >  			--list --replace-all
> >  			--get --get-all --get-regexp
> >  			--add --unset --unset-all

It makes sense to me. It just means that "--local" itself gets completed
(while the other hunk is about using the presence of "--local" impacting
other completion). It's an orthogonal issue, but I don't mind them in
the same patch.

> How would this interract with the writing side of "git config"?
> "git config --local foo.bar value" and "git config foo.bar value"
> are the same, no?
> 
> Is it "yes they are the same but it does not hurt?"

It doesn't affect writing at all. The change is in
__git_config_get_set_variables, which is used only here:

  --get|--get-all|--unset|--unset-all)
        __gitcomp_nl "$(__git_config_get_set_variables)"

So it is purely about completing existing variables, and it's right to
limit itself to a particular file if we know that is what has been
given.

I'm not sure I understand the original poster's point about "git config
-l --local". "-l" does not take a limiter, does it?

-Peff
