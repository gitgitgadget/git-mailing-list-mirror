From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] describe: use argv-array
Date: Tue, 9 Jul 2013 14:53:38 -0400
Message-ID: <20130709185338.GA5153@sigill.intra.peff.net>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
 <1373236424-25617-4-git-send-email-gitster@pobox.com>
 <20130709045151.GE27903@sigill.intra.peff.net>
 <7vip0jwzou.fsf@alter.siamese.dyndns.org>
 <7vehb7wwob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 20:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwd2o-0001Y8-RM
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab3GISxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 14:53:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:41066 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab3GISxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 14:53:42 -0400
Received: (qmail 9826 invoked by uid 102); 9 Jul 2013 18:54:58 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 13:54:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 14:53:38 -0400
Content-Disposition: inline
In-Reply-To: <7vehb7wwob.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229977>

On Tue, Jul 09, 2013 at 09:00:20AM -0700, Junio C Hamano wrote:

> >>> +		return cmd_name_rev(args.argc, args.argv, prefix);
> >>
> >> This leaks the memory allocated by "args". The original did, too, and it
> >> is probably not that big a deal (we exit right after anyway). The fix
> >> would be something like:
> >>
> >>   rc = cmd_name_rev(args.argc, args.argv, prefix);
> >>   argv_array_clear(&args);
> >>   return rc;
> >
> > Yes; this was meant as a straight rewrite and I did not bother, but
> > I should have cleaned it up as I meant to build on top.
> >
> > Will amend, even though I do not think we need to build anything on
> > top.
> 
> Heh, you fooled me.  cmd_name_rev() uses the usual parse-options
> machinery that updates args.argv[].  Dashed options that were
> consumed will not remain in args.argv[] and argv_array_clear() will
> not have a chance to free them, and besides, args.argc and args.argv
> will be out of sync and wreaks havoc in argv_array_clear().

Ick, yeah, I forgot about that. Let's just leave it as a leak, then. We
are exiting immediately afterwards, anyway.

-Peff
