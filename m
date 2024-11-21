Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB81DE3CE
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230647; cv=none; b=R6IFco5PEHIYlYJCSbsntQa+TfDJpbtRXSW0ygCZ8DHKRx2g4TYlLV+3jhS6eMARc0x4UM7p7scHfyZ1L/efdqvaaWQGh7iUv6Jk4KTlQVuigU51a6980Yk1hfslYwNkooziJADTnBF49Py03xCHeiM0Qv6O0spp61KhF2iUbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230647; c=relaxed/simple;
	bh=ZtJBs7eVe5UGwXkkhfEdfXKJk7nX2mt6AatoAY5lt6U=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=FPvu1Ia7ZDv5m+mh4d+uUsiSdoRWmy8OPx9YCz8n6OLe9/Oph4j2f/edQIqRI9eZU8SL1XI4V9BENpZl0ddDAkzd2GF6G+NkWPIf7s8YcVHbkHYISEHqBhXdMW1fcRQboA+3OLi0QhB2cYksfUcBjip/zNRyQ/uTS/SpyIIOCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Bwho4dCq; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Bwho4dCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=cVqC39dXyYdJ3js9JstsoAe0IHbmoEeoDH4q1sLFo/k=;
 b=Bwho4dCqTlJHgFaWzryMVA1llLHwRKkPeSv/dU41mx45PTdOHH759YsmwkqWVstcJtMXbSFrENt5
   U9yWE7b9kJv8fPSZBgSPsS3m9qVgvaylt7mxuK554Xgjaf08xRyzl+6QPkiPDhnBRC+gpEE/2DZS
   hlBoddfVHqAPvh8H7gTICMHrdCbDMrvlowld5N2AxRSAODgcYG92UrODoufOeIL0V5Pd96z+2sKT
   T2InIzC0BKU4LTfdMb225zflADtMTCy0vDPVZfCboD+D89CCB3WDZcq7OeyIfpdiM3yGOypTqnSD
   5prHKj34VBmwCwO0z7VCClwwJs6EqbV0Hq0npQ==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB00NNGPPQBT50@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:38 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 06/10] remote set-head: better output for --auto
Date: Thu, 21 Nov 2024 23:55:06 +0100
Message-id: <20241121225757.3877852-7-bence@ferdinandy.com>
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
 AAHd84Hzpuqkwcc35CxQIH07TVs1gyHKWGJbWSYW9PUVbdWjPAD9MsAm+uD4T00S
 KKfP9LBszRWf7ki3EBKju86foe85HPzO9ktyVaVt7RyJgN/iwugvN8bgXMoQbrka
 E6baaUo06nWvUC7QyKgSa7ox9XkMpZxx1XOE0ZPAclj72CHZH/K+usEUZOjPsyw3
 PXQrJUH9XDhMYx59fo5r0DJCPXgMvk5D3dGEmTgrsKx3e5HfVH6iYCUxBVOnZqUg
 DRrK0+4CTcU11FQIHu/6VmjTOiYh/C+l8AidMhs1jWqt02sny6nfQ9RH2xBCNkwV
 9pillirqiLbUVkYVe8VzLVPSyuFC0qt6Y7jrbc1lFXWUTqammmWwfE/HPDBJ0cQO
 fdby4tOKtOdeJbUaJkmxYdBaRJ6BnRmWCsB76skuJhBiWGzhP+2OGNaXHGWOUo9A
 TFiSgwuY3HwnNY5ucFyKXwh6OSCEtb+/xukZfsag2GfpTWP9uwwXmxHj

Currently, set-head --auto will print a message saying "remote/HEAD set
to branch", which implies something was changed.

