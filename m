From: Jeff King <peff@peff.net>
Subject: Re: weird diff output?
Date: Thu, 14 Apr 2016 14:34:06 -0400
Message-ID: <20160414183405.GE22068@sigill.intra.peff.net>
References: <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
 <20160330045554.GA11007@sigill.intra.peff.net>
 <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
 <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
 <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
 <20160331134750.GA29790@sigill.intra.peff.net>
 <CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com>
 <CAGZ79kZ+JgVNSvJ+tZwGqP-L-NVUv8hmd1jsbh71F08F5AqsjA@mail.gmail.com>
 <alpine.DEB.2.10.1604140639230.8340@zino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:34:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqm5n-0002TK-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbcDNSeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:34:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:49581 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755686AbcDNSeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:34:09 -0400
Received: (qmail 15648 invoked by uid 102); 14 Apr 2016 18:34:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:34:08 -0400
Received: (qmail 1473 invoked by uid 107); 14 Apr 2016 18:34:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:34:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 14:34:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1604140639230.8340@zino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291555>

On Thu, Apr 14, 2016 at 06:56:39AM -0700, Davide Libenzi wrote:

> That was a zillions of years ago :) , but from a quick look at email
> thread, if you want to do it within xdiff, xdi_change_compact would be
> the place.  The issue is knowing in which situations one diff look
> better than another, and embedding an if-tis-do-tat logic deep into
> the core diff machinery.  In theory one could implement the same thing
> higher up, working with the unified diff text format, where maybe a
> user can provide its own diff post-process hook script.  In any case,
> that still leaves open the issue on what to shift in the diff chunks,
> and in which cases. Which is likely going to be language/format
> dependent. IMHO, it gets nasty pretty quickly.

Thanks, that's helpful. Stefan already came up with a heuristic that I
implemented as a post-processing script in perl. It _seems_ to work
pretty well in practice across multiple languages, so our next step was
to implement it in an actual usable and efficient way. :)

Looking over the code, I agree that xdl_change_compact() is the place we
would want to put it. We'd probably tie it to a command-line option and
let people play around with it, and then consider making it the default
if there's widespread approval.

-Peff
