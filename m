From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] Documentation/githooks: Explain pre-rebase parameters
Date: Wed, 20 Feb 2013 11:36:21 -0500
Message-ID: <20130220163621.GI14102@odin.tremily.us>
References: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
 <7vk3q45dg2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=WHz+neNWvhIGAO8A
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 17:37:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8CfI-0003Fg-77
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 17:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297Ab3BTQgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 11:36:39 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:40087 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3BTQgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 11:36:39 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIJ005J324MC440@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 20 Feb 2013 10:36:23 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id E70788AD07D; Wed,
 20 Feb 2013 11:36:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361378181; bh=7grmZlIQiZfY3ZErmoXgs3EQTE+q4zocMdVq7c5q7Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sTlOazeL3r+pi82zFrsvPu9OmKUFQpOuIp54vfXTksMyQfqg8bNykkHFU/2ca9D0P
 cEeyMnu3ZNqtvNJSowtL5BpkGUTbHig/XzkvZOmWqi0d6DYCJI307Ri12AoIaBejrV
 hRyyuY4+LFjmdmifvR8Jy4v6lviFDGm8Kybf+Rks=
Content-disposition: inline
In-reply-to: <7vk3q45dg2.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216708>


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 11:08:29AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > Also, it appears that the `git-rebase--*.sh` handlers don't use the
> > pre-rebase hook.  Is this intentional?
>=20
> The codeflow of git-rebase front-end, when you start rebasing, will
> call run_pre_rebase_hook before calling run_specific_rebase.  It
> will be redundant for handlers to then call it again, no?
>=20
> In "rebase --continue" and later steps, you would not want to see
> the hook trigger.

Ah, that makes sense.

> > diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> > index b9003fe..bc837c6 100644
> > --- a/Documentation/githooks.txt
> > +++ b/Documentation/githooks.txt
> > @@ -140,9 +140,10 @@ the outcome of 'git commit'.
> >  pre-rebase
> >  ~~~~~~~~~~
> > =20
> > -This hook is called by 'git rebase' and can be used to prevent a branch
> > -from getting rebased.
> > -
> > +This hook is called by 'git rebase' and can be used to prevent a
> > +branch from getting rebased.  The hook takes two parameters: the
> > +upstream the series was forked from and the branch being rebased.  The
> > +second parameter will be empty when rebasing the current branch.
>=20
> Technically this is incorrect.
>=20
> We call it with one or two parameters, and sometimes the second
> parameter is _missing_, which is different from calling with an
> empty string.  For a script written in some scripting languages like
> shell and perl, the distinction may not matter (i.e. $2 and $ARGV[1]
> will be an empty string when stringified) but not all (accessing
> sys.argv[2] may give you an IndexError in Python).

Will fix in v2.

Since $upstream_arg will always be set, would it make sense to change
the `${1+"$@"}` syntax in run_pre_rebase_hook() to a plain "$@"?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRJPuDAAoJEEUbTsx0l5OMd+cP/3auGWjqc3lzl2nhb4jXVVHN
bDU8OUClqfPloSh8YIrWtYmuNybd5zAJDsZR7JISBtAzYsULpyBQGBm+OjkDkyVY
HoBH2fV14CgFvDlLM6XRViIjyd+ZFzvGGWU2KcVz4jY2E6+u4VN+M410ptKiMGx4
0hGuHcKK4ZRrWfNqJrujhx9RGUyAd5XyrhZHgI8lppFMVDp3GUBtBAjacVpyP4O0
T9uWMnNEPuIwfBNOCoRBI68KEvExN8PPJ/3SzuLMA5+8f/bUkj8VzRYejLt/+Kd8
BUYOMdrysX++c3QjqLARIdZru+9gO8pu1XgqAhN0p1eNMfs+8+MtIHDdmYCAw4Ir
RJ82LN16UpiDK9/l0Iq8BhFplKglplzugFCbn2Eg9JhOrDf2WkGEWX0xgd6cf6om
OXaZ/M1csDXRFGoSPK6EBvL2mG932RlIQdWBJRWbPHV45RzCQj6r/WThlFQRqULk
tT+ZP6w/lvpP028zZ2bi06lVSccs0tsd2p4i9CXpVtHd2SwZS5vIPm0nTlm1amxG
iBg41ZYrcki0YAsox2TcSEoLZwknhf5v2uto3KlTAHcl8pBQkdDGrURkuDREayH8
sDw1U4f272e2QL+NBHoZRVGK2miGNvO3xhBjvVP5jaqDcCecgQ2tFj26EIv/QZMD
CNwuBR982kUYdQ+XAHH1
=aXzP
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
