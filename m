From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 11:13:47 -0700
Message-ID: <xmqqd2eov8ys.fsf@gitster.dls.corp.google.com>
References: <538ED6DF.5020505@web.de>
	<xmqqr434vaeh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:14:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsFhL-0000hF-61
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbaFDSN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 14:13:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53811 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbaFDSN6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2014 14:13:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0034A1CE1E;
	Wed,  4 Jun 2014 14:13:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+nWpdm7TbQKZ
	38IQ+Ng7CitEcbw=; b=MrW5ih/ZY1gjMDekPiAQZRqohWMdFYvCtOU2EgS2aF7N
	YqKJKVZO3nYVJfIp0u0mHxm/p0JD0z0eVf5c4wrcwJ7hvPzWyITYadwh+lK3csdI
	wQ8PEe7/fj0v4PIARjW1cL9HR3CidF7KbL1gKaSICC7Z4Pv8ibv8Xbm+6ti2P6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=utUhLc
	E3ko4FsFRNEgK+xd8xFENVWk7vfWaecf5Mx+6fDTxI+uEX0M0x0eiAMRTyu2bilg
	FbSPinMVr4P+1qy/5qSJtGuhx8vxsXwEV1gCgUSK/OgHUrtY4w9rm66YxEbIbW4T
	iKo7gv3YRR2yQHTEda38Qt4QDwQnqjUVojCdg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA4761CE1D;
	Wed,  4 Jun 2014 14:13:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58B6B1CE1A;
	Wed,  4 Jun 2014 14:13:49 -0400 (EDT)
In-Reply-To: <xmqqr434vaeh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 Jun 2014 10:42:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9FAB494-EC13-11E3-829B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250752>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> t9001 used a '\n' in a sed expression to split one line into two lin=
es.
>> Some versions of sed simply ignore the '\' before the 'n', treating
>> '\n' as 'n'.
>>
>> As the test already requires perl as a prerequisite, use perl instea=
d of sed.
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>
> Hmph.  I read this in pubs.opengroup.org/onlinepubs/9699919799/utilit=
ies/sed.html
>
>     The escape sequence '\n' shall match a <newline> embedded in the
>     pattern space.
>
> so it may be better to be a bit more explicit in the log message to
> say whose implementation has this issue to warn people.
>
>>  t/t9001-send-email.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> index 64d9434..2bf48d1 100755
>> --- a/t/t9001-send-email.sh
>> +++ b/t/t9001-send-email.sh
>> @@ -1342,7 +1342,7 @@ test_cover_addresses () {
>>  	git format-patch --cover-letter -2 -o outdir &&
>>  	cover=3D`echo outdir/0000-*.patch` &&
>>  	mv $cover cover-to-edit.patch &&
>> -	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.pa=
tch >"$cover" &&
>> +	"$PERL_PATH" -pe "s/^From:/$header: extra\@address.com\nFrom:/" co=
ver-to-edit.patch | tr Q "$LF" >"$cover" &&
>
> We have a shell function "perl" in test-lib-function.sh these days
> so that you do not have to write "$PERL_PATH" yourself in tests ;-)

Also, piping output from perl to tr feels somewhat suboptimal.  I do
not see where in the test material we use "Q to LF", and we may want
to remove that altogether, but without that removal, an updated
patch may look like this.

 t/t9001-send-email.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64d9434..9f06b8c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1342,7 +1342,10 @@ test_cover_addresses () {
 	git format-patch --cover-letter -2 -o outdir &&
 	cover=3D`echo outdir/0000-*.patch` &&
 	mv $cover cover-to-edit.patch &&
-	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch=
 >"$cover" &&
+	perl -pe "
+		s/^From:/$header: extra\@address.com\nFrom:/;
+		y/Q/\n/;
+	" cover-to-edit.patch >"$cover" &&
 	git send-email \
 	  --force \
 	  --from=3D"Example <nobody@example.com>" \
