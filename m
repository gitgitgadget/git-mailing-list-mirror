Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32B181CE3
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408318; cv=none; b=HYpfbWFgqtNL4qjS1mFRmM0uaGarH7suQU+zZT6ucCtgi3bfBa4/EQ2bPk6KqWSa9xxu4hpQCgKS3xCg991MufK5vo6HBr/YfZkfuuqLLQ9kc4zq2WmJeAd2qQFJzVA0okWT9sL9r+Uy3zf0W8Za/jXWuewbw7wXKaYCE7mw1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408318; c=relaxed/simple;
	bh=mxfU6rZXKnQLXPGiBjrUvB9BbNy+NPC4n/YO1liYfcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7FgRPE7dJA2hezsjjRd7hgFOg44vocm+d7u4XJeDGukzvzOb+kZcCe8kTI1NUX4osBiubRW88dDm1GfheMy02ByDJ3bbGiYHSeGoQRHveVjKcUrykkbiEaerGmkHZYDzxMcl+RSrON0fwLJ4azW7T9pn9uquhmLDkE0N6JlxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=s262kGq6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="s262kGq6"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 299A4A12D1
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 15:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=I9lzG7xgcojh3sMe17641Ljg0Kpd0sAdNU5dB6NNaas=; b=
	s262kGq6F4l7N4nQZ9h8xwzGWhMa00LCpYg7e1VvJICqLzzKHJP16jpgqeAhQAfX
	WiJP+YDl0ID1DscO1oPe5BRHHMChe6MOGoOiM+XG3wp2HqOtkvSpvQrrRDgYTDQM
	S7nBJEKqX70ZpG6B97T8YhPSZzLO2Njwe/LkRvuu7EpR/2UxQjGmU7GMbm/0hmhO
	tb3DJ3A7pZ0dnGUBhLqSXQ5zNAb2P6fAlUOPT3T8qPLOfg1fucfu5DA3yJnyZ2us
	ZZDtOord3rlj1bNX1pQN3rF6XA941md5N4ppZdaM9Ls1AoA3dkGIjPMwk83OfOEQ
	WrxvYkTE6zXLf48YcpQ+nzfOsiGSL2f6jRnVGaSBdEXK0iyecoWByA4KNOy+zAXj
	6dAonsUQU+7k+29QPauQUXJBG+KjOO37SAUa11BsLvF6ZF6Wi9ikGQZ/hoWHdqv5
	Fh+7cSJZO8q4gPB7W+6/vwKKM5csf5kfw9alk25L4SlXcJ4fSeI8b5hJTEtKN79N
	Zr4zLm+UkpSO5yKw6G7vWbpPbRXfFCJRlhSKohoDFxTmnqSJ13OAPllThlUw5p97
	UgpQN+tIlpKf9//OLqc4Iq0Wmd/hQswDl1C2FegKW19+GuyYG3xl6Bt5uoO/cf+T
	cz0dsA4j55PfwuxLfj89DxtDcMoq+sBtroWMbJ3j4/Q=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <git@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH v2] git-send-email: Use sanitized address when reading mbox body
Date: Wed, 26 Jun 2024 15:24:41 +0200
Message-ID: <20240626132440.3762363-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.45.2.437.gf7de8c0566
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1719408305;VERSION=7975;MC=4240859846;ID=1242206;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576C706B

Commas and other punctuation marks in 'Cc: ', 'Signed-off-by: '
etc. lines mess with git-send-email. In parsing the mbox headers,
this is handled by calling `sanitize_address()`. This function
is called when parsing the message body as well, but was only
used for comparing it to $author. Now we add it to @cc too.

Note that sanitization is only done for the message body, as
`git format-patch` already RFC 2047-encodes mbox headers, so
those are generally trusted to be sane. Also note that
`sanitize_address()` does not process the mailbox addresses,
so it is up to `sendmail` to handle special characters there
(e.g. there are mailboxes in rwgular use with '+'-es in them).

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * added testcase to t9001
    * added rationale behind trusting mbox headers and the address-parts

 git-send-email.perl   |  4 ++--
 t/t9001-send-email.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

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
index 58699f8e4e..7e0b8ae57c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1299,6 +1299,36 @@ test_expect_success $PREREQ 'utf8 sender is not duplicated' '
 	test_line_count = 1 msgfrom
 '
 
+test_expect_success $PREREQ 'setup expect for cc list' "
+cat >expected-cc <<\EOF
+!recipient@example.com!
+!author@example.com!
+!one@example.com!
+!odd_?=mail@example.com!
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
+	Signed-off-by: A. U. Thor <thor.au@example.com>
+	EOF
+	git send-email -1 --to=recipient@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" >actual-show-all-headers &&
+	test_cmp expected-cc commandline1 &&
+	grep "^(body) Adding cc: \"Person, One\" <one@example.com>" actual-show-all-headers &&
+	grep "^(body) Adding cc: =?UTF-8?q?F=C3=BC=C3=B1n=C3=BD=20N=C3=A2m=C3=A9?="\
+" <odd_?=mail@example.com>" actual-show-all-headers &&
+	grep "^(body) Adding cc: \"A. U. Thor\" <thor.au@example.com>" actual-show-all-headers
+'
+
 test_expect_success $PREREQ 'sendemail.composeencoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.composeencoding iso-8859-1 &&
-- 
2.34.1


