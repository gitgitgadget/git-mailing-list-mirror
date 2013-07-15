From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Mon, 15 Jul 2013 01:12:33 -0400
Message-ID: <20130715051233.GC21127@sigill.intra.peff.net>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
 <7voba8pu6r.fsf@alter.siamese.dyndns.org>
 <455666C5-7663-4361-BF34-378D3EAE2891@gmail.com>
 <7vsizjn390.fsf@alter.siamese.dyndns.org>
 <7v4nbyic57.fsf@alter.siamese.dyndns.org>
 <47B58075-3FDD-48E5-9047-8650F7FC5E3B@gmail.com>
 <7v8v18fp2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 07:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyb5j-0004WS-8P
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 07:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab3GOFMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 01:12:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:36001 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376Ab3GOFMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 01:12:36 -0400
Received: (qmail 22976 invoked by uid 102); 15 Jul 2013 05:13:56 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Jul 2013 00:13:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jul 2013 01:12:33 -0400
Content-Disposition: inline
In-Reply-To: <7v8v18fp2s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230419>

On Sun, Jul 14, 2013 at 09:02:19PM -0700, Junio C Hamano wrote:

> > Or proceed with what's there right now (there are a few pending
> > updates from reviewers) and then, as Junio says above, adjust it later
> > if needed?
> 
> I have been assuming that "strictly textual match" will be a subset
> of the matching semantics Aaron and Peff suggested.  That is, if we
> include your version in the upcoming release, the user writes the
> http.<URLpattern>.<variable> configuration so that the entries match
> what they want them to match, the enhanced URL matcher Aaron and
> Peff suggested will still make them match.
> 
> Am I mistaken?  Will there be some <URLpattern> that will not match
> with the same URL literally?

I think we need to decide now, because the two schemes are not
compatible, and switching will break setups. Yes, the matcher that Aaron
and I suggest is a strict superset (i.e., we will not stop matching
things that used to match), which is good. But we would not be able to
implement "longest prefix wins" overriding anymore, which would change
the meaning of cases like:

  [http "https://example.com"] foo = 1
  [http] foo = 2

(under Kyle's scheme it is "1", and under ours "2"). We can probably
come up with some clever rules for overriding a broken-down URL that
would stay backwards compatible. E.g., longest-prefix-match if there are
no wildcarded components, and last-one-wins if there are. But that is
not a rule I would want readers to have to puzzle out in the
documentation.

So I think we are much better off to decide the semantics now.

-Peff
