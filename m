From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo =
 bar"
Date: Fri, 3 Oct 2014 20:13:25 -0400
Message-ID: <20141004001325.GC17063@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003202743.GH16293@peff.net>
 <xmqqsij4kdch.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 02:13:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaCyb-0002sC-T5
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 02:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758326AbaJDANa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 20:13:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:54971 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758123AbaJDAN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 20:13:27 -0400
Received: (qmail 12417 invoked by uid 102); 4 Oct 2014 00:13:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 19:13:27 -0500
Received: (qmail 16486 invoked by uid 107); 4 Oct 2014 00:13:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 20:13:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 20:13:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsij4kdch.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257883>

On Fri, Oct 03, 2014 at 03:17:18PM -0700, Junio C Hamano wrote:

> > That's a bit verbose. We could hide it behind something like test_eq,
> > too, but it introduces several extra new processes.
> 
> What do you mean by "extra new processes"?  Whether open coded in a
> verbose way, or wrapped inside a helper, e.g.
> 
> 	test_eql () {
> 		echo "$1" >expect &&
>                 shift &&
>                 "$@" >actual &&
>                 test_cmp expect actual
> 	}
>         ...
> 	test_eql whatever do_something
> 
> the number of processes would be the same, no?
> 
> Or do you mean test_cmp is an extra process compared with
> 
> 	test_eq whatever "$(do_something)"

Sorry, yeah, I meant new processes versus "test $foo = $bar".

> Hopefully, do_something does something more than what takes test_cmp
> to run, so I wouldn't be worried too much about it.

Yeah, I may just be overly paranoid here. If we are not worried about a
few extra processes, then the test_eql you showed above may be
preferable, because its output is uniform with other test_cmp tests
(although maybe it also introduces problems, because it does not handle
stray whitespace in the same way, and it puts extra files in the working
tree).

-Peff
