Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BA42A8E
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774942; cv=none; b=ehhhkGt2j9tR2YMqwCEIHWwwaA27lAWr7VkH3kpJV3h3sD2+CZK3Pe+mzVVITZDWxQGuASjW+0Gm5TlKgTaI/bwK2TIFcy5yglF8qtu/j1LfBI8lAhlLu7CTL8u1bGTJy7K6squ4ad5qVdJEkD3AipKurDqTkm3P5vNTs7R0aDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774942; c=relaxed/simple;
	bh=JJyJ9w8laW6Bgjqhe4FEkuG9NLF+y77YrCBRgZBi+do=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=ADs5g03yhDCt2WDwIHZTobVOEiXq03CN/i4Xavk6JGZY8IY8kmd1m0Ie+dw8FD/QgEInLUERtkMfUX8mQ2cE6HYG/vXpMTpu0mmn7862qKbgTw0qjS9QFK1dzgPjIgYjCNt5mYezgWXC8a8aaLW07UCEiYs8rrNlWbRayJshwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=c8GxXiWs; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="c8GxXiWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=oaZGBd2GE0b76w8ULLAgOyLEE4HsF78Y9R+9eAg+SpE=;
 b=c8GxXiWsU6WLh0LdPi3hJaOMqzJazrT+G+qgWHc72ddMUOzJNluAu284L3fH2lO4sQkEL55Et+0M
   +MoMufb45i3J1icIqBauJ38dJ+3Qg5/B3uYnvSCFnbe1Om4TsL5s4qeQDw863YoEaRiJSG15YE7h
   k3Q1RkDLRjQLuuT1ufOOL0LeWylfoOM/W/hQ4+mDxrWrEW7ytvloqP0M9ocJqhy/Dt1lzoLbF60p
   fvyYTxz4Z4srMgvtzan3OYTwjRIAwIG+kSuCljovtSVyuPkIR9uqJR9jHO9Kju5afJUOkTv+Qp/2
   gH9ai7Gl2wT2RZgAlHliiBqKTs3IGv2Grpyx8Q==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL900GXTNA2P230@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 12 Oct 2024 23:15:38 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v7 2/6] remote set-head: add new variable for readability
Date: Sun, 13 Oct 2024 01:03:22 +0200
Message-id: <20241012230428.3259229-2-bence@ferdinandy.com>
In-reply-to: <20241012230428.3259229-1-bence@ferdinandy.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGyDThqj/DzwlIBYYc38z5yYxtl9qs7mkGlf7wRrUuWXwwLHFDkH9H0TANtg48M
 bt7VpTaqMosFK23dNH7vfpg6dTuEhPCEG9Zb2mdDaTLksvwl/PhwvTKEBj66TXGu
 aaUKLuXFNMjHlWhlGtc8nXvaZyMkbYMLmS7MtQfSFh6iQG+eHhQoCQZoKJMIkBKm
 P1vofcGQi0WPsKiulq6vSalHVo0WZYfz3bDLpCdwKBJ4eo6PgQiqGmdRn+cFGeWn
 sMePn39QtR9bJAYPYGANiMNgjxyOxz8xM383ZmzqDXGYElxp2ge7+ytlx7hCnDSh
 l4scgBdnqF0nFYIrmD8JXyx8MWPER1HcS1MzQOvYTtvkvYb4wvnWIupuXRDHcDor
 S0gGpf22Q/cTcwrv0tqx9Jd63pUPrVIn2VrSl3UmC3bjmkduIoW8UL2AR3WI2VH7
 qR2qAn75CuW1UE/8CzLF7TPyk0kJwCNm/O/NP4Bzv05gCSEaLHlfwiDI

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store in a new refs variable. Although this change
probably offers some performance benefits, the main purpose is to
shorten the line lengths of function calls using this variable for
better readability.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v5: new patch (split from the next patch as a preparatory step)
    
    v6: no change
    
    v7: - change commit prefix to be more in line with project standards

 builtin/remote.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d8ff440027..353ffd2c43 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1404,6 +1404,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	char *head_name = NULL;
+	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1434,7 +1435,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, NULL, REF_NO_DEREF))
+		if (refs_delete_ref(refs, NULL, buf.buf, NULL, REF_NO_DEREF))
 			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
@@ -1442,9 +1443,9 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
+		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head", NULL))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", NULL))
 			result |= error(_("Could not setup %s"), buf.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
-- 
2.47.0.7.g072c39eddb.dirty

