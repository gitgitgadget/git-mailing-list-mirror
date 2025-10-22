Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F619F40B
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111917; cv=pass; b=HhFup7pSl6pDhOfjUBEkSTf8q5Ex5AFqGr9aYxIufKZllQG0kWqhR6IrQ693daExbQP55JdeG19Bd0y5eniJEH4AeqTO+6NUSPUYcDSsDaG+FzJBuVplNeaJbN08JVvV8F7Xe/jQd6ZO9XIt8SAgay+ytbVh+CEmOVzqGPBCOEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111917; c=relaxed/simple;
	bh=Cm74eUUpV2jty1uXlV41sNWPesnQf2iR1vS3KDBOGsE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUke8Dc3Nm2c1P+OS77/P2SmrpcT/P99Ovk/h/alIR+L/p7f5h3hvc0hhWnEUtZGZHP133LdL2gF4NxyuRq34jyso1tAkTrKd8LXJoDb0422WSDpgy5DKxh0fIvEVVeI5KBHvL339y9sAENJu6C2sE0Wug78CyfXQU+qF3MVhws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=AOL5vU/g; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="AOL5vU/g"
ARC-Seal: i=1; a=rsa-sha256; t=1761111657; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fvz6i3GsvZgDVfF3ylJqzwjT5EERSZubufWHzjqQOqtLsgqgWilXLNsYBGfPp37uQ3wz6kVHSJzgvBJcvQ43i1vPvzzSCc5tbXNwBFb6xoKyVN3ri5IrLRnaAr+mOVG62N9mpiXUmMKI29hUEkaTHaDpr6cG/oVAe1TGWvOl5Zs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111657; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=c58AWjqlGHokWRsHLxnXzPpEBZrlcXvkXfLUNkVTtZc=; 
	b=U9LcBJJwycXAi0i++TOpOxCXBOAbCRrK6Z7UrxEzMFfK6ID41jnxIZeZebk+yB4JUSag8PIUgZ6CBFrstIfhh1ivFsB3We1yBOpKBsBIM7tpJw7wq7LYkcpuyTSntmf1weg7Sn7s3CMB1eZQOXe7w3NSq/gvbmQcIgZcfUxSv/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111657;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=c58AWjqlGHokWRsHLxnXzPpEBZrlcXvkXfLUNkVTtZc=;
	b=AOL5vU/ghhZBQ51UKZq8B8jxmEWyD2LJV1OLG35XHaJF6buws3L1hkMwPxx5yE0e
	rQNAlgEqNsDwLcxbcGmcDGfJ5QdaFAAfGy8IzHfXvD6vqsqHzBRqATyKSq8eMHmQfbQ
	Ip8dsUXMPB6Gb3C8lRRnKPePbXUAd1cBV+WY90pw=
Received: by mx.zohomail.com with SMTPS id 1761111655132925.6683959022408;
	Tue, 21 Oct 2025 22:40:55 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 29/29] sequencer: honor --trailer with fixup -C
Date: Wed, 22 Oct 2025 13:39:49 +0800
Message-ID: <20251022053951.602605-30-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add an interactive rebase test that exercises
todo lists containing fixup and fixup -C commands,
and teach append_squash_message() to append trailers
when replacing the commit message.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 sequencer.c               |  4 ++++
 t/t3440-rebase-trailer.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index c02364cfce..fbf35cb474 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2027,6 +2027,10 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 		if (opts->signoff)
 			append_signoff(buf, 0, 0);
 
+		if (opts->trailer_args.nr &&
+			amend_strbuf_with_trailers(buf, &opts->trailer_args))
+			return error(_("unable to add trailers to commit message"));
+
 		if ((command == TODO_FIXUP) &&
 		    (flag & TODO_REPLACE_FIXUP_MSG) &&
 		    (file_exists(rebase_path_fixup_msg()) ||
diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index d697bf558b..d0e0434664 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -97,6 +97,33 @@ test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
 	expect_trailer_msg HEAD^ "third"
 '
 
+test_expect_success '--trailer handles fixup commands in todo list' '
+	git checkout -B fixup-trailer HEAD &&
+	test_commit fixup-base base &&
+	test_commit fixup-second second &&
+	first_short=$(git rev-parse --short fixup-base) &&
+	second_short=$(git rev-parse --short fixup-second) &&
+	cat >todo <<EOF &&
+pick $first_short fixup-base
+fixup $second_short fixup-second
+EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	expect_trailer_msg HEAD "fixup-base" &&
+	git reset --hard fixup-second &&
+	cat >todo <<EOF &&
+pick $first_short fixup-base
+fixup -C $second_short fixup-second
+EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	expect_trailer_msg HEAD "fixup-second"
+'
+
 test_expect_success 'rebase --root --trailer updates every commit' '
 	git checkout first &&
 	git -c trailer.review.key=Reviewed-by rebase --root \
-- 
2.51.0

