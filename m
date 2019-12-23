Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF81C2D0C8
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 01:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDED206D3
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 01:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="UV8Xz2OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLWB7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:59:10 -0500
Received: from mr85p00im-ztdg06021101.me.com ([17.58.23.180]:36882 "EHLO
        mr85p00im-ztdg06021101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfLWB7K (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 20:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1577066347; bh=FX3y7KcSArge984O6pdptrbiCyputU8YzyV8FMZ4Az4=;
        h=Content-Type:From:Subject:Date:Message-Id:To;
        b=UV8Xz2OTqtuHZVaVTg1d3q6xAlZXtQ9d0EVKS/+cmBekgFXZ1qHpfutJio3czP/gZ
         1Ul/elopSXXnMir2gip2pRfhfsiSfxh34dckejW21a7XeZkIgCR5aDtpWUYjkQLRoR
         iuG6tYfQ5uA4GxRnUO2DQNZUrbnwMimZArHRBeUFQ8yIvQC0X11COkHqmB0URXT/W/
         RmN+RUPlBlqUU1sK5Q+ScyOavusBje75jQlUcF9MMd/Z9XhDQ5w0Yp6kvUU2SdHNnY
         7K9HbJF9xkY6aTkq8Nft/i3BuiKbXhEyc44u4mqt4jEHRJPO3UqlyzVGVyxA2PsgyC
         n8T+kUqNtGxHg==
Received: from [100.64.174.251] (122-56-197-197.mobile.spark.co.nz [122.56.197.197])
        by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id 85FF334040D;
        Mon, 23 Dec 2019 01:59:07 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Michael Clark <michaeljclark@mac.com>
Mime-Version: 1.0 (1.0)
Subject: Re: NewHash alternatives and SHA benchmarks
Date:   Mon, 23 Dec 2019 14:59:05 +1300
Message-Id: <9279D11D-2BC2-4800-8282-C2219F152269@mac.com>
References: <20191223011306.GF163225@camp.crustytoothpaste.net>
Cc:     git@vger.kernel.org
In-Reply-To: <20191223011306.GF163225@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: iPhone Mail (17C54)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912230015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 23/12/2019, at 2:13 PM, brian m. carlson <sandals@crustytoothpaste.net>=
 wrote:
>=20
> =EF=BB=BFOn 2019-12-22 at 06:41:33, Michael Clark wrote:
>> Recommendations
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> After performing multiple benchmarks and thinking about this for
>> several weeks I have come to the conclusion that SHA512/256 is a
>> very good alternative to SHA256, both from the perspective of its
>> length extension resistance, and performance. It seems that NewHash
>> implementation is some way off so it is not too late to change.
>>=20
>> - Consider SHA512/256 for NewHash
>=20
> This has been discussed extensively on the list.  Git is not in general
> vulnerable to length extension attacks because it hashes the length of
> the object as part of the object header.  This was documented as one of
> the known aspects in the transition plan in
> Documentation/technical/hash-function-transition.txt.
>=20
> We've considered a lot of hash algorithms, including BLAKE2b-256,
> SHA-256, SHA-512/256, SHA-3-256, SHAKE256 with a 256-bit length, and
> others.  This was no doubt controversial, but we discussed the pros and
> cons of many options and this is what we decided.  I will state that
> while our choice was not one of my more preferred options, I value that
> we have a consensus on the way forward.
>=20
> Among the reasons we chose SHA-256 is performance on newer x86-64
> processors with the SHA extensions, which support only SHA-1 and
> SHA-256, and compatibility with a wide variety of cryptographic
> libraries.  I have no desire for Git to provide assembly implementations
> of NewHash, and that means people must rely on existing cryptographic
> libraries.

the SHA extensions that are not generally available, which include SHA1 on t=
he cusp of its deprecation. It seems silly not to support SHA512 when implem=
enting SHA2 support especially considering it=E2=80=99s faster on 64-bit.

It=E2=80=99s used in PBKDF2-SHA512 for iterated password hashes. SHA512/256 i=
s just a different IV.

Don=E2=80=99t be discouraged by my comments. Thanks for taking the time to d=
escribe the state. The rationale of pragmatism should be in the hash migrati=
on plan.

SHA256 will always take more energy than SHA512 which actually means is poss=
ibly slightly weaker, which could be used as a rationale for choosing SHA256=
. I don=E2=80=99t think the other rationale is acceptable though because the=
 choice of purity of choice should lead what goes into hardware.

I want pure hashes of the unpacked object so I will have to think about how I=
 do that. Possibly SHA-3 too. git doesn=E2=80=99t really support large files=
 that well either so I=E2=80=99ll have to keep that in mind... If the algori=
thm is not vulnerable to length extensions, then the length prefix is not re=
quired. Anyhow...

I=E2=80=99ll have to hack up some shell scripts or something in the meantime=
.

> Cryptographic libraries overwhelmingly do not support SHA-512/256.
> While OpenSSL does, it's only in the latest versions, and people
> generally cannot legally distribute both Git and OpenSSL linked
> together, so they must rely on system libraries for good performance.
> Apple Common Crypto, for example, does not document any SHA-512/256
> implementations.
>=20
> There is also a benefit to chaining using a single algorithm for
> signatures, which therefore necessitates using SHA-256 or one of the
> other original SHA-2 algorithms until the next version of OpenPGP is
> implemented which supports SHA-3.
>=20
> Because we decided some time ago, I've sent in a bunch of patches to our
> testsuite to make it work with SHA-256.  Some of these patches are
> general, in that they make the tests generate values which are used, or
> they are specific to the length of the hash algorithm.  Others use
> specific hash values, and changing the hash algorithm will require
> recomputing all of these values.
>=20
> Absent a compelling security reason to abandon SHA-256, such as a
> significant previously unknown cryptographic weakness, I don't plan to
> reimplement all of this work.  Updating our testsuite to work
> successfully with SHA-256 has taken a huge amount of time, and this work
> has been entirely done on my own free time because I want the Git
> project to be successful.  That doesn't even include the contributions
> of others who have reviewed, discussed, and contributed to the current
> work and transition plan.  While I appreciate the benefits of
> alternatives to SHA-256, I'm a bit annoyed that you're proposing to
> throw away all of this work after we explicitly sought to build
> consensus about an algorithm so that this stage of the work could begin.
>=20
> Of course, nothing prevents you from proposing a new algorithm and
> fixing the testsuite to make it work, but I don't believe that we're
> likely to adopt a different algorithm at this point, given the previous
> discussion on the list.  The code is designed to be pluggable to support
> arbitrary algorithms, but there are pieces which assume that the
> algorithm can be distinguished by length (e.g., the dumb HTTP protocol)
> and therefore you'd need to devise a different way to distinguish these
> versions.
>=20
> If you'd like to see what a Git binary that supports multiple hash
> algorithms looks like at the moment, you're welcome to look at my
> transition-stage-4 branch at https://github.com/bk2204/git.git so you
> can get a fuller understanding of what's involved.  You can run the
> testsuite with that code and GIT_TEST_DEFAULT_HASH=3D<hashname> to see
> what passes and fails.

Thanks. I=E2=80=99ll check it out and try it.

My comments aren=E2=80=99t directed at you. I=E2=80=99m interested in your w=
ork. Keep it up. Well, take a break. idk. Whatever. I=E2=80=99ll probably be=
 spending my holidays reading git code, or maybe libgit2 :-p

>> SHA algorithm patches
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> I will be sending a patch series which adds SHA Algorithms which
>> are in the sha-algorithms branch of my git tree.
>>=20
>> - https://github.com/michaeljclark/git.git
>> - https://github.com/michaeljclark/git/tree/sha-algorithms/sha
>>=20
>> This is a precursor to asking some questions about the proposed
>> implementation of multiple or compat hashs (N-hash or 2-hash?).
>> I am curious about the pack format and directory structure for
>> loose objects. It seems there needs to be a single hash chosen
>> for loose object filenames, and auxilliary hashes will need
>> hash to hash map to go from a compat hash to new hash.
>=20
> That's correct.  There's documentation in the transition plan about what
> this will look like.
>=20
> A stage 4 implementation (where repositories are either SHA-1 only or
> SHA-256 only) has been written and I'll send it out once the remaining
> test fixes are merged.
>=20
> I should point out that we specifically chose not to support a plethora
> of algorithms because the goal is to encourage everybody to adopt a
> single, secure algorithm.  The network protocol will need to
> interoperate using a single algorithm, which means the repository will
> need to contain a mapping for that algorithm.  Since the current plan is
> to support no more than two algorithms at a time, one of which will need
> to be SHA-1, allowing users to pick and choose from a variety of
> algorithms harms interoperability.  Seamless interoperability between
> SHA-1 and NewHash repositories was considered extremely important in the
> transition plan.  That won't be coming immediately with the stage 4
> implementation, but it is planned for the future.
>=20
> My hope is that whatever we pick now will be secure for some time to
> come and that when we need to adopt a newer hash, whether due to
> cryptographic advance or post-quantum cryptography, there will be no
> existing SHA-1 repositories and transition can take place from NewHash
> to NewNewHash.
> --=20
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

