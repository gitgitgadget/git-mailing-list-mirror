From: Jeff King <peff@peff.net>
Subject: Re: weird diff output?
Date: Thu, 14 Apr 2016 22:18:29 -0400
Message-ID: <20160415021829.GD22112@sigill.intra.peff.net>
References: <20160330045554.GA11007@sigill.intra.peff.net>
 <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
 <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
 <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
 <20160331134750.GA29790@sigill.intra.peff.net>
 <CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com>
 <CAGZ79kZ+JgVNSvJ+tZwGqP-L-NVUv8hmd1jsbh71F08F5AqsjA@mail.gmail.com>
 <alpine.DEB.2.10.1604140639230.8340@zino>
 <20160414183405.GE22068@sigill.intra.peff.net>
 <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:18:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqtLB-0006h1-LS
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbcDOCSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:18:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:49901 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751336AbcDOCSc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:18:32 -0400
Received: (qmail 7842 invoked by uid 102); 15 Apr 2016 02:18:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:18:32 -0400
Received: (qmail 5974 invoked by uid 107); 15 Apr 2016 02:18:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:18:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 22:18:29 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291595>

On Thu, Apr 14, 2016 at 02:05:03PM -0700, Stefan Beller wrote:

> > Looking over the code, I agree that xdl_change_compact() is the place we
> > would want to put it. We'd probably tie it to a command-line option and
> > let people play around with it, and then consider making it the default
> > if there's widespread approval.
> 
> I just stumbled upon
> http://blog.scoutapp.com/articles/2016/04/12/3-git-productivity-hacks
> which advertises git config --global pager.diff "diff-so-fancy | less
> --tabs=4 -RFX"
> 
> Would you consider your perl script good enough to put that instead of
> diff-so-fancy?

For some definition of "good enough". I don't plan to run it myself. And
I don't use diff-so-fancy. But I think diff-so-fancy folks also tend to
run contrib/diff-highlight, which is written in perl and quite similar
in structure to what I posted earlier (unsurprisingly, since I wrote
it).

So I think it works, and the performance hit from piping through perl
generally isn't bad enough to be a problem (and by definition it's only
running when you would run an interactive pager in the first place).

I don't think that this particular heuristic is in quite the same class
as diff-highlight and diff-so-fancy, though. Those ones transform the
diff away from something that can be applied, so you really do just want
them for human viewing. But this new heuristic is something that you'd
probably want as part of format-patch, for example, and we don't
generally kick in the pager there. So I think it would be much more
natural inside of the diff generation.

-Peff
