Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05765135A51
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964366; cv=none; b=f0Iavc5RH2EIVMvk+2QjIZkfDfNUfc8ztOPz43NeDoQtZHgvHBARyUzFN/L2k/QqZbW8VgOeqYdDIzYpFVTigCt9jGRzBq4zqwpmD72lU0b5ftk7uR290LRcoiVGEMKQvF8NS4emeMWk0xeHJD3q7lB5agK6TViwoVx/v1gSfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964366; c=relaxed/simple;
	bh=FvmbqSbgcpkmlwmr1V0hcw3sP+tVFUzXEvYQt34+4mA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d1u2so0l6c5SRwEVOKDJekeJFyb8QAHj7I+A2gdmECqyBvlllyhnlUu/TGAJzmZYUHuO6CKpsqgFALWbrI9EjXXSlItpUqhGH9sUA4FQRojyJ9p1sy4R2d1FsRNUwcAuq11WIoI6LVnyy3yzToY8U2oF+sXcX8SurTeQ0VsoW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 24664 invoked from network); 17 May 2024 16:46:00 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 16:46:00 -0000
Date: Fri, 17 May 2024 18:45:59 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: Three t4150 tests does not work as expected
Message-ID: <ZkeJx97qdLoaC2H-@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I noticed that the following three t4150 tests probably does not work as
expected:

- record as an empty commit when meeting e-mail message that lacks a patch
- record an empty patch as an empty commit in the middle of an am session
- create an non-empty commit when the index IS changed though "--allow-empty" is given

All of them does something like:

	git show HEAD --format="%B" >actual
	grep -f actual expected

While the 'actual' file usually contains something like (four lines
between the 'cut' markers):

-------------------------- cut --------------------------
empty commit

--
2.45.1

-------------------------- cut --------------------------

IOW, there are two empty lines there.  Because of that the grep gets an
empty RE from the 'actual' file and so it matches everything that comes
in the 'expected' file.

Is this the expected behavior?


Thank you.

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
