From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: Re* [PATCH 1/2] sha1_name: try to use same abbrev length when
 core.abbrevguard is specified
Date: Thu, 10 Mar 2011 20:52:46 +0900
Message-ID: <1299757966.1499.34.camel@leonhard>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
	 <7vipvsaz27.fsf@alter.siamese.dyndns.org>
	 <7vbp1kayoe.fsf@alter.siamese.dyndns.org>
	 <7vlj0n5o3n.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:53:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxeQX-0005VA-Md
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 12:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab1CJLxC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 06:53:02 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57882 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab1CJLwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 06:52:53 -0500
Received: by iwn34 with SMTP id 34so1442988iwn.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 03:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=T8klGQLCu3E06S8WitVwXC64zsSwIxz1lVAz6klXZZY=;
        b=kMQxTWx3OF+KT08G3FIJzKzogePCRz+v/34YV8QUPT21eZuLBPhFquKNnLtVQiXzus
         QGe3R5oQm3CirdWxIuJQtyhmPbYvQ7mgDbkR3CBzMVMJWcOkzaeiE+oLrc6X2qCfdmFS
         D5IichoyNBqCWjfK9A1TJcHSGNNvt9lSx8iVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=UIEb4Zp3kipygV+haXHVkByQSVfycNa+U4wvPAUhZVGgLmJyrBdeimjXG1sDi62PDi
         ROR82nhu0GoXxYHmrMXZIs6udQhSoEjwzGLsr19hJepXqyuv4Bv6hxfkpKR16edtk/ev
         Hp7NDqAe5VIa7Ws1tErGXf2+cnDzzoZYxnxTk=
Received: by 10.42.244.74 with SMTP id lp10mr10209971icb.4.1299757972775;
        Thu, 10 Mar 2011 03:52:52 -0800 (PST)
Received: from [118.176.73.109] ([118.176.73.109])
        by mx.google.com with ESMTPS id y8sm2216984ica.14.2011.03.10.03.52.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 03:52:52 -0800 (PST)
In-Reply-To: <7vlj0n5o3n.fsf_-_@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168811>

2011-03-10 (=EB=AA=A9), 01:19 -0800, Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > I think what may be desirable is to honor the caller-supplied "len"=
 a bit
> > better.  If an object is uniquely identifiable with only 4-hexdigit=
 today,
> > and if the caller gives 7 as len and the guard is set to 3, we retu=
rn 10
> > hexdigits with the current code.  We should instead return 7 hexdig=
its in
> > such a case, as that is in line with the "use 3 extra to give the
> > disambiguation we find today a better chance to survive".
>=20
> And here is an attempt to do so.  I have to admit that I didn't give =
it
> too much thought, though, so please be careful when reviewing the log=
ic.
>=20

What if the unique length is greater than or equal to the given length?
=46or instance the unique length is 7 and the caller gives 7 and the gu=
ard
is 3. What do you want to return, 7 or 10? How about the unique length
of 8?

I think the meaning of the guard is somewhat vague. When this feature
was considered in LKML at first, Linus just wanted to change the defaul=
t
length of commit abbreviation to 12 by making it user-configurable. [1]
And this is the same situation what I tried to tell you in the previous
email.

So I think it would be better to choose the output length using only
caller-given length and the guard length if it guarantees the uniquenes=
s
today. It'll be simple, consistent and expected behavior IMHO.

Thanks.


> -- >8 --
> Subject: find_unique_abbrev(): honor caller-supplied "len" better
>=20
> The caller of this function wants to ensure that the returned string =
is a
> unique abbreviation of the object name, and at least len characters l=
ong.
> When "len" is sufficiently short and we cannot ensure uniqueness with=
 only
> "len" bytes, we returned minimally unique prefix (i.e. if you dropped=
 the
> last character, there would be two or more objects that share that sa=
me
> prefix as their names in the repository).
>=20
> An earlier change introduced core.abbrevguard configuration with a
> realization that a short prefix that is unique today may not stay uni=
que
> forever, as new objects are added to the repository. When "len" is sh=
orter
> than the length necessary to ensure uniqueness today, instead of retu=
rning
> a string that is only one character longer than the longest ambiguous
> prefix, we wanted to add that many extra characters to ensure uniquen=
ess
> for longer time.
>=20
> However, the code forgot that "len" may be sufficiently long.  If an
> object is uniquely identifiable with only 4-hexdigit today, and if th=
e
> caller gives 7 as len and the guard is set to 3, we returned 10 hexdi=
gits,
> which was 3 characters longer than necessary.  We should instead retu=
rn 7
> hexdigits in such a case, as that is in line with the original intent=
ion
> of using 3 extra hexdigits to give the disambiguation we find today a
> better chance to survive.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sha1_name.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
>=20
> diff --git a/sha1_name.c b/sha1_name.c
> index 709ff2e..0f81581 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -193,6 +193,23 @@ static int get_short_sha1(const char *name, int =
len, unsigned char *sha1,
>  	return status;
>  }
> =20
> +/*
> + * The caller wants a unique abbreviation of the full object name in
> + * "sha1" that is at least "len" characters long.
> + *
> + * (1) If sha1 identifies an existing object, there must be no other
> + *     object that shares the returned string as the prefix of its
> + *     name;
> + *
> + * (2) If no object with the given object name exists, there must be
> + *     no object that has the returned string as the prefix of its
> + *     name.
> + *
> + * Usually we try to return as short a string as possible, but the
> + * core.abbrevguard configuration may tell us to use at least that
> + * many characters more than necessary to make the result unique,
> + * in order to keep it unique a bit longer.
> + */
>  const char *find_unique_abbrev(const unsigned char *sha1, int len)
>  {
>  	int status, exists;
> @@ -202,6 +219,13 @@ const char *find_unique_abbrev(const unsigned ch=
ar *sha1, int len)
>  	memcpy(hex, sha1_to_hex(sha1), 40);
>  	if (len =3D=3D 40 || !len)
>  		return hex;
> +	len -=3D unique_abbrev_extra_length;
> +	if (len <=3D 0)
> +		len =3D 1;

Anyway, how about

	  if (len < MINIMUM_ABBREV)
		  len =3D MINIMUM_ABBREV;


> +	/*
> +	 * Try to see how short a prefix we can feed to get
> +	 * the desired unique hit
> +	 */
>  	while (len < 40) {
>  		unsigned char sha1_ret[20];
>  		status =3D get_short_sha1(hex, len, sha1_ret, 1);


--=20
Regards,
Namhyung Kim
