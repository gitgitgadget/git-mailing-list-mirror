From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 3 Feb 2015 16:50:43 -0500
Message-ID: <20150203215043.GA21357@peff.net>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1422919650-13346-2-git-send-email-gitster@pobox.com>
 <20150203005005.GB31946@peff.net>
 <xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
 <20150203210140.GA20594@peff.net>
 <xmqqtwz2pu4c.fsf@gitster.dls.corp.google.com>
 <20150203212450.GC20594@peff.net>
 <xmqqpp9qptc3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:50:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIlMx-0000gT-N1
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 22:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbbBCVur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 16:50:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:44858 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750785AbbBCVuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 16:50:46 -0500
Received: (qmail 17164 invoked by uid 102); 3 Feb 2015 21:50:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 15:50:46 -0600
Received: (qmail 15094 invoked by uid 107); 3 Feb 2015 21:50:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 16:50:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2015 16:50:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpp9qptc3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263338>

On Tue, Feb 03, 2015 at 01:40:12PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But wouldn't we still fail writing "foo/bar" at that point if "foo" is a
> > regular file (again, we should never do this, but that is the point of
> > the test).
> 
> The point of the test is not to create foo, whether it is a symlink
> or an emulating regular file, in the first place.

I thought the point was not to create "../bar", when "foo" points to
"..". I agree that the way you have implemented it is that we would
never even write "foo", and the test checks for that, but to me that is
the least interesting bit of what is being tested. Crossing a symlink
boundary and escaping from the tree are interesting, and the atomicity
is a side note. We could also realize that treating "foo" as a file
would fail and cancel the whole operation atomically, too.

But I think we are getting into contrasting our mental models, which is
probably not productive. I am OK with leaving it without the SYMLINKS
flag, as it should pass on systems that do not handle symlinks. And if
it does not, then that will be a good cross-check that our analysis was
sane. :)

-Peff
