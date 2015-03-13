From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/10] Use a structure for object IDs.
Date: Fri, 13 Mar 2015 22:45:24 +0000
Message-ID: <20150313224524.GG46326@vauxhall.crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <5500689A.5090101@alum.mit.edu>
 <xmqqk2yn5l39.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 23:45:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWYKp-0001ve-QT
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 23:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbbCMWpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 18:45:34 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50088 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437AbbCMWpd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 18:45:33 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d0c6:418b:e1a:b913])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B58D12808F;
	Fri, 13 Mar 2015 22:45:30 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqqk2yn5l39.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265423>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 01:35:06PM -0700, Junio C Hamano wrote:
>Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 4. We continue to support working with SHA-1s declared to be (unsigned
>> char *) in some performance-critical code, even as we migrate most other
>> code to using SHA-1s embedded within a (struct object_id). This will
>> cost some duplication of code. To accept this approach, we would need an
>> idea of *how much* code duplication would be needed. E.g., how many
>> functions will need both (unsigned char *) versions and (struct
>> object_id *) versions?
>
>Ideally, only the ones that knows the underlying hash function is
>SHA-1 (i.e. anybody who mentions git_SHA_CTX), moves bytes from/to
>in-core object name field and raw range of bytes (e.g. sha1hash());
>everybody else like hashcpy() and hashcmp() should be able to do its
>thing only on structs and a generic-looking constant that denotes
>how many bytes there are in the hash (or even sizeof(struct oid)).
>
>I do not know what kind of code duplication you are worried about,
>though.  If a callee needs "unsigned char *", the caller that has a
>"struct object_id *o" should pass o->hash to the callee.

That's the plan.  My goal (which may or may not be achievable) is to
make hashcpy, hashcmp, and similar functions an implementation detail of
struct object_id functions.  If we have to use o->hash somewhere, okay.
I'm much more interested in practicality than theoretical purity.  I
want these changes to provide easier-to-change, more maintainable code,
not more complex and difficult code.

>And please do not suggest switching to C++; all it would do to
>overload these into a single name is to make the callers harder to
>read.

I'm not considering that.  I've attempted to compile git with g++
before as an idle curiosity, and I gave up almost immediately because it
looked like a bunch of work.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVA2iEAAoJEL9TXYEfUvaLGuAQAIL1oa29PXw6sOwjbAT4jn1f
aKKi0yhP8PKGLbIx57burmVNP3E6VGJbfyYonNXFpno0urdkcCEXBc8MkblcMxLc
tofGFD8r0ZPviAjiKHbRkQWEdgx8b/hMUV5qGmnFy/0F1hqPNwylkARbAoNFiyj6
ejHnUYXDs0ZUyQSIraoC90o4OiBlI10dkiJrXTL4V1whsZnKhQgtObwtXO3NFmnb
+FfwIKt+ZU3srj0MHI2ZQ6PWcSHC5hxAfON/GK904pNG/L/u7iqfMsaxwgdjcdPX
in0aeamkV0Euw+N22Sa6y8nanrvwcRUTAGyltlcRSdlgYnOYCP20SoF5kT6plNrJ
MQO49JfJubo0EqwAYp3AxGcGzdiCGcdKr96/Y4ZXtXUumE5gaSD0ZyOqSmpZGiTt
lzOk6K25Ow5FdnKvMvQKEnYkCDeEJagNO7x6kmj9hw8YvPy4c8qsQUYNZKTithFE
IKvGq5qhXFytH5LzimDA7c5Wx1n2kRVdJh56P7p8fB5xNSZz9nGodefuqikszDD6
zA0WGTfnCDUjnnTnN44TEJHa5jP6PfDgDCAEmlJv4p1M7s99fgXEJnYzIrVbEgbX
QOVrhrwyzIND9GdKrZx59y+OMZfDYFq7L3RP2rfY3X80apwhEIoxvNFLToUF0Iqq
jN7FauxvXJiyr6p7Dfrj
=18TM
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
