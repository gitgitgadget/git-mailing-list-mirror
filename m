Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3E224D6
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813620; cv=none; b=Ffjqdf2PYyl7nu7aClfT/HVRCzDICAcq2jMQLLTmyE6JRszbyVUmzmduNGg22YrKDzQJCjl44qeVRRD0ibPTuxGf/RjheOvAtaqmcHmnlCh9cJahbBCq0pEgBAD9zDr2r4c1pgpGtiyIs9CCQSepI8hC7KQiEssh2NnCjEm9CZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813620; c=relaxed/simple;
	bh=8S38K/ykidft9/C/I90iFiRWcXQWkB0/DIld/vKsbNs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=D9ko+M8zMadlACD7wD2R7SAW8iHYuHvNekM+GGrWcHY5lt6Ahpht8UiOMXmtwp33R9s3o95cwsg8NYSRy0NLrJkiFZQTYHEcWESeqC2FQjJDbUdPRYeBiyL9qBLH4+oQvepJ6GdMdepBfgVx6Tk7j40jCJsIoO2OcRK70JcMCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46CJkjM54146033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 19:46:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Emily Shaffer'" <nasamuffin@google.com>
Cc: "'Emily Shaffer'" <emilyshaffer@google.com>, <git@vger.kernel.org>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20240709225042.2005233-1-emilyshaffer@google.com> <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net> <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com> <ZpBbgXYQlpHZa3xR@tapette.crustytoothpaste.net> <CAJoAoZn+R3qhoVA=av8NMcCAJyRHOe6QTXV=pyjs80JmV0mVzw@mail.gmail.com> <ZpGFHWZTWAQUXGCe@tapette.crustytoothpaste.net>
In-Reply-To: <ZpGFHWZTWAQUXGCe@tapette.crustytoothpaste.net>
Subject: RE: [PATCH] Documentation: add platform support policy
Date: Fri, 12 Jul 2024 15:46:40 -0400
Organization: Nexbridge Inc.
Message-ID: <01b101dad494$3ad61d50$b08257f0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLOJF488y2+/PGZbbSRsjvDFvsFqgHGsZGHAOpA7/wCL7BPKQKzK0piAcfeU7OvwgCXkA==
Content-Language: en-ca

On Friday, July 12, 2024 3:34 PM, brian m. carlson wrote:
>Subject: Re: [PATCH] Documentation: add platform support policy
>
>On 2024-07-11 at 23:15:35, Emily Shaffer wrote:
>> On Thu, Jul 11, 2024 at 3:24=E2=80=AFPM brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > Some older OSes require kernel features that aren't compiled in by
>> > default, so containers are out.  For example, CentOS 6 won't run on
>> > a modern kernel because it lacks whatever the predecessor to the
>> > vDSO was (which can be recompiled into the kernel, but nobody does =
that).
>>
>> Is this hinting that we should mention a minimum kernel version for
>> Linux-kernel-based OSes?
>
>This is actually a feature that still exists in the kernel and could be =
enabled for newer
>kernels, but because distros don't use it (they use the vDSO instead), =
they don't
>compile it in.
>
>I'm not sure a minimum kernel version is helpful, because most of the =
LTS distro
>kernels backport features, like Red Hat backported getrandom for =
example.  In the
>interests of getting to a useful agreement, I think for now we should =
just punt on
>this and having a 10 year lifespan will probably do the trick, and we =
can determine
>in the future if we need to apply more stringent measures.

When looking at the "exotics", many have their own kernel lifespans. =
When worrying about NonStop, for example, the Kernel version stays =
around about 5 years under full support, then goes another few until =
retired. I think it is important for people to know the compatible =
versions of the kernel builds have. I do track those for the platform.

