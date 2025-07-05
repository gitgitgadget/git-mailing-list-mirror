Received: from 20.mo583.mail-out.ovh.net (20.mo583.mail-out.ovh.net [91.121.55.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1CD2FB
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.55.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751764792; cv=none; b=MQsQW8pNzorSNjf28kKWQvi4XKh+57Ac0kC4s7v89kx666VR71+kuQjZORg2IcVzVvd39uTS8sGiSQEDLROTGIIWm4mqZToz0Xp5OE1TyV6gBRupPF+c9xeTJlnynxKYCpQo5P/kXZ6Mf5y31dGAff+xnq2+2rzI38T6tCiUz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751764792; c=relaxed/simple;
	bh=cIuEi8XH0/jea3QMJUaa7DdxAhMCFOh4KzGqJoC6aO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fCx56n7an3wpGb07rDnQrdz062/d22CGm8xzJ85gZBfsaN4J1E+5v3S8j6MfMSZiICSuoofPCCBJf4VVlX1+6XVpKthjr1Ghrkm+vIzJU86Ullpza/ZHhsjhtpuAXZaEFsTGUOLDjrNIWIV4ClAXjW634jRf+mUyA1WQ/B+A+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=s7s+dxko; arc=none smtp.client-ip=91.121.55.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="s7s+dxko"
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.54.180])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4bZQhb0d6xz5ydb
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 22:50:55 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-774q8 (unknown [10.110.113.83])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 73926100152;
	Sat,  5 Jul 2025 22:50:54 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.96])
	by ghost-submission-5b5ff79f4f-774q8 with ESMTPSA
	id +yQME06saWipHwYAuOgIrg
	(envelope-from <redoste@redoste.xyz>); Sat, 05 Jul 2025 22:50:54 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-96R001fe107187-55d4-4038-8b6d-dda2361cb188,
                    03B360DA9A158DBC4F736A687BEA6D6B8F7DE961) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Jul 2025 00:50:43 +0200
Message-Id: <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>, "Junio C Hamano"
 <gitster@pobox.com>, "Fabian Stelzer" <fs@gigacodes.de>, "Elijah Newren"
 <newren@gmail.com>, "redoste" <redoste@redoste.xyz>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
From: "redoste" <redoste@redoste.xyz>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: aerc 0.20.1
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250705192113.GB2496172@coredump.intra.peff.net>
 <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
In-Reply-To: <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
X-Ovh-Tracer-Id: 12415861226444985749
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -65
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvjedvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfrhgvughoshhtvgdfuceorhgvughoshhtvgesrhgvughoshhtvgdrgiihiieqnecuggftrfgrthhtvghrnheptdetudfhtdejkedtkeffhedtvddvleejfeeihffguddutdeklefgveeuudeguefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpiedvrdefgedrvdegledrfeejpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgvughoshhtvgesrhgvughoshhtvgdrgiihiidpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=PwCCLhn239Nq9bDH7fRVPhjDDc4nCrq4VzCxmuNS9tM=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751755855; v=1;
 b=s7s+dxkoAKTcxtGaN7RVlcEHUGHovDDNphDf/SSXHbJd3UFQAWmvlYTgBobTl9LIdmuPMP31
 eg31GP+8D9MtdyeY/LUrFx0/3wpyP33ryqpG++GUBL6llQHYow64u4qyF0iI6F5Z5BXOwXHJt8w
 pFuheIATSL2wQBI9LzVgCE4qE5a44KWeMMZGyZKCtT/Pe6zboIVixIlY0gCTQp1OeWJsLI/ZtNg
 awIrszVx3vuhGa6da88/Rf2LmUICl/ayCx476yFvNXP6ZtzqDM7di8VtdyfWy4lS5uDN/CQWhVJ
 nLFvddANJVywFssd0utTqaXYlx2s9zkmhfBr/HPtdj/Fw==

On Sat Jul 5, 2025 at 22:07 CEST, brian m. carlson wrote:
> On 2025-07-05 at 19:21:13, Jeff King wrote:
>> I wonder if it is worth adding a test, or if it would be too weirdly
>> focused on this obscure case to be very useful against future
>> regressions.
>
> I don't have a strong view either way, but I do wonder if it's a good
> idea to have the testsuite poking around in `/tmp`, although maybe if we
> honour `TMPDIR` then it would be possible to do in a tidy way.
I looked into adding a test, but I didn't find any other tests checking
for temporary files and I agree that messing in /tmp doesn't feel really
appropriate for the testsuite.

Maybe something like this?

diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f780636..359dc8eba8 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -85,6 +85,7 @@ test_expect_success GPGSSH 'sign commits using literal pu=
blic keys with ssh-agen
	eval $(ssh-agent) &&
	test_when_finished "kill ${SSH_AGENT_PID}" &&
	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
+	export TMPDIR=3D$(pwd) &&
	echo 1 >file && git add file &&
	git commit -a -m rsa-inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
	echo 2 >file &&
@@ -95,7 +96,8 @@ test_expect_success GPGSSH 'sign commits using literal pu=
blic keys with ssh-agen
	git commit -a -m ecdsa-inline -S"key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
	echo 4 >file &&
	test_config user.signingkey "key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
-	git commit -a -m ecdsa-config -S
+	git commit -a -m ecdsa-config -S &&
+	! ls .git_signing_key_tmp*
 '
=20
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with k=
eys having defined lifetimes' '

I can add it in a v2 if you think it's a good way to test it.

> I also have some friends who are trans and have transitioned or are in
> the process of transitioning but have simply not gotten around to
> getting legal paperwork done[1].
This is the exact reason why I'm not very comfortable with using my
legal or real name, (well, it's mostly because I still can't find a name
I like).
And since it's a simple patch that's probably not even copyrightable, I
figured out that using a pseudonym was fine.

Since I knew that the Linux kernel changed their documentation to remove
the use of "real name", I thought it was more common and didn't relly
think about it a lot.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd4563201f33a022fc0353033d9dfeb1606a88330

I'm sorry, I should have read the git documentation more thoroughly.

If it's really an issue I don't mind signing off with a different and
more distinctive name.

--=20
redoste
