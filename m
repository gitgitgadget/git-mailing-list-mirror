Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A738DC8
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140441; cv=none; b=n2soXFGD7ZKN0EwbU6DW5rtGJpZC+WytUxMdPxFE24XQVcordQBdEWY0KIAA2BfOYLPpsYadVoanC/IHkJv4k7K84DbZFoHGQcPB+v0kelf9JQiCUKwXnc80iovHO1xoIe1YMcDStytK71C9E3yYmVz/2uqJDPTSLNCkiIa6axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140441; c=relaxed/simple;
	bh=um0hcDygkRTfZ50yVTmPw1Qel3fsWex6bQY8xjsqVeo=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8BKYdsR3A4vy0+bn7C5fiObfxsixH4mTuSzEvAs1qR7Nhc9OFpaSkyVev/P9Wze97wPCkXUPNhAPfYjb8c+vL5ko0+PkwCcxb6q2U0OKzAkNkfqwwJSJvuprUDmp+LN737TUm8buu3ZbgHXRGoCEOVfAYIcQU3VknCKmFCrmNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45BLDuIm2018550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 21:13:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'David Hillman'" <davidahillman@gmail.com>, <git@vger.kernel.org>
References: <28659397-293f-4706-a0ac-75298673ee30@gmail.com>
In-Reply-To: <28659397-293f-4706-a0ac-75298673ee30@gmail.com>
Subject: RE: Commit throws fatal ownership error without explanation
Date: Tue, 11 Jun 2024 17:13:51 -0400
Organization: Nexbridge Inc.
Message-ID: <112701dabc44$45bc0940$d1341bc0$@nexbridge.com>
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
Thread-Index: AQLfWWgx1jHU88mkYzvRklH6yTaaq6+50uNA
Content-Language: en-ca

On Tuesday, June 11, 2024 4:53 PM, David Hillman wrote:
>Thank you for filling out a Git bug report!
>Please answer the following questions to help us understand your issue.
>
>What did you do before the bug happened? (Steps to reproduce your =
issue)
>
>        Attempted to commit a change.
>
>What did you expect to happen? (Expected behavior)
>
>        Commit should have been applied.
>
>What happened instead? (Actual behavior)
>
>        Git threw a fatal error with the following malformed message, =
which fails to
>identify the file(s) with problematic ownership.
>
>"[master 3e58b1d] Updated sans comment
>1 file changed, 3 insertions(+)
>fatal: detected dubious ownership in repository at =
'/srv/git/projects.git'
>To add an exception for this directory, call:
>
>        git config --global --add safe.directory /srv/git/projects.git
>fatal: Could not read from remote repository.
>
>Please make sure you have the correct access rights and the repository =
exists.  "
>
>
>What's different between what you expected and what actually happened?
>
>        If git throws a fatal error due to improper file ownership, it =
must report the
>offending file(s) so the user can correct the issue.  It is never =
acceptable to die and
>leave behind a mystery as to the cause.
>
>        At an absolute minimum, the error message must report the =
expected
>ownership that was not found, not the vague and useless =
characterization of
>"dubious ownership".  "Dubious ownership" might be fine for a warning, =
but is
>unacceptable for a fatal error.  In other words, this error message =
should be as
>follows:
>
>"fatal: The following files have incorrect ownership.
>
>     file /srv/git/projects.git/example/path/to/file/one.pl is owned by =
user123541,
>should be user434892
>
>     ... [ repeat as necessary ]
>
>"
>
>
>
>
>Anything else you want to add:
>
>Please review the rest of the bug report below.
>You can delete any lines you don't wish to share.
>
>
>[System Info]
>git version:
>git version 2.43.0
>cpu: x86_64
>no commit associated with this build
>sizeof-long: 8
>sizeof-size_t: 8
>shell-path: /bin/sh
>uname: Linux 6.8.0-31-generic #31-Ubuntu SMP PREEMPT_DYNAMIC Sat Apr 20
>00:40:06 UTC 2024 x86_64
>compiler info: gnuc: 13.2
>libc info: glibc: 2.39
>$SHELL (typically, interactive shell): /bin/bash
>
>
>[Enabled Hooks]
>not run from a git repository - no hooks to show

A few things:
1. git allows directories to be shared by multiple users. This is =
helpful when an enhancement is being worked on by a team where a number =
of users are contributing to the same clone at the same time.
2. Git detects that the .git directory (or files inside that directory) =
are not owned by the user performing the command, like git commit. =
That's where the message:
    fatal: detected dubious ownership in repository at =
'/srv/git/projects.git'
    To add an exception for this directory, call:

        git config --global --add safe.directory /srv/git/projects.git
    comes from. This part of the message is considered a fatal error =
because you have not declared that this is a shared repository. Once you =
execute the git config, you should not receive this message.
3. The actual error, in this case, is probably coming from a lack of =
access to more than one file in the .git directory (a.k.a. metadata). =
Rather than reporting all files, the implication is to check the =
security and owner in the .git directory and fix those first. This =
likely results from a user sharing the repository who has an =
incompatible umask (if Linux) or unshared security settings in Windows =
or something else if NFS or other file system.
4. IIRC, in a situation where a file without proper security is in the =
working index (outside .git), I believe git does report an error =
specifying the exact name of the file that caused the problem. In your =
case, there is a high probability that the .git directory (some or all) =
contents are not readable by your user.

Please check the assumptions. I think fixing #2 and #3 should help.
Regards,
Randall

