Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE81185B74
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734999; cv=none; b=Bs6j33lonCPzgA7yCpxErlUBTMo4sDx6aF6lS0xNivprDZ2MNDQ4iJlgshKN7FC7Y9HNriT+SFupX9xEOAmrT2G9ECEyUBNs9Farb+Fhu/mIIOZktlWPB2V5N7OvKDavCHwC/YSYOP0IFZPNvCnAn+G2OjeL/s8liMDz97ugucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734999; c=relaxed/simple;
	bh=fAFVBuv10LA02QRc8/E7tmw7rHSiaADhYIKP9tvIgdM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=q7sZQnh11aam5YMh2TQseiLTsC2wFuIVoDAi2OjxpteJ7hbLjOL6bGn8lRI+uT9iRtbYSZIR+Ut6MNbbmzw4yQCmvsNxmYNhD06BiGif72/ZDM/mH3Js3Cyfv6EOkm9VuB35ZqBcVAfhSI0x5aCl1ACDPsIpc5U8kAhb/MqicPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=A19hmGZS; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="A19hmGZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=nmcIT2k0Fg8lH2I5P85N2ZcnNRMFEltQEQg7YHQ2kzY=;
 b=A19hmGZSvBxyK7rKp5lyOkJxz7Px/ZzRFvSDl+80SeYAgIxzEaqh/JjaDiLgPMqXUeCDOFl1lfj1
   sbcKKeVAbRRDL4GtzWG+BU8keS8K9Z3Or1Woep9fS0FrTChgScD2m3mJsMD8nDVXnF1QoF2EFeCA
   HlVMSGHnJmGIWhk6RZRbcNhloKt1LmCCxnkI3d7dwRFO+U29jQ2U+8CkGSVwohamNV20pcMd2Y1z
   wYlKsycMGmvj7DA/whzs6e1yw8uqjlprF+bFifGPwVjYrW87cXc654/eFmOjQdFMqBDf4/VLV09O
   SmMcZD/T8Nhj94+kh8g1yv2jsiHdV4GdOphYUg==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKN00N09CURQF60@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 30 Sep 2024 22:23:15 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v4 2/5] set-head: better output for --auto
Date: Tue,  1 Oct 2024 00:19:52 +0200
Message-id: <20240930222025.2349008-3-bence@ferdinandy.com>
In-reply-to: <20240930222025.2349008-1-bence@ferdinandy.com>
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
 <20240930222025.2349008-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHyeI1GC1WEq4rT6PdihqO8P/mfN0dkRFH643wIUILRJE9M1SidZS4CDd3XE2nQ
 kt2nhmTIBMHS8zWb9GN7jObAD0bgyHTbzQ59S1s5cSJU+D384JLWUDb1mSIc1rDN
 AfelJMSSDOnfSfuRf9pjKYp7stqk3N8/aWsqvTUAj/SBKH8uWizFAA2+9VLY8thV
 demoUEjHCD0f0L8SJX2gXyc8IB15TkhYuW0LO+uFm84ZirJPK8/Drqu3Iyv+f2EV
 oyxtQ14pU12FstYh+BSXEXn/i64ussEH+IOtqFNW6/jIipZHVqwvGEAY86s3pFco
 TVb4klRei7RfEcsFqZSnV3C23IHYyRhbfaPcZX+QEkoU0zbP+Zq0009Ie6JPcRb4
 pp2udLczMR0fiA+e7xZH8oe9E9wxFDSwDqw59eMQzuheHFNlf4w6i4Nk3prR4c5e
 JxSkT7Zhs2alN+Nml7aSEwnHqvyeX19J6Ww46LALJogbL6rdZ8lZe0Y=

Currently, set-head --auto will print a message saying "remote/HEAD set
to branch", which implies something was changed.

Change the output of --auto, so the output actually reflects what was
done: a) set a previously unset HEAD, b) change HEAD because remote
changed or c) no updates.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v1-v2:
    
        was RFC in https://lore.kernel.org/git/20240910203835.2288291-1-bence@ferdinandy.com/
    
    v3:
    
        This patch was originally sent along when I thought set-head was
        going to be invoked by fetch, but the discussion on the RFC
        concluded that it should be not. This opened the possibility to make
        it more explicit.
    
        Note: although I feel both things the patch does are really just
        cosmetic, an argument could be made for breaking it into two, one
        for the no-op part and one for the --auto print update.
    
        Was sent in:
        https://lore.kernel.org/git/20240915221055.904107-1-bence@ferdinandy.com/
    
    v4:
        - changes are now handled atomically via the ref update transaction
        - outputs have changed along the lines of Junio's suggestion
        - minor refactor to set_head for improved legibility

 builtin/remote.c  | 36 ++++++++++++++++++++++++++++++------
 t/t5505-remote.sh | 13 ++++++++++++-
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d8ff440027..c61a7800ff 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1399,12 +1399,34 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static void report_auto(const char *remote, const char *head_name,
+			struct strbuf *buf_prev) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head;
+
+	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
+	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
+
+	if (prev_head && !strcmp(prev_head, head_name))
+		printf("'%s/HEAD' is unchanged and points to '%s'\n",
+			remote, head_name);
+	else if (prev_head)
+		printf("'%s/HEAD' has changed from '%s' and now points to '%s'\n",
+			remote, prev_head, head_name);
+	else
+		printf("'%s/HEAD' is now created and points to '%s'\n",
+			remote, head_name);
+}
+
 static int set_head(int argc, const char **argv, const char *prefix)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT,
+		buf_prev = STRBUF_INIT;
 	char *head_name = NULL;
 
+	struct ref_store *refs = get_main_ref_store(the_repository);
+
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
 			 N_("set refs/remotes/<name>/HEAD according to remote")),
@@ -1434,7 +1456,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, NULL, REF_NO_DEREF))
+		if (refs_delete_ref(refs, NULL, buf.buf, NULL, REF_NO_DEREF))
 			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
@@ -1442,17 +1464,19 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
+		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head", NULL))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", &buf_prev))
 			result |= error(_("Could not setup %s"), buf.buf);
-		else if (opt_a)
-			printf("%s/HEAD set to %s\n", argv[0], head_name);
+		else if (opt_a) {
+			report_auto(argv[0], head_name, &buf_prev);
+		}
 		free(head_name);
 	}
 
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
+	strbuf_release(&buf_prev);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f..711d6e5598 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -434,7 +434,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to main" >expect &&
+		echo "'\''two/HEAD'\'' is now created and points to '\''main'\''" >expect &&
 		test_cmp expect output
 	)
 '
@@ -453,6 +453,17 @@ test_expect_success 'set-head explicit' '
 	)
 '
 
+
+test_expect_success 'set-head --auto reports change' '
+	(
+		cd test &&
+		git remote set-head origin side2 &&
+		git remote set-head --auto origin >output 2>&1 &&
+		echo "'\''origin/HEAD'\'' has changed from '\''side2'\'' and now points to '\''main'\''" >expect &&
+		test_cmp expect output
+	)
+'
+
 cat >test/expect <<EOF
 Pruning origin
 URL: $(pwd)/one
-- 
2.47.0.rc0.5.gf1cffeb8df.dirty

