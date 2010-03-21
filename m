From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 3/3] find_unique_abbrev: early out without a memcpy
Date: Sun, 21 Mar 2010 22:09:49 +0100
Message-ID: <40aa078e1003211409q50b9efc3pf5bcfccb48b7eeb6@mail.gmail.com>
References: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
	 <1269111329-5896-4-git-send-email-kusmabite@gmail.com>
	 <7v39ztmnjp.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 22:10:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtSPJ-0000ES-Aa
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 22:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab0CUVJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 17:09:52 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53348 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab0CUVJv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 17:09:51 -0400
Received: by wwe15 with SMTP id 15so2845229wwe.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n/jvFelxyNOhvyYQax3nnnV7lXK+C2waEbgZWvZUgno=;
        b=KnjubCbyWaIu0IlBtFbhWrNkHYSZJbq5G8UKvGJuS9JG40FYqFnaKnsteAzeqoTtJ1
         zWiGB85QNsAphye8z0pzvZ3/PiikF3Y2oggqf1/wx2o1BrQB7A9TmoDBU6QbJDjhzYWD
         VIcQsFMlYUxJH3+ODqlPP0CpEy0uIPuvzm5TY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=cpw558kdgwfO0GShDLvliPIzJWdpES9StpXN6QrADWgSKvyeM0rjBkHvxf3v8DQ/RG
         qeTp+OTINzO+gDIwRRhrI8bR3+wwcYsbBJj991HguzlHF9sg8ouf+RRJhFzvJ/AC62Fi
         kuG2vx8B6/05g8V+Jn9Nq/PVGqxLIUwYag+GA=
Received: by 10.216.180.141 with SMTP id j13mr1408601wem.227.1269205789366; 
	Sun, 21 Mar 2010 14:09:49 -0700 (PDT)
In-Reply-To: <7v39ztmnjp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142860>

On Sun, Mar 21, 2010 at 9:23 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> =A0sha1_name.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index bf92417..2b1be58 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -196,10 +196,10 @@ const char *find_unique_abbrev(const unsigned =
char *sha1, int len)
>> =A0 =A0 =A0 int status, exists;
>> =A0 =A0 =A0 static char hex[41];
>>
>> + =A0 =A0 if (len =3D=3D 40 || !len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sha1_to_hex(sha1);
>> =A0 =A0 =A0 exists =3D has_sha1_file(sha1);
>> =A0 =A0 =A0 memcpy(hex, sha1_to_hex(sha1), 40);
>> - =A0 =A0 if (len =3D=3D 40 || !len)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return hex;
>
> This is somewhat iffy. =A0hex[] being static means there can only be =
one
> outstanding return value from f-u-a being used, iow
>
> =A0 =A0 =A0 =A0printf("%s %s", f-u-a(a, 0), f-u-a(b, 0))
>
> is a no-no. =A0But at the same time, it means that you can use one mo=
re
> recycled buffer than sha1_to_hex() gives us, so this may be safe:
>
> =A0 =A0 =A0 =A0char *ua =3D f-u-a(a, 0);
> =A0 =A0 =A0 =A0printf("%s %s %s %s %s", ua,
> =A0 =A0 =A0 =A0 =A0 =A0sha1_to_hex(b), sha1_to_hex(c), =A0sha1_to_hex=
(d), sha1_to_hex(e));
>
> but with the above it probably is not anymore, no?
>

True, I didn't think of that.

But is this really a problem? I mean, we already have 3 guard-buffers
here, so it would only trigger when the result of more than four calls
to sha1_to_hex (directly, or through find_unique_abbrev) has to be
kept alive at the same time.

The only documentation I could find of this was the comment "/* static
buffer result! */" from cache.h, and it doesn't mention that there's
multiple buffers. So I'd say that any call-site that required four
buffers are, well, perhaps a little bit TOO tightly integrated with
that function ;)

The test-suite didn't catch any failures in it, but I guess I would
have to analyze the calling code a bit more to be sure.

> As an optimization patch, I would buy that delaying the "exists" chec=
k
> until the "no abbreviation" check returned early would make sense, th=
ough.
>

=2E..or we could just do this. To be honest, this is probably where mos=
t
of the change in performance come from. Which in case makes the commit
message somewhat misleading.

Then again, the third option is the easiest one; just drop 2/3 and
3/3. I'd be perfectly fine with that, I just went a little OCD with
consistency here. Those two patches gain us very little. I haven't
measured performance change outside of ls-tree, though.

--=20
Erik "kusma" Faye-Lund
