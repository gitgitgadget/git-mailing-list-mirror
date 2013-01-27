From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sun, 27 Jan 2013 14:13:29 +0000
Message-ID: <20130127141329.GN7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzT5O-0000Va-VP
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 15:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab3A0OTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 09:19:34 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52662 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab3A0OTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 09:19:32 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jan 2013 09:19:32 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D52D0CDA5A5;
	Sun, 27 Jan 2013 14:13:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZS+FfH7loTBV; Sun, 27 Jan 2013 14:13:38 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id D5684CDA5BE;
	Sun, 27 Jan 2013 14:13:37 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C4A6E161E565;
	Sun, 27 Jan 2013 14:13:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FoWRYp4InlUV; Sun, 27 Jan 2013 14:13:37 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CD968161E341;
	Sun, 27 Jan 2013 14:13:31 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <5104B0B5.1030501@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214700>

On Sun, Jan 27, 2013 at 05:44:37AM +0100, Michael Haggerty wrote:
> On 01/26/2013 10:44 PM, Junio C Hamano wrote:
> > John Keeping <john@keeping.me.uk> writes:
> >> @@ -45,7 +45,7 @@ def get_repo(alias, url):
> >>      repo.get_head()
> >> =20
> >>      hasher =3D _digest()
> >> -    hasher.update(repo.path)
> >> +    hasher.update(repo.path.encode('utf-8'))
> >>      repo.hash =3D hasher.hexdigest()
> >> =20
> >>      repo.get_base_path =3D lambda base: os.path.join(
>=20
> This will still fail under Python 2.x if repo.path is a byte string t=
hat
> contains non-ASCII characters.

I had forgotten about Python 2 while doing this.

>                                 And it will fail under Python 3.1 and
> later if repo.path contains characters using the surrogateescape
> encoding option [1], as it will if the original command-line argument
> contained bytes that cannot be decoded into Unicode using the user's
> default encoding:

Interesting.  I wasn't aware of the "surrogateescape" error handler.

> 'surrogateescape' is not supported in Python 3.0, but I think it woul=
d
> be quite acceptable only to support Python 3.x for x >=3D 1.

I agree.

> But 'surrogateescape' doesn't seem to be supported at all in Python 2=
=2Ex
> (I tested 2.7.3 and it's not there).
>=20
> Here you don't really need byte-for-byte correctness; it would be eno=
ugh
> to get *some* byte string that is unique for a given input (ideally,
> consistent with ASCII or UTF-8 for backwards compatibility).  So you
> could use
>=20
>     b =3D s.encode('utf-8', 'backslashreplace')
>=20
> Unfortunately, this doesn't work under Python 2.x:
>=20
>     $ python2 -c "
>     import sys
>     print(repr(sys.argv[1]))
>     print(repr(sys.argv[1].encode('utf-8', 'backslashreplace')))
>     " $(echo fran=E7ais|iconv -t latin1)
>     'fran\xe7ais'
>     Traceback (most recent call last):
>       File "<string>", line 4, in <module>
>     UnicodeDecodeError: 'ascii' codec can't decode byte 0xe7 in posit=
ion
> 4: ordinal not in range(128)
>=20
> Apparently when you call bytestring.encode(), Python first tries to
> decode the string to Unicode using the 'ascii' encoding.

Actually it appears to use sys.getdefaultencoding() to do this initial
decode.  Not that it makes much difference here since the failure is th=
e
same.

> So to handle all of the cases across Python versions as closely as
> possible to the old 2.x code, it might be necessary to make the code
> explicitly depend on the Python version number, like:
>=20
>     hasher =3D _digest()
>     if sys.hexversion < 0x03000000:
>         pathbytes =3D repo.path
>     elif sys.hexversion < 0x03010000:
>         # If support for Python 3.0.x is desired (note: result can
>         # be different in this case than under 2.x or 3.1+):
>         pathbytes =3D repo.path.encode(sys.getfilesystemencoding(),
> 'backslashreplace')
>     else
>         pathbytes =3D repo.path.encode(sys.getfilesystemencoding(),
> 'surrogateescape')
>     hasher.update(pathbytes)
>     repo.hash =3D hasher.hexdigest()

If we don't want to put a version check in it probably wants to look
like this (ignoring Python 3.0 since I don't think we need to support
it):

    hasher =3D _digest()
    try:
        codecs.lookup_error('surrogateescape')
    except LookupError:
        pathbytes =3D repo.path
    else:
        pathbytes =3D repo.path.encode(sys.getfilesystemencoding(),
                                     'surrogateescape')
    hasher.update(pathbytes)
    repo.hash =3D hasher.hexdigest()

The version with a version check seems better to me, although this
should probably be a utility function.


John
