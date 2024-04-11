Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6F3CF72
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.104.188.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712874833; cv=none; b=XgAuaMDCokDUdVrshHnCxQ842GipGIzRBsvRdXGHZoyncasoJLVF0kRaNo02WnpFWYUvkjRBHFnxgMEORi8gofOGfwSiY6VnGwH9N6x3yCUzSpnbOI70a4kxm+D0uov0MYk5T6aLCsdhZmEcltl1fQacqIPC/VPEoPNkQ+kN+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712874833; c=relaxed/simple;
	bh=oNwUqXPsEn3OEWrWRoEyN291+qPDbzdYDo2CsfLrAXQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gcSnfm4vYAndCXNsdpT8ytXP0JumeTlFZ0AcDdYw7bFsCYESyy8KXXqC8FP+NKoyJmDYWe0BSW4QOtxzTtOIGShgtxcRjK+O07PsccR6JcFAjz2SC1dyyQn080rmL072BTFQ489Sdb282f3vD7qSYTWNdOlN4KcIXGuWMMF6fQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com; spf=pass smtp.mailfrom=m5p.com; arc=none smtp.client-ip=74.104.188.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m5p.com
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
	by mailhost.m5p.com (8.17.1/8.17.1) with ESMTPS id 43BMI2B0069636
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:18:08 -0400 (EDT)
	(envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
	by m5p.com (8.17.1/8.15.2/Submit) id 43BMI2ZV069635
	for git@vger.kernel.org; Thu, 11 Apr 2024 15:18:02 -0700 (PDT)
	(envelope-from ehem)
Date: Thu, 11 Apr 2024 15:18:02 -0700
From: Elliott Mitchell <ehem+git-scm@m5p.com>
To: git@vger.kernel.org
Subject: fast-import interface issues
Message-ID: <ZhhhmvjuYfWc535m@mattapan.m5p.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've ended up trying to use `git fast-import` for a task and have ended
up observing issues with the current interface.

First item, why is there no -0 option?  Due to any string being a valid
filename, most Unix utilities have evolved a -0 option (sometimes other
characters).  `find -print0`, `xargs -0`, `grep -z`, `grep -Z`,
`tar -T --null`.  Yet there is no `git fast-import -0`.  I suspect this
could work better with unusual filenames.

Second, forced use of quotes for 'ls' SP <path> LF seems a poor choice.
Using the empty string as a dataref or the mark of the WIP commit seem
better choices.  In particular 'ls' SP SP <path> \0 could be readily
distinguished from a sha1 or other existing data references.

Third, why is 'cat-blob' limited to blob data?  `cat-file --batch` isn't
limited to blobs, so why is `fast-import`'s equivalent so limited?

Alas, I'm already involved in too many things at once and cannot hope to
implement these myself.  Yet they do seem obvious limitations in what
`git fast-import` can be used for.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


