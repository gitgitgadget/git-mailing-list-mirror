Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75D1F8F00
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518291; cv=none; b=Ke9kzF8SKbwqp0SCRPj1JWEXO/aEkpw5J/xAwHxCMqRCUOya2Un9b6jRG3Vkx0mXYeWpeOGoQWCIt3Dbh61CivrAVVzj8VUVTiv4vX6S4kA4kJf2Giz95Z19xwVLQ/60NLCoy+lyVuyXQexPJPYnDR0/SNeJAfOXtYuzmiIWAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518291; c=relaxed/simple;
	bh=Lwu3SQpdhjS+vJk0NGEhXAIjry6gqhMToRrqDnysVkA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=RPG/2tPa7dpRIJv1bI5rSpffQWT6uEt3GIorSIoyEzeC2HBETbKyoFfhbr2M3/A9uJbT0lr00hpyNN3DwDVE5dD9nb6Sjmi1jlB7JOHQZpEOfHhkb5+dbvsHJdbClM4DAImllNiL3WXgE9u2jZgT1jqGVOnLk5VrcaunGHD4GGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=lbhbsu1+; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="lbhbsu1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=RSdARxnwDLsivWTSsFt1k6FUvxYMT1rzy27yMlS7nrg=;
 b=lbhbsu1+J/c+E/rotCWrpboZ6+Y/7/PvHOrMVPx3afOkZrXPR+lJKriAM/VxQg3FNnInDNbR3Mub
   t4X8OEbdONBdREBHZc1n3O/h3wP0YkfdU7EJvUvfISp9+TVq4gu5Si157U9Eix9H5DMXRDDglQ/E
   8c5bLRnQLazzM0tc2BhP+3kcuuRUTuYzzg4mvIRJrrmUgPU+zqtQNCvAALp7IezZT7ScWV9EeyTY
   qRboqkng02+p5DjblanIVne1NWUrq7nDb4OO0EmouyNwUUJE15m4+HcgelJoEi2IXtpw+aqtmYI4
   n4PSLFVfVXm0TmTEVfGfoGUvxubvVOTDAWFulw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP00D16KUII730@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:44:42 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 3/8] remote set-head: refactor for readability
Date: Mon, 21 Oct 2024 15:37:00 +0200
Message-id: <20241021134354.705636-4-bence@ferdinandy.com>
In-reply-to: <20241021134354.705636-1-bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAEbr3ITLQC96PGfDI26XyQWVrgmp9SpsUj0eWM5yfRaqCuK6lfmdMQChnItPhMs
 Shydt2EnaJ1/v5t3kMyrBcR/6zSfNlN9DVxmJPFYTGFtRpuTG96bOCGL3ZDTK0hR
 7VWwJ8vjxQOcoWTXrHJN1OgmEfE9ki/ItRRp40hZ9edxKvx/YeReuHQ+n+wCV4i8
 FdCTiNf6PZy4GeN0+oMu6LuEiFlEuyULIz5Jh2GfXJWiI6xRLmR1fFU3/DUSKDGw
 VuLsDztiR963oodQDrdzVmdTyuYvxCO4ly4565K67n9HNS9/f6p1+HBt7S6g0Br7
 uWRYOsNueCl9KxD7GCo70xzTxozW089p1psWdqBuKmLL6wd+iEw+Gm+bOCwKBwDi
 rsXwcZpxrS30IkTIYnvW/LzUqNxEN4AfMzsZLeRd0/inA7rCZGp/OnbySL3ST3WI
 rN08WJCP6oQIksIZ4DHZjvqvlc67+J7Suc6YRmYEQPj2XZFRw3Y9+0VL

Rename buf and buf2 to something more explanatory.

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store in a new refs variable. Although this change
probably offers some performance benefits, the main purpose is to
shorten the line lengths of function calls using this variable.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v5: new patch (split from the next patch as a preparatory step)
    
    v6: no change
    
    v7: - change commit prefix to be more in line with project standards
    
    v8: no change
    
    v9: - further improve readability by renaming buf, and buf2 consistently
          with how patch 6 was already done
    
    v10: no change

 builtin/remote.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 76670ddd8b..1d68c5b2ba 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1402,8 +1402,9 @@ static int show(int argc, const char **argv, const char *prefix)
 static int set_head(int argc, const char **argv, const char *prefix)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
 	char *head_name = NULL;
+	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1415,7 +1416,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
 	if (argc)
-		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
@@ -1434,25 +1435,25 @@ static int set_head(int argc, const char **argv, const char *prefix)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, NULL, REF_NO_DEREF))
-			result |= error(_("Could not delete %s"), buf.buf);
+		if (refs_delete_ref(refs, NULL, b_head.buf, NULL, REF_NO_DEREF))
+			result |= error(_("Could not delete %s"), b_head.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
 
 	if (head_name) {
-		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
-			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
-			result |= error(_("Could not setup %s"), buf.buf);
+		if (!refs_ref_exists(refs, b_remote_head.buf))
+			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
+		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
+			result |= error(_("Could not setup %s"), b_head.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
 	}
 
-	strbuf_release(&buf);
-	strbuf_release(&buf2);
+	strbuf_release(&b_head);
+	strbuf_release(&b_remote_head);
 	return result;
 }
 
-- 
2.47.0.94.g8861098b6d

