From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v14 01/11] trailer: add data structures and basic
 functions
Date: Wed, 17 Sep 2014 03:58:39 -0400
Message-ID: <20140917075838.GA16200@peff.net>
References: <20140915052330.26573.34823.chriscool@tuxfamily.org>
 <20140915053142.26573.86374.chriscool@tuxfamily.org>
 <xmqqsijs4o02.fsf@gitster.dls.corp.google.com>
 <CAP8UFD3wi2KCZhDAF7vqMpb72DbLMbHNDiDGi0tFLW+vzsQqSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 09:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUA8Y-0000SI-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 09:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbaIQH6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 03:58:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:49359 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751570AbaIQH6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 03:58:41 -0400
Received: (qmail 29801 invoked by uid 102); 17 Sep 2014 07:58:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Sep 2014 02:58:41 -0500
Received: (qmail 10309 invoked by uid 107); 17 Sep 2014 07:59:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Sep 2014 03:59:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Sep 2014 03:58:39 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD3wi2KCZhDAF7vqMpb72DbLMbHNDiDGi0tFLW+vzsQqSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257215>

On Tue, Sep 16, 2014 at 10:01:11AM +0200, Christian Couder wrote:

> On Mon, Sep 15, 2014 at 10:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> >
> >> +/* Get the length of buf from its beginning until its last alphanumeric character */
> >
> > That makes it sound as if feeding "abc%de#f@" to the function returns
> > 3 for "abc", but
> 
> For me the last alphanumeric character in "abc%de#f@" is "f", so it is
> the length from the beginning to "f" so it should return 8.

FWIW, I parsed the comment as you intended, but I do think it is a bit
unclear (especially given the name, as it is skipping over more than
just alnums). From reading the calling code, it looks like the intent is
to take a token string like "Signed-off-by:" and find that the ":" is
part of the ending punctuation, but that the "-" are retained as
internal punctuation.

Would it make sense as:

  /*
   * Return the length of the string not including any final
   * punctuation. E.g., the input "Signed-off-by:" would return
   * 13, stripping the trailing punctuation but retaining
   * internal punctuation.
   */
  int token_len_without_separator(const char *token)
  ...

The name is a bit clunky, but hopefully it is more clear what the point
is.

-Peff
