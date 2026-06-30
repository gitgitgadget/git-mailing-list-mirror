Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3834751E
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818128; cv=none; b=t6+TXQfFClR0+RWBNiReDfk4ybWsJsc/EBCKlonPK/umdUz+mF4zzZo6g2+n8cLVIJQPBimo6G6CiEpJQ8e68xpnXmMagiX3erFbdQIQpo/eHi1XmbAInKLF90n2KMw5YpZxhDAN/ogxoADgOaX+YVr+QpV4S+0+IrhAA3zPJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818128; c=relaxed/simple;
	bh=JHpcrK3dLtFD0uJrhtBKW8ZtP25eErvtjtTfw2WambA=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=uXEElQe7o7454qcQoFY+W5FUEuEt2Lkge0FQCgKLfg2wsdYmFgBwoMfkwlxrQLdlRdKcwOFIrJMRgy931qkYO4zHUjpi2QUTng/8u2aUGhBiwk0sW7bFdUZG9L82kBAHIu0H8lUOe054wl1F43o123deJnYCS/jG7sqatkPS06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=M3Ev+eES; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="M3Ev+eES"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C1EFE240027
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 13:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1782818117; bh=bsBg33NDt1cYwSfvL9txvJOuGkwdGJvnCrHtvz14wYE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type:
	 Content-Transfer-Encoding:From;
	b=M3Ev+eESAZbrLv+LajgvdTTqzrAaMeZYZ9/A5cB1RoIu5AWWXCFoxGuYjBM9DiR71
	 rZpFCSp1pJ3EeR/kJRoThPv8ypwBRHgb2GZgZ4aCkC0DnCIck0P25HEe9APfH96Ckp
	 TJVTsSmwXuJNpm8fzmQjLckIHW3Xp1wMlzKCs3OhQiryd73HyFtkYmUE9m+IEuRsz6
	 EscqvvvcM0N3v5sawY3lV4fxhahdkvocgTBoZZhySZT6NcqkqEudNBfTEjYcKKMlSo
	 5zannlLFyDZ52QsyBpfAf07loRQBUauy20GoP+rLj9W6o2THbIppMVPmP3ZdTkmwR7
	 EV/bZlhFvyytg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gqLCn2dxTz6tvq
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 13:15:17 +0200 (CEST)
Message-ID: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
Date: Tue, 30 Jun 2026 11:15:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: Laszlo Ersek <laszlo.ersek@posteo.net>
To: git@vger.kernel.org
Subject: git-blame vs. abbrev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

when git-blame is passed the "-b" option ("Show blank SHA-1 for boundary 
commits"), shouldn't git-blame *stop* reserving a commit hash nibble for 
the caret that otherwise marks boundary commits?

More directly, I find it inconvenient that git-blame shows commit hashes 
that are one nibble longer (13) than my "core.abbrev" (12) setting; that 
makes cutting and pasting commit hashes from the git-blame output into a 
git-rebase TODO list cumbersome. I briefly hoped that by setting 
"blame.blankBoundary", I could get around that, but it doesn't seem to 
work (I tried with Git 2.55). I now have an alias that passes 
"--abbrev=11" explicitly, as a last resort, to git-blame. (Even a 
potential "blame.abbrev" would be superior, but such a permanent setting 
doesn't seem to exist.)

Thanks,
Laszlo Ersek
