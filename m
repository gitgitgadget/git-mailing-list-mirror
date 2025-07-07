Received: from 9.mo561.mail-out.ovh.net (9.mo561.mail-out.ovh.net [87.98.184.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B0262FFE
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.184.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914653; cv=none; b=l+XF1T8e1syspzLigkYtkHKMKpMl7NENXRRZ9lJfuz28Opre2eleDiZidfs/21o/FL+j9NeOunMSKQ7ZRttygclW/0lrzlklVsBHj91nAk/egfWv+TR7G8t7C0eeAY0hyF5rnk2Fd57D0VzIqZHjSrt5xVKdGIRhZp9yLjPLMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914653; c=relaxed/simple;
	bh=6ERTrckbYuGYYm6BMANENZEkO7o5mmY3tRkhmVrTIuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kn9OMURPG/0yB8uN/jaCEjhFmuShrTXvKZSLEhasDOKmwBnTKqVSmRCBDF9/GASfUM4mumIqENM9JlbxZvc3xjJp8sXPhMMI60w+8fOMQurtgLPU7O2Jh3tSvyudEFgKhtY5J6gERk5s89nzrG0xMUIfIJ+Gy8F2c9U+MxsArSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=A4IHGWAY; arc=none smtp.client-ip=87.98.184.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="A4IHGWAY"
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.249.122])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4bbYDl5d7vz6Mkr
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:49:11 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-k86ff (unknown [10.108.42.28])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 882738162A;
	Mon,  7 Jul 2025 18:49:10 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.101])
	by ghost-submission-5b5ff79f4f-k86ff with ESMTPSA
	id wOndEqYWbGhEGAAAJc5QGg
	(envelope-from <redoste@redoste.xyz>); Mon, 07 Jul 2025 18:49:10 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G0041b9f5cce-d667-4b4b-b233-da2a597211b9,
                    D0C7EFB74D5D647EA3E92B704F5959655B36BFB1) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
From: redoste <redoste@redoste.xyz>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	redoste <redoste@redoste.xyz>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3] ssh signing: don't detach the filename strbuf from key_file tempfile
Date: Mon,  7 Jul 2025 20:48:51 +0200
Message-ID: <20250707184852.16010-1-redoste@redoste.xyz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230829.29696-1-redoste@redoste.xyz>
References: <20250704230829.29696-1-redoste@redoste.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1632273393259025888
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -83
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddujedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheprhgvughoshhtvgcuoehrvgguohhsthgvsehrvgguohhsthgvrdighiiiqeenucggtffrrghtthgvrhhnpeduvdejtdejuddvteelfeduvefhffffhfefkedvteekudffjedthefhkeeuieetjeenucfkphepuddvjedrtddrtddruddpiedvrdefgedrvdegledrfeejpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=k6Lwb35hVC60kqe7IU/3KFjFvq/YDUDJPlTjT/Gsjg8=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751914151; v=1;
 b=A4IHGWAYkIt/cF5YFNoFLK702RuQitVnb0ixyaWgFekKCwWr8qx8J1YdU+2Q6gEDzNQWLax2
 kJMgxsd5uEyUWgjsjZz9OZDaNbVD2zn0O6BrZzZxxIPIdSg6W6VKY/eHNtBvRxpT5oUWm74wKfp
 VGePHbHgs4ttJ5Ge3c+QskJOY9KiF5l7SxO/kJUsBSMJW6QgH9JbISeexA1MTGmJoFXGXi2x2C/
 A6cVFmdAR8t3az7wSnj86rlpfMXSw6XI7fJoccJBLlGfBb7FOLRUkjG9GJ/3vlXOaI7TJWySFNZ
 OshAeJwb058fv51wATrA1o/zz8fsYulUpxJd1yuWZkDog==

Detaching the filename string from the tempfile structure used to cause
delete_tempfile() to fail and the temporary file was not cleaned up.

While it's possible to get rid of the allocation and copy from
xstrdup(), it keeps the code symetric with the other branch since
interpolate_path() also allocates and ssh_signing_key_file is freed
in both cases.

The exisiting test was updated to check if the temporary files are
properly deleted. To prevent TMPDIR from leaking into the other tests, a
new subshell is created, however this prevents test_config from working.
The cleanup of the config changed in the subshell is done by
test_unconfig in a call to test_when_finished outside of it.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: redoste <redoste@redoste.xyz>
---
v1->v2:
 * add a test case that checks for temporary files after signing commits
 * add small explaination about the use of xstrdup() in the commit
   body
v2->v3:
 * merge the test with the previous ssh-agent test
 * export TMPDIR in a subshell to prevent the environment variable from
   leaking in the next tests
 * use test_must_be_empty instead of test_line_count

 gpg-interface.c              |  2 +-
 t/t7528-signed-commit-ssh.sh | 32 ++++++++++++++++++++------------
 2 files changed, 21 insertions(+), 13 deletions(-)

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
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f780636..0f887a3ebe 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -84,18 +84,26 @@ test_expect_success GPGSSH 'sign commits using literal public keys with ssh-agen
 	test_config gpg.format ssh &&
 	eval $(ssh-agent) &&
 	test_when_finished "kill ${SSH_AGENT_PID}" &&
-	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
-	echo 1 >file && git add file &&
-	git commit -a -m rsa-inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
-	echo 2 >file &&
-	test_config user.signingkey "$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
-	git commit -a -m rsa-config -S &&
-	ssh-add "${GPGSSH_KEY_ECDSA}" &&
-	echo 3 >file &&
-	git commit -a -m ecdsa-inline -S"key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
-	echo 4 >file &&
-	test_config user.signingkey "key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
-	git commit -a -m ecdsa-config -S
+	test_when_finished "test_unconfig user.signingkey" &&
+	mkdir tmpdir &&
+	TMPDIR="$(pwd)/tmpdir" &&
+	(
+		export TMPDIR &&
+		ssh-add "${GPGSSH_KEY_PRIMARY}" &&
+		echo 1 >file && git add file &&
+		git commit -a -m rsa-inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
+		echo 2 >file &&
+		git config user.signingkey "$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
+		git commit -a -m rsa-config -S &&
+		ssh-add "${GPGSSH_KEY_ECDSA}" &&
+		echo 3 >file &&
+		git commit -a -m ecdsa-inline -S"key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
+		echo 4 >file &&
+		git config user.signingkey "key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
+		git commit -a -m ecdsa-config -S
+	) &&
+	find tmpdir -type f >tmpfiles &&
+	test_must_be_empty tmpfiles
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys having defined lifetimes' '
-- 
2.49.0