>> > We also don't really want to be on the hook for trying to support
>> > OSes Ubuntu is still derived from Debian.  It is likely that things
>> > which work in one will work in another, but not guaranteed.
>> >
>> > I mention Debian is because it has a large variety of supported
>> > architectures.  I absolutely don't want to say, "Oh, you have MIPS
>> > hardware, too bad if Git doesn't work for you."  (I assure you the
>> > distro maintainers will be displeased if we break Git on less =
common
>> > architectures, as will I.)  In fact, MIPS is an architecture that
>> > requires natural alignment and can be big-endian, so it's very
>> > useful in helping us find places we wrote invalid or unportable C.
>> >
>> > The reason I'm very hesitant to require that we run everything in
>> > GitHub Actions because it only supports two architectures.  ARM64
>> > and RISC-V are really popular, and I can tell you that running even
>> > a Linux container in emulation is really quite slow.  I do it for =
my
>> > projects, but Git LFS only builds one set of non-x86 packages (the
>> > latest Debian) because emulation is far too slow to build the =
normal
>> > suite of five or six packages.
>>
>> Does that restriction apply to just GitHub-hosted runners, though?
>> Would it be possible for an interested party to set up self-hosted
>> runners (configured via GH Actions) that are using AMD or POWER or
>> whatever? (For example, I think it would be quite feasible for Google
>> to donate some compute for this, though no promises).
>
>Self-hosted runners on public code are very hard to secure.  You're =
basically letting
>arbitrary people on the Internet run code on those machines and make =
outgoing
>network connections (due to the fact that you can push whatever into a =
PR
>branch), with all of the potential for abuse that that involves (and as =
my colleagues
>can tell you, there's a whole lot of it).  GitHub has taken extensive =
pains to secure
>GitHub Actions runners in the cloud, and while we use self-hosted =
runners for some
>internal projects, they are absolutely not allowed for any public =
project for that
>reason.

I'm not sure this applies to some of the exotics. NonStop cannot run the =
Google CI code. While we could, in theory, connect to via SSH to run =
builds, my system is behind a VPN/Firewall, which would make the builds =
impossible. I do build using Jenkins based on an SCM poll. It's not =
perfect and some tests do not run correctly in Jenkins but do outside. I =
would like to provide the feedback to the git team, somehow, on what =
built successfully or not, outside of the mailing list.

>I would be delighted if Google were willing to do that, but I think =
you're going to
>need help from teams like Google Cloud who are going to be used to =
dealing with
>abuse at scale, like cryptocurrency miners and such.  Unfortunately, =
there are many
>people who act in a less than lovely way and will exploit whatever they =
can to make
>a buck.
>
>I will also note that the official Actions runner is in C# and only =
runs on a handful of
>platforms due to the lack of portability of C#.  (It might =
theoretically run on Mono,
>which would increase its portability, but I must profess my complete =
ignorance on
>anything about that code.) I also know of an unofficial one in Go[0], =
which I'm for
>obvious reasons unable to endorse, encourage, or speak about =
authoritatively in
>any way, but that would still exclude some platforms and architectures =
which don't
>support Go.

We don't have C# or Go, nor are likely to any time soon, so that is a =
problem.=20

>
>> The appeal is not "because GitHub Actions are great!" for me - the
>> appeal is "because most Git developers run the CI this way if they
>> remember to or use GGG, and Junio runs it on `seen` all the time". If
>> there's some other recommendation for self-service CI runs that don't
>> need some careful reminding or secret knowledge to run, I'm happy =
with
>> that too. (For example, if someone wants to set up some bot that =
looks
>> for new [PATCH]-shaped emails, applies, builds, runs tests, and mails
>> test results to the author after run, that would fit into the spirit
>> of this point, although that sounds like a lot of setup to me.)
>
>Yeah, I understand what you're going for.  If there were some super =
easy way to get
>everything running in an automatic CI, I'm all for it.  I think CI is =
the easiest way to
>make sure we don't break anything.
>
>I think it's worth trying to get CI set up for whatever we can, and if =
CI is a possibility
>somewhere, it becomes a lot easier to say yes.
>
>> Should have a reroll in the next 30min, it was ready to go and then I
>> got this mail :)
>
>Sounds good.  I don't think anything in this email should affect that =
reroll.
>
>[0] https://github.com/ChristopherHX/github-act-runner
>--
>brian m. carlson (they/them or he/him)
>Toronto, Ontario, CA

--Randall

