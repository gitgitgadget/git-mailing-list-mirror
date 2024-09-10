Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325D1AAE2B
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000638; cv=none; b=gWWEfUP3FOtALnX4zLoTOj4GKzfh5r37pezmVHCzJy12lC+/uujeoM0q5M7aiy6/Sl63P9H5Y+M92/0P++nX1IH3pCVfQTYl3XI/4lFlkJ9vrrICFjhfDyl7HtQreaR/3SbG4W0i3pFLzs0u+3+8WogBhRWQfu+qYhaLRe0O2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000638; c=relaxed/simple;
	bh=b5NrbsBixKD2I1DrQJ1TlOrzd6gVpzK7pQW9yz0tf+o=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=CxbjqkCEfxWv4Xg9VUl0hDab+rt5xGZEtG4GOGMhQbV8XcJbdsymfTV8ngK1hgszJUXLApeUZUhSA1w8zNzDvcmPAq5iQifE9kJyLqosaEN366eXRmEQI6NKSO7qy4o53WwJYNMG4+8jVY4J2xvIjeFtYtSdH5Y4z8Qpjht4Bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=eXaYUVYO; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="eXaYUVYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=6U7X65IS9yvt5ArGE0vZuKwRwAVma+9LaJi7Q8pWPzQ=;
 b=eXaYUVYOq60XplSybgL3tBoRwNKGFTkOO0U60zBfpVkfGDfSXrj+A/Al918vHmy9NaOBXohpGlK0
   3FghgzJMbMmVvYDdmyE11HNQTFbrvsjclaEV3/dGVXKKHTmPiYA5T3qUZADOwrElGiPSvLSG9OGe
   8NxvitPGKKHJpvH4pzEdt2FzFzB0+K60QS0Yj6nwJXCHPh0L+35VJsC/MszVRF3hK01dYt+Q+Wiw
   rz2Ewm+t9p9SCj13T0OnN5j67ClJDrAfZ8CUZxA/fSL6YezT+sxtyOUMXUVq0e/Hj9cJpCBRQZtL
   d3uxJq1GKvjtCvUXZZ8HWK2Cp6RK9JoqxV1fCA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJM002ZH6DJPM80@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 10 Sep 2024 20:32:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de,	Bence Ferdinandy <bence@ferdinandy.com>,
 cc@mail.ferdinandy.com,
	/tmp/FUboFpyPuH/0002-set-head-do-not-update-if-there-is-no-change.patch@mail.ferdinandy.com
Subject: [RFC PATCH 2/2] set-head: do not update if there is no change
Date: Tue, 10 Sep 2024 22:24:59 +0200
Message-id: <20240910203129.2251090-3-bence@ferdinandy.com>
In-reply-to: <20240910203129.2251090-1-bence@ferdinandy.com>
References: <20240910203129.2251090-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFxi86bPgRcegmbXIsY/P7lbwx4JNeZPF/hHo7CO58m8jRv1gYSgzOjKP2xP//n
 6TfHVxYFhd/f6MHZWCwICNT2hqDCm6ulmMAMRvMRNHSNV/yS9Nsp5ySM9Ykh1tv3
 1zOnVl7FyG8W8GHN0z+Mp5K6R9e5FOSFpSjh3aI33DzYjz/clCUTZa4htKH9xQBh
 dT3f1W0UUciBMgvasKOOAslIXMB9Er1LjTnLxaBjqN7eNHwqcfQt3JL3kkmEFttu
 68BPvMl9SmEX1tebM3ulGXJLE4dUsDjScqHmNcDZIJA1PZgXq8+J/7oydFh7+LxS
 oPASqsOqx8pSOrYks8GsyHvkv1nMufGtSob15FQN647v458/GhTlGsoJVfQHmLo+
 /OOKra9SYsKmikYGOcktC81k1WSpU9CfLRD20voRoQ9WRrAYanVkCPNUj6rRBdtf
 GrDk0Tai0p/cqXhHA5fQSlmzoWhzWDIIJPwxPp1urQuybw4z89w7PXY=

Currently, even if there is no actual change to remote/HEAD calling
remote set-head will overwrite the appropriate file and if set to --auto
will also print a message saying "remote/HEAD set to branch", which
implies something was changed. In contrast, on a nil operation e.g. pull
will clearly state that nothing was done, while fetch will not output
anything.

Change the behaviour of remote set-head so that the reference is only
updated if it actually needs to change. Since set-head --auto is
essentially a fetch-like operation, align it's behaviour with fetch and
only print output if something was actually done.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/remote.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 35c54dd103..e220e51b84 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1400,8 +1400,8 @@ static int show(int argc, const char **argv, const char *prefix)
 
 static int set_head(int argc, const char **argv, const char *prefix)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	int i, opt_a = 0, opt_d = 0, is_ref_changed = 0, result = 0;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
 	char *head_name = NULL;
 
 	struct option options[] = {
@@ -1440,12 +1440,14 @@ static int set_head(int argc, const char **argv, const char *prefix)
 
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		refs_read_symbolic_ref(get_main_ref_store(the_repository),buf.buf,&buf3);
+		is_ref_changed = strcmp(buf2.buf,buf3.buf);
 		/* make sure it's valid */
 		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
+		else if (is_ref_changed && refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
 			result |= error(_("Could not setup %s"), buf.buf);
-		else if (opt_a)
+		else if (opt_a && is_ref_changed)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
 	}
-- 
2.46.0

