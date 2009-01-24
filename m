From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sat, 24 Jan 2009 15:45:39 -0500
Message-ID: <20090124204539.GA18548@coredump.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901220113.32711.markus.heidelberg@web.de> <7vmydi4kiz.fsf@gitster.siamese.dyndns.org> <200901241228.33690.markus.heidelberg@web.de> <7vk58ko8k7.fsf@gitster.siamese.dyndns.org> <20090124191700.GA17935@coredump.intra.peff.net> <7vvds4movp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: markus.heidelberg@web.de,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQpPG-0007NK-8c
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbZAXUpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbZAXUpm
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:45:42 -0500
Received: from peff.net ([208.65.91.99]:39393 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428AbZAXUpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:45:41 -0500
Received: (qmail 19645 invoked by uid 107); 24 Jan 2009 20:45:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 24 Jan 2009 15:45:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jan 2009 15:45:39 -0500
Content-Disposition: inline
In-Reply-To: <7vvds4movp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107006>

On Sat, Jan 24, 2009 at 12:26:50PM -0800, Junio C Hamano wrote:

> > Sadly, this is an area that is not covered very well in the tests
> > (partially, I think, because it is "just" output which we tend to
> > neglect, and partially because the isatty() stuff is hard to test with
> > our harness). So I don't think it's _entirely_ Markus' fault.
> 
> Oh, don't get me wrong.  I am not interested in finding whose fault it
> was.  I was just stating the fact that one person not finding a breakage
> does not mean much as an assurance.

OK. I was just trying to encourage Markus to keep trying. ;)

> +test_expect_success 'format-patch is colorless even with color.ui = auto' '
> +	git config color.ui auto &&
> +	TERM=ansi git format-patch -1 >/dev/tty &&
> +	grep "^+5$" 0001-foo.patch
> +'
> +

Actually, could this not just be "format-patch is colorless even with
color.ui = always"? I.e., shouldn't format-patch _always_ not have
color, no matter what (and we assume that "always" is a superset of
"auto"). And then it is also much easier to test.

Of course that doesn't fix the fact that it would _also_ be nice to test
"auto" functionality in general. Here you use the fact that format-patch
sends output to a file. But I don't think there is a good way to test
that "git log --color=auto" works as expected.

-Peff
