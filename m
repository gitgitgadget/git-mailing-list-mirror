From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] diff-highlight: do not split multibyte characters
Date: Sat, 4 Apr 2015 10:09:02 -0400
Message-ID: <20150404140902.GA25455@peff.net>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
 <20150330221635.GB25212@peff.net>
 <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
 <20150403012430.GA16173@peff.net>
 <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
 <6a8dcc870e53040e1f54d7c36a1b33a@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yi EungJun <semtlenori@gmail.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 16:09:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeOl5-0007FN-IW
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 16:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbbDDOJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 10:09:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:42410 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752575AbbDDOJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 10:09:05 -0400
Received: (qmail 22794 invoked by uid 102); 4 Apr 2015 14:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 09:09:04 -0500
Received: (qmail 30658 invoked by uid 107); 4 Apr 2015 14:09:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 10:09:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 10:09:02 -0400
Content-Disposition: inline
In-Reply-To: <6a8dcc870e53040e1f54d7c36a1b33a@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266774>

On Fri, Apr 03, 2015 at 03:15:14PM -0700, Kyle J. McKay wrote:

> When the input is UTF-8 and Perl is operating on bytes instead of
> characters, a diff that changes one multibyte character to another
> that shares an initial byte sequence will result in a broken diff
> display as the common byte sequence prefix will be separated from
> the rest of the bytes in the multibyte character.
> 
> For example, if a single line contains only the unicode character
> U+C9C4 (encoded as UTF-8 0xEC, 0xA7, 0x84) and that line is then
> changed to the unicode character U+C9C0 (encoded as UTF-8 0xEC,
> 0xA7, 0x80), when operating on bytes diff-highlight will show only
> the single byte change from 0x84 to 0x80 thus creating invalid UTF-8
> and a broken diff display.
> 
> Fix this by putting Perl into character mode when splitting the line
> and then back into byte mode after the split is finished.
> 
> The utf8::xxx functions require Perl 5.8 so we require that as well.
> 
> Also, since we are mucking with code in the split_line function, we
> change a '*' quantifier to a '+' quantifier when matching the $COLOR
> expression which has the side effect of speeding everything up while
> eliminating useless '' elements in the returned array.
> 
> Reported-by: Yi EungJun <semtlenori@gmail.com>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

This version looks good to me. I looked over the diff of running "git
log -p --color" on git.git through diff-highlight before and after this
patch, and everything looks like an improvement.

  Acked-by: Jeff King <peff@peff.net>

Thanks both of you for working on this.

-Peff
