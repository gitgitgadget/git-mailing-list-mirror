From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 4 Nov 2015 15:15:22 -0500
Message-ID: <20151104201521.GD16101@sigill.intra.peff.net>
References: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
 <CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
 <xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
 <xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
 <CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
 <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
 <20151104200249.GC16101@sigill.intra.peff.net>
 <CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:16:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4Ts-0003WS-Ml
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030877AbbKDUP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 15:15:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:52910 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030775AbbKDUPY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 15:15:24 -0500
Received: (qmail 15088 invoked by uid 102); 4 Nov 2015 20:15:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 14:15:24 -0600
Received: (qmail 6293 invoked by uid 107); 4 Nov 2015 20:15:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 15:15:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 15:15:22 -0500
Content-Disposition: inline
In-Reply-To: <CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280880>

On Wed, Nov 04, 2015 at 02:08:21PM -0600, Doug Kelly wrote:

> Currently there's no mtime-guarding logic (I dug up that conversation
> earlier, though, but after I'd done the respin on this series)... OK,
> in that case, I'll create a separate patch that tests/cleans up
> .bitmap, but doesn't touch .keep.  This might be a small series since
> I think the logic for finding pack garbage doesn't know anything about
> .bitmap per-se, so it's looking like I'll extend that relevant code,
> before adding the handling in gc and appropriate tests.

I'd hoped you could reuse the list of extensions found in
builtin/repack.c (e.g., see remove_redundant_pack). But I guess that is
not connected with the garbage-reporting code. And anyway, the simple
list probably does not carry sufficient information (it does not know
that ".keep" is potentially more precious than ".idx", for example).

-Peff
