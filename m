From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Thu, 22 Aug 2013 00:57:35 +0200
Message-ID: <521545DF.2040004@googlemail.com>
References: <5214F816.3010303@googlemail.com> <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com> <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com> <52153C01.6040101@googlemail.com> <xmqqsiy2slo3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig49A146088DD0534ED41B3D20"
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:57:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCHLP-0002GK-QI
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab3HUW5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:57:32 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:36812 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab3HUW5b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:57:31 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so571165eae.10
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=uQ/y32N5+XiIqzaatYQyqb0Wr4vp3aAxTJz+f4vDpaE=;
        b=GWiNma9i6V47ABtdiyiaiVbU/DXpeDFncW2S8VELDmNtX8yy74O13HH5dtGDiwxdL1
         o8vI5u8ZQReyPTt2UvyoZbKW/luZt2kjxaPFi1pV5onakjdew1Zd7LJ47p1dNASwXaQn
         V0hEIZuNe4vZGRaYbLk/4fDSr7o/Q2f/EWGUkyKa+2p7g9Ap4yIs6fZ96p3Pgrd2WGjx
         LTHo9NIoAI/4gptuI+c4oBer++b1cdJ8nu/eI8bXaZ8bcWOC+uhYL35jUL+nX2k7MTy6
         HUFssl2s5qM0u5eoLuluYD4l6X4bKsXgxqxSlZUz9oupTqEc+Wp2G5RRShBJvjTp6u4r
         ch/g==
X-Received: by 10.14.113.137 with SMTP id a9mr13233749eeh.3.1377125849876;
        Wed, 21 Aug 2013 15:57:29 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k7sm13207356eeg.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 15:57:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqsiy2slo3.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232748>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig49A146088DD0534ED41B3D20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/22/2013 12:50 AM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>>>> +static int delta_base_offset =3D 1;
>>>> +char *packdir;
>>>
>>> Does this have to be global?
>>
>> We could pass it to all the functions, making it not global.
>=20
> Sorry for being unclear; I meant "not static".  It is perfectly fine
> for this to be a file-scope static.

No need to be sorry! I am sleepy, and may missunderstand even clear
messages. I'll change it to static of course.

>=20
>>>> +
>>>> +		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
>>>> +			string_list_append_nodup(fname_list, fname);
>>>
>>> mental note: this is getting names of non-kept packs, not all packs.
>>
>> I should document that. ;)
>=20
> Rather, consider giving the function a better name, perhaps?

What about one of:
get_non_kept_pack_filenames
get_prunable_pack_filenames
get_remove_candidate_pack_filenames

>=20
>>>> +	while (strbuf_getline(&line, out, '\n') !=3D EOF) {
>>>> +		if (line.len !=3D 40)
>>>> +			die("repack: Expecting 40 character sha1 lines only from pack-ob=
jects.");
>>>> +		strbuf_addstr(&line, "");
>>>
>>> What is this addstr() about?
>>
>> According to the documentation of strbufs, we cannot assume to have sa=
ne=20
>> strings, but anything.
>=20
> Sorry, I do not get this.  What is a sane string and what is an
> insane string?  sb->buf[sb-len] is always terminated with a NUL
> when strbuf_getline() returns success, isn't it?
>=20

I should read the strbuf documentation again. Thanks for pointing it
out. I'll remove the strbuf_addstr(&line, "");

Thanks for your patience in the reviews,
Stefan


--------------enig49A146088DD0534ED41B3D20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSFUXfAAoJEJQCPTzLflhq3L8QAIBrM2XwUFvI7dPM42szuGjm
ZxWkbA5eNSa9n+HEartUUA1o2YZIj5TwZjzLZNxBSCAyipWOxqBeAHK0hrIV/hMu
9f3we9DAPlILWFMwNmGjrSh9vhpWTdio6mdk4Tyu9j4gsYmg20YRnCd4tsrq6tbC
udq5AB8TZO41wmvcnwlrtrnL1Yp8j0cImhkKRrO3/sgTpRsORfCOaQIUee5AL7EZ
Rr7nhEbAve07Y9mlpVM0+1RAmtyEwIbBzfYWd8SUMjPCmxQQ1NPLQBS/MVcX09a9
CS3gEO3xngg3L4miz3SUtC0Tl1iEwU5mpGmUFjIGBmdB9DsZVvdcNHSGV8VDyH3+
MKwwOZeQ1ZWoqNs0cP9mRWQq98vEeuqv+/OwJPpcHNAiXzjyxN0oHcpyn7GCw5vb
WnO8G1defRFH3fmvRTfSRZP7wU03Za+TAo3l43DFRbGCpyNHD9Wzl589q6gOsPGr
Dff+ENWpLQlZws1AniT6dh1B2JiLKXvwxhBUZRw+mmAgndPCEYqTu+/InXihOM6C
ULw1qTE8tMMoXAVRf+j1Z8BvLO3VmMUOULcgXXNu7Inf19o5ppEFKEZ5kzaLTGyY
BIQ+b7dulv/7D+LKucyFrP0vPj3WoICIoDY3lbJK80ELd4H+It9wPxvURXMVuBoB
KyFlHA7imvZ3oMMJMpvg
=efbK
-----END PGP SIGNATURE-----

--------------enig49A146088DD0534ED41B3D20--
