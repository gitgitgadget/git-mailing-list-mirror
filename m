Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955FC1DE2C5
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230627; cv=none; b=K9G1hWl2S6+rp5z2VqIuwvCNbBlL10XfU0AJ6zY6JakcRJXU1LqqYjqccMfHR0Ri7P5rMaPaQBuKUut4gubwGiEc8eIzlPxpqVJnFJnHo/D10+iJBXMbND199+jpkRfc0E3olrirmpW965qyUi9kVpydGXBz1712727RryFFmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230627; c=relaxed/simple;
	bh=B6IYcsj77IqLcS9NF/3jyyNT43Btv0nU0emwBM2LuWo=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=b3+smbHcuEPEaRl51mQUv29rR0xHkBQD1N+ZYC/hH8Vpng5ilyocj4eJIsKLfmMXNBH+t0J3I/xF46Z1P0rYzswXdI+UgDUoB2GEv/9sMYi2gsR8bSkECDnMivQayn6OWe5Fd77fnOimCk443ALJSMdCgz3lpz2LBbbB0+Pa/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=kert+G19; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="kert+G19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=FNzK6rnOepoxiNmCOqvcu0hb4Ek0J3CvmHhMQ87jAH8=;
 b=kert+G19ax1HXKn73D8N24Pz163hO7bWfCkfQw6j14ZW+lFzFS/uUsiNFUKcGtmWZTBeK2yEk1x+
   8bqykyJ74OS99mO9QVai9+xfzmLZt5+aT5T+ZC1RKgwQw9Tb6X2Bs4SMQGq2W22/rbnDBQgYv+2u
   PrHNBGapM3tYVCTrQ7xvhVeFi4XZiqeRp0RNl3HOFp3pJ2vYOuVjVZXhSTykicKBhpij07iQJbrW
   s1q8HEOPeGMmgvcevUM8qJLoyffKb8V1GqI3euzOy8LwyKvReUankYjtY/d2Ee4dFZQhAu59O36M
   vc7XG7+arhmVTVLjcPG+0BWOnaiZfpZ/VaRuUA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB00JDOPP6K0A0@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 05/10] remote set-head: refactor for readability
Date: Thu, 21 Nov 2024 23:55:05 +0100
Message-id: <20241121225757.3877852-6-bence@ferdinandy.com>
In-reply-to: <20241121225757.3877852-1-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGcL/GPtO++bdrGzpnjJgdWKUrU5hjCqV9PMW4f5UekgmcxBbymtZ7nkK9a10hj
 I8Ibett0fHO+HpGtaPPjqs8Gnixm5Ys23+mzPbD7i0ElJH97wzPummt+u+frF4na
 6Go11AtyKqZWhXv/5yeQdyUcy50egYIneqb/srp3IcryMMLH7UUOPBJx0me8t8ET
 fBuLrXWWNf0DDxC2UKHJexW/c7k8N2Sn7n/v+YPlTkVT+yO0oc/g2z9WcoRQmktu
 Jw0qRo4q0WoKvqdOEl39j0x6zUmAeRnMdS8xjMEPu1o1xXXhg7o+blXbsVc5hYfD
 GH0CzFfZpmHkDAKqk5gu1kJmm7wreEOIDCejBXw+lNLF3DGz6mtiJ+xbhftttuui
 x/AbL4IRcXjKcw8TwqBjLcxyzKuv+XfhwfVzrlgOCe1tzp5Zgdw5CjYiaJaQ6aJD
 hwJIFuJg0EyPta2xs1llUH7SVLwrzPJWCtPc7j35GYwDEeEbqvzEpYQ=

Make two different readability refactors:

Rename strbufs "buf" and "buf2" to something more explanatory.

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store the result in a new refs variable. Although this
change probably offers some performance benefits, the main purpose is to
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
    
    v11: no change
    
    v12: no change
    
    v13: more precise wording for commit message
    
    v14: no change

 builtin/remote.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 8a182439f2..bcc3ee91ef 100644
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
-			result |= error(_("Could not set up %s"), buf.buf);
+		if (!refs_ref_exists(refs, b_remote_head.buf))
+			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
+		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
+			result |= error(_("Could not set up %s"), b_head.buf);
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
2.47.0.298.g52a96ec17b

