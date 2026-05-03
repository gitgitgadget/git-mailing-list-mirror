Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851F1A6830
	for <git@vger.kernel.org>; Sun,  3 May 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821593; cv=none; b=KDG+Dw+iZtd8WZqrMW/wxIkNaS3XzlvHQkrpWm6PaIOnSevUcQ4qat+NcJvAcSTSBasLNI80EQX8t8qmLok5BfuwbEIbp69EzVAdE6id6ZuWpU/holpCNipddmLzZ0bCBjtQhrwD7ame0ByEgWS0nFRx4g5q1jlx140d346+yYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821593; c=relaxed/simple;
	bh=gY16DSJEqO9WFCqSEcgy12lKQ5YRlDnd3NIoUX1VVa0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=a5F9I6m9tvSgB3soQW0zDybZiqrYIlisrVSit997KEVNYnIpZ2oV75eqelHbum78v2f34Pfi7pjRLJ6r7COBKmNlpXc8Gwa9Q3Y5JuiXF8+ucHLinEPSeZvgLan/iB/gEOi0Q9PdhpMxVWYHqq0bvFGv39lkiKAAz3w5vfXQgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=CrF2i8p5; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="CrF2i8p5"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id JYYhwKlse4vCcJYYiwtszv; Sun, 03 May 2026 16:16:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1777821400; bh=7vTz/CFpVsdRjWYrxKKAPgDma7sHtO4LpYOwqMf3Rzs=;
	h=Date:To:Cc:From:Subject;
	b=CrF2i8p5EXEA5Ko9DjL6yt1HVe5VrsI38u088MGg/boLyioPTcLnM+T9XZWwFtFnz
	 tG7BwlX64+dNSDC1eCFEz5pqcOmJfEPQsEkDg3h5Axvh4CINBYsOn518OVThQ1+Byo
	 AMIllApulvsdPdo1qEc6sAYVllJAOu2xw4Eeize9rei1onXsaL4477dBvRmAvy6KgC
	 qf+kuSjApG/Lf/rT11JC9X5e5YVv5je7uQ9GiFzTv2OK5wwAVTezqtyVXcSzDbMai2
	 F6REb3bjeHugXynmExpRlCVO/jnkpuDrqbToSEGl9vlzfJE3djVhCm2CyDEcWB/T2P
	 OuCa9MDit/c7g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=KZZxshYD c=1 sm=1 tr=0 ts=69f766d8
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5vhzZ0tVsuy0SMuEDeIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
Date: Sun, 3 May 2026 16:16:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] name-rev: fix an 'may be used uninitialized' error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGkcVVlwZ7ETV0n0pAkhbvo6Eh1SGNdh9nnKkOe2zzR5QIXgdeqeItQyCGLAJjCRdaPHUdOVzwuQqRXILl/T5UHZ43isfoOaxUaD6KpgCFBp2WmZU5jj
 UjA8YmEMIwf3KNYo7jsowMShxyjezmiQsiBJSekwcXNNsnGQUQe9hq1DyCFzy84MLAt1wlKCJBTObPibfzfQ1Pm99QpR2Y5y7dQ=


Today's seen branch fails to build (with DEVELOPER=1), like so:

      CC builtin/name-rev.o
  builtin/name-rev.c: In function ‘cmd_format_rev’:
  builtin/name-rev.c:885:28: error: ‘commit’ may be used uninitialized [-Werror=maybe-uninitialized]
    885 |                         if (!commit) {
        |                            ^
  builtin/name-rev.c:867:40: note: ‘commit’ was declared here
    867 |                         struct commit *commit;
        |                                        ^~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2932: builtin/name-rev.o] Error 1

This can be fixed in several ways; initialise the 'commit' variable to
NULL (on line 867), initialise 'commit' to NULL on the line before the
conditional on line 883, or (as I chose here) initialise the 'commit'
variable in an else arm of the conditional.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Kristoffer,

I wrote this patch yesterday, just before I had to go out, and didn't
get around to sending it to the list. Today, the problem has gone
away ... (along with the 'kh/name-rev-custom-format' branch)!

Assuming you will be sending a new version soon, ... could you please
squash this (or similar) into the patch corresponding to commit 5903855b1c
("format-rev: introduce builtin for on-demand pretty formatting", 2026-04-29).

Note that I don't think this particular fix is better than any other, it
was just that my cursor was on that line in vim ... :)

ATB,
Ramsay Jones

 builtin/name-rev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b941e93834..5b7f7a00e5 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -882,6 +882,8 @@ int cmd_format_rev(int argc,
 			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
 			if (peeled && peeled->type == OBJ_COMMIT)
 				commit = (struct commit *)peeled;
+			else
+				commit = NULL;
 			if (!commit) {
 				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
 					*argv);
-- 
2.54.0
