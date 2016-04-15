From: Jeff King <peff@peff.net>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Fri, 15 Apr 2016 13:38:33 -0400
Message-ID: <20160415173833.GA20014@sigill.intra.peff.net>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
 <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
 <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
 <20160415095139.GA3985@lanh>
 <CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
 <20160415165208.GA17928@sigill.intra.peff.net>
 <xmqqwpnybwxw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:38:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7hZ-0004Wx-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbcDORih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 13:38:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:50266 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751851AbcDORig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 13:38:36 -0400
Received: (qmail 31972 invoked by uid 102); 15 Apr 2016 17:38:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 13:38:35 -0400
Received: (qmail 12549 invoked by uid 107); 15 Apr 2016 17:38:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 13:38:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2016 13:38:33 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpnybwxw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291628>

On Fri, Apr 15, 2016 at 10:31:39AM -0700, Junio C Hamano wrote:

> Last time I checked, I think the accesses to attributes from the
> convert.c thing was one of the things that are cumbersome to make
> safe in multi-threaded world.

Multi-threaded grep has the same problem. I think we started with a big
lock on the attribute access. That works OK, as long as you hold the
lock only for the lookup and not the actual filtering. We later moved to
pre-loading the attributes in 9dd5245c104, because looking up attributes
in order is much more efficient (because locality of paths lets us reuse
work from the previous request).

So I'm guessing the major work here will be to split the "look up smudge
attributes" step from "do the smudge".

-Peff
