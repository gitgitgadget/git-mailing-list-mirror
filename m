From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 4 Feb 2014 17:48:03 -0500
Message-ID: <20140204224803.GB6317@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
 <20140117042153.GB23443@sigill.intra.peff.net>
 <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
 <20140121054927.GD5878@sigill.intra.peff.net>
 <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com>
 <20140204221220.GA5457@sigill.intra.peff.net>
 <xmqqiosu7ca2.fsf@gitster.dls.corp.google.com>
 <20140204222507.GA6031@sigill.intra.peff.net>
 <52F16D77.2000604@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:48:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAon0-0007Qc-4M
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935288AbaBDWsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:48:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:44648 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934009AbaBDWsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:48:06 -0500
Received: (qmail 17275 invoked by uid 102); 4 Feb 2014 22:48:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Feb 2014 16:48:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Feb 2014 17:48:03 -0500
Content-Disposition: inline
In-Reply-To: <52F16D77.2000604@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241581>

On Tue, Feb 04, 2014 at 02:45:11PM -0800, Yuri wrote:

> On 02/04/2014 14:25, Jeff King wrote:
> >Right. If git just disabled the color, I think that would be sane (and
> >that is what my patch was shooting for). But somebody who sees:
> >
> >   $ git log
> >   ESC[33mcommit 3c6b385c655a52fd9db176ce1e01469dc9954f91ESC[mESC[33m
> >   (ESC[1;36mHEADESC[mESC[33m, ESC[1;32mjk/meta-makeESC[mESC[33m)ESC[m
> >
> >does not necessarily know what is going on. They do not know that it is
> >a "less" problem, nor that their less settings are relevant. They only
> >see that Git is broken out of the box.
> 
> Maybe, instead of doing all the elaborate guess and assumption work,
> have configure script check if the current PAGER supports colors and
> build git accordingly?
> configure could run the pager as one of its tests, and determine if
> "ESC" appears on the output.

But this is not a build-time problem, but rather a run-time problem. We
do not know what the environment of the user will be at run-time.

The safest thing would be to turn off auto-color when LESS (or any of
the pager environment variables) is set at all (and not worry about
whether "R" is set; only know that _we_ are not setting it, so we cannot
count on it). But that would potentially inconvenience a lot of people
whose default color would suddenly go away.

-Peff
