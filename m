Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7B22FF32
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587651; cv=none; b=aef2ifkqtqAwEBYkawmhEP8jzDqHh4i5uudSVr7xlk4G17A+yJW59YoG57CCOqGTi56g4tcmJxhjt1oaFzcIEPK4sc2NNJTHhCTwHBRJNKtTUg0ZHVFQVATaep5X5Hrg1qFm6vTBeINs3t8ZRuvECTK+e9H46eRzw/3WkNrDQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587651; c=relaxed/simple;
	bh=vX/5zYeeyY0ZtNNLx7Q/DxN6CYPMREh0QqW6Ze+7fds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfhgSJJxhbwI6foq+5UYfCIRE4nC7g4Ud5dWeRmSixpVnlhS5rwOIMYUwNGnAFjbCNDiC3QOftKPThHM6WRWbHMQWhBBxvaL01EsRekg5zFoZofAsLEBZgKvtGLVFmpuQpZyjXrqrUgm+Td3hs+/DYApSNa2s90qmdy257m35FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=MATFD3En; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="MATFD3En"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 52LK7H70012032-52LK7H72012032
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:07:20 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tvieD-0065HO-4c
	for git@vger.kernel.org; Fri, 21 Mar 2025 22:07:17 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Fri, 21 Mar
 2025 22:07:16 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 08e4da9b;
	Fri, 21 Mar 2025 20:07:16 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH] bulk-checkin: fix sign compare warnings
Date: Fri, 21 Mar 2025 22:07:15 +0200
Message-ID: <20250321200715.3338-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=NhHdgG/6GTKx4hZnkZZiGVAZdsQvleqNhXQDLPT8fkk=;
 b=MATFD3EnFWPgjO9YFbRB6gAvRb+AkKXs6lvzB/OCtxNX6PXL6f+NyfzWbvkaBcGKl7LRR/pz+ciB
	rBQREAgzpevHzhhJHfOZma4na830dgLkgJCaae6TKODCn1tdchKHkJYEDYvXcx85gstiS3OHiMKh
	e6HRoKpK6dE8/knIaHxbtymuAIn+quqqpS2BwzEsflgI2waNFSXwlRLWMI/L9Pu0V562rJvjPocq
	xFWazFeAJqPIGL7xMzSA9VFguJsYa4mggrtynO/qjgm/JnFFbbWsVGt51CcFoUurEzmhhAnSoo1L
	N2JLIWOcf/xTueChSqvuFgnuSMsNyUMbFSdCcg==

In file bulk-checkin.c, three warnings are emitted by
"-Wsign-compare", two of which are caused by trivial loop iterator
type mismatches.  The third one is also an uncomplicated case for
which a simple cast is a sufficient remedy.

Fix issues accordingly, and enable sign compare warnings for the file.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 bulk-checkin.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 20f2da67b9..0133427132 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
@@ -56,7 +55,6 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
-	int i;
 
 	if (!state->f)
 		return;
@@ -82,7 +80,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, hash);
-	for (i = 0; i < state->nr_written; i++)
+	for (uint32_t i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
 clear_exit:
@@ -131,14 +129,12 @@ static void flush_batch_fsync(void)
 
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
-	int i;
-
 	/* The object may already exist in the repository */
 	if (repo_has_object_file(the_repository, oid))
 		return 1;
 
 	/* Might want to keep the list sorted */
-	for (i = 0; i < state->nr_written; i++)
+	for (uint32_t i = 0; i < state->nr_written; i++)
 		if (oideq(&state->written[i]->oid, oid))
 			return 1;
 
@@ -192,7 +188,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 			offset += rsize;
 			if (*already_hashed_to < offset) {
 				size_t hsize = offset - *already_hashed_to;
-				if (rsize < hsize)
+				if ((size_t)rsize < hsize)
 					hsize = rsize;
 				if (hsize)
 					git_hash_update(ctx, ibuf, hsize);

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.30.2

