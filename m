Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936C54737
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532006; cv=none; b=qGG0n6NMCNEdKJ5pXCm8SOmksfGSDlj49kHAfEr+FHoG+0CZio6R389UQXYkIcc4J2S8Lv+/ocwumCbaz52Y9xLu2fRIuLXV+5PivQzkav8goPFN5H3Zkg2VIt9iixcBSFI7xro7UiDYqIzEl2/WQDS6AS/+LXZsBZ458XatQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532006; c=relaxed/simple;
	bh=eNpX5PWTT2ye9/O6n05IALrMxhreaX+sAQLf45At9k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQacRtowvZVGwTcv03iVk+3h7BPgAwizlZte1vAs3a9beeaAvNgdasnkpAJTK+lwsKibSEaA7ccridN5zk3yp4uV5+/SAGbheUJNZbpxqDE80HBZwqpNGwkFFrFZVxx781A6BONiZPlIbKZyKWJ4NDXkmZXA65sg7Vx4xDO3Nos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVm-000000002BQ-3ZD0
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:39 +0100
Received: from [10.20.10.233] (port=28680 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVl-006akg-2N;
	Fri, 15 Mar 2024 20:46:37 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 6899B1800FD;
	Fri, 15 Mar 2024 20:46:36 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:36 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 06/22] t/t0*: avoid redundant uses of cat
Date: Fri, 15 Mar 2024 20:46:03 +0100
Message-ID: <20240315194620.10713-7-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315194620.10713-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t0002-gitfile.sh                 | 2 +-
 t/t0011-hashmap.sh                 | 2 +-
 t/t0028-working-tree-encoding.sh   | 4 ++--
 t/t0204-gettext-reencode-sanity.sh | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 736516cc6a47..bf3bf604abe3 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -40,7 +40,7 @@ test_expect_success 'final setup + check rev-parse --git-dir' '
 
 test_expect_success 'check hash-object' '
 	echo "foo" >bar &&
-	SHA=$(cat bar | git hash-object -w --stdin) &&
+	SHA=$(git hash-object -w --stdin <bar) &&
 	test_path_is_file "$REAL/objects/$(objpath $SHA)"
 '
 
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 1cb6aa682432..46e74ad1072b 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -239,7 +239,7 @@ test_expect_success 'grow / shrink' '
 	echo value40 >> expect &&
 	echo size >> in &&
 	echo 64 39 >> expect &&
-	cat in | test-tool hashmap > out &&
+	test-tool hashmap <in >out &&
 	test_cmp expect out
 
 '
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 1b55f59c237c..ad151a346708 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -131,8 +131,8 @@ do
 		test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
 		test_when_finished "git reset --hard HEAD^" &&
 
-		cat lf.utf8.raw | write_utf${i} >lf.utf${i}.raw &&
-		cat crlf.utf8.raw | write_utf${i} >crlf.utf${i}.raw &&
+		write_utf${i} <lf.utf8.raw >lf.utf${i}.raw &&
+		write_utf${i} <crlf.utf8.raw >crlf.utf${i}.raw &&
 		cp crlf.utf${i}.raw eol.utf${i} &&
 
 		cat >expectIndexLF <<-EOF &&
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reencode-sanity.sh
index 4f2e0dcb02bd..310a4500125f 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -82,7 +82,7 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext.c: git init UTF-8 -> ISO-8859-1'
     printf "Bjó til tóma Git lind" >expect &&
     LANGUAGE=is LC_ALL="$is_IS_iso_locale" git init repo >actual &&
     test_when_finished "rm -rf repo" &&
-    grep "^$(cat expect | iconv -f UTF-8 -t ISO8859-1) " actual
+    grep "^$(iconv -f UTF-8 -t ISO8859-1 <expect) " actual
 '
 
 test_done
-- 
2.44.0

