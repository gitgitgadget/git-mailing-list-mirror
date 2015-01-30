From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/1] apply: reject input that touches outside $cwd
Date: Fri, 30 Jan 2015 13:24:56 -0500
Message-ID: <20150130182456.GA29477@peff.net>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
 <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
 <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
 <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
 <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
 <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
 <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
 <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
 <xmqqzj91cfnl.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 19:25:08 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHGFf-0005CH-HM
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 19:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763006AbbA3SZA (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 13:25:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:43380 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754116AbbA3SY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 13:24:59 -0500
Received: (qmail 30783 invoked by uid 102); 30 Jan 2015 18:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 12:24:59 -0600
Received: (qmail 25968 invoked by uid 107); 30 Jan 2015 18:25:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 13:25:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 13:24:56 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzj91cfnl.fsf_-_@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263186>

On Thu, Jan 29, 2015 at 03:48:14PM -0800, Junio C Hamano wrote:

> By default, a patch that affects outside the working area is
> rejected as a mistake; Git itself never creates such a patch
> unless the user bends backwards and specifies nonstandard
> prefix to "git diff" and friends.
> 
> When `git apply` is used without either `--index` or `--cached`
> option as a "better GNU patch", the user can pass `--allow-uplevel`
> option to override this safety check.  This cannot be used to escape
> outside the working tree when using `--index` or `--cached` to apply
> the patch to the index.

It looks like your new --allow-uplevel goes to verify_path(). So this
isn't just about "..", but it will also protect against applying a patch
inside ".git". Which seems like a good thing to me, but I wonder if the
option name is a little misleading. It is really about applying the same
checks we do for index paths to the non-index mode of "git apply".

>  * Meant to apply on top of the previous one, but these two are
>    about separate and orthogonal issues.

I agree they are orthogonal in concept, though I doubt the symlink tests
here would pass without the previous one (since verify_path does not
know or care about crossing symlink boundaries).

-Peff
