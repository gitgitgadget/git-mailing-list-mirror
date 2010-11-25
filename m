From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] git apply: binary files differ can be applied with -pN
 (N>1).
Date: Thu, 25 Nov 2010 10:52:53 +0800
Message-ID: <4CEDCF85.1010806@gmail.com>
References: <4CECA0AE.90505@gmail.com> <7vlj4itz8j.fsf@alter.siamese.dyndns.org> <4CEDC011.1050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 03:53:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLRxN-0006JJ-R8
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 03:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab0KYCxC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 21:53:02 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54089 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151Ab0KYCxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 21:53:01 -0500
Received: by pva4 with SMTP id 4so98708pva.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 18:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=9JS2L7u6kdVPRyAbaFsTLoaPMfcwqdzE7CGwHNrcg3I=;
        b=JnEM4XGV7BAxjZeYKSJD+L1mdS8XR7viTKc6sPk5hcUbAfQXMR3G/TuU9pX01q+7fC
         Npf2W64Zl0BEykYjPa6JPu8bcBummkiO8/43T0jsAhN/GB3yc8tFsLsvXRy6pha+umeV
         bsjRg8KZUTf6poCcTwyyVSs/ZHb97kMqxhYPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VG9VsoX1RydISWTUZV+7XmeM3vgjfCVq1bEtNewACHRMbuDsHeFNXWfZYGzO7dkPsw
         +tANAQiSlCLEor3EnhRqN4NVDfyGiPLPhbeNPKeUI0dEiVxHPVSPjyzBDdBmO9e+FDlQ
         1q2wGtRKC9vQ2SYQW5qFVCPg2dH9kWazOXmes=
Received: by 10.142.150.13 with SMTP id x13mr114959wfd.407.1290653579199;
        Wed, 24 Nov 2010 18:52:59 -0800 (PST)
Received: from [192.168.0.50] ([123.115.150.125])
        by mx.google.com with ESMTPS id f5sm273622wfg.14.2010.11.24.18.52.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 18:52:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); zh-CN; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CEDC011.1050503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162099>

> =E4=BA=8E 2010=E5=B9=B411=E6=9C=8825=E6=97=A5 01:20, Junio C Hamano =E5=
=86=99=E9=81=93:
> By the way, this codepath is shared by all forms of patches "diff --g=
it"
> header, not just binary.  Do you see a similar breakage with --no-pre=
fix
> patches that are not binary, and if not why?

Some cases a git diff without "--- path/to/old" and "+++ path/to/new",
will make current git apply -p2 broken.

1. Prue file mode changes:

    diff --git a/sub1/file1 b/sub2/file1
    old mode 100644
    new mode 100755

2. Remove empty file:

    diff --git a/sub1/file1 b/sub1/file1
    deleted file mode 100644
    index e69de29..0000000

3. Add empty file:

    diff --git a/sub2/file1 b/sub2/file1
    new file mode 100644
    index 0000000..e69de29

4. New binary file:

    diff --git a/sub2/file1 b/sub2/file1
    new file mode 100644
    index 0000000000000000000000000000000000000000..4dd0c65a410e8aea160=
8d6b2dd70e74def0012c5
    GIT binary patch
    literal 8
    Pcmb<-^>JfjWMlvU2^Ilc
   =20
    literal 0
    HcmV?d00001
   =20
5. Modify binary file:
    diff --git a/sub1/file1 b/sub2/file1
    index f96ec1a8358556543a73b3fb93a0d1c2aad8432a..4dd0c65a410e8aea160=
8d6b2dd70e74def0012c5 100644
    GIT binary patch
    literal 8
    Pcmb<-^>JfjWMlvU2^Ilc

    literal 7
    Ocmb<-^>JfjWCQ>Qy8&AO
   =20

I think all these cases can use this testcase in t/t4120-apply-popt.sh:

    +test_expect_success 'apply git diff with -p2 and use default name =
from header' '
    +       sed -e "/^\(---\|+++\) / d" patch.file > patch.newheader &&
    +       cp file1.saved file1 &&
    +       git apply -p2 patch.newheader
    +'


=E4=BA=8E 2010=E5=B9=B411=E6=9C=8825=E6=97=A5 09:46, Jiang Xin =E5=86=99=
=E9=81=93:
>=20
> =E4=BA=8E 2010=E5=B9=B411=E6=9C=8825=E6=97=A5 01:20, Junio C Hamano =E5=
=86=99=E9=81=93:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>> When patch file generated against two non-git directories using
>>> 'git diff --binary --no-index' without '--no-prefix', the patch
>>> file has patch level greater then 1, and should be applied with
>>> '-p2' option. But it does not work if there are binary differ
>>> in the patch file, it is because in one case the patch level is
>>> not properly handled.
>>>
>>> Signed-off-by: Jiang Xin <jiangxin@ossxp.com>
>>
>> Can you please add a testcase to protect your fix from getting broke=
n by
>> later changes by other people, perhaps to t/t4120?
>>
>=20
> Yes, I add a testcase in t/t4120, and I will send it as a new PATCH.
> The new testcase is like following:
>=20
> +test_expect_success 'apply git diff with -p2 and use default name fr=
om header' '
> +       sed -e "/^\(---\|+++\) / d" patch.file > patch.newheader &&
> +       cp file1.saved file1 &&
> +       git apply -p2 patch.newheader
> +'
> +
>=20
>> By the way, this codepath is shared by all forms of patches "diff --=
git"
>> header, not just binary.  Do you see a similar breakage with --no-pr=
efix
>> patches that are not binary, and if not why?
>>
>=20
> The breakage will appear under these circumstances:
> * the patch is in git style: header with "diff --git".
> * the header does not contain '--- path/to/old' and '+++ path/to/new'=
=2E
> * has a patch level greater than 1.
>=20
> When I do `git diff` against binary files, I find the patch header do=
es not has
> '--- path/to/old' and '+++ path/to/new'. May be there exist other cas=
es, but
> I'm not sure.
>=20
>>> ---
>>>  builtin/apply.c |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/builtin/apply.c b/builtin/apply.c
>>> index 23c18c5..d603e37 100644
>>> --- a/builtin/apply.c
>>> +++ b/builtin/apply.c
>>> @@ -1126,6 +1126,7 @@ static char *git_header_name(char *line, int =
llen)
>>>  	 * form.
>>>  	 */
>>>  	for (len =3D 0 ; ; len++) {
>>> +		int nslash =3D p_value;
>>>  		switch (name[len]) {
>>>  		default:
>>>  			continue;
>>> @@ -1137,7 +1138,7 @@ static char *git_header_name(char *line, int =
llen)
>>>  				char c =3D *second++;
>>>  				if (c =3D=3D '\n')
>>>  					return NULL;
>>> -				if (c =3D=3D '/')
>>> +				if (c =3D=3D '/' && --nslash <=3D 0)
>>>  					break;
>>>  			}
>>>  			if (second[len] =3D=3D '\n' && !memcmp(name, second, len)) {
>>> --=20
>>> 1.7.3.2.245.g03276.dirty
>=20
>=20
