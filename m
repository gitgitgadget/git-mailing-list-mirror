From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Sat, 9 May 2015 00:07:04 -0400
Message-ID: <20150509040704.GA31428@peff.net>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
 <CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
 <20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Sat May 09 06:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqw2r-0000SF-Sn
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 06:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbEIEHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 00:07:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:55992 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbbEIEHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 00:07:07 -0400
Received: (qmail 16269 invoked by uid 102); 9 May 2015 04:07:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 23:07:07 -0500
Received: (qmail 25745 invoked by uid 107); 9 May 2015 04:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 May 2015 00:07:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 May 2015 00:07:04 -0400
Content-Disposition: inline
In-Reply-To: <20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268697>

On Fri, May 08, 2015 at 10:03:41PM -0400, Trevor Saunders wrote:

> On Fri, May 08, 2015 at 05:29:42PM -0700, Stefan Beller wrote:
> > On Fri, May 8, 2015 at 4:46 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> > > its rather silly especially considering the next line contains the
> > > full hash again.
> > 
> > Maybe we can omit it altogether then?
> 
> SO we'd print something like
> 
> the first bad commit is
> Commit abcdefabcdefabcdefabcdefabcdefabcdefabcd
> Author foo@ba.com
> 
> blah blah blah
> 
> ? That seems reasonable to me.  If we're going that far does it also
> make sense to drop printingthe lines about which trees have changed and
> just print the commit message / author / hash?

Yeah, I have always found bisect's output somewhat silly. It prints the
"--raw" diff output, which is not incredibly useful. And then to top it
off, it does not feed the "--recursive" switch to the diff, so you don't
even get to see the real list of changed files.

I suspect the most minimal we could go is:

  git log --format='The first bad commit is %h %s' $bad

and then let the user inspect further from there using the hash. But I
think it would also be reasonable to just do a straight "git log -1
$bad" with no with no diff.

(Actually, it looks like all this is generated in bisect.c:show_diff_tree,
so it would have to be written in C; but it should be pretty easy to
tweak the display options).

-Peff
