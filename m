From: Jeff King <peff@peff.net>
Subject: Re: GPG public keys
Date: Wed, 9 Dec 2015 17:04:14 -0500
Message-ID: <20151209220413.GA21751@sigill.intra.peff.net>
References: <9E65FDC7-B4F6-45DC-9B0E-F017B904C868@pixelrebel.com>
 <xmqqtwnsie6h.fsf@gitster.mtv.corp.google.com>
 <3860CB92-AD83-4372-AE7C-BBA8BF2D8F67@pixelrebel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jamie Evans <jamie@pixelrebel.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:04:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6mqT-00084m-UV
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbLIWER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2015 17:04:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:39502 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752100AbbLIWER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:04:17 -0500
Received: (qmail 1072 invoked by uid 102); 9 Dec 2015 22:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 16:04:16 -0600
Received: (qmail 13891 invoked by uid 107); 9 Dec 2015 22:04:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 17:04:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Dec 2015 17:04:14 -0500
Content-Disposition: inline
In-Reply-To: <3860CB92-AD83-4372-AE7C-BBA8BF2D8F67@pixelrebel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282199>

On Wed, Dec 09, 2015 at 09:03:47AM -0800, Jamie Evans wrote:

> Thanks, Junio, for the tutorial!  I had tried to lookup the key, but
> failed to put the =E2=80=980x=E2=80=99 at the head.

An easier way to get keys is just:

  $ gpg --recv-keys 96AFE6CB
  gpg: requesting key 96AFE6CB from hkp server keys.gnupg.net
  gpg: key 713660A7: public key "Junio C Hamano <gitster@pobox.com>" im=
ported
  [...etc...]

You may need to drop a keyserver into your config, like:

  echo "keyserver keys.gnupg.net" >>~/.gnupg/gpg.conf

It doesn't really matter which one you use. Keyservers aren't
authoritative. They are just a convenience for grabbing the key data,
and most of the major ones share keys with each other. The real securit=
y
comes from the signatures which you get along with the keys.

> I was actually verifying the signature on a tarball release.  Just
> curious, how do I know the key in the database really belongs to you?
> It=E2=80=99s has your name and email, but what=E2=80=99s to keep an i=
mposter from
> creating a key with your name on it and posting it to the database?  =
I
> guess all the signatories on your key are others vouching for your
> key?

Right. Now that I've got Junio's key from the command above, I can do:

  gpg --list-sigs 96AFE6CB

Of course you won't have those keys either. You can recursively recv-ke=
y
them, but that doesn't help if you don't trust them. The same imposter
can create a network of plausible-looking keys and upload them.

In an ideal world you sign somebody else who signs somebody else who
signs Junio's key, and therefore you (probably trust it)[1]. But of
course bootstrapping that process is hard.

In practice, the simplest thing is probably to notice that all of the
git releases since v1.7.1.4 are signed by 96AFE6CB. If there was an
imposter, presumably somebody would have noticed by now and complained.

Of course you can't just fetch the v1.7.1.4 tag _now_, because the same
person impersonating the most recent tag could also be impersonating
(and back-dating) the older tags. But you could fetch it now, store it
somewhere trusted (e.g., on your laptop), and wait two weeks. If you
find no public outcry over hacked git, then it is probably OK to assume
that is the real key.

-Peff

[1] There are some cool tools to visualize the trust chains.
    Unfortunately this one does not seem to have Junio's latest key, bu=
t
    here is an example going from my key to the key Linus uses to sign
    the kernel:

      http://pgp.cs.uu.nl/mk_path.cgi?FROM=3D90F6F6B8&TO=3D00411886&PAT=
HS=3Dtrust+paths

    Of course somebody can impersonate that tool, too. :) But you can
    fetch all of the individual keys in a path and verify
    cryptographically that the path exists.
