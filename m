From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 16:24:41 -0400
Message-ID: <20120615202441.GA12163@sigill.intra.peff.net>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
 <7vzk849zxg.fsf@alter.siamese.dyndns.org>
 <20120615193724.GB26473@sigill.intra.peff.net>
 <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com>
 <7vmx449w3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:24:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfd4c-0004Xu-5H
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab2FOUYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:24:45 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57768
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757589Ab2FOUYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:24:45 -0400
Received: (qmail 3712 invoked by uid 107); 15 Jun 2012 20:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 16:24:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 16:24:41 -0400
Content-Disposition: inline
In-Reply-To: <7vmx449w3j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200093>

On Fri, Jun 15, 2012 at 01:08:32PM -0700, Junio C Hamano wrote:

> Tim Henigan <tim.henigan@gmail.com> writes:
> 
> >>> @@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
> >>>        * The return code for --no-index imitates diff(1):
> >>>        * 0 = no changes, 1 = changes, else error
> >>>        */
> >>> -     exit(revs->diffopt.found_changes);
> >>> +     result = !!diff_result_code(&revs->diffopt, 0);
> >>> +     exit(result);
> >
> > I assume the '!!' before 'diff_result_code' is a typo.
> 
> Not a typo.  I meant to use that idiom to turn 0 or not into
> boolean, as diff_result_code() can return values other than 0 or 1.

I wonder if that is a good idea, though. AFAICT, diff_result_code will
only return a different exit code if "--check" is used. If we pass along
the exit code fully, then:

  1. If --check is not used, we will be diff(1)-compatible.

  2. If --check is used, then we will not be compatible with diff(1) in
     our exit code. But diff(1) does not have --check in the first
     place, so there is no point in us trying to be a drop-in
     replacement.

-Peff
