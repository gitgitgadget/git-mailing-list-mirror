Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6531E502
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104232; cv=none; b=mSFi5Gko71geTUztenr4exTcMG0bxybVATkyD1fX4DMwSQwWVaWZ7+W9t2gqZ3IQun9MrCKHC1QnUQCUqztvESDU/4aEGJGFQPzjqgTDew0cyqp2Le15W1v06JuGlGeKk34WkwU5Pfon6TkLg2Xwvvz8dF9xbGaJnuiXlzoks1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104232; c=relaxed/simple;
	bh=grZXCO/hy6l4xJxI/turfMcsB+KXiq9G3gqgS5Atlzw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=mmfSHDLzOhPHxS58+yjEHVBqD8o+9laSOaMtRkWg6lrXrBwG0cIKQe0zBUqebzHfEFvm4qlf8yjXIkwwVsbL10GpgYD0J1wyfhvT8qucBP+nqQtvYPsY9RBCy8QK3TNZO5pdGmfvVfmOhZvpx3G7OPQUss6FDpbnGDvhjAC95FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=PgQitvP3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="PgQitvP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739104227; x=1739709027; i=ps.report@gmx.net;
	bh=48WFdHWqGiIRk2pHXDPgeJ3BlXII3q9Y7grnmJJzBFU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PgQitvP30NEjh36dK101w0GUXvcRiynYL1oYSJjWq8vgXKQiimoWR0uyrAKuhMZg
	 Vs1wVFdx2+2QRVO50cr4CP0mCubru7BVA1I2lLglsLzFFm2YwOAZxOUObmEO93zkT
	 FZLHXY/nmUjU9JUdrCbg6Jh09UvVvGKHLv+92vpsYnr2lco8Ro2ezslP9WrGriSl/
	 IuFvKWmA6ZMCeZhbu9HYZkUmxAzEXjxakZximS9g7UBTXgOp3zlZ1V+XyzqOQhL+o
	 QRFGi58g9dZJqlLoAJ608mG+MsCRdDUfa33sOiYtLcmA+KYpOuEvO/q59guxlaT2B
	 K7NwrnKx39USYY/FXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1tXE1H3GSy-00FwbH for
 <git@vger.kernel.org>; Sun, 09 Feb 2025 13:30:27 +0100
Date: Sun, 9 Feb 2025 13:30:27 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: git@vger.kernel.org
Subject: Meson build leaks host 'sh' path to target build when
 cross-compiled
