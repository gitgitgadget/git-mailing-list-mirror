Received: from 18.mo583.mail-out.ovh.net (18.mo583.mail-out.ovh.net [178.33.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B025543
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077456; cv=none; b=TKzxoKXiI2yO9Ilf911sAY9FAIDnBJtEdNDKRSxDuxGAxeiAYCNOdKgwTJqsHRnc4d6ADbv5r9t5SH+X6GBsPOFSrIhmGuQuLGWqjVbrnJtaVwujKM/QYws7UqzyXyQ3ewWtQR0t+LAuaqtc2xiB9zMdAzvPRnJWgZso1BD/HRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077456; c=relaxed/simple;
	bh=e0DuWMhu9g4/318aPBkgBXPnWq6g6zflIiHUu4GMLrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8h0FkycCAH59bNDV+SzeAWoZa2MUDqZtA6UeiX2M3IwmTEiAn4VZ5f3MTJnUa1hEN31wtwFH609KFTSxsugwCEpYRzxJ07dLncP+Xnv/9RknwIA/cpCxIufwdv8fG+zN0S2VivRTbRcDIyIUfRFa9863hSga1wq3q/eSOsWRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org; spf=pass smtp.mailfrom=devyard.org; arc=none smtp.client-ip=178.33.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devyard.org
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.140.177])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 8DDB827EBF
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 18:54:32 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-z4d9m (unknown [10.108.54.55])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 50CC61FE42;
	Sun,  4 Feb 2024 18:54:32 +0000 (UTC)
Received: from devyard.org ([37.59.142.107])
	by ghost-submission-6684bf9d7b-z4d9m with ESMTPSA
	id yN1wDWjdv2XGEgAAbck5jQ
	(envelope-from <ypsah@devyard.org>); Sun, 04 Feb 2024 18:54:32 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S0011759a858-b6e9-4507-bc98-cd2f8028aea6,
                    2F615BA836ACE59B185ACC479DFD3D80C8A04DFC) smtp.auth=ashpy@devyard.org
X-OVh-ClientIp:213.10.167.74
From: Quentin Bouget <ypsah@devyard.org>
To: git@vger.kernel.org
Cc: Quentin Bouget <ypsah@devyard.org>
Subject: [PATCH 0/2] Fix gitlab's token-based authentication w/ kerberos
Date: Sun,  4 Feb 2024 19:54:25 +0100
Message-ID: <20240204185427.39664-1-ypsah@devyard.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15954001683053458869
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepsfhuvghnthhinhcuuehouhhgvghtuceohihpshgrhhesuggvvhihrghrugdrohhrgheqnecuggftrfgrthhtvghrnhepgfetueeugedtheefvdevteevgfetjefhkeeuffffkeethfeivedvtdeiieejhffgnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepuddvjedrtddrtddruddpvddufedruddtrdduieejrdejgedpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoeihphhsrghhseguvghvhigrrhgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth

Gitlab supports GSSAPI-based authentication with kerberos but when setup
on port 443, token-based authentication with credentials provided in the
remote's URL no longer works (cf. the note here [1]).

This patch series provides a fix which I tested against such a gitlab
setup.

This is my first ever contribution to git, apologies in advance for any
"faux pas".

[1] https://docs.gitlab.com/ee/integration/kerberos.html#http-git-access-with-kerberos-token-passwordless-authentication

Quentin Bouget (2):
  http: only reject basic auth credentials once they have been tried
  http: prevent redirect from dropping credentials during reauth

 http.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

-- 
2.43.0

