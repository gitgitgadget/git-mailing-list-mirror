Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100EE22D4F7
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429386; cv=none; b=qupJb0rZDmFUlgkjeLZQ1Ik7fCCkXSvcxT+WEdF8+iHhQbZMCeh9WmSnO0XvinSxSOOCjBNB5TvyVqjfVsXSgDbKIjvZB/AiCZbRh+o9wdaDw+5tj5/VNUv4bU7sxfSQf3/Uf6biAC0LKFDs31oNuofNBu8K0SFMtCSHCBAKuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429386; c=relaxed/simple;
	bh=AlOEhmvJ3AwEaWQ0db9p40LsV7XhM9Vr0oeUMYSZ2I8=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:To:
	 References:In-reply-to; b=qO1ajuCrF8qs8QOUC+q9nLo+XbPI9/WxaYVCbYDB6ErUI7qJTfpQ66DzouhQck/PGeTa53Q8CQ6gxBTHQVv7cyhg7YZewCedYMah5+NbvZzutWSeb5Fhmms86n2LvC8pVpU4TKAVaXiQPsXT/m7puJBgpLI/F2vQA3oNCF4GQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=bXh0gzp/; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="bXh0gzp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=v4TViSmnFq1i4b8UciL6YJ1HRkAJHuMkm2cHbwNU2Hc=;
 b=bXh0gzp/2e2/z9gmj1HhVeuZfrlag3xW7BMK4d9jwswQql1jxlS8Ra/EFvuwq+YyliqAxAlm6SZY
   sEMbTgjm8ssKEnwtS+fGzMeBJyYHCwEA97vlPY/SLArxzRLajUDFXvvAU0r9RNLKkVhd2hijSirD
   TR/zHb7Nq8GJK/XOkFYIEECucvW+/E1Mw4dxa893V/5+EhzWjuozMMJTHKFR/X3f72efRI7EEkov
   d8Z+Y2i9OXZB2ezkg13LrukGAF+XYduR0NHX76qfINswuPtmiVyGQ8gLo8aEYuHL1AeGfR5pkkJX
   YQo5utCf8QIaypslc1jgzvPqsEcea/iGrkaRAw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO100OCWEO4L8A0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 05 Dec 2024 20:09:40 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 05 Dec 2024 21:09:06 +0100
Message-id: <D641F472LOV5.223NEPZXKIL4Q@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v15 09/10] fetch: set remote/HEAD if it does not exist
To: "Josh Steadmon" <steadmon@google.com>, <git@vger.kernel.org>,
 <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
 <jonathantanmy@google.com>
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
 <20241122123138.66960-10-bence@ferdinandy.com>
 <wmu5ld4xsfjz2tpp54jmxqroma423t5nn2jh3q5gq2wswr6fkm@vrlhigyuxfzu>
 <444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w7o4pf@4fngcyfmvfcp>
In-reply-to: <444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w7o4pf@4fngcyfmvfcp>
Reporting-Meta:
 AAF4Lzxwz18C28KRgGM9sc33GIQnG8/blug4yQAfot+f6isX8jFRDgKSKxrWkSDG
 NpyfGRi9a4OleIlgtv6qK8tNr0Wkp8+VOTlQpAZwSiNBiN6rFs3eanL8eBtRufdo
 Rinz9wq6H37yeyDM8I1ut4+HBvyTcw559BxyQ0oKClaQts6lYDehGqj21Y22yhXI
 pYi8MpZP5HIyqt0Lt62fzNqycfBi+Bai/0vHdn05mWaNGF7x2ZL3/b2wDddtVbrh
 5kGiAdtyfooKFoBhB8JcqyRL5H5DRvjnKoNMwajxBzdSy15t5kty1xpC5+/oDMH5
 zKsLA8E8WX7G7aMytuJutAsZFZPd0aKdilC+3R2mbPRLG2rZkhQF6KhP3dQo/4IE
 yH1vH4NXuAE+H5rFNa4jyPBDSma3doguJryB/4C+ciilgwvDqGHxMWDVpfPpe1R0
 B7U9tXJzdn9mwVENHmQaFpx15LOFM/Gii7YvrQe8Nmp3tXJ8/PiQ3K+7


On Thu Dec 05, 2024 at 20:50, Josh Steadmon <steadmon@google.com> wrote:
> On 2024.12.05 10:58, Josh Steadmon wrote:
>> On 2024.11.22 13:28, Bence Ferdinandy wrote:
>> > When cloning a repository remote/HEAD is created, but when the user
>> > creates a repository with git init, and later adds a remote, remote/HE=
AD
>> > is only created if the user explicitly runs a variant of "remote
>> > set-head". Attempt to set remote/HEAD during fetch, if the user does n=
ot
>> > have it already set. Silently ignore any errors.
>> >=20
>> > Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
>>=20
>> At $DAYJOB, we noticed that this breaks `git fetch --tags`, although I
>> haven't had a chance to figure out what causes the error just yet.
>>=20
>> I was able to bisect down to this commit using Jonathan Tan's
>> reproduction script:
>>=20
>> rm -rf test_tag_1 test_tag_2
>> GIT=3D~/git/bin-wrappers/git
>> mkdir test_tag_1 && cd test_tag_1
>> REMOTE=3D$(pwd)
>> $GIT init .
>> touch foo.txt
>> $GIT add foo.txt
>> $GIT commit foo.txt -m "commit one"
>> $GIT tag foo
>> cd ..
>> mkdir test_tag_2 && cd test_tag_2
>> $GIT init .
>> echo fetch --tags
>> $GIT fetch --tags "file://$REMOTE"
>> echo regular fetch
>> $GIT fetch "file://$REMOTE" 'refs/tags/*:refs/tags/*'
>> $GIT --version
>>=20
>>=20
>> Prior to this change, the first `$GIT fetch --tags "file://$REMOTE"`
>> fetches the `foo` tag; with this change, it does not.
>
>
> FWIW, moving this:
>
> @@ -1643,6 +1703,8 @@ static int do_fetch(struct transport *transport,
>                                     "refs/tags/");
>         }
>
> +       strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +
>
> to just above the prior `if` block fixes our issue and doesn't break any
> tests. However, I'm not sure yet why the order of ref_prefixes should
> matter here.

Thanks for looking into this! I think the issue is with=20

 $GIT fetch --tags "file://$REMOTE"

instead of adding a proper remote. Tbh, I've never seen the above syntax be=
fore, so first I just ran your script, which reproduced the issue for me, b=
ut then I modified it to use a proper remote which works as expected:

rm -rf test_tag_1 test_tag_2
GIT=3D~/git/bin-wrappers/git
mkdir test_tag_1 && cd test_tag_1
REMOTE=3D$(pwd)
$GIT init .
touch foo.txt
$GIT add foo.txt
$GIT commit foo.txt -m "commit one"
$GIT tag foo
cd ..
mkdir test_tag_2 && cd test_tag_2
$GIT init .
$GIT remote add origin $REMOTE
echo fetch --tags
$GIT fetch origin --tags=20
echo regular fetch
$GIT fetch origin 'refs/tags/*:refs/tags/*'
$GIT --version

So I'm assuming this is why also the tests never caught this, since probabl=
y
all of them are using `git remote add`.