Change the output of --auto, so the output actually reflects what was
done: a) set a previously unset HEAD, b) change HEAD because remote
changed or c) no updates. As edge cases, if HEAD is changed from
a previous symbolic reference that was not a remote branch, explicitly
call attention to this fact, and also notify the user if the previous
reference was not a symbolic reference.

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
    
    v5: - the minor refactor has been split out into its own patch
    
    v6: - fixed uninitialized prev_head
        - fixed case of unusual previous target
        - fixed a test that would have been actually broken at this patch
          (the output was only correct with the later update to fetch)
        - added 4 tests for the 4 output cases
    
    v7: - change commit prefix to be more in line with project standards
        - fixed tests to also work with the reftable backend
        - renamed report function, fixed style issue with checking buf len
        - fixed not releasing an strbuf
    
    v8: no change
    
    v9: - mark output strings in report_set_head_auto as translatable
        - rename buf_prev to b_local_head for consistency
        - use ${SQ} in tests instead of '\''
    
    v10: no change
    
    v11: no change
    
    v12: no change
    
    v13: added handling the edge case of previous remote/HEAD being
    a detached HEAD
    
    v14: - fixed badly named variable
         - fixed not reporting errors correctly

 builtin/remote.c  | 59 +++++++++++++++++++++++++++++++++++---------
 t/t5505-remote.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index bcc3ee91ef..6d659d63ca 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1399,10 +1399,38 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static void report_set_head_auto(const char *remote, const char *head_name,
+			struct strbuf *b_local_head, int was_detached) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head = NULL;
+
+	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
+	skip_prefix(b_local_head->buf, buf_prefix.buf, &prev_head);
+
+	if (prev_head && !strcmp(prev_head, head_name))
+		printf(_("'%s/HEAD' is unchanged and points to '%s'\n"),
+			remote, head_name);
+	else if (prev_head)
+		printf(_("'%s/HEAD' has changed from '%s' and now points to '%s'\n"),
+			remote, prev_head, head_name);
+	else if (!b_local_head->len)
+		printf(_("'%s/HEAD' is now created and points to '%s'\n"),
+			remote, head_name);
+	else if (was_detached && b_local_head->len)
+		printf(_("'%s/HEAD' was detached at '%s' and now points to '%s'\n"),
+			remote, b_local_head->buf, head_name);
+	else
+		printf(_("'%s/HEAD' used to point to '%s' "
+			"(which is not a remote branch), but now points to '%s'\n"),
+			remote, b_local_head->buf, head_name);
+	strbuf_release(&buf_prefix);
+}
+
 static int set_head(int argc, const char **argv, const char *prefix)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
+	int i, opt_a = 0, opt_d = 0, result = 0, was_detached;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
+		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
@@ -1440,20 +1468,27 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
 
-	if (head_name) {
-		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
-		/* make sure it's valid */
-		if (!refs_ref_exists(refs, b_remote_head.buf))
-			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
-		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
-			result |= error(_("Could not set up %s"), b_head.buf);
-		else if (opt_a)
-			printf("%s/HEAD set to %s\n", argv[0], head_name);
-		free(head_name);
+	if (!head_name)
+		goto cleanup;
+	strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
+	if (!refs_ref_exists(refs, b_remote_head.buf)) {
+		result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
+		goto cleanup;
+	}
+	was_detached = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
+			"remote set-head", &b_local_head);
+	if (was_detached == -1) {
+		result |= error(_("Could not set up %s"), b_head.buf);
+		goto cleanup;
 	}
+	if (opt_a)
+		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
 
+cleanup:
+	free(head_name);
 	strbuf_release(&b_head);
 	strbuf_release(&b_remote_head);
+	strbuf_release(&b_local_head);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4e127bf5b8..e6acff4afe 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -444,12 +444,63 @@ test_expect_success REFFILES 'set-head --auto failure' '
 	)
 '
 
+test_expect_success 'set-head --auto detects creation' '
+	(
+		cd test &&
+		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto to update a non symbolic ref' '
+	(
+		cd test &&
+		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
+		git update-ref refs/remotes/origin/HEAD HEAD &&
+		HEAD=$(git log --pretty="%H") &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} was detached at ${SQ}${HEAD}${SQ} and now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects no change' '
+	(
+		cd test &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} is unchanged and points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects change' '
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/ahead &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} has changed from ${SQ}ahead${SQ} and now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects strange ref' '
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/heads/main &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} used to point to ${SQ}refs/heads/main${SQ} (which is not a remote branch), but now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
 test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to main" >expect &&
+		echo "${SQ}two/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
 		test_cmp expect output
 	)
 '
@@ -468,6 +519,16 @@ test_expect_success 'set-head explicit' '
 	)
 '
 
+test_expect_success 'set-head --auto reports change' '
+	(
+		cd test &&
+		git remote set-head origin side2 &&
+		git remote set-head --auto origin >output 2>&1 &&
+		echo "${SQ}origin/HEAD${SQ} has changed from ${SQ}side2${SQ} and now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
 cat >test/expect <<EOF
 Pruning origin
 URL: $(pwd)/one
-- 
2.47.0.298.g52a96ec17b

