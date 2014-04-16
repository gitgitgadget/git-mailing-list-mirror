From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 00/25] Lockfile correctness and refactoring
Date: Wed, 16 Apr 2014 21:50:56 +0200
Message-ID: <534EDF20.70201@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu> <534D7D2E.7060100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:51:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaVrQ-0002ni-Sl
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 21:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbaDPTvD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2014 15:51:03 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47812 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604AbaDPTvA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 15:51:00 -0400
X-AuditID: 1207440c-f79656d000003eba-4b-534edf23d446
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.CC.16058.32FDE435; Wed, 16 Apr 2014 15:50:59 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9722C.dip0.t-ipconnect.de [79.201.114.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3GJou68030248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Apr 2014 15:50:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <534D7D2E.7060100@web.de>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqKt83y/YYMUzQ4uuK91MFg29V5gt
	Vv6ssfjR0sNsceZNI6NFZ8dXRgc2j2e9exg9Ll5S9lj8wMvj8yY5j7v/dzJ53H62jSWALYrb
	JimxpCw4Mz1P3y6BO2Pm0geMBedFKv6cusnUwDhFoIuRk0NCwERizrU9zBC2mMSFe+vZuhi5
	OIQELjNK3FvZzArhnGeS2D3zJytIFa+ApsSl1+eYQGwWAVWJB2tWs4PYbAK6Eot6moHiHByi
	AkESf84qQpQLSpyc+YQFxBYRyJCYdGw+O8hMZqD1EtPWvQXbLCzgJHFq6UNmkF4hgTiJtrmS
	IGFOATWJu1PWsoGEJQTEJXoag0DCzAI6Eu/6HjBD2PISzVtnM09gFJyFZNssJGWzkJQtYGRe
	xSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRESCTw7GL+tkznEKMDBqMTDOyPH
	N1iINbGsuDL3EKMkB5OSKG/UXb9gIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8mWeBcrwpiZVV
	qUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd6HIEMFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQfEbXwyMYJAUD9DeuyDtvMUFiblAUYjWU4y6HBcaVrQwCbHk5eel
	SonzFoEUCYAUZZTmwa2Apb1XjOJAHwvzvgOp4gGmTLhJr4CWMAEtORTuC7KkJBEhJdXAyPJ/
	cmy2nVrvJvaGyesXNW+U+z25PbhZPe3Y0ruX7wR8imCy8OeeWHbkI//phn//fAqX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246379>

On 04/15/2014 08:40 PM, Torsten B=F6gershausen wrote:
> refs.c:
> int close_ref(struct ref_lock *lock)
> {
> 	if (close_lock_file(lock->lk))
> 		return -1;
> 	lock->lock_fd =3D -1;
> 	return 0;
> }
>=20
> When the close() fails, fd is still >=3D 0, even if the file is close=
d.
>=20
> Could it be written like this ?
>=20
> int close_ref(struct ref_lock *lock)
> {
> 	return close_lock_file(lock->lk);
> }

It seem to me it would be better to set lock->lock_fd to -1 regardless
of whether close_lock_file() succeeds.  Or maybe this field is not even
needed, and instead lock->lk->fd should be used.

This is a bit beyond the scope of this patch series, but I will put it
on my todo list.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> lockfile.c, line 49
>  *   - filename holds the filename of the lockfile
>=20
> I think we have a strbuf here? (which is a good thing),
> should we write:
>  *   - strbuf filename holds the filename of the lockfile
> ----------
> (and at some places filename[0] is mentioned,
> should that be filename.buf[0] ?)

I think it is OK to speak of a strbuf as "holding" a filename (what els=
e
would that construct mean?

But you are correct that the comments shouldn't speak of filename[0]
anymore.  I will fix it.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> int commit_lock_file(struct lock_file *lk)
> {
> 	static struct strbuf result_file =3D STRBUF_INIT;
> 	int err;
>=20
> 	if (lk->fd >=3D 0 && close_lock_file(lk))
> 		return -1;
> ##What happens if close() fails and close_lock_file() returns !=3D 0?
> ##Is the lk now in a good shaped state?
> I think the file which had been open by lk->fd is in an unkown state,
> and should not be used for anything.
> When I remember it right, an error on close() can mean "the file coul=
d not
> be written and closed as expected, it can be truncated or corrupted.
> This can happen on a network file system like NFS, or probably even o=
ther FS.
> For me the failing of close() means I smell a need for a rollback.

Yes, this is a good catch.  I think a rollback should definitely be don=
e
in this case.  I will fix it.

In fact, I'm wondering whether it would be appropriate for
close_lock_file() itself to do a rollback if close() fails.  I guess I
will first have to audit callers to make sure that they don't try to us=
e
lock_file::filename after a failed close_lock_file() (e.g., for
generating an error message).

> Please treat my comments more than questions rather than answers,
> thanks for an interesting reading

Thanks for your helpful comments!

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
