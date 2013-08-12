From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] diff: remove ternary operator evaluating always to true
Date: Mon, 12 Aug 2013 10:32:01 +0200
Message-ID: <52089D81.5010506@googlemail.com>
References: <1375986704-11441-1-git-send-email-stefanbeller@googlemail.com> <20130810072114.GD30185@sigill.intra.peff.net> <7vli471mxy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAE252E93C723319BD93FE6FF"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 10:31:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8nXd-0003yT-3e
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 10:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab3HLIbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 04:31:49 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48868 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab3HLIbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 04:31:48 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so1380017wib.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=Fs24UNO77o7GplHjP3lupxOtAi76vQ0IubjN5EYZaL8=;
        b=qIOhkRU7Lf20W4PdP+tGSLkp9JQs6KORHWEGFy/IIRtgW15gCfErhXyRwPISVLky83
         dCQx/6jNe4aDrOPKsOpGmiYqEK0P8W7qf778y2hu5fVFjhOpen73sjE0eAse0EOcCD4O
         sBf+7P5tpLbSRzhRT4g5L6p6Um72iY/omHwU1GwHmHT0DnT1vb3zq3G95Ij19pRWWoW7
         S/iwztulAZH02xdUY5GIyhFQft+QJB44oyyzV6wFymDgP9HUlfVB1JEPF5WV9POc9QuY
         HcheDYVyohAGhpdAQpFZLdcoLvnN946zBINKoxx0VDoP4YYGcOV0ep1zOk3OtATiofI7
         DLvQ==
X-Received: by 10.194.232.40 with SMTP id tl8mr12158811wjc.42.1376296306632;
        Mon, 12 Aug 2013 01:31:46 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fu13sm5977295wic.7.2013.08.12.01.31.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 01:31:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <7vli471mxy.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232177>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE252E93C723319BD93FE6FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/12/2013 07:46 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
>> On Thu, Aug 08, 2013 at 08:31:44PM +0200, Stefan Beller wrote:
>>
>>> The next occurrences are at:
>>> 	/* Never use a non-valid filename anywhere if at all possible */
>>> 	name_a =3D DIFF_FILE_VALID(one) ? name_a : name_b;
>>> 	name_b =3D DIFF_FILE_VALID(two) ? name_b : name_a;
>>>
>>> 	a_one =3D quote_two(a_prefix, name_a + (*name_a =3D=3D '/'));
>>> 	b_two =3D quote_two(b_prefix, name_b + (*name_b =3D=3D '/'));
>>>
>>> In the last line of this block 'name_b' is dereferenced and compared
>>> to '/'. This would crash if name_b was NULL. Hence in the following c=
ode
>>> we can assume name_b being non-null.
>>
>> I think your change is correct, but I find the reasoning above a littl=
e
>> suspect. It assumes that the second chunk of code (accessing name_a an=
d
>> name_b) is correct, and pins the correctness of the code you are
>> changing to it. If the second chunk is buggy, then you are actually
>> making the code worse.
>=20
> True.  I think the original code structure design is name_a should
> always exist but name_b may not (the caller of run_diff_cmd() that
> eventually calls this call these "name" and "other", and the intent
> is renaming filepair is what needs "other").
>=20
>> I wonder if the implicit expectation of the function to take at least
>> one non-NULL name would be more obvious if the first few lines were
>> written as:
>>
>>   if (DIFF_FILE_VALID(one)) {
>>           if (!DIFF_FILE_VALID(two))
>>                   name_b =3D name_a;
>>   } else if (DIFF_FILE_VALID(two))
>>           name_a =3D name_b;
>>   else
>>           die("BUG: two invalid files to diff");
>>
>> That covers all of the cases explicitly, though it is IMHO uglier to
>> read (and there is still an implicit assumption that the name is
>> non-NULL if DIFF_FILE_VALID() is true).
>=20
> I think that is an overall improvement, especially if we also update
> the checks of {one,two}->mode made for the block that deals with
> submodules to use DIFF_FILE_VALID().
>=20
> Thanks.
>=20

