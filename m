Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65B3612F2
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837945; cv=none; b=h+vbvRBAb7BcKEyo2IdcOnxgB1tezVhcATbjc88X37wvQhrJ/l6LdUXeBYu8urK0naAjAtaWXAzXP/7LwnHlKO4iHSXK+qo8RxnYwcPYzBuXSHkYMBJB6T6Jd3TD7UaqPrt0gKAHZvughng4q7aPp+v/c1cmfwbXXtHsB+kwdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837945; c=relaxed/simple;
	bh=23ZgOQxPj272+xtVnFhFNjJ/NKfukBmjtRECIqeYxrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1+/6LAjcZtkTSakbS+ZS6qmMQC5IpAnNA9mEQzT6NMlCvGmgyjz8hku1M2TSpOTCk6vJivMJpzrLpfaxZS19m4OFT+QMyqx+zRvIknQZQqWXRjxBGVzQqPnykF1vRbx4sAhVUNwgOPCBNWuBBOXC1x+4QSydlSeNVqN+wU9xVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=UPrQhdt2; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="UPrQhdt2"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772837942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvz1f5SVGyUgRhmtGMG5pYgIe0OJNwKADGfEWKYXEpI=;
	b=UPrQhdt2sDUbar8l1SnF2W9h5z9how4taMz0lZgF2LFh0YqlOsEmDtxfHHzkRW0zHAKOEc
	7eaUMrvw0dAj4BpinJgnUp032bWTCZPf+rSY7qV1Kyi+bHeJZh9zUOVSqDPYVjXqlJCUHy
	yD1w5Pn24Ce1EoKME+qjqliEoJUeW/ZlbUO0sHuGjCqeDem60Da7jbT07SnuiHeDZcp0jE
	KbdKsmdk1PT46INfSsTnYFg8BQkmY22N+qZlERJ2GFkMFpRAAtaA4/3WSeKMn5xFgCceIA
	huT/vZHOx6RMTqIzUCSqNbDQ/qSJ/yfu1xmHsWMjfBsLwiSZOT7YqdK9z64i+Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v6 2/5] format-patch: move cover letter summary generation
Date: Fri,  6 Mar 2026 23:58:45 +0100
Message-ID: <dc131c756520a0982d1d6f733dff48a464900ea5.1772837832.git.mroik@delayed.space>
In-Reply-To: <cover.1772837832.git.mroik@delayed.space>
References: <cover.1772232373.git.mroik@delayed.space> <cover.1772837832.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=mroik@delayed.space; h=from:subject:message-id; bh=23ZgOQxPj272+xtVnFhFNjJ/NKfukBmjtRECIqeYxrc=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq1v9M7P5GlKkEaHR1uSIRQJAdu98Qw/vl6BP2 jyfr6gebHKJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatb/QAKCRBIeX6hnBm+ 0Qt8EACPOOqZLptnqVuku8gEl99ss9RlfNj3hJoL3gIvw+IDt4aNugVko4vvaQkaBMUAZGZogZr P25OeiGJAjjMX6t98wZJXbls/WzOY6hbIkpv62G3gducaTGO06BLHdpVHTYU/v2M8JfI41EfNpc PQn71a3z+SAPW3fh48tamdrBGbsgXdqOqoFbUx/EuT9VNF0Z0W0t8IRiPlCm5NYVyywPsBc+0iH 79L0Yl1svkb+YGInmrbcxf0UXnykiTmiMdPXH+WeTc4UNipzcqxMbGCRzv0/whLK4IHMQ27nE5D Q+vKQDRO0ISMp/qrUkvaniGqbhbdHX8WvJieP658GR9FhDjYF9/xMtKQ2WwFbq2adPAzlm9PbLU Yese52BqsSNDvdgZEoplPCV8lD7kC9WitnfhoaiRaxj+nwGzTHxJ0bl59OVqtuK4vkTeD2Era4+ 010w9n5l9rhy/mhCcA5u8GU8PCED5huOuHAYZHnVUSiARNK+k9zjthzuuKuf4uIR3v3VwSJ4m/n 5jEFE+qEkQf02rrNRc+TDAXU3Iu0xRrYns1BkAGn+QqdrHWv8aRBMV7dA3IP2g+WUgqv6H9X7ZE lmacsWfAiqwW7BT10qso2XuD59enT+3R3Np8e9XZHGCtu13Wg4yJi9u0Gg8J+oI9mTnaLWevDge n/qMnv6HF
 C//XUA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

As of now format-patch allows generation of a template cover letter for
patch series through "--cover-letter".

Move shortlog summary code generation to its own function. This is done
in preparation to other patches where we enable the user to format the
commit list using thier own format string.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef363..0d12272031 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1324,6 +1324,25 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 	}
 }
 
+static void generate_shortlog_cover_letter(struct shortlog *log,
+					   struct rev_info *rev,
+					   struct commit **list,
+					   int nr)
+{
+	shortlog_init(log);
+	log->wrap_lines = 1;
+	log->wrap = MAIL_DEFAULT_WRAP;
+	log->in1 = 2;
+	log->in2 = 4;
+	log->file = rev->diffopt.file;
+	log->groups = SHORTLOG_GROUP_AUTHOR;
+	shortlog_finish_setup(log);
+	for (int i = 0; i < nr; i++)
+		shortlog_add_commit(log, list[i]);
+
+	shortlog_output(log);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1377,18 +1396,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	free(pp.after_subject);
 	strbuf_release(&sb);
 
-	shortlog_init(&log);
-	log.wrap_lines = 1;
-	log.wrap = MAIL_DEFAULT_WRAP;
-	log.in1 = 2;
-	log.in2 = 4;
-	log.file = rev->diffopt.file;
-	log.groups = SHORTLOG_GROUP_AUTHOR;
-	shortlog_finish_setup(&log);
-	for (i = 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
-
-	shortlog_output(&log);
+	generate_shortlog_cover_letter(&log, rev, list, nr);
 
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
-- 
2.53.0.5.g1a4ba6dc33

