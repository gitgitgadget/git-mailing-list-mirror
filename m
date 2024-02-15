Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9519476
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707977361; cv=none; b=qXPsSYV3dkZqNtczsrWugMX8F3vdUBVmhMxtu/euWeG97uNBcJz/RLBdZYito5n8jxJto7tiXkW2D0KjtW8o8Kpf4R7m4D2aoIr+ZYMWZofzJDBXIKz9Z4fpGwziiksKvhKROk//u7YUwZOFhRku9q4fsZN2HIwDu+QOD11AKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707977361; c=relaxed/simple;
	bh=EIvyO1iGZQYq9p/YQGBQKSkMt2qFLrzFskVPVKx9nAU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=silYzfp+N0IELB96ocAyln8VUJjmtzL+yCIcvaxPGYN5wJS11MI9kip6cY+6MgX0xj1lA6+N3ecz7YZDaA9Bq+PVbpTXzD2n9BQ19ngboE6pHrhsDwf8QD/GiYnS3Hp2N374LZP8VI28Z1Tb4btZcDBH9m4VTLFGFrMcGRm1OXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frippery.org; spf=pass smtp.mailfrom=frippery.org; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frippery.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frippery.org
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rmy@frippery.org>)
	id 1raUuE-00D1Ma-OM
	for git@vger.kernel.org; Thu, 15 Feb 2024 06:07:34 +0000
Received: by argus.frippery.org (Postfix, from userid 1000)
	id E711560D7; Thu, 15 Feb 2024 06:07:31 +0000 (GMT)
Date: Thu, 15 Feb 2024 06:07:31 +0000
From: Ron Yorston <rmy@frippery.org>
To: git@vger.kernel.org
Subject: Bug: git-archive: --add-virtual-file doesn't seem to respect
 --prefix
Message-ID: <65cdaa23.MHIIVADqwryAD0ON%rmy@frippery.org>
User-Agent: Heirloom mailx 12.5 7/5/10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 9

The man page for git-archive has similar language regarding the
--add-file and --add-virtual-file options:

   The path of the file in the archive is built by concatenating the
   value of the last --prefix option (if any) before...

However this doesn't seem to be true for --add-virtual-file.  In any
git repository:

   $ touch real_added_file
   $ git archive --format=tar --prefix=prefix/ --add-file=real_added_file \
      --add-virtual-file=virtual_added_file: HEAD | \
      tar tvf - | grep added_file
   -rw-rw-r-- root/root         0 2017-02-22 17:18 prefix/real_added_file
   -rw-rw-r-- root/root         0 2017-02-22 17:18 virtual_added_file

I expected to see 'prefix/virtual_added_file'.

Ron