Message-ID: <20250209133027.64a865aa@gmx.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aXJTU9du4qmQ5bwT/OxKz8kLv9Fh1lpFzAp7JeG86VGrdFuojrw
 NQUOTF2qqEc2T1h0mBsuTTi6j1SZ3ISTAo+7zvePGto0rZaK64tHLKzhpW+RXN0wTUFzACT
 aocXGIYlSOqLeOHK8wpP+ZaoXPsgfmLS5JA0Yn+l3MfLxL8b7BuYXUg0grvhDDS16ecuKEW
 8kInKnC8KSblHqHRn0YBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ppn4wdd4r0c=;E2CI/UHCXu06LPWRbHf3fS/RzCy
 JlwK84mS2s/RY+3Ddq9V4N7QBZCLqOFf2o8zHB1ON5qPKPyQWj0aKPwnZ0vnZiUt8gfFSEL1C
 KDcxzJhzaBEX1bHqxymj8mLlce7chb4rmf0HUEwc8LBlOVDknCdWWIh3HSnSwpoV0tZYXftVw
 AUlcu4FQT9m04DXpqtAmRiunxW+a5xCbcQQFATVmY3fsMee3qBITwnvF8TArssBKILB8icnTO
 rw2otVbziuZlez4wgAfbpA3tE3bfsAZp7cnO64DpfwY1zDEPuCifAmcM4kKPCMJVExsMJUFFd
 M+xBh8S3OUdhbAF6ms6sMSzLEXRNXwBsYNJY4inUowhxcoDuoYlEuUfbTBznEjjmP/KL+1N+Y
 +vSjQCzuuQhD7vJhrJXOIMjvPhOcOeZJNIosQpNan1LTB58KfrDoCJGNiwpKxn2D5OGygRYCJ
 B/X+2NaGqr/dSvFHAQ3HukfZ1DST458VTFWJg8sWAdVHQmbqNzQ7aUmCyL3u1GN1Jt3APPhLg
 AQ55dD/uz/XnQTik6OOWFjCA/tIYK35uYfgJaVkBhkhOtn/An9ZuQoBox3VDoMNzjdZjHTGj7
 RUaUhrCcH4oOeDFvv1r3TkoEpPYSnWA2m2/mh+T6WwbTo5rSg+8JXVGuJX5ZywTpfmPuOaLHb
 uLeUszd+aBeapqqCFQVIewFGx8ZamhT1ou/9TZH21XGcYmVx5JbDrMUI33Z0gYAtKOgGe4Cwy
 f/acIh3lY7Ct41LQ4idQJ8QS14sBk4irmp+T/aw69xncN/bEL7Xbi+FIBs0vFsDrD11feOK7i
 BA8v2zi5suLulUzM9r1AKx/K04/tr7J4DfRYwo0UT6WY8zRLxLdMXN2Xx4TxqiRPFx8tvxirI
 UU2mkPh1TjPt7bkFN5U9YKmAGxwoTkTbw7lsaP7zjsPKpZPuIC1B9qbNKYxvarvEAfcfxGrjS
 KcZLtXVZCHsIPK07Fbg/cucHcpYcj2XzQ/3OHobo4DUdjLhAbbrwIQSlWI7fcTT72z4TDBTLM
 RJFWwyXmLTOOSbfEoitKO3AoFsYg/zv1VLjJk/wIG7yzF9q4LQFpRHFe9mKHvjPLtCCmESrVJ
 hmPtK7hqmP2lgVvRFRmqCHshjms7yzPhz2qS5Jowru1LRvLEGhcJmUZbZnNbr9cdoWpdx6ruJ
 i2VknWOIz+aIIzxddZ2obGoO/9aV4aIbgBqHBCFOgz3X08rgWzjU3W1hiljkX0DMZmiQw6Mln
 Pdl6tvmXiFkkegABXcfjv6hr6USus3PHDFdvrZM6SsqVcquhHc5QP2OGnbfJlVnGUcBPndCSb
 avsBUYHoNoct9SAehT/x8sxBWD1kXG/2w1XMywHNy+XxM5b9g+MLtsCo2Yvl9NB6zIJATCR9z
 Jh9QaRMiQUqiAbNl3hSaJlb+fJLBtyKG/yRRWpudQy+BrupYFC5tIxcMhr

What did you do before the bug happened? (Steps to reproduce your issue)

  Cross compile git from source (git-2.48.1) using the meson build system
  (Buildroot package experimental converted from autoconf to meson).

What did you expect to happen? (Expected behavior)

  Execute command 'git fetch' on the target without failure.

What happened instead? (Actual behavior)

  Command 'git fetch' on the target failed.

What's different between what you expected and what actually happened?

  Debug with strace showed the following difference:

  - o.k (autoconf):

    679   execve("/bin/sh", ["/bin/sh", "-c", "git-upload-pack '/home/git-repo"..., "git-upload-pack '/home/git-repo"...], 0x55c342ce4420 /* 17 vars */ <unfinished ...>

  - failure (meson build):

    6861  execve("/usr/bin/sh", ["/usr/bin/sh", "-c", "git-upload-pack '/home/git-repo"..., "git-upload-pack '/home/git-repo"...], 0x5639ab382210 /* 17 vars */) = -1 ENOENT (No such file or directory)

  The meson build tries to execute the non-existent '/usr/bin/sh' (instead of
  '/bin/sh' as the autoconf build), 'which sh' on the host returns
  '/usr/bin/sh'...

  From meson.build

   [...]
   186 shell = find_program('sh', dirs: program_path)
   [...]
   685   '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',

  Do not use the result of 'find_program('sh',...)' for '-DSHELL_PATH='
  (at least not for cross-compile), use fix '/bin/sh' instead or make it
  configurable via a meson option?

Regards,
Peter


[System Info]
git version:
git version 2.48.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.11.1
OpenSSL: OpenSSL 3.2.3 3 Sep 2024
zlib: 1.3.1
uname: Linux 6.13.1-1-default #1 SMP PREEMPT_DYNAMIC Mon Feb  3 05:33:25 UTC 2025 (1918d13) x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
