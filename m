From: Joey Hess <id@joeyh.name>
Subject: Re: proposal for extending smudge/clean filters with raw file access
Date: Thu, 12 May 2016 16:46:34 -0400
Message-ID: <20160512204634.GA9292@kitenet.net>
References: <20160512182432.GA27427@kitenet.net>
 <xmqq7fezdoe7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 22:46:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xVS-000538-De
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbcELUqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:46:46 -0400
Received: from kitenet.net ([66.228.36.95]:45664 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbcELUqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:46:45 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=aWxZkN58;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1463085994; bh=FQh15uGmIWYKk93vM7gdr+9zg8PxUz8CyD3hZ/JB7sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWxZkN58DHHIC5t3B7o4XycmIimWydXvz7C+nNnNr6rczpg9GYB58UVPB0PbLnYhP
	 Qm+UfoxFvakT6rY0LOpJr6A7hu8LxFXI9Bp6aAPoRJpVy9rakBIQ0juvWfBqbS/rQX
	 im9/JclAyfDbaYAw9n/GTQU9Q1hJIZRvtfvgZgJc=
Content-Disposition: inline
In-Reply-To: <xmqq7fezdoe7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no
	version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294474>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> This side, I do not think we even need a new variant.  We can just
> update the code to interact with "clean" so that it the writer to
> the pipe ignores SIGPIPE, detects EPIPE on write(2), says "ah, the
> other end does not need the full input to produce its output".  The
> reader from the pipe consumes its output without failing AS LONG AS
> the "clean" filter exits with zero (we do check its exit status,
> right?)

There are two problems with doing that. First, any clean filter that
relied on that would not work with older versions of git.

Secondly, and harder to get around, the filename passed to the clean
filter is not necessarily a path to the actual existing file that is
being cleaned. For example, git hash-object --stdin --path=3Dwhatever.
So the current clean filter can't really safely rely on accessing the
file to short-circuit its cleaning. (Although it seems to mostly work..
currently..)

> We cannot do a similar "we can just unconditionally update" like I
> said on the "clean" side to "smudge", so it would need a new
> variant.  I do not want to call it anything "raw", as there is
> nothing "raw" about it.  "smudge-to-fs" would be a better name.

"raw" was just a placeholder. "clean-from-fs" and "smudge-to-fs" are
pretty descriptive.

--=20
see shy jo

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVzTrqMkQ2SIlEuPHAQKRTQ//V/593rnSI/71GRDGVJgrH7HlTK10aXkL
xFA4wsf8C/9YE5m/CRjp4DPyzfpYtchabNXivp57QMM1Ua7jiE+Nyd2/qy9zoM/S
ZHUMmZIPwPzI2Ie6rLFFRL105AFXfdfudjHAIvNoEjtJWosGl7TXbnkcGl1EvfgX
qfAto1dapJQ4sskl7vAUNlKFA2h4jkwAuF5abTOlzTG8ysG0o59xo6ez9hIugkXK
uL+N4U/7OQdr1uHW6znThZkPFMpwniizXqM9VWX4BGTSsEdWX022Jh8tCeZIhSNb
LisD0EPe7+nyMhXv6SyY5OMOufJ4RJKd9UfC842i3I8g0GUibPU+VAuJx4yarA2K
VaVc87+gW9YhUdgC6DGIyMWpyihf81GXcZl6X3g7d6E/ZXLhb1rmafiMZf84kAtX
8K5kVaRFi+Ywt/PFpmmDEjUaNL2DdNXlETlHRroN2YgTFE7c5n23LMQ7DzB0Uvx6
+F0Z/OHxaGa0CUPoi0n/gesrwyIObitACQQoiimZ3a6EOKhQcsshn7gIGxauDcbe
uDw7vG+V55umpwntQBgnPlAgBf6vJA6N/dg91KQ8MCrKyLk6jnWFWWa4sKJUV8Ly
FM0fKWido35vOfhIpq63ZnjBJPIw+BtYVHo2XYPCAOMEkEZ4MraAGpc2BkHGPV3s
1L2EcUv0dMA=
=3V4Y
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
