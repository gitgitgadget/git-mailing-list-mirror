Received: from mail.marc-jano.de (mail.marc-jano.de [116.203.25.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A06EAF9
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.25.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757785596; cv=none; b=jwRNG5ptFdhjBB/ha1whu9L5ivp1dJF5qG3VeB31DVCqM3PoxNyoHdmdvmlgPZETuO1vnmsHscFyayqqpYJDk2vqKCfbVqbqzI8PI/L3sqf+57ZjbcKKyHTdg2ksJdbDP6BxbS09NoTjTdzKSRINo3Gb+07QjjZPrOO/7+Ko9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757785596; c=relaxed/simple;
	bh=7I45glEhmR4eQRyxHXoHE64uFooIQlE/tE8Uoin6lT4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FqcahtAH+Zoqc4etmuzlLVUrTy1k9pxvZtVU7St7YPJzsaEke0y+ZB/7Mt9v5aTvgrH9kpVIncoVLWBRulgz23T4JoT0eAcXaRUSWGP3eGOiTPV7Ly3zglhw2QxlrQZl8zUsxMgxp1GnnJNh2nJzj6Oy9Q6XBJ7LOHImuDewRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de; spf=pass smtp.mailfrom=marc-jano.de; dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b=JabcAJNK; arc=none smtp.client-ip=116.203.25.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b="JabcAJNK"
Received: from pc1.trash.bin (IP-045136170220.dynamic.medianet-world.de [45.136.170.220])
	by mail.marc-jano.de (Postfix) with ESMTPSA id 1014785BAA
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 19:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marc-jano.de;
	s=default; t=1757785136;
	bh=7I45glEhmR4eQRyxHXoHE64uFooIQlE/tE8Uoin6lT4=;
	h=Date:From:To:Subject:From;
	b=JabcAJNKMHd2BWdlGS7oMahZhXP2wjPWLEwWEd3/lcS/XOspUpFWK1Yp5snAYe57t
	 6eZWBII542SxVc1x/+WlL5W4p4m4YKmh1ND8xqMYcjPyDuQyJDeH9f0k/apxb1C9Vd
	 03lOCvJtoQRONSTCtbHwVRuiE4afxDiqLajqeM882nvfwYVgYeNR0jVoDHVmW2PfzW
	 G4xnFTR7tyZWJ09xr7Gp7sdPKbgJHsbuTU2oRRxnf8+HRM3cVvOa9YryPBhCQBegze
	 Y8QbkhpvEzQ6W+Nf2ksloUoRbCFqERWsVDPFJ3YkzstHiRr6eyamczIdgilZm6jEFB
	 Pvf+mhUBWw81A==
Received: from pcdm2.trash.bin (unknown [192.168.4.71])
	by pc1.trash.bin (Postfix) with SMTP id DB9AB1B0810C
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 19:38:53 +0200 (CEST)
Received: by pcdm2.trash.bin (sSMTP sendmail emulation); Sat, 13 Sep 2025 19:38:53 +0200
Date: Sat, 13 Sep 2025 19:38:53 +0200
From: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
To: git@vger.kernel.org
Subject: safe.directory does not work at all (git 2.39.5, 2.51.0)
Message-ID: <duuus2ifgydpwpja6vccvxbcnxdgy6mc6h63okzv7xdqo23fpi@ermurkhms4j3>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone!


git seems to have freshly implemented some security measure, and the
documented solution / workaround / whatever does not seem to work at all.
For the first time in years, git does not work for me anymore, I cannot
push my changes to the remote repository.

See below for what was created using "git bugreport":


=====================================================================
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

- What did you do before the bug happened? (Steps to reproduce your issue)

  I created a shared bare repo on my.server, permissions for everything
  are 2770 (rwxrws---) for dirs and 660 (rw-rw----) for files in that
  remote repository, and all dirs and files belong to root:git. I have
  an account "myuser:git" on that server.
  
  Then I tried to clone it to my local PC, which failed to some new
  security measure git seems to have introduced recently:

--------- snip ---------
$ git clone myuser@my.server:/git/main/test.git
Cloning into 'test'...
fatal: detected dubious ownership in repository at '/git/main/test.git'
To add an exception for this directory, call:

        git config --global --add safe.directory /git/main/test.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
$
--------- snip ---------

  I did execute the suggested command, so that my ~/.gitconfig now
  (only) contains:

--------- snip ---------
[safe]
        directory = /git/main/test.git
--------- snip ---------
          
  but the error still occurs. Using "git -c safe.directory='....'"
  did not help, either.
  

- What did you expect to happen? (Expected behavior)

  I expected the disabling of the above security measure to work.
  Actually, I want safe.directory to be set to "*", but that does not
  work, either.
  

- What happened instead? (Actual behavior)

  See above.


- What's different between what you expected and what actually happened?

  See above.


- Anything else you want to add:

  Can we please make suddenly occurring security measures and other
  breaking changes opt-in?


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.5 (same error with 2.51.0 on a different PC)
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.12.38+deb12-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.38-1~bpo12+1 (2025-07-27) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
=====================================================================


Any help is appreciated!

If all else fails, I would downgrade to the last git version without
that security feature, if someone knows the version number that
introduced this feature ...


MJK
