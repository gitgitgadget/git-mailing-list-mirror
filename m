Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C135C614
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824614; cv=none; b=D90PmDpA+Dd0ltQ5VK8IcycXh5gOC+sJbo2YWnr34YJ5sLS+uV5lte2b9o9ZCMqd+eWJZStUliZo0IegMtpygTpbqdJQdKbOl1eGNRP28N0Lnni/0HuvpemthFYAkfG7fWTfsJb9FRUPsOIv/Ke9NY2gGw6HbZKLWpqThvw2c7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824614; c=relaxed/simple;
	bh=AIWkGJaNsLIU3T+0Vki7myB+Og3PLa/vGOHsm8yOA3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5RjmV27kMIusZv9gF2RCWqIojSdqzNkRzk7jCSNGx6XQ+M2wRMOPIGHPNAH0X0sVLz8AMC9RvlrdmtxC91+7btyJ3XkgSr4o1lUYTzfRAOZVZ0Yheri8hhfe+zZxjQRRfa1UXsKLyHNFM4yLisuo82BRBFD59OlFD4K0T+t39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=RuO57Pgq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="RuO57Pgq"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2B51BA0744
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 11:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=vSc4Hb0Tv1At5eGAk3Ey02W6kQOB19wNPm0SVR2OiDc=; b=
	RuO57PgqYHtrr0pJp7aTwFiSq9NKyT4bN2DsJwnOIeb7SmDwiQS7rG397/BN3rOu
	CQbXzRh+wCLcJWCp5IfVXPUJ2iAieDBYmZ3fCOP1osS3mE9woQhu0eMneA71L6yM
	noVJvgY4A5Z13/seRcprHJHBet9mSekS+OPxhKXfkJsGijjDAIFXQBI8dqglbWJS
	R4TnE7oO+PCOndShbnWV2nsVP+DV2kEFFl16Mw8ceSBXvKy4BdzNbs3O89LEbf0d
	P0r1Ov+YF4Kh4TARfjvWZB6iyzgwqKSIlSb3HpGnMcHq5MlW7IubYPW2QwcW62N6
	HIvenTCCzQiZfaHUNdNnDWp4AjLkCdlKa1QO/iSQf+eIYpEFTavWjUgvBf5P4Lw8
	EAkWucBwiNwp2B6UzKfXmYVINEbdmgBktdCobFSC/XZFZabn6Vi6Fnz3PjZy7tHu
	KI3FqFUFXkeTkSrcxsvKmBpcsrV6JcG5bSnB5JxnczBGH78MFIoxjlTf28DeLAJ7
	QmA0DuqIZ2Q2leX1CJg4YzHWmuPwjRS2qkZsIJATECs/YQTiy6CeXDB8JgKzemFW
	xKrCdMNJl64yRQPyyjFHz1zxLQJCmD+/wQmIxkZZcFh0Zp/sYS6oya0cPwr9yR4n
	WqQVKYv3O4jfiKf5AVkLjwxKm45EcLeA8k16tNAS/rw=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <git@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH v4] git-send-email: Use sanitized address when reading mbox body
Date: Mon, 1 Jul 2024 11:01:16 +0200
Message-ID: <20240701090115.56957-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1719824600;VERSION=7975;MC=1857361481;ID=65369;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485465756B

Addresses that are mentioned on the trailers in the commit log
('Signed-off-by: ' etc.) are added to @cc (unless suppressed),
passed to the SMTP server. However, these hand-written
addresses may be malformed (e.g. having unquoted commas and
other punctuation marks in the display-name part).

The code was already calling `sanitize_address()` for suppression
purposes, so we just have to use the result ($sc) for adding to @cc.

Note that sanitization is only done for the message body, as
`git format-patch` already RFC 2047-encodes mbox headers, so
those are generally trusted to be sane. Also note that
`sanitize_address()` does not process the mailbox addresses,
so it is up to `sendmail` to handle special characters there
(e.g. there are mailboxes in regular use with '+'-es in them).

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v4:
    * t9001: use ${SQ} instead of double quotes
    * re-worded message again
    Changes in v3:
    * more testcases
    * clarified wording in message
    Changes in v2:
    * added testcase to t9001
    * added rationale behind trusting mbox headers and the address-parts

 git-send-email.perl   |  4 ++--
 t/t9001-send-email.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f0be4b4560..72044e5ef3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1847,9 +1847,9 @@ sub pre_process_file {
 					$what, $_) unless $quiet;
 				next;
 			}
-			push @cc, $c;
+			push @cc, $sc;
 			printf(__("(body) Adding cc: %s from line '%s'\n"),
-				$c, $_) unless $quiet;
+				$sc, $_) unless $quiet;
 		}
 	}
 	close $fh;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 58699f8e4e..64a4ab3736 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1299,6 +1299,49 @@ test_expect_success $PREREQ 'utf8 sender is not duplicated' '
 	test_line_count = 1 msgfrom
 '
 
+test_expect_success $PREREQ 'setup expect for cc list' "
+cat >expected-cc <<\EOF
+!recipient@example.com!
+!author@example.com!
+!one@example.com!
+!os@example.com!
+!odd_?=mail@example.com!
+!doug@example.com!
+!codev@example.com!
+!thor.au@example.com!
+EOF
+"
+
+test_expect_success $PREREQ 'cc list is sanitized' '
+	clean_fake_sendmail &&
+	test_commit weird_cc_body &&
+	test_when_finished "git reset --hard HEAD^" &&
+	git commit --amend -F - <<-EOF &&
+	Test Cc: sanitization.
+
+	Cc: Person, One <one@example.com>
+	Cc: Ronnie O${SQ}Sullivan <os@example.com>
+	Reviewed-by: Füñný Nâmé <odd_?=mail@example.com>
+	Reported-by: bugger on Jira
+	Reported-by: Douglas Reporter <doug@example.com> [from Jira profile]
+	BugID: 12345
+	Co-developed-by: "C. O. Developer" <codev@example.com>
+	Signed-off-by: A. U. Thor <thor.au@example.com>
+	EOF
+	git send-email -1 --to=recipient@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" >actual-show-all-headers &&
+	test_cmp expected-cc commandline1 &&
+	test_grep "^(body) Adding cc: \"Person, One\" <one@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: Ronnie O${SQ}Sullivan <os@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: =?UTF-8?q?F=C3=BC=C3=B1n=C3=BD=20N=C3=A2m=C3=A9?="\
+" <odd_?=mail@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Ignoring Reported-by .* bugger on Jira" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: Douglas Reporter <doug@example.com>" actual-show-all-headers &&
+	test_grep ! "12345" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: \"C. O. Developer\" <codev@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: \"A. U. Thor\" <thor.au@example.com>" actual-show-all-headers
+'
+
 test_expect_success $PREREQ 'sendemail.composeencoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.composeencoding iso-8859-1 &&
-- 
2.34.1