So, do I understand your reasoning, when proposing this patch?
(This may break whitespaces as it's copied into my MUA, will resend with
git send-mail if you think this is the right thing.)

This patch just covers your discussion and not the previous patches.

Stefan

--8<--
=46rom 701bab4f15598ba230552af7f1d5719187f1b2e8 Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Mon, 12 Aug 2013 10:29:07 +0200
Subject: [PATCH] diff: Additional error checking for input parameters

This makes the diff function error out instead of segfaulting if the
parameters are bad.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 diff.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index e53ddad..de21971 100644
--- a/diff.c
+++ b/diff.c
@@ -2254,8 +2254,11 @@ static void builtin_diff(const char *name_a,
 			(!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del =3D diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add =3D diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one ? one->path : two->path,
-				line_prefix,
+		struct diff_filespec *spec =3D one && DIFF_FILE_VALID(one) ? one : two=
;
+		if (!spec && !DIFF_FILE_VALID(spec))
+			die("BUG: two invalid diff_filespec structs in diff");
+
+		show_submodule_summary(o->file, spec->path, line_prefix,
 				one->sha1, two->sha1, two->dirty_submodule,
 				meta, del, add, reset);
 		return;
@@ -2276,8 +2279,13 @@ static void builtin_diff(const char *name_a,
 	}
=20
 	/* Never use a non-valid filename anywhere if at all possible */
-	name_a =3D DIFF_FILE_VALID(one) ? name_a : name_b;
-	name_b =3D DIFF_FILE_VALID(two) ? name_b : name_a;
+	if (DIFF_FILE_VALID(one)) {
+		if (!DIFF_FILE_VALID(two))
+			name_b =3D name_a;
+	} else if (DIFF_FILE_VALID(two))
+		name_a =3D name_b;
+	else
+		die("BUG: two invalid files to diff");
=20
 	a_one =3D quote_two(a_prefix, name_a + (*name_a =3D=3D '/'));
 	b_two =3D quote_two(b_prefix, name_b + (*name_b =3D=3D '/'));
--=20
1.8.4.rc2



--------------enigAE252E93C723319BD93FE6FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSCJ2BAAoJEJQCPTzLflhquyIQANV3qItbdmvUlNvNemHmKcef
P5o/w6JOa8XhxBKBerNh7rCiXSQPQyapo5Cbhh70GO0bgFPyVn6SGpoo6tSC7U1t
viLjfzbz7zKeJcU18KZShFv3+3PnCLNnnEghsvdZmX8pCDIDKxUiJqmnyNvLtktx
osLTBK6ppZXI5byUF9PimRYWvlCJBrZO9cfhFkG5lnfEAX7AgUyAbMQ6ucpW2tGD
ESzk+seFNog6VZFmm01qU7qjIuQPtlbs3+c2fiiNOxMdz1aZdmSYk5ataNaQQO07
dUPe8qLz/F/VOplo4gZ+cXOv/+rHLp1Vr/IsesP1XuZ5SJ3ybkOWeFjvw0kDurZt
BZ1OojfvXA2Y5ZBlTFx4ZVWs6/VfSeN//ja0VIFOK25f8ptivDQBp3IPudPzLOav
pYbqlPCB0TyqaTRfuWjhmR1V8aRXvwCRBaMYRs10Kz6MuY/Ehrieq4Uy8L0Ig74n
b8uyyuXNo7LVkC8CSRlUpuT6hD8tvCekkJkLOqTm+vNN1SvFB3ch0u7qNkwU/a3s
QTvBVsetvgzti1BITCkvmqv3Bwgo0W1c3KWJb+Qf77DkmhqZBbqGoNndnr6KGCl4
U8ItmoS5XRRylWHwq/pdkCxO+/6T9RFR646sX6prqDMyXgiLwJdlreuS2/T52R4D
mpN/qws8VS+whcOQ/QZP
=Oe4u
-----END PGP SIGNATURE-----

--------------enigAE252E93C723319BD93FE6FF--
