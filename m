Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4266CDCF
	for <git@vger.kernel.org>; Tue, 21 May 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281222; cv=none; b=MHbP/2izPfN85RllprA6vgCCF+jEEYZ9ZPHw1CS/2QaNKa9Rb/0hhllCf+5qLIUAcUqmj6h/lphWYSWhFqwAuX4tf7V/NEnY1509mMkVp9IiBKfXq9RRLOq5dp0Z4CvZS3mcVMZSO+IL3f5HB/gWEI8sk4cmffuF6aWRWXckaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281222; c=relaxed/simple;
	bh=0Xw8A5sF8VI+VKAlZsLb3dMgqnKAKaDIYr4P1CtWEDE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Hp4QHbkX3zNdEAMCHqj3568OupJod8180QRkDETjcf9J6iLLcdY7R7foded19+F27fR5fFfdSz/a4Tgmjpt0zLOXUwDW1gRylstbdnoenZhKbEreEzpfmbH8kRwio1QCkrIl9KbohRQUjlR3dRnLvk29rTP5JUHa1vMTbqEvZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=dYMUqL+U; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="dYMUqL+U"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=0Xw8A5sF8VI+
	VKAlZsLb3dMgqnKAKaDIYr4P1CtWEDE=; h=to:subject:from:date;
	d=aixigo.com; b=dYMUqL+UIJHvt+qRQBaNXPo/3qfejet+crG+ohD288sfvgJHC1ix19
	FQ5tryShqO84O3kmjQLkc3wq8JXhyoy22NnjFY71xDQNJL9C6KkeJUJfvDwd+9s6wXfatI
	/T+Xe1XSyt+YElCyb1qCnCFzWQy0+fbPGd4oq01ahKov+m0=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id bb9617f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 21 May 2024 10:40:15 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44L8eE2k730768
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 21 May 2024 10:40:14 +0200
Message-ID: <14ed85d8-dccb-4928-a4b8-a099d151fe5b@aixigo.com>
Date: Tue, 21 May 2024 10:40:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
Subject: git-shell vs "detected dubious ownership in repository"
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi folks,

since 2.45.1 (upgraded from 2.40.something) I cannot pull my
etckeeper repositories anymore:

	# su - etckeeper
	% cd /archive/host.example.com
	% git remote -v
	origin  host.example.com:/etc (fetch)
	origin  host.example.com:/etc (push)
	% git pull
	fatal: detected dubious ownership in repository at '/etc/.git'
	To add an exception for this directory, call:
	
	        git config --global --add safe.directory /etc/.git
	fatal: Could not read from remote repository.
	
	Please make sure you have the correct access rights
	and the repository exists.

Please note there is git-shell on the remote side. Question is,
what is dubious about the existing access bits of the remote repo?
Currently I have

	root@host.example.com:/etc/.git# ls -al
	total 532
	drwxr-s---   8 root etckeeper   4096 May 21 10:14 .
	drwxr-xr-x 242 root root       20480 May 18 06:28 ..
	-rw-r-s---   1 root etckeeper   2716 May 17 14:04 COMMIT_EDITMSG
	-rw-r-s---   1 root etckeeper     23 Jun  5  2013 HEAD
	drwxr-s---   2 root etckeeper   4096 Jun  5  2013 branches
	-rw-r-s---   1 root etckeeper     92 Jun  5  2013 config
	-rw-r-s---   1 root etckeeper     37 Jun  5  2013 description
	-rw-r-s---   1 root etckeeper  70979 Jun 28  2021 gitk.cache
	drwxr-s---   2 root etckeeper   4096 Jun  5  2013 hooks
	-rw-r-----   1 root etckeeper 397408 May 21 10:14 index
	drwxr-s---   2 root etckeeper   4096 Jul 11  2023 info
	drwxr-s---   3 root etckeeper   4096 Jul 11  2023 logs
	drwxr-s--- 260 root etckeeper   4096 May 17 14:04 objects
	-rw-r-s---   1 root etckeeper    105 Jul 11  2023 packed-refs
	drwxr-s---   4 root etckeeper   4096 Jun  5  2013 refs

Doesn't look dubious at all. Unless you are root you have to be in
the etckeeper group to get read access, restricted by the top level
directory and all underneath files and directories . Note the sticky
bit for the etckeeper group. What is wrong with that?

Every insightful comment is highly appreciated.


Regards
Harri
