Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660014D6E4
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564687; cv=none; b=PXf4no0NQCX7syIT7Qy6Dskbk5r73sGI8l9snEyC3RH3tLXEGO3W7gFDUXQZEzbOcg/3jls9nJHjD23xJBs0hsd6TdKsXdgkP//luLnrw9cjijl8v8wXtTBmRM1s4ujoWqIhJ8M42Y1SHY5xycKeKNJJikLnyUuInVjpXQX6uxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564687; c=relaxed/simple;
	bh=U5QVIwOiqblUFUtL1foBHZudjQOMJNSfJEAU+UB9xsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QKJKD9z2JLJGPvSDRS6fJRmHHi6Xj9GY7zV4Dykr4jg7jm7hZUWR9cXySdmsJJcyCP7jFFQ5EDrUqGJ6VyKfHaOjk3KWcHfTrjAwnXDdtgbfzGMLapeYWHQHxtSDt9YIKpf0zfsT25e0D+LI3C6xsJhJKpZYQMVlubUCDZUnobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FvJzAD+N; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FvJzAD+N"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 55CEAA0608
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 10:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=MMvGabFB02vSHGYgshl4Wjv11dklCZJxv38e3AtAXyE=; b=
	FvJzAD+NyNaiTYUUM7EZwWkrUq7Pa6NGTMWzgrfpNdsZvwY20hDP5nOAyKJitDk1
	TNArXaKb1aWzZPQnfd5KyZAR7EX0O2Sr4q46kaHBCG5540wa72e8f/jUhrMIQpWc
	K2Okr5Uc93W5KPHxzvA6Ge8EYtRAKUyZApcJAQNPu/FMXJKZ+yJo38E6UAbbTxn3
	E840Xp8H/SQSDNd3ooGhzTsit118P0aQEuVl/+UhANt/2y4IpWEWRv3GYwBPqrZI
	cHaRQrBu/tvnRQ20PDEK8iLB7pzOxzHbeb9ulwh5CTvc38Hj1LrTiGgnAYuQ1SQu
	vQte2pN25keDarg6Vm5Tooc6MGAF9Z4XWJdPujEHZjcxQATcl7WT2M1mt0noByDG
	Nizc040dIO0QG3hDCeAf13o1J3U0AHuyl/gBZ9RoHcoWkbhxt4U1zD+Aie/WKgCq
	5eQP3zBzIzuQwYFyi3IeFwZoZNxPAm63wpf1Dvvl/UjmOFu6nAX1APy7qqg0SsjN
	C+pelHd0D2RCjjMJgdRsuKLzuqOTtSBQvYN986SGWovpUVszpg4THytgy+PgPMAf
	kxeCmEt/ALJCQfLsastNTCGO4eBNXJzkPdoBTJGMjCV8sZva3BDAXnszVwHAThjp
	NrkMQppwlO0r5kxJPXqBCxH74Lzp2hoqKxBZBN2idHc=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <git@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH v3] git-send-email: Use sanitized address when reading mbox body
Date: Fri, 28 Jun 2024 10:50:19 +0200
Message-ID: <20240628085018.65076-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.45.2.437.gf7de8c0566
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1719564682;VERSION=7975;MC=300963723;ID=1545470;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576C7D63

Commas and other punctuation marks in 'Cc: ', 'Signed-off-by: '
etc. lines mess with git-send-email. This is handled by calling
`sanitize_address()` before adding addresses to @cc. This function
was already being called, but was only used for comparing it to
$author for suppression purposes.

Note that sanitization is only done for the message body, as
`git format-patch` already RFC 2047-encodes mbox headers, so
those are generally trusted to be sane. Also note that
`sanitize_address()` does not process the mailbox addresses,
so it is up to `sendmail` to handle special characters there
(e.g. there are mailboxes in regular use with '+'-es in them).

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

[ sorry, I forgot the --notes: ]

Notes:
    Changes in v2:
    * added testcase to t9001
    * added rationale behind trusting mbox headers and the address-parts
    Changes in v3:
    * more testcases
    * clarified wording in message

 git-send-email.perl   |  4 ++--
 t/t9001-send-email.sh | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

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
index 58699f8e4e..8bbbf20855 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1299,6 +1299,57 @@ test_expect_success $PREREQ 'utf8 sender is not duplicated' '
 	test_line_count = 1 msgfrom
 '
 
+test_expect_success $PREREQ 'setup expect for cc list' "
+cat >expected-cc <<\EOF
+!recipient@example.com!
+!author@example.com!
+!one@example.com!
+!odd_?=mail@example.com!
+!doug@example.com!
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
+	Reviewed-by: Füñný Nâmé <odd_?=mail@example.com>
+	Reported-by: bugger on Jira
+	Reported-by: Douglas Reporter <doug@example.com> [from Jira profile]
+	BugID: 12345
+	Signed-off-by: A. U. Thor <thor.au@example.com>
+	EOF
+	git send-email -1 --to=recipient@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" >actual-show-all-headers &&
+	test_cmp expected-cc commandline1 &&
+	test_grep "^(body) Adding cc: \"Person, One\" <one@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: =?UTF-8?q?F=C3=BC=C3=B1n=C3=BD=20N=C3=A2m=C3=A9?="\
+" <odd_?=mail@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: Douglas Reporter <doug@example.com>" actual-show-all-headers &&
+	test_grep "^(body) Adding cc: \"A. U. Thor\" <thor.au@example.com>" actual-show-all-headers
+'
+
+test_expect_success $PREREQ 'quotes are sanitized in cc list' "
+	clean_fake_sendmail &&
+	test_commit quote_in_cc_body &&
+	test_when_finished \"git reset --hard HEAD^\" &&
+	git commit --amend -F - <<-EOF &&
+	Quotation marks sanitization in Cc:.
+
+	Cc: P'erson, One <one@example.com>
+	Reported-by: \"Douglas 'Bug' Reporter\" <doug@example.com>
+	EOF
+	git send-email -1 --to=recipient@example.com \
+		--smtp-server=\"$(pwd)/fake.sendmail\" >actual-show-all-headers &&
+	test_grep \"^(body) Adding cc: \\\"P'erson, One\\\" <one@example.com>\" actual-show-all-headers &&
+	test_grep \"^(body) Adding cc: \\\"Douglas 'Bug' Reporter\\\" <doug@example.com>\" actual-show-all-headers
+"
+
 test_expect_success $PREREQ 'sendemail.composeencoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.composeencoding iso-8859-1 &&
-- 
2.34.1


