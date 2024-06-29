Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586C22331
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719684090; cv=none; b=IQ9OYXgrovrv87Rw1cCOQqDaBqLDq1nXhmn4eJdFSei75Va/m5fJ4MrIokMboga0IU8A+RZXL/fwAPKQTIlJE6dCQ6Cq0i0k7FML/UARqaT6DhhwAIi3CHxjGWPQZrLjk4Gd84/MX1HKC3rA+fCLoYIa9FU/gTwg/Saz0+jGtx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719684090; c=relaxed/simple;
	bh=2c8L7XtlDk28RnlsVjOl6AYrhUHmH8xl7EotSZIHm2w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Te3G13jg7+27419eSIDsdUEGw6fJbj9N3124u5I1VSl3dwpDWV69JpZm4f4+6CAR2scJlWSxVndbnvdGQV1WqWfPQpNi1n73a66i+TZAppLG4GhUO7iY3gdixYRAs7YtpJgfwzbga6Sg8PwCBtQvb2xhJ3DK72rmx+dbdN5bqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Pn+hhM+2; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Pn+hhM+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719684085; x=1720288885; i=l.s.r@web.de;
	bh=ux2/lgyOczPFKVWN/h3X981ofSqFziefyE2XOu7Chw0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pn+hhM+2KUbFca/jbMMgN2w9FOVlCBPleLbwR5QrIwsoL73jrYPcZaa2wFXTC535
	 wYdWs9g1vaYedJUYkuTTW58l77Wby+FEAXdPu8TUCa1CpogkHZ62SMAfhCCsPfBP2
	 4Dl6bMiRybmMwzgaDM+JEgWFeOuuKKWNUqJ1TZJqyAUKj9vtIxIRSYBGQjwKrYIN3
	 qsKw+KcgllIXh0ljndF4rhoDDOJOzwlKxsfDPSKwvH6OwvXlveZlz7VXC5jWwdc5l
	 +MgTjzFAtwDxvqlhcQSmhPebZs8iJfI4BkH4bpyBCe+voocRTD5rtkRsRXPdskcnk
	 zLDOvBGxWsIqnhnJPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7usy-1sSaCF1KiY-00Bh82 for
 <git@vger.kernel.org>; Sat, 29 Jun 2024 20:01:25 +0200
Message-ID: <fb79ebc4-5ecf-4257-ac2e-39f98db5649c@web.de>
Date: Sat, 29 Jun 2024 20:01:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] submodule--helper: use strvec_pushf() for --super-prefix
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WQcE/q8ZLWDFBMa/BUJuxWArBAMITSifOrauUcuvnavPftNzH6K
 k//HM5jT0QG4VtdqGFkup8Mqo/N1PHVeaSsLw0M2PrEGomzVdm7GUuFkIBIpY43euG90xWB
 qWIK7KrateDHM84Ra30hFZDS/KNxS6iGiIcIxjFqSK99f1D+LUMQ+xeZt7G5vqyV0JCMIus
 TMZpuiQHWBfQO4FJgmBQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S5SJCvua6Lc=;1cbMF7ZYXOe5yWywS4tHvy6bCzb
 6/ZsDUDlnQEWaxIBG2bHmCiadDy8reDgC3zVsFfjgKMqT6rEnpvfRJCw1EeQtdMi4+0nb04UY
 n4r2cb4Q2OSat6+W7U166wAM+qOUgurj6+AifB1P/YLUfibBIsBwUYwBJxjILdZI/zZwB8xq9
 NaI0JdwlOlbSqMGHuYouL1oDofmMmMs8aD3H6byDNBDc/ZbfKAXGTt6tljO3WjakGaJOo4qzG
 k6tSfX4qQ0FaMbPMZAII11FRGgQpN4OkjIC/aZiZsyIRbc8PRpiDmy8aujjcMtmpnuYCLQ0RN
 u6MYojVrGaCK9AZZAvE6+7pzd4L1B45d4yCK093+Jv0Alf4QjPTw45bDijcxZn+m6f9jtFls0
 V9+KUVcSUKcBnIRpMVYO9qanF4XbxV2NhYZREyBGtAxdQjPv299bF667oDc379VwRQzm/4hYh
 eZ+pcAaCkEm/MmtDENkc9i2Xeub1gHFISCwSMGNfTHfHpjgOfv0V8qNfQ0mY98e3ldXlN4rKu
 oGorqm2yrJTDJYHIIodjA+IdmQmgzD8JMZ2VX9xVfvm0Ci8TRSJngXtYcXGEcQF7Gbxp47AzO
 U9cCaxpPLJs6sOdnmOaRmRekpKwu+z2bVFEeBAWr7NIL0hQj9tHCSIi7cBdcR6FDL75pLvAhT
 uYjB40plsl9NLWieh8ylQuA9LpgvlZOnLfq/VXBR/EUpl9uYri1vZDYzwwmzApS15xNlTySAR
 7/XqibmLVNjuSAPbe2xdGC3ZmqyXHVM3KPuFWcBkOLKPBdy9YvEAiFnsfnwU5LirrVp7eSiGN
 uIx+vOsWCC7me4yHdrh4Nw5d80dkE1VXLO7AM5yjCmOXs=

Use the strvec_pushf() call that already appends a slash to also produce
the stuck form of the option --super-prefix instead of adding the option
name in a separate call of strvec_push() or strvec_pushl().  This way we
can more easily see that these parts make up a single option with its
argument and save a function call.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/submodule--helper.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 880ab4456e..f1218a1995 100644
=2D-- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -376,8 +376,7 @@ static void runcommand_in_submodule_cb(const struct ca=
che_entry *list_item,

 		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
 			     NULL);
-		strvec_pushl(&cpr.args, "--super-prefix", NULL);
-		strvec_pushf(&cpr.args, "%s/", displaypath);
+		strvec_pushf(&cpr.args, "--super-prefix=3D%s/", displaypath);

 		if (info->quiet)
 			strvec_push(&cpr.args, "--quiet");
@@ -702,8 +701,7 @@ static void status_submodule(const char *path, const s=
truct object_id *ce_oid,

 		strvec_pushl(&cpr.args, "submodule--helper", "status",
 			     "--recursive", NULL);
-		strvec_push(&cpr.args, "--super-prefix");
-		strvec_pushf(&cpr.args, "%s/", displaypath);
+		strvec_pushf(&cpr.args, "--super-prefix=3D%s/", displaypath);

 		if (flags & OPT_CACHED)
 			strvec_push(&cpr.args, "--cached");
@@ -1304,9 +1302,7 @@ static void sync_submodule(const char *path, const c=
har *prefix,

 		strvec_pushl(&cpr.args, "submodule--helper", "sync",
 			     "--recursive", NULL);
-		strvec_push(&cpr.args, "--super-prefix");
-		strvec_pushf(&cpr.args, "%s/", displaypath);
-
+		strvec_pushf(&cpr.args, "--super-prefix=3D%s/", displaypath);

 		if (flags & OPT_QUIET)
 			strvec_push(&cpr.args, "--quiet");
@@ -2534,10 +2530,9 @@ static void update_data_to_args(const struct update=
_data *update_data,
 	enum submodule_update_type update_type =3D update_data->update_default;

 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
-	if (update_data->displaypath) {
-		strvec_push(args, "--super-prefix");
-		strvec_pushf(args, "%s/", update_data->displaypath);
-	}
+	if (update_data->displaypath)
+		strvec_pushf(args, "--super-prefix=3D%s/",
+			     update_data->displaypath);
 	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
=2D-
2.45.2
