Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AED1CABB
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331970; cv=none; b=Y6zNlYIpUWepOjzlO3TnxN0099vEq26Y3XZYIUqSIPPzp+Bptqh7ITDXk5q0q/6x+DOScAbIp2fKpypo+QMazwV8JMs6otN2WzfpuiZoIANtjBGNUBUiIF8ta7gwzMJaVsK4naNfQrrJyiYC0A4161FV4jHs+5N8+ZK3oXt72bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331970; c=relaxed/simple;
	bh=tQ/CiUjIlzAuS48z4MQwoAodRTXfNDR9C99eGJWo5cA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdX8hC0L9qOqMYhkajC0mfGfeOofiwObEiJcsyDr8J5dFK4sjOueTGYUNaFoZBbdMjT5xdqM+vh8TDcSQK/bW0o+oguwxvWdURuTQ0uqE23D/VTEVIJE+KHsSiiRFUhv6LSp3WJa9iDVfZQAyWlYcLk8VYEvcM7jKo5MV53bVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=c5sGoxAS; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c5sGoxAS"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AAECC37E80;
	Tue, 25 Jun 2024 12:12:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tQ/CiUjIlzAu
	S48z4MQwoAodRTXfNDR9C99eGJWo5cA=; b=c5sGoxASHZLGW33PJP3JoPY+lpiN
	HhIp1xfZDoxGWOnot9nTNIDKG0FrGHSO7hjqueattIdO3H4VBEyzgYB/C0E2Mgxd
	yJ+Dzs785I9br4+MfxhU9T44rZvcJpfVxM4i8eKyBbIzNBMA09t7UMnszdpTk3fw
	RFa7VVFBTh88FIs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A447637E7F;
	Tue, 25 Jun 2024 12:12:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 442A737E7E;
	Tue, 25 Jun 2024 12:12:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, "David C. Rankin"
 <drankinatty@gmail.com>,  git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
In-Reply-To: <20240625072419.GU19642@kitsune.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
	message of "Tue, 25 Jun 2024 09:24:19 +0200")
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
	<xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
	<20240625072419.GU19642@kitsune.suse.cz>
Date: Tue, 25 Jun 2024 09:12:38 -0700
Message-ID: <xmqqr0cl6lxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BEF30454-330D-11EF-864B-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Dscho, the f4aa8c8b (fetch/clone: detect dubious ownership of local
repositories, 2024-04-10) is your brainchild and people seem to be
unhappy about having to adjust their settings.  Are there any advice
you can offer them?

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Mon, Jun 17, 2024 at 11:15:13PM +0200, Michal Such=C3=A1nek wrote:
>> Hello,
>>=20
>> On Mon, Jun 17, 2024 at 11:47:20AM -0700, Junio C Hamano wrote:
>> > "David C. Rankin" <drankinatty@gmail.com> writes:
>> >=20
>> > >   Security enhancement in 2.45.1 have broken ability to serve git =
over
>> > >   https and ssh from local git server running Apache. (web server =
runs
>> > >   as http:http on Archlinux)
>> > >
>> > >   The fix of adding the following to gitconfig (system-wide and
>> > >   per-user in ~/.gitconfig) does not solve the problem:
>> > >
>> > > [safe]
>> > > 	directory =3D *
>> >=20
>> > It is not clear what you exactly meant "per-user" above, so just to
>> > make sure.  Is this set in the global configuration file for the
>> > httpd (or whoever Apache runs as) user?
>> >=20
>> > The purpose of "dubious ownershop" thing is to protect the user who
>> > runs Git from random repositories' with potentially malicious hooks
>> > and configuration files, so the user being protected (in this case,
>> > whoever Apache runs as) needs to declare "I trust these
>> > repositories" in its ~/.gitconfig file.  What individual owners of
>> > /srv/my-repo.git/ project has in their ~/.gitconfig file does not
>> > matter when deciding if Apache trusts these repositories.
>>=20
>>=20
>> looks like the semantic of 'dubious ownershop' changed recently.
>>=20
>> Disro backport of fixes for CVE-2024-32002 CVE-2024-32004 CVE-2024-320=
20
>> CVE-2024-32021 CVE-2024-32465 to 2.35.3 broke git-daemon. No amount of
>> whitelisting makes the 'fixed' git serve the repository.
>
> Same regression between 2.45.0 and 2.45.2 which allegedly fixes the
> same CVEs.
>
> Looks like downgrading to gaping hole version is needed to serve reposi=
tories
> in general.
>
> Please consider adjusting the fix so that repositories can still be ser=
ved.
>
> Thanks
>
> Michal
>
> To reproduce:
>
> cat /usr/local/bin/git-ping
> #!/bin/sh -e
>
> # Try connecting to one or more remote repository URLs
>
> while true ; do
>         git ls-remote -h "$1" >/dev/null
>         shift
>         [ -n "$1" ] || break
> done
>
> mkdir -p /srv/git/some
> chown hramrach /srv/git/some
> su hramrach -c "git init --bare /srv/git/some/repo.git"
> su hramrach -c "touch /srv/git/some/repo.git/git-daemon-export-ok"
> version=3D2.35.3-150300.10.36.1 ; zypper in --oldpackage git-core-$vers=
ion git-daemon-$version
> systemctl start git-daemon.service
> git ping git://localhost/some/repo.git
> <nothing>
>
> version=3D2.35.3-150300.10.39.1 ; zypper in --oldpackage git-core-$vers=
ion git-daemon-$version
> systemctl restart git-daemon.service
> git ping git://localhost/some/repo.git
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
>
>
> systemctl status git-daemon.service
> =E2=97=8F git-daemon.service - Git Daemon
>      Loaded: loaded (/usr/lib/systemd/system/git-daemon.service; disabl=
ed; vendor preset: disabled)
>      Active: active (running) since Thu 2024-06-06 08:29:28 CEST; 6min =
ago
>    Main PID: 31742 (git)
>       Tasks: 2 (limit: 4915)
>      CGroup: /system.slice/git-daemon.service
>              =E2=94=9C=E2=94=80 31742 git daemon --reuseaddr --base-pat=
h=3D/srv/git/ --user=3Dgit-daemon --group=3Dnogroup
>              =E2=94=94=E2=94=80 31749 /usr/lib/git/git-daemon --reusead=
dr --base-path=3D/srv/git/ --user=3Dgit-daemon --group=3Dnogroup
>
> Jun 06 08:29:28 localhost.localdomain systemd[1]: Started Git Daemon.
> Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: fatal: detecte=
d dubious ownership in repository at '/srv/git//some/repo.git'
> Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: To add an exce=
ption for this directory, call:
> Jun 06 08:29:39 localhost.localdomain git-daemon[31756]:         git co=
nfig --global --add safe.directory /srv/git//some/repo.git
>
> git config --global --add safe.directory /srv/git//some/repo.git
> mv ~/.gitconfig /etc/gitconfig
> git ping git://localhost/some/repo.git
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
>
> git config --global --add safe.directory /srv/git/some/repo.git
> mv ~/.gitconfig /etc/gitconfig
> git ping git://localhost/some/repo.git
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
