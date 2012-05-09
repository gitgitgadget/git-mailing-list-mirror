From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] sha1_name: support sha1^{note} to return note sha-1
Date: Wed, 9 May 2012 16:09:35 +0200
Message-ID: <CALKQrgdGCoKooM7KayNMQ_+Fg9=-1YnwNE_9NHzpX0jfoRjT_A@mail.gmail.com>
References: <1336482870-30842-1-git-send-email-pclouds@gmail.com>
	<20120508161126.GB26838@sigill.intra.peff.net>
	<CACsJy8AfD-N6L6nZNDG3uw4s6jAdYqkuQ8Jt2XRXRGzRwt1ncQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 16:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS7aM-0006Ez-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 16:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280Ab2EIOJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 10:09:42 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:52848 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab2EIOJl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 10:09:41 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1SS7aF-0001pl-2a
	for git@vger.kernel.org; Wed, 09 May 2012 16:09:39 +0200
Received: by qabj40 with SMTP id j40so522419qab.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 07:09:35 -0700 (PDT)
Received: by 10.60.4.199 with SMTP id m7mr208842oem.65.1336572575814; Wed, 09
 May 2012 07:09:35 -0700 (PDT)
Received: by 10.76.133.226 with HTTP; Wed, 9 May 2012 07:09:35 -0700 (PDT)
In-Reply-To: <CACsJy8AfD-N6L6nZNDG3uw4s6jAdYqkuQ8Jt2XRXRGzRwt1ncQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197474>

On Wed, May 9, 2012 at 10:25 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Tue, May 8, 2012 at 11:11 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, May 08, 2012 at 08:14:30PM +0700, Nguyen Thai Ngoc Duy wrote=
:
>>> @@ -473,7 +474,19 @@ static int peel_onion(const char *name, int le=
n, unsigned char *sha1)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_type =3D =
OBJ_NONE;
>>> =C2=A0 =C2=A0 =C2=A0 else if (sp[0] =3D=3D '/')
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected_type =3D =
OBJ_COMMIT;
>>> - =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 else if (!strncmp("note}", sp, 5)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *no=
te;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct notes_tree t;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1_1(name, sp=
 - name - 2, outer))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&t, 0, sizeof(t)=
);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_notes(&t, NULL, NU=
LL, 0);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 note =3D get_note(&t, o=
uter);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (note)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 hashcpy(sha1, note);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_notes(&t);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return note ? 0 : -1;
>>> + =C2=A0 =C2=A0 } else
>>
>> The notes code is relatively expensive to initialize, with the
>> assumption that the effort will be amortized across multiple lookups
>> (which are made faster). Is it possible to cache this initialized no=
tes
>> structure in case many lookups are done?
>
> No idea. I have never worked/used notes until yesterday (and these
> patches were the result). I will look into it.

IIRC, the initialization loads the top-level notes tree object into
memory. Subtrees (if any) are loaded on demand. FTR, if you have less
then ~256 notes in the notes tree, there will be no subtrees. As the
number of notes grows, the number of subtree levels grow roughly
logarithmically with the total number of notes (see determine_fanout()
for more details).

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
