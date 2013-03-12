From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Tue, 12 Mar 2013 15:26:36 -0400
Message-ID: <20130312192636.GE17099@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165857.GC1136@sandbox-ub.fritz.box>
 <20130312110003.GD11340@sigill.intra.peff.net>
 <20130312160056.GB4472@sandbox-ub.fritz.box>
 <20130312161620.GA4551@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:27:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFUqo-0004xY-HV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719Ab3CLT0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:26:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50027 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932532Ab3CLT0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:26:40 -0400
Received: (qmail 29379 invoked by uid 107); 12 Mar 2013 19:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 15:28:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 15:26:36 -0400
Content-Disposition: inline
In-Reply-To: <20130312161620.GA4551@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217985>

On Tue, Mar 12, 2013 at 05:16:20PM +0100, Heiko Voigt wrote:

> > Ok if you say so I will do that :-). I was thinking about adding a patch
> > that would remove cf as a global variable and explicitely pass it down
> > to get_next_char. That makes it more obvious that it actually is != NULL.
> > Looking at your callgraph I do not think its that much work. What do you
> > think?
> 
> I just had a look and unfortunately there are other functions that use
> this variable (namely handle_path_include) for which its not that easy
> to pass this in. So I will just drop the check here.

Ah, I should have read all your responses before answering the last
email. I think handle_path_include is surmountable, and I started to do
a proof-of-concept patch, but there's a harder one: die_bad_config,
which is called from git_config_int and friends. Getting the "cf"
pointer there is hard, because you would have to update every config
callback that uses git_config_int. Not worth it, I think.

Thanks for looking, though.

-Peff
