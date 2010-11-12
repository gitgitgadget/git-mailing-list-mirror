From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] add: do not rely on dtype being NULL behavior
Date: Fri, 12 Nov 2010 08:55:43 +0700
Message-ID: <AANLkTi=Hv_dpP3=2hyXeLZ0KRV-zdunPvCD4whgyYHM_@mail.gmail.com>
References: <1289480602-10545-1-git-send-email-pclouds@gmail.com> <7voc9vhhvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 02:56:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGis9-0000qC-0p
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 02:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392Ab0KLB4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 20:56:06 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40894 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab0KLB4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 20:56:05 -0500
Received: by wyb28 with SMTP id 28so1396183wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 17:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=U0I40nl54yxs1pwnIhOOYRZbR6AxquIp7iLSNAQMeUo=;
        b=NnJEz0n7e2FVd0a/tCP8CLoRsssta+HdrYHIbNEki4N3R9xaP6fU7djPXfe5WFsj3B
         4m4SdtlefbMRGpTTibi/xGENjB0ABeR2xWc6+igGacA2+m4hDozzm9tG6XeyfHUeLNaE
         QABkgxCs3mfCRS/n/CKwY6PzkpjkYYtCaN1A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=D3+Me3ZpnCJGAPIbzVbz62Agz+MOZoQEEA4B3Uh4WxXQmvL3bguSegU2FABCDsMrfL
         E3uF+bZ3m8x6fE9MQcVOZpFU7BKzjGSlYt9lyv2bq0nInsA/IU3OCygxh970RW2zbKgy
         XVare6m8fSyi3Iat98DQlL9IZrnkl+1LWppos=
Received: by 10.216.255.148 with SMTP id j20mr1460749wes.11.1289526963785;
 Thu, 11 Nov 2010 17:56:03 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 11 Nov 2010 17:55:43 -0800 (PST)
In-Reply-To: <7voc9vhhvr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161316>

2010/11/12 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Commit c84de70 (excluded_1(): support exclude files in index -
>> 2009-08-20) added support for excluded() where dtype can be NULL. It
>> was designed specifically for index matching because there was no
>> other way to extract dtype information from index. It did not suppor=
t
>> wildcard matching (for example, "a*/" pattern would fail to match).
>>
>> The code was probably misread when commit 108da0d (git add: Add the
>> "--ignore-missing" option for the dry run - 2010-07-10) was made
>> because DT_UNKNOWN happens to be zero (NULL) too.
>>
>> Do not pass DT_UNKNOWN/NULL to excluded(), instead pass a pointer to=
 a
>> variable that contains DT_UNKNOWN. The real dtype will be extracted
>> from worktree by excluded(), as expected.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0I do not add tests for the "a*/" failure above because I plan
>> =C2=A0to fix it. Expect c84de70 will be reverted "soon" (in my times=
cale)
>> =C2=A0when sparse checkout can pass real dtype.
>>
>> =C2=A0builtin/add.c | =C2=A0 =C2=A03 ++-
>> =C2=A0dir.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A02 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index 56a4e0a..1a4672d 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -446,7 +446,8 @@ int cmd_add(int argc, const char **argv, const c=
har *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!seen[i] && pathspec[i][0]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 && !file_exists(pathspec[i])) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ignore_missing) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (exclude=
d(&dir, pathspec[i], DT_UNKNOWN))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int dtype =3D=
 DT_UNKNOWN;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (exclude=
d(&dir, pathspec[i], &dtype))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dir_add_ignored(&dir, pathspec[i], strlen(pathspec=
[i]));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("pa=
thspec '%s' did not match any files",
>> diff --git a/dir.c b/dir.c
>> index b2dfb69..c4bed66 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -359,7 +359,7 @@ int excluded_from_list(const char *pathname,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int to_exclude =3D x->to_exclude;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (x->flags & EXC_FLAG_MUSTBEDIR) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dtype) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dtype !=3D NULL) {
>
> Hmm, are you sure about this part?

Don't write code when you feel asleep. No, that was wrong.
--=20
Duy
