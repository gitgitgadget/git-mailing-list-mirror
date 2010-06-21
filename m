From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] notes: Initialize variable to appease Sun Studio
Date: Mon, 21 Jun 2010 21:53:52 +0100
Message-ID: <4C1FD160.6010700@ramsay1.demon.co.uk>
References: <e0fbd6edc13d94a097e8e7e3649b9e669f9b4ee3.1268413246.git.trast@student.ethz.ch>	<1276558805-26573-1-git-send-email-avarab@gmail.com>	<7vvd9fwrmc.fsf@alter.siamese.dyndns.org> <AANLkTimmnlHmt6LTHFKUtJZ7taSF10p4Pkna4CCb1G_J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 21:13:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR8u7-0005mp-U1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 21:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0FVTM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jun 2010 15:12:57 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:42444 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752847Ab0FVTM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jun 2010 15:12:57 -0400
X-Greylist: delayed 1508 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2010 15:12:56 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1OR8VD-0005L0-f2; Tue, 22 Jun 2010 18:47:46 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTimmnlHmt6LTHFKUtJZ7taSF10p4Pkna4CCb1G_J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149489>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Jun 19, 2010 at 04:52, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Sun Studio 12 Update 1 thinks that *t could be uninitialized,
>>> ostensibly because it doesn't take rewrite_cmd into account in its
>>> static analysis.
>> Hmm, I am wondering if I should apply this or just tell you to fix y=
our
>> compiler ;-)
>=20
> I just noticed it when testing on Solaris, I don't use it regularly.

gcc version 3.4.4 issues exactly the same warning (but gcc versions 4.1=
=2E2
and 4.4.0 don't).

However, gcc 3.4.4 also issues a warning for notes.c, thus:

    notes.c: In function `write_each_non_note_until':
    notes.c:719: warning: 'cmp' might be used uninitialized in this fun=
ction

The obvious patch is below, ;-)

ATB,
Ramsay Jones

-- >8 --
=46rom: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Mon, 21 Jun 2010 19:52:29 +0100
Subject: [PATCH] notes: Initialise variable to appease gcc

gcc version 3.4.4 thinks that the 'cmp' variable could be used
while uninitialised and complains thus:

    notes.c: In function `write_each_non_note_until':
    notes.c:719: warning: 'cmp' might be used uninitialized in \
        this function

Note that gcc versions 4.1.2 and 4.4.0 do not issue this warning.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 notes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index 6ee04e7..30d6ded 100644
--- a/notes.c
+++ b/notes.c
@@ -716,7 +716,7 @@ static int write_each_non_note_until(const char *no=
te_path,
 		struct write_each_note_data *d)
 {
 	struct non_note *n =3D d->next_non_note;
-	int cmp, ret;
+	int cmp =3D 0, ret;
 	while (n && (!note_path || (cmp =3D strcmp(n->path, note_path)) <=3D =
0)) {
 		if (note_path && cmp =3D=3D 0)
 			; /* do nothing, prefer note to non-note */
--=20
1.7.1
