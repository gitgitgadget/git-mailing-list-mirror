Received: from 7.mo561.mail-out.ovh.net (7.mo561.mail-out.ovh.net [46.105.57.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC335972
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.57.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751675247; cv=none; b=TcwvMNgLghOb5uw09CiK/wMHzHC3uv1WWA+++1IqNTbfiTraVLIb3mlARnDxYHLDYxW20NgKbx5kN3EAAzt8NvpRsP3sKIREPRcETIurn7tNX+/jGmRjWBcGfrN/NdiCUfoL+a8wUZLBTYDyyYQkvtpHPHQ1A+IZgiILCCxjHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751675247; c=relaxed/simple;
	bh=c4tjj8uGjkILVy8soVfHOPI7/Qmt2jqNkHY+/QnlVDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQK35+PRmwilryvw3AuChuJxQoXRvOcjpvFgcMysdlGiSPFHgGrOnY2EBjVh9JUVCY/PVWAoCyIyRwOBipyIKkeuuq5i7MCQL+XI9yGYVje/WLOmQYqOuwikfmkhtxJc+F5+IPVvPNSNgD2h3U7UKUX7+MQ2LjQLufkuPrC5Y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=tlz1lpRl; arc=none smtp.client-ip=46.105.57.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="tlz1lpRl"
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.249.188])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4bYq8D0MF6z5yBl
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 23:09:16 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-j66bp (unknown [10.110.113.27])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 564198162A;
	Fri,  4 Jul 2025 23:09:15 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.111])
	by ghost-submission-5b5ff79f4f-j66bp with ESMTPSA
	id mlbwDBtfaGgHKgMAUTtfiA
	(envelope-from <redoste@redoste.xyz>); Fri, 04 Jul 2025 23:09:15 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-111S005fd43fdb6-f82f-4f56-95d5-0151842f7430,
                    B7FF274696B85F25958CC2D2EDE21C6E7056D288) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
From: redoste <redoste@redoste.xyz>
To: git@vger.kernel.org
Cc: redoste <redoste@redoste.xyz>,
	Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH] ssh signing: don't detach the filename strbuf from key_file tempfile
Date: Sat,  5 Jul 2025 01:08:28 +0200
Message-ID: <20250704230829.29696-1-redoste@redoste.xyz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6853071259641353572
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgeeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheprhgvughoshhtvgcuoehrvgguohhsthgvsehrvgguohhsthgvrdighiiiqeenucggtffrrghtthgvrhhnpedvkeetgfeuffdvleeifefgleegveeugfdtheetgedvhfefgfdvgfeltdeikeevteenucfkphepuddvjedrtddrtddruddpiedvrdefgedrvdegledrfeejpdefjedrheelrddugedvrdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=YzDNU8HH7EbWUdhA4Rd3UyLRqQiafuDFBNWpeoJKqQw=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751670556; v=1;
 b=tlz1lpRldyLqEp1b57sCzZ9cU3YCZAP859YBjC+8mg5WpJLBHJyrJiU2F14fOLJZPAhlDmhb
 S9yRUwXnilm09kGR6UUrOfnIZ046gfTX3UgjuYkdZzbT0HWg1N9/IPq8xCN8h6kG6Z70XPhaZIc
 SzFh5JAp8JMIiuXsWWNQVx9KnmL9ry65vnazHswE7G9TXZC5e9A6njPlqCQCeVfCUNeUFmLxHen
 qFlQh5TNczJFiyyeA3etGr+n36cirq9+HFx8DnX4hFz6CZF6fb8yegKRcY6Xfc7r1sjzOvZ0KJa
 t4ihtrxphx9ZivB2atduHjQrthBDMZ2Ub/N8whNFmqZ6A==

Detaching the filename string from the tempfile structure used to cause
delete_tempfile() to fail and the temporary file was not cleaned up.

Signed-off-by: redoste <redoste@redoste.xyz>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..bdcc8c2a2e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1048,7 +1048,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 				    key_file->filename.buf);
 			goto out;
 		}
-		ssh_signing_key_file = strbuf_detach(&key_file->filename, NULL);
+		ssh_signing_key_file = xstrdup(key_file->filename.buf);
 	} else {
 		/* We assume a file */
 		ssh_signing_key_file = interpolate_path(signing_key, 1);
-- 
2.49.0

