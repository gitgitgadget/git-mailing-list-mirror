From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] connect: remove get_port()
Date: Tue, 3 May 2016 01:03:38 -0400
Message-ID: <20160503050338.GD32259@sigill.intra.peff.net>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-2-git-send-email-mh@glandium.org>
 <e1056272-8c0e-0a0b-2295-4653a47cf86f@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 03 07:03:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axSUs-0007FK-7W
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 07:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbcECFDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 01:03:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:60819 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751145AbcECFDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 01:03:41 -0400
Received: (qmail 11938 invoked by uid 102); 3 May 2016 05:03:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 01:03:41 -0400
Received: (qmail 22828 invoked by uid 107); 3 May 2016 05:03:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 01:03:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 01:03:38 -0400
Content-Disposition: inline
In-Reply-To: <e1056272-8c0e-0a0b-2295-4653a47cf86f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293325>

On Sun, May 01, 2016 at 12:10:09PM +0200, Torsten B=C3=B6gershausen wro=
te:

> On 2016-05-01 08.02, Mike Hommey wrote:
> > get_port() is only used as a fallback when get_host_and_port() does=
 not
> > return a port. But get_port() does the same search as
> > get_host_and_port(), except get_host_and_port() starts from the end=
 of
> > the host, respecting square brackets for ipv6 addresses, and get_po=
rt(),
> > operating after get_host_and_port(), works on a modified host strin=
g
> > that has square brackes removed if there were any.
> typo: brackets.
> >=20
> > I cannot think of any legal host:port string that would not have a =
port
> > returned by get_host_and_port() *and* have one returned by get_port=
().
> > So just remove get_port().
> >=20
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> Does this pass the test-suite ?
> It doesn't pass here, t5601:

Hmm. I do notice that Mike's patch only touches the ssh code path. The
normal TCP code path _just_ uses get_host_and_port. Does that mean the
TCP side is missing some cases, or is the extra parsing just for
handling bracketed "[host:port]:path" cases for ssh, like:

> not ok 39 - bracketed hostnames are still ssh
> #
> #               git clone "[myhost:123]:src" ssh-bracket-clone &&
> #               expect_ssh "-p 123" myhost src
> #

?

-Peff
