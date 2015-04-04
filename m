From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Sat, 4 Apr 2015 10:10:26 -0400
Message-ID: <20150404141026.GB25455@peff.net>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
 <20150330221635.GB25212@peff.net>
 <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
 <20150403012430.GA16173@peff.net>
 <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
 <20150403220821.GB11220@peff.net>
 <CDAB9DBC-0F59-4176-BD9F-620A124EA300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 16:10:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeOmP-00088k-LY
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 16:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbbDDOK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 10:10:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:42415 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752595AbbDDOK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 10:10:28 -0400
Received: (qmail 22860 invoked by uid 102); 4 Apr 2015 14:10:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 09:10:28 -0500
Received: (qmail 30683 invoked by uid 107); 4 Apr 2015 14:10:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 10:10:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 10:10:26 -0400
Content-Disposition: inline
In-Reply-To: <CDAB9DBC-0F59-4176-BD9F-620A124EA300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266775>

On Fri, Apr 03, 2015 at 03:24:09PM -0700, Kyle J. McKay wrote:

> >I thought that meant we could also optimize out the "map" call entirely,
> >and just use the first split (with "*") to end up with a list of $COLOR
> >chunks and single characters, but it does not seem to work. So maybe I
> >am misreading something about what is going on.
> 
> I think our emails crossed in flight...
> 
> Using just the first split (with "*") produces useless empty elements which
> I think ends up causing problems.  I suppose you could surround it with a
> grep /./ to remove them but that would defeat the point of the optimization.

Yeah, the problem is the use of (). We want to keep the $COLOR
delimiters, but not the empty ones. Perhaps you could do:

  split /($COLOR+)|/

but I didn't try it. I think what you posted is good and a lot less
subtle.

-Peff
