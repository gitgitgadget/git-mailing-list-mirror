From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 16:36:45 -0400
Message-ID: <20150428203645.GA11473@peff.net>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
 <20150428061741.GL24580@peff.net>
 <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
 <20150428201918.GA10902@peff.net>
 <20150428203400.GN5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnCFQ-0002Gq-M7
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966172AbbD1Ugs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 16:36:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:51344 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966013AbbD1Ugs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:36:48 -0400
Received: (qmail 8925 invoked by uid 102); 28 Apr 2015 20:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 15:36:47 -0500
Received: (qmail 20197 invoked by uid 107); 28 Apr 2015 20:37:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 16:37:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 16:36:45 -0400
Content-Disposition: inline
In-Reply-To: <20150428203400.GN5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267942>

On Tue, Apr 28, 2015 at 01:34:00PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Tue, Apr 28, 2015 at 10:07:43PM +0200, erik elfstr=C3=B6m wrote:
>=20
> >> Also if it turns out that we actually need to treat the "file too
> >> large" error differently in clean (as discussed in thread on the f=
ile
> >> size check) then we can no longer communicate that back using the
> >> strbuf interface.
> >
> > Yeah, agreed. This system breaks down as soon as you need to
> > programatically know which error happened.
>=20
> On the contrary: it separates the information that is used
> programatically and the information intended for the user.
>=20
> The return value (or an int * parameter) distinguishes errors that
> affect control flow.  A string can provide information for the user.
>=20
> This way it is easy to tweak the information that the user sees in
> one place, without changing control flow.

But the NULL does not carry the information about _which_ error, and
Erik is suggesting that the caller may need to change behavior based on
that information. IOW, his current patch (return NULL and set the
specific integer code in a variable) allows this, but switching the
integer code out for a human-readable strbuf does not.

-Peff
