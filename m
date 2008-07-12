From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] git-mailinfo: Fix getting the subject from the body
Date: Sat, 12 Jul 2008 23:45:30 +0200
Message-ID: <487925FA.5020001@etek.chalmers.se>
References: <4876820D.4070806@etek.chalmers.se> <7v3amfxx3a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Don Zickus <dzickus@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 23:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHmul-0008Gk-At
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 23:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYGLVpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 17:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbYGLVpB
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 17:45:01 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:38071 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbYGLVpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 17:45:00 -0400
Received: from [192.168.0.85] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id 7BA7A11EC7;
	Sat, 12 Jul 2008 23:44:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v3amfxx3a.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88268>

Junio C Hamano wrote:
> Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:
>=20
>> "Subject: " isn't in the static array "header", and thus
>> memcmp("Subject: ", header[i], 7) will never match.
>>
>> Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
>> ---
>>
>> This has been broken since 2007-03-12, with commit
>> 87ab799234639c26ea10de74782fa511cb3ca606
>> so it might not be very important.
>>
>>  builtin-mailinfo.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
>> index 962aa34..2d1520f 100644
>> --- a/builtin-mailinfo.c
>> +++ b/builtin-mailinfo.c
>> @@ -334,7 +334,7 @@ static int check_header(char *line, unsigned lin=
esize, char **hdr_data, int over
>>  		return 1;
>>  	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
>>  		for (i =3D 0; header[i]; i++) {
>> -			if (!memcmp("Subject: ", header[i], 9)) {
>> +			if (!memcmp("Subject", header[i], 7)) {
>>  				if (! handle_header(line, hdr_data[i], 0)) {
>>  					return 1;
>>  				}
>=20
> Actually, I do not think your patch alone makes any difference, and t=
he
> original code looks somewhat bogus.  If there is no "Subject: " in th=
e
> same section of the message (either in e-mail header in which case
> hdr_data =3D=3D p_hdr_data[], or in the message body part in which ca=
se
> hdr_data =3D=3D s_hdr_data[]), hdr_data[1] will be NULL, because the =
only
> place that allocates the storage for the data is the first loop of th=
is
> function that deals with real-RFC2822-header-looking lines.
>=20
> You'd probably need something like this on top of your patch to actua=
lly
> activate the code.

Right, I noticed that too. It's fixed in the strbuf conversion, I think=
=2E

Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> wrote:
 > After looking at this part some more, I see that there is no guarant=
ee
 > that hdr_data[i] !=3D NULL in this codepath, and then we won't use t=
he
 > subject anyway.

I'll be hiking the next week, in case you wonder why I'm not responding=
=2E

I'll try to get another version of the patches out before I leave.

/Lukas
