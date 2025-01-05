Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB2158538
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093754; cv=none; b=qBCWkAyvWXyeIblWCH6QGdQ1luO7PCRC1Q7gLFiSAx+uoioMWJrVaGsOO8wb7qcx7+oR9knaFryw1hYlxEqtFdpQhHmG3BfDboLlBjlKuhxIfmTfgFqP9icFd305rPkPGsAQNWSSVDxc6Qln+dEiW6De08BxkHw1+uYA7WH/2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093754; c=relaxed/simple;
	bh=PjQNB/p7vA4V2z8uC/c4NPRxMt7pNr1r6RJRtuij00w=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=CZzUUGqe4pFLyCGE3e0qjU7hDLb6lYI79agifwNITycoS+6ZcETn2SKq6y0LuGALXvjhmCyrMtSJeXQZ0Qndw0ljadTqvqaq5LGXLXZCCNDxMOBhB528K6WORNqN9PehFXoJL1IToHiBcAt7zSfhc8UddLJEgHUQ/XT0/Y+TDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=d3NRExZF; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="d3NRExZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=7kOxR9R0Zd0j5ftTNb3YD7QN+SSbIzZWNb/1yRLwW70=;
 b=d3NRExZFJ6YirYiayLyczBdT0IW5yllFG2SEkKJyCZ24TVOhFGB2aHQUNqWWcnLxmoxZ06Xkyt/O
   Sa3dSdE0EGRjIzcfbX9sHkGA2yAKgrze8MDDa0vy0lvWomVDNc7eXjPEN60f1ouIoSVs485upVQ0
   kigcgetzjGSGzy9soNOnBC01QCtPQ3F+X32VfpYb6f2vbQuGdm8rO36kXPbADJMc2+e3bmmvlkUV
   lyrHhxO3Q966cEE9+t4kCt69iAe6InMtEreL7sh5CiqHjtA8HfURdwJVKJk6mVY3EbqUkf7QIo9l
   3cyvhHTUjjIiSfq96ErxNvLCCZdBmh1Bcd03pA==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SPM0021MI9UJ550@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 05 Jan 2025 16:10:42 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,	karthik.188@gmail.com,	l.s.r@web.de,
	me@ttaylorr.com,	phillip.wood@dunelm.org.uk,	ps@pks.im,
	"Teng Long" <dyroneteng@gmail.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH] fetch: fix erroneous set_head advice message
Date: Sun,  5 Jan 2025 17:09:40 +0100
Message-id: <20250105161017.210412-1-bence@ferdinandy.com>
In-reply-to: <20250105114201.35079-1-tenglong.tl@alibaba-inc.com>
References: <20250105114201.35079-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFBIT4dEOBGz7BK91AbWKz2TtlIzd3GMBMS8dCWPbdG14EkF4aXr+vJ2uW5q8Mh
 YNBAYt6o1xXBpKBMOtXI0rN0Qxl+LAI+BF+WhbIKiAB6EKuCSCGibLRD8d4D6sTz
 JjIK2jyi8NsnrRcws8OTpvmTc/1fIOhy18Tora1ZKRTxWgVHrq3MvLWBBeeCjIze
 mONi4GonOY0gq4nXd7nAgMaRsfyiKFjIt83tm2ahiR9LJr1GLjvwieZ/oTHCYwYI
 CaDIh3Z47RunDSvLxk2ndoW7aIRBlHu+F2hNn06lFCijvKMEL4O3CJpk2ZLhc/OA
 W4wWny/RoTwzHTlmb7Agfl2zBAB73rXfATk3nq6YdE31JJGWt2cZjeV2W+HVc5IX
 WM2gBjOEsERpm9/iyn/QK/zXD13i/q5MZ7HxePaku0ZfKK/3q9/bSei+FtRtqFcl
 7i5E75iTAfjF4jOGjWP16aKkpigMX/jS+Qjnno//ZNVzSBYiy8c1rioo

9e2b7005be (fetch set_head: add warn-if-not-$branch option, 2024-12-05)
tried to expand the advice message for set_head with the new option, but
unfortunately did not manage to add the right incantation. Fix the
advice message with the correct usage of warn-if-not-$branch.

Reported-by: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2d37a378ba..fe2b26c74a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1588,8 +1588,8 @@ static void set_head_advice_msg(const char *remote, const char *head_name)
 	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
 	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
 	   "if you do not want to see this message. Specifically running\n"
-	   "'git config set remote.%s.followRemoteHEAD %s' will disable the warning\n"
-	   "until the remote changes HEAD to something else.");
+	   "'git config set remote.%s.followRemoteHEAD warn-if-not-branch-%s'\n"
+	   "will disable the warning until the remote changes HEAD to something else.");
 
 	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
 			remote, head_name, remote, remote, head_name);

base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
-- 
2.48.0.rc0.146.g306ab352f4

