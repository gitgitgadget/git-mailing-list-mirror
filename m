Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB5182D8
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535421; cv=none; b=CS3SpHNT+03s15V7Jp/fngSxqpjzHpQolDK7yAD+Vnj5q4QcmWLXwparViZVe6XRycwErgIOFS15A+h+Kkn+tIQCEcurf+LuPP6k8BoKkgz2i9UwdHUP4vV0yeqXFod8iWAj5mTcxUjKInGWqj5JgXOnXPMDYGri+LL3/0cln7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535421; c=relaxed/simple;
	bh=bXEfsvG6q6QjdHwLiH/PcPPsgbRMdwsFbPHwFxZfOpI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a/byE9GDx5KU+ItYxVsAUNY/hYB+Kj2FOFWQL0ZtCbL8T/gezBJlR2DJc6ex103zP88FlEMloQ9/RL+hITkrn73cYnY956GI6s2VIhkmZQFHlb5FQKxV/2C9qLTJeDDqYmrdE3lVNV/yLesxQpwxlRKKmBjYZqWoHKNpA5uPFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471I3b543497488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 1 Aug 2024 18:03:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Date: Thu, 1 Aug 2024 14:03:31 -0400
Organization: Nexbridge Inc.
Message-ID: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdrkHN3mkCcmnbYqQIGUeM5NQQAdCQ==

Hi Team,

I think this is low priority but would like to understand the situation. It
only happens on NonStop ia64 (consistently), not x86.

The t7701.09 subtest fails missing files:

Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
ls: cannot access '.git/objects/pack/pack-*.mtimes': No such file or
directory
test_line_count: line count for cruft.after != 2
not ok 9 - --max-cruft-size with pruning

The test directory contains:
./.git/objects/pack
./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.rev

but no mtimes files. I'm not sure how to proceed with this - currently
ignoring the failure but I
think it might be significant. This only fails on NonStop ia64 (which is
much older) and passes
on NonStop x86. There is no real file system reason why this would be a
difference between the
two platforms. There are some limit differences, but that's pretty much it.

Any assistance tracking this down would be appreciated. I can set up
breakpoints to catch
whatever is needed.

Regards,
Randall

