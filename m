From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 04:03:58 -0400
Message-ID: <20130903080358.GA30158@sigill.intra.peff.net>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 10:04:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlaq-0007Qy-Md
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 10:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab3ICIEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 04:04:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:53203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633Ab3ICIEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 04:04:01 -0400
Received: (qmail 22994 invoked by uid 102); 3 Sep 2013 08:04:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 03:04:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 04:03:58 -0400
Content-Disposition: inline
In-Reply-To: <20130903075107.GA25540@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233707>

On Tue, Sep 03, 2013 at 09:51:07AM +0200, SZEDER G=C3=A1bor wrote:

> > I wonder if we should have a:
> >=20
> >   test_cmp_args () {
> >           echo "$1" >expect &&
> >           echo "$1" >actual &&
> >           test_cmp expect actual
> >   }
> >=20
> > to let these remain one-liners like:
> >=20
> >   test_cmp_args "$(git rev-parse start)" "$(git rev-parse final^1^1=
^1)"
>=20
> This idea come up before, but there is one flaw which makes this
> function less useful: a non-zero exit code of the commands in the
> command substitutions would be lost.

Good point. You'd probably have to do something gross with eval, like:

  test_cmp_args () {
    eval "$1" >expect &&
    eval "$2" >actual &&
    test_cmp expect actual
  }

but then the callers have to deal with an extra layer of quoting. Not
worth it to save a few lines.

Thanks for a sanity check.

-Peff
