Received: from thyestes.tartarus.org (thyestes.tartarus.org [5.196.91.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE5A2D
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.91.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736469318; cv=none; b=uoyDJodkug2xwAFwHyICrnSnlHaJyZap2LCNmnWHBHePjkbtaEH/YIQGftv6Jt6mTQdkBao/Bh4i9Bc68AwI9xw8OOe8P1YKOksJVMyhPnelAU5S9+Pjgy+WZgJMZpzn6Y6Rgqf55BKx/KONRJLeo0rIGTi1mzT8VnO2ENX/iEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736469318; c=relaxed/simple;
	bh=pMIfQCNPg1XLJgoImq0fIk9KsH8nfs2LWQWWAPz14EA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qk83b3uA8nvBz1VMuTRmCUu4h7MsEaqypE6+Mh6EXZLYZrDGqfHCQ58i9SImJM7DIyZ7JvbgrQ18xcon7elIG0viUcIFwxGqB9v7HmlqhqVnnHKpVBB6VOv81k0OoLdvyWmd1Vnwx77cuQjpLQbyBajmjp5VbGUsiKt1THcT2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=survex.com; spf=pass smtp.mailfrom=survex.com; arc=none smtp.client-ip=5.196.91.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=survex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=survex.com
Received: from olly by thyestes.tartarus.org with local (Exim 4.92)
	(envelope-from <olly@survex.com>)
	id 1tW2Kd-0002yn-Bv
	for git@vger.kernel.org; Thu, 09 Jan 2025 23:52:55 +0000
Date: Thu, 9 Jan 2025 23:52:55 +0000
From: Olly Betts <olly@survex.com>
To: git@vger.kernel.org
Subject: git grep: ^$ false match at end of file
Message-ID: <20250109235255.GA3418@survex.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

git grep '^$' seems to match at the end of the file, reporting a line
number one greater than the number of lines in that file.  This does
not match the behaviour of grep.

To reproduce:

$ git init -q git-grep-bug
$ cd git-grep-bug
$ echo test > test.txt
$ git add test.txt
$ git commit -m test
[master (root-commit) 55b48b26] test
 1 file changed, 1 insertion(+)
 create mode 100644 test.txt
$ git grep -n '^$'
test.txt:2:
$ grep -n '^$' test.txt
$

(The -n option isn't required to trigger it.)

I'm using the git 1:2.47.1-1 packages from Debian unstable.  I can also
reproduce with git 1:2.48.0~rc1+next.20250101-1 from Debian
experimental.

Cheers,
    Olly
