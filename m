Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A8A32
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006925; cv=none; b=QKY+1uopaxxDPFtjwbl4Zv9EvynXLRduJsoMQ9G/s/OI8lVkliI4Gz25bhJceeMdfDAS0JDIABfZBnpXnqOCNfp5AtT24HqD/0KWR/JBze1APKa8YoCzZ1zx5urEBvEKkcA06GWSqi+9sl+aTn/8BdXbVq7faWYbeUuzh+a2Dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006925; c=relaxed/simple;
	bh=O8MY7Z8mLP6Q2d0lEfUB7SjCtW3JMKs6reZVUFNz0+s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=d05l0SiLLR6vCa1r5nTHKjmf6AwV9i6YFntvdUXRiL3H1jXMepHLBYoKdZpturC//SlVXKkuL1qaf2IQs0jEAobpcfSSdMqxM3rzA+qN1OjxJs9whACyZ7fF4mmIbG69RARhyipUcsTZjtVzBJOoQFIiOg3TYD8WdSZds6AxKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=qnfqODBN; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="qnfqODBN"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHZotGMzbvxWAtHZpteQCK; Sat, 15 Mar 2025 02:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006922; bh=LVw2WLpMjAd/rb5YNA6A2TOQloWflAtZi+iQxAH72/o=;
	h=Date:To:Cc:From:Subject;
	b=qnfqODBNog6GZdUChip1xG+IlGClDpgoCCbTqUiAkkwy3jG2W5osDSh4dhNH1s4ve
	 Ks7lk6hANpJ5yvPp8MlzPYPbOPvwOs99DLmqXlR2z5p2baMigByee1nIoRZpK58OKV
	 rWlnjv6u+NctjAPmhkk2fmiFyWFpkWEoy5P3KpRKdi4SLOrLvBubb9T0LbWiybDfGM
	 3brLQ0wGHGFAmETTM4p8INUOWCoKd7D9lGzdMdusHecv5h3AS1CuC62k1KCc8m3RJu
	 WzP0ztn1yAbDwW6b1cfFqEzNgDzmDU50B5g0cepCMjAiAVzyC0mjksH/zgvNjvkWgI
	 MCohvNLWX5uZg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea8a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=mCKABES6tY-doaLBvqoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <84b41b4b-00fb-4bc9-83ab-df1911c81a8d@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:48:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 09/12] builtin/gc.c: correct RAM calculation when using
 sysinfo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPuo8w80RFL/YDdmEL1L9TXM3xxp91Q1MC2yPVHJ0ji321g7yd5v4TutMJAqFp/IJUFUTt9RLSyegDSG4812sgE0bR5uAU5Rq/i5E+CauS3Sh56CHO5k
 bHuJdqFozF/lUhQBN4naQaKAESAAf5q6y/hhGBfv7L/rez1PKVhab8Mw0NkirrvONX/MvuoS3WdrQ9Ep4gjBZyuSqYLJoyNggmc=


The man page for sysinfo(2) on Linux states that (from v2.3.48) the
sizes of the memory and swap fields, of the returned structure, are
given as multiples of 'mem_unit' bytes. In earlier versions (prior to
v2.3.23 on i386 in particular), the 'mem_unit' field was not part of
the structure, and all sizes were measured in bytes. The man page does
not discuss the motivation for this change, but it is possible that the
change was intended for the, relatively rare, 32-bit platform with more
than 4GB of memory.

The total_ram() function makes the assumption that the 'totalram' field
of the 'struct sysinfo' is measured in bytes, or alternatively that the
'mem_unit' field is always equal to one. Having writen a program to call
the sysinfo() function and print the structure fields, it seems that, on
Linux x84_64 and i686 anyway, the 'mem_unit' field is indeed set to one
(note that the 32-bit system had only 2GB ram). However, cygwin also has
an sysinfo() implementation, which gives the following values:

  $ ./sysinfo
  uptime:      21381
  loads:       0, 0, 0
  total ram:   2074637
  free ram:    843237
  shared ram:  0
  buffer ram:  0
  total swap:  327680
  free swap:   306932
  procs:       15
  total high:  0
  free high:   0
  mem_unit:    4096

  total ram: 8497713152
  $

[This laptop has 8GB ram, so a little bit seems to be missing. ;) ]

Modify the total_ram() function to allow for the possibility that the
memory size is not specified in bytes (ie 'mem_unit' is greater than
one).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/gc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 99431fd467..cdcf1dc6e7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -373,8 +373,13 @@ static uint64_t total_ram(void)
 #if defined(HAVE_SYSINFO)
 	struct sysinfo si;
 
-	if (!sysinfo(&si))
-		return si.totalram;
+	if (!sysinfo(&si)) {
+		uint64_t total = si.totalram;
+
+		if (si.mem_unit > 1)
+			total *= (uint64_t)si.mem_unit;
+		return total;
+	}
 #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM))
 	int64_t physical_memory;
 	int mib[2];
-- 
2.49.0
