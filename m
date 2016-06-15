From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 22:41:34 -0400
Message-ID: <20140318024134.GA644@sigill.intra.peff.net>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
 <1395093144-6786-2-git-send-email-quintus.public@gmail.com>
 <xmqqob14a14s.fsf@gitster.dls.corp.google.com>
 <20140317230139.GB19578@sigill.intra.peff.net>
 <xmqqd2hka0h7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 03:42:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPjyY-0006dp-I2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 03:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbaCRCli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 22:41:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:41545 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753297AbaCRClh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 22:41:37 -0400
Received: (qmail 13627 invoked by uid 102); 18 Mar 2014 02:41:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 21:41:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Mar 2014 22:41:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2hka0h7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244322>

On Mon, Mar 17, 2014 at 04:07:00PM -0700, Junio C Hamano wrote:

> >> > -		if (!memcmp(used_atom[at], "color:", 6))
> >> > +		if (starts_with(used_atom[at], "color:"))
> >> >  			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
> [...]
> What if used_atom[at] is not related to color at all?  We do not
> want to touch the variable.

Thanks, that is what I was missing. It is not "did we find a reset" but
"toggle on for a non-reset color, toggle off for a reset".

It could be written with skip_prefix as:

  if (skip_prefix(used_atom[at], "color:", &c))
          need_color_reset_at_eol = !!strcmp(c, "reset");

but I do not think it is particularly important to do so. Sorry for the
noise.

-Peff
