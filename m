Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57F3D5236
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946256; cv=none; b=e8IhgxLdurzmL2ktllDVMjNIJ8ymBl4h0NP2tTXpsM8Mu0wMDm661m0IYwFGVN3uvVRNM5NemCLWtO4/k45zUAYPBOuvuZsT7LTQT7jzQFyy1CahygC1jrAJILEjhbzkup/Wl2aU7lB7fYZUn5x2PdIE0wk4mfxaffZh2JMP3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946256; c=relaxed/simple;
	bh=TH/0V3FntyTKazyYXQpBVmm6Ph58A/OAUWfKlsuKVQA=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Opo/19G7QkmUqxPkDXjS3Ij/qQawPCOaIFkPLBPJWqkfWWYrBfAPA0cTUjcKKGQoWvHsjcIpUwR/aaRblFAm/h1FNcdCZBU9hqiy4lSpzuY7wjlqpiZvFiw5d5PhpnnsTCh2Jnu080wRipS7OlV2XSJetBnqrN+Tsz91kW8vNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 60KLvPhL2030651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 21:57:26 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Chris Packham'" <judge.packham@gmail.com>, "'GIT'" <git@vger.kernel.org>
References: <CAFOYHZDnXQOcDmzwf1WRpZpNRAs-R2YOBh3ru0mr0ffrMLB=9Q@mail.gmail.com> <CAFOYHZDcFJBiZwmposZVGmymmRz1XOaXP8iCRgTDVcsWPTH=6g@mail.gmail.com>
In-Reply-To: <CAFOYHZDcFJBiZwmposZVGmymmRz1XOaXP8iCRgTDVcsWPTH=6g@mail.gmail.com>
Subject: RE: Detecting source of a push in a pre-receive hook
Date: Tue, 20 Jan 2026 16:57:20 -0500
Organization: Nexbridge Inc.
Message-ID: <00ce01dc8a57$c3e19140$4ba4b3c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJNbMQYliBXGo20g0REne6mBkIZjQFwt1sPtG5OmQA=
X-Antivirus: Norton (VPS 260120-4, 1/20/2026), Outbound message
X-Antivirus-Status: Clean

On January 20, 2026 3:46 PM, Chris Packham wrote:
>At $dayjob we're moving from a mix of plain git repositories on a =
server accessed via
>ssh with a secondary Gerrit server tacked on the side for code review =
to using the
>Gerrit server as the primary source of truth.
>
>So that people don't have to update origin.url for all their local =
repositories, we're
>using the Gerrit replication plugin to keep the old server in sync (and =
will likely do so
>for the foreseeable future).
>We have installed a pre-receive hook for the migrated repositories on =
the old server
>that rejects pushes from anyone except the user that the replication =
runs as.
>
>For various reasons we also have a CI system that pushes some things =
(mostly tags
>but some automated merge commits as well) that runs as the same user. =
We'd
>really like to be able to have the pre-receive hook reject pushes from =
the CI system
>but allow them from the Gerrit server. Does the pre-receive hook have =
any way of
>knowing the source of a push operation?

Let me first say that I have not tried this, but had a similar request =
on an exotic
platform. Let me then say that the next paragraph contains likely very =
bad ideas.

You *might* be able to as the OS what the end point is for stdin to your =
hook. I
am in no way certain that git passes the originating pipe to you, but =
some systems
may allow this. Some other systems allow you to walk though process =
context
given the originating pipe, but that's probably less likely to work. =
Other OS
environments allow you to install hooks into the OS to track pipe =
operations.
If any of this even slightly works, it is highly unlikely to be =
portable.

Perhaps a better way (more reliable, easier, portable) is to use a =
firewall to
block the requests from the CI system to a specific port your git =
subsystem
is listening on.

My $0.0002 thoughts,
Randall

