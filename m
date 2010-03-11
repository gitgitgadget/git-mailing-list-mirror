From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Do not strip empty lines / trailing spaces from a
 commit message template
Date: Thu, 11 Mar 2010 03:31:48 -0500
Message-ID: <20100311083148.GA13786@sigill.intra.peff.net>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 09:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpdoE-0000So-Qs
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 09:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207Ab0CKIbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 03:31:52 -0500
Received: from peff.net ([208.65.91.99]:33102 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518Ab0CKIbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 03:31:51 -0500
Received: (qmail 28140 invoked by uid 107); 11 Mar 2010 08:32:14 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 11 Mar 2010 03:32:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Mar 2010 03:31:48 -0500
Content-Disposition: inline
In-Reply-To: <20100311081213.GA13575@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141941>

On Thu, Mar 11, 2010 at 03:12:13AM -0500, Jeff King wrote:

> >  	if (fp == NULL)
> >  		die_errno("could not open '%s'", git_path(commit_editmsg));
> >  
> > -	if (cleanup_mode != CLEANUP_NONE)
> > +	if (cleanup_mode != CLEANUP_NONE && strcmp(hook_arg1, "template"))
> >  		stripspace(&sb, 0);
> 
> And the code looks OK, though admittedly I am not too familiar with this
> chunk of code (at first I was confused that you would have to look at
> hook_arg1, but apparently there is no other variable that contains the
> result of that big if-else chain).

BTW, a subtle point for anyone else reviewing this patch: we also call
stripspace in message_is_empty to skip over an untouched template. But
that code path is stil OK, because we stripspace the whole message that
comes back from the user before calling message_is_empty(), so the
result should be the same for an untouched template.

-Peff
