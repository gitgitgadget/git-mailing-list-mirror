Received: from impout002.msg.chrl.nc.charter.net (impout002aa.msg.chrl.nc.charter.net [47.43.20.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD5137C28
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231810; cv=none; b=UwAPTC0yHiMdVjqT9xR5XW/BXFBSCmYnLcxE75JisdIDBikJDtokrh7KnHiYIchqM9isSepEV2ulIWWaXsaBpJTai65SEAg4UJymy2sIw8DqljGlikvEV59mGhnbf6bqiwk+ptzh3JgRLKQ+s2r3rHLx38DQiegQyVChjeWmWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231810; c=relaxed/simple;
	bh=w5WYloa0T5Uw5sHSuCJ+xrzLizWpZ8ZlF42IPQAP+Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnhO8jv5+9DDHNkNPp04x6V2tFzYln/XyD727yHxJomVbsbymGf4sDuhRfTBjEGh2E8GG3y/f4Fsc0hBbou9GofFFNtwYmut+85gDZ+Woiz94L401qtFmS0XtCAp30PLDPcRXKs46JQnJSWoN0mj5rToz6PYCS3Bewnf7gQ6cA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=svkbdC+o; arc=none smtp.client-ip=47.43.20.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="svkbdC+o"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id 98GYsTho2i0hy98GesQjS9; Mon, 20 May 2024 19:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1716231712;
	bh=w5WYloa0T5Uw5sHSuCJ+xrzLizWpZ8ZlF42IPQAP+Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=svkbdC+o6f5lzAlaOaHZhUbY2CWRx6D94KFXvJ6/fy+xLir5zuw/5GbIyi+qiPzJ5
	 68mqq1JaEXBDTsIPtV3A5HH6ur2DyWnucuVLL6SAAVv4IHxnt01w34AmF053spPMyN
	 DK8mjb7HZ2TLIMIwh6Miuvx65VRgxy+IwbZOGnAZqxz2KT8KBwg+LPIhA/cnR24qvE
	 fZQFhy5DA41pSeM1il6DL5aRHFXj+gJBdrMkYDBZBpD2yLP+kUcPvx393Ly8+gX8Cl
	 46qmPYo5y4c9C+MtimUVdOR8ltCMQ4Rnex9yyFFHFH+yWESYDY8E6TNeYqkhAqJuB3
	 6FvJ+X7bI32wQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=Wf8KaVhX c=1 sm=1 tr=0 ts=664b9e20
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=7C5ArlEIky0_6m2BBFwA:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] chainlint.pl: latch CPU count directly reported by /proc/cpuinfo
Date: Mon, 20 May 2024 15:01:31 -0400
Message-ID: <20240520190131.94904-4-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520190131.94904-1-ericsunshine@charter.net>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfB7QGDXEuRasyztpVK8MLyBevEnVIZTSKmZgSiUFVNlOxDg/bgblh71gFwbx61n+lFLCiQX5j+VeFnMLhDCPdm+InoGvdYwQKsxgLyDioA9K/Og/MESM
 qnuMWUWGh2o2e9FBl9nynopGWqDc6VPyraCWhBhzFZvTp/YkupdfTrIDFM75WZ7DJlua2lypYaWjwzV0Sfp7YyAfSU37A8wnaMg7vIKcDk4vmshLNM80bv31
 9xTs8QjoaWXtXmgqiOa4OkondmFlbMgWBdmnoIpdFhuxU1/cT3wEgR8QcXFZ90fst/jdXwaBLTsjGp04+aGyog==

From: Eric Sunshine <sunshine@sunshineco.com>

On Linux, ncores() computes the number of CPUs by counting the
"processor" or "CPU" lines emitted by /proc/cpuinfo. However, on some
platforms, /proc/cpuinfo does not enumerate the CPUs at all, but
instead merely mentions the total number of CPUs. In such cases, pluck
the CPU count directly from the /proc/cpuinfo line which reports the
number of active CPUs. (In particular, check for "cpus active: NN" and
"ncpus active: NN" since both variants have been seen in the
wild[1,2].)

[1]: https://lore.kernel.org/git/503a99f3511559722a3eeef15d31027dfe617fa1.camel@physik.fu-berlin.de/
[2]: https://lore.kernel.org/git/7acbd5c6c68bd7ba020e2d1cc457a8954fd6edf4.camel@physik.fu-berlin.de/

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index d593cb95e7..1bbd985b78 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -724,6 +724,9 @@ sub ncores {
 	if (open my $fh, '<', '/proc/cpuinfo') {
 		my $cpuinfo = do { local $/; <$fh> };
 		close($fh);
+		if ($cpuinfo =~ /^n?cpus active\s*:\s*(\d+)/m) {
+			return $1 if $1 > 0;
+		}
 		my @matches = ($cpuinfo =~ /^(processor|CPU)[\s\d]*:/mg);
 		return @matches ? scalar(@matches) : 1;
 	}
-- 
2.45.1

