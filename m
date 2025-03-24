Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107E2E3367
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852860; cv=none; b=qbrWn0PV+G89YmxcoqPlsEvpi3fg8e/rCdmuivZzGET5qwZ1oH8RL/WFRoMPj41lZ7evpOh9oa9EuDkrh0x/kWkfxqfKHrnnAyZHkGaiNTD/8O/P0xjxqH3ePkXCPK4AKyYsravremNHp1k4OVrn3ZW3gCAvyX3ShpxQUimSn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852860; c=relaxed/simple;
	bh=8Z1rOZQr0DQAgR2UPOFD+0OdTPr5W+aMV9F52XJCWb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qH7/5xKS1hpAHc27NIyoGGuwC6R2wEX3PubqGykkPrQuRBGNGZ1PW2NyXJe7qnyT/qHel0ictjOPS+JWnfOHEY7vlnr+rXp+X+WQlgQFsta5I0sICTSlnC+6zQx5NBrbtt4EjpyvIcODnqsdnCO/sHU76cKaBoTA19jEGqiqj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=jESNbh9G; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="jESNbh9G"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 52OLlLps006824-52OLlLpu006824
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 24 Mar 2025 23:47:22 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1twpdh-00BWfz-3A; Mon, 24 Mar 2025 23:47:21 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Mon, 24 Mar
 2025 23:47:20 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 7e8e1af7;
	Mon, 24 Mar 2025 21:47:20 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: <peff@peff.net>, <karthik.188@gmail.com>, <gitster@pobox.com>,
	<taahol@utu.fi>
Subject: [PATCH v3] bulk-checkin: fix sign compare warnings
Date: Mon, 24 Mar 2025 23:47:03 +0200
Message-ID: <20250324214703.7547-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250321200715.3338-1-taahol@utu.fi>
References: <20250321200715.3338-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-07.utu.fi (130.232.247.47) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpZSAMJGhwAAQNGWVBQKA8FCQEERgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=okA55YMaf48cKiQI+9RCxlv1sF/rqcr9CKjuhr7KW/Y=;
 b=jESNbh9G4Fs8suvVuSylb8uAVX7kWCyyQdDL2gzh8pEPlZli+ou0K3CtXPKJ6xY9pnGReHBIelMv
	XWxMeWWijBpjBZAD+tWz94hHkrb+7B43Fj/6tJzC7TzilKgOQNlr6fIPQk/EeO934yMhjlcMUd9P
	mliOm7CTaW6zkBGV5YtJ9bB1TVwLTz2TEF3XX0NAr7XaFyKVL+0bvmm5kuNY3qw2ioGc6N8oTbGK
	YdvjmxkBw9mHypNyg7Lfx8wINJ94fJKSwZX7POVGVvoG3WuBLdMm//+/uZ3SVKsKDLzrlpEgZ16I
	usA4je8vM9/xpokusXT2P5VMq+lyCcSvUivNXA==

In file bulk-checkin.c, three warnings are emitted by
"-Wsign-compare", two of which are caused by trivial loop iterator
type mismatches.  For the third case, the type of `rsize` from

			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);

can be changed to size_t as both options of the ternary expression are
unsigned and the signedness of the variable isn't really needed
anywhere.

To prevent `read_result != rsize` making a clash, it is to be noted
that `read_result` is checked not to hold negative values.  Therefore
casting the variable to size_t is a safe operation and enough to
remove the sign-compare warning.

Fix issues accordingly, and remove `DISABLE_SIGN_COMPARE_WARNINGS` to
enable "-Wsign-compare" for the file.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    Okay, I think I got it know.  Thanks for bearing with me.
    
    Range-diff against v2:
    
          ## bulk-checkin.c ##
         @@
           */
        @@ bulk-checkin.c: static void flush_batch_fsync(void)
          			return 1;
    
         @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
        +
        + 	while (status != Z_STREAM_END) {
        + 		if (size && !s.avail_in) {
        +-			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
        ++			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
        + 			ssize_t read_result = read_in_full(fd, ibuf, rsize);
        + 			if (read_result < 0)
        + 				die_errno("failed to read from '%s'", path);
        +-			if (read_result != rsize)
        +-				die("failed to read %d bytes from '%s'",
        +-				    (int)rsize, path);
        ++			if ((size_t)read_result != rsize)
        ++				die("failed to read %u bytes from '%s'",
        ++				    (unsigned)rsize, path);
          			offset += rsize;
          			if (*already_hashed_to < offset) {
          				size_t hsize = offset - *already_hashed_to;
        --				if (rsize < hsize)
        -+				if ((size_t)rsize < hsize)
        - 					hsize = rsize;
        - 				if (hsize)
        - 					git_hash_update(ctx, ibuf, hsize);

 bulk-checkin.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 20f2da67b9..a5a3395188 100644
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
 
@@ -182,13 +178,13 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	while (status != Z_STREAM_END) {
 		if (size && !s.avail_in) {
-			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
+			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
 			ssize_t read_result = read_in_full(fd, ibuf, rsize);
 			if (read_result < 0)
 				die_errno("failed to read from '%s'", path);
-			if (read_result != rsize)
-				die("failed to read %d bytes from '%s'",
-				    (int)rsize, path);
+			if ((size_t)read_result != rsize)
+				die("failed to read %u bytes from '%s'",
+				    (unsigned)rsize, path);
 			offset += rsize;
 			if (*already_hashed_to < offset) {
 				size_t hsize = offset - *already_hashed_to;

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.30.2

