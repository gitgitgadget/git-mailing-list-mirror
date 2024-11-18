Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD931A9B3D
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944043; cv=none; b=fvlWnOyGVSEHt67N/bY0Us/LeOytce/x9W6+rD4mN5b/j+fp8/eLTRpeIDNpaV5XLps5skDsZgfolzzhCXy/gXa3hkeBBi/V5IjbOQb4doRKGRxkgQlO7FGeNxgqqsYFrfMe/qdYPOgvZXPWReIVhry4Jis+Wo8F8rmEYdnh5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944043; c=relaxed/simple;
	bh=EIj27zVqV+CgQ42azyF/9iRhUf9CG44UZLNsDG1R+o4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=AbkljZmjG5Aswb2Chzl2NzayDTrsfj8gUSfdAd2RqWBb4Av6kYRKoJQ8Xz7+RGfy1/ElQDlzLe04jSKfEjypdja+0L1YDDOIiZ12oZW3svzlZdwXxC3OPERLFvTb8afT06BshhOUATspbS6Dj6kBa6bKM+r9AtxtgRjS/C7gEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=QXOfUKT4; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="QXOfUKT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=0QO9T+1FX9wCBfcZFY3uwS2SL2v7MEEGu6h+8fX9JBo=;
 b=QXOfUKT4bI3swUd0ITtlrvXPZKwA81ZiWG2G8TJnN3NRk+osaVO66zCiIfqjohvi8KwJQz/9EDUb
   5QERMOrwhv76bCMVP+FK/bgY6Q+U7z1lC2+1CqPzcL95LD3p90OaVcCPK+HHA34scFUhyAM3FDEL
   PneW+2GoAG3nzbqVuLPcpK5Wk9H/qPxQ/kTsXZpr4Y9Qi2ZYiHa/rGmas67ZhTCmRvCke1/jX6hO
   11rT1/51wNnADCrFfj0/Ypk5Uk2qOlX3z9MEwNOaDDKGeiwcXCxnfzjB2iV8x6OLu42mfFkLbilg
   cadgM0Fgdn89sMLTtyxIbZqDF7M/kAHYn7Olhw==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500K5JKKHOGC0@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:33:53 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 4/9] remote set-head: refactor for readability
Date: Mon, 18 Nov 2024 16:09:23 +0100
Message-id: <20241118151755.756265-5-bence@ferdinandy.com>
In-reply-to: <20241118151755.756265-1-bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAEjJVsesN8odlnllSlE9F69lhtyb5Bp7GBDuxpwuovrMAl2gXGbuBYsm/tBvUoX
 4RKyQoY5ZHffuuMilFkIAyU7Qptmb/ZoUqn1immpV5MnjMDCzvImljsod2NXjpRT
 Ta62hnekjiolsDhSdKUnigCyuPBUmKj6NHvXAOCUerBDUsWaSQf2aDqfi9vhD1rs
 dwPHN+iXKLkHHxKAvj+HiNmA8+k39MFrKvBsBTyV2tkfYD9Zws/liDP7dpjISbRK
 kTo9P3wRQbJtX232FDOZyqgSLLkanFYL7ax3XSuBaTTlpBJvV4E8RfVD/bHKSjss
 qyrELvHD47K2ggQFZUHvBTj9Ox6Qtz6q6NuIcYSxJxYr8uGHVycRHJev998J92nR
 SNhQCChkOo/lNKlm57HdVFijUUkbMh7nypsiTJ8jcKff0OoGmBzNe3Oa29GGzfrN
 AdiYYMK9JrQnkAgXD2kKYNOIiPzEhT40ezNZGIybGSM5A98wyZy2Yn8u

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
2.47.0.296.gda1ecfef29.dirty

