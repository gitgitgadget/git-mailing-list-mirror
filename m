From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Wed, 11 Jun 2008 12:28:08 -0500
Message-ID: <48500B28.1050505@gmail.com>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk> <484E87B2.2090506@gmail.com> <20080611062753.GB15034@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:29:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6U8F-0001Fz-9h
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 19:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYFKR2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 13:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYFKR2R
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 13:28:17 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:1988 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYFKR2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 13:28:16 -0400
Received: by py-out-1112.google.com with SMTP id p76so1486586pyb.10
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=aqGKGETJFyHVKXfG09ntUPz2KRKDZFaTuHcKnOMY8Ug=;
        b=TIO3Z5q95p4fmq9JCzTpYYjNcqrkj4QVP7LRwyhtJiLt4XLcHRBpcPlVbS4MtL+xXA
         F/sQJ9gKVoouHfaSakx1gGBslU0HDKot9mkZfrSp1bNArpYu7wrTPF3+Sxnb/9aaLePD
         bLNv+lxyyOhGvk+iRh/cZfIRJx1Guc2BocGnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=ttvD3BtWsoTyPC3ZFm2+k7bZAJAKt656pWsM0kDaHrrG+otfS+Q9wZiolNEFUPb50F
         eLrUoiPv5dn1QMlja+mB5CoJn4kUBPnb/comeYc8gpm+YruiNB4G5e2w4KviMlGPzWYK
         Hl8HlgpdcShYrsOoiV3w4rhXv8jOxmI9JAnfo=
Received: by 10.115.77.1 with SMTP id e1mr149874wal.58.1213205295042;
        Wed, 11 Jun 2008 10:28:15 -0700 (PDT)
Received: from ?172.16.17.168? ( [66.187.231.200])
        by mx.google.com with ESMTPS id 13sm129843wrl.19.2008.06.11.10.28.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 10:28:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <20080611062753.GB15034@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84626>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl Hasselstr=C3=83=C2=B6m wrote:
> On 2008-06-10 08:54:58 -0500, Clark Williams wrote:
>=20
>> --- a/stgit/commands/imprt.py
>> +++ b/stgit/commands/imprt.py
>> @@ -178,8 +178,22 @@ def __create_patch(filename, message, author_na=
me, author_email,
>>  def __import_file(filename, options, patch =3D None):
>>      """Import a patch from a file or standard input
>>      """
>> +    if patch:
>> +        pname =3D patch
>> +    else:
>> +        pname =3D filename
>> +
>>      if filename:
>> -        f =3D file(filename)
>> +        if filename.endswith('.gz'):
>> +            import gzip
>> +            f =3D gzip.open(filename)
>> +            pname =3D strip_suffix('.gz', filename)
>> +        elif filename.endswith('.bz2'):
>> +            import bz2
>> +            f =3D bz2.BZ2File(filename)
>> +            pname =3D strip_suffic('.bz2', filename)
>                                   ^
> Here's why I keep blathering about tests! In Python, you don't have a
> compiler to catch these for you ...
>=20

Yup, caught that right after I sent the updated patch :)

>> +        else:
>> +            f =3D file(filename)
>>      else:
>>          f =3D sys.stdin
>> =20
>> @@ -197,11 +211,6 @@ def __import_file(filename, options, patch =3D =
None):
>>      if filename:
>>          f.close()
>> =20
>> -    if patch:
>> -        pname =3D patch
>> -    else:
>> -        pname =3D filename
>> -
>=20
> I just realized a problem with this that was already present in your
> first version: if patch !=3D None, so that you set pname =3D patch, y=
ou
> overwrite pname since you strip the .gz/.bz2 suffixes _later_.
>=20

Ah, I didn't realize that patchname overrides all (should have). I'll f=
ix that next
go-round.

> Other than that, it looks good. But you sounded tempted to go with th=
e
> idea of just trying the decompressors rather than go by the suffix? I
> think that'd be an improvement.
>=20

Yeah, it's tempting. I'll play with it a bit and see what it would take=
=2E Seems it
would just take a try/except block with logic to make the patchname rig=
ht (I still
would want to remove a .gz/.bz2 suffix from the patchname).

> As for testing, you'd simply make two copies of one of the subtests i=
n
> t1800, where you test .gz- and .bz2-compressed versions of the same
> patch. Should take about five minutes to write.
>=20

I'll make sure I have tests to go with the next patch.

Clark


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhQCygACgkQqA4JVb61b9fckgCfbjep1oC3WT3hxVSo/8y6/FVM
O8AAn1GEGjvbwerEY0U0N1UlJC8Lv37R
=3DRHjB
-----END PGP SIGNATURE-----
