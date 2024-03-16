Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB30CA62
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710568649; cv=none; b=q5xGe5fNUmSzXhU+gDwumbzpcJstNX2gF5By9F0n9EPwMDauf7otNle5HcLUzIEkURCXeRIw+XtPri7gCjgCMdBD60SkwTJM8Rnq3FqhluGxYNlu11HBBCdmtUZseCcKE38lu5GUPpiUDsfYBFQPvPZMdXJrad9DCqFMRLd9WXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710568649; c=relaxed/simple;
	bh=SHkA7Kx4R43JA39BpmePu/7Gn+YG9V9gD6IKjRJNNB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TlJYM93DZ8Qhqs9/1FKBY/PorD5q8cbm9bWTGoLkQY8x7kSEerj26Q0zBujxPq4NA1Ub2pIzI/icusaUuMa6t3paHiCPNh603b38RDCgQPslNdcK8NJmLDPV+XjGOfgLHOdPkmBThUMhzppAO/t3unMB93cZGDuMj13ppopv4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qyd/+rxE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qyd/+rxE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EA2130E10;
	Sat, 16 Mar 2024 01:57:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SHkA7Kx4R43JA39BpmePu/7Gn+YG9V9gD6IKjR
	JNNB4=; b=qyd/+rxEgtwnhQ6Ve6SacN/mr/f0/zHffTyRmyNnUBcEcrJrem9msX
	iB0DXLZZ6UdGX3ITGsWL882s1w3Nm6eeHNVIH9DiPqVI74XpOBVootCtUN8gYUP4
	hjnN8m80TOzivpDC0pnstwKUCNW0d+h8NWJ2TJ5/G1xwl/8LRapug=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 78D1030E0F;
	Sat, 16 Mar 2024 01:57:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11C9030E0E;
	Sat, 16 Mar 2024 01:57:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>,  David Heidelberg
 <david@ixit.cz>,  Phillip Wood <phillip.wood123@gmail.com>,  Dragan Simic
 <dsimic@manjaro.org>
Subject: Re: [PATCH v5] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <xmqqy1ajqvkb.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 Mar 2024 10:00:36 -0700")
References: <20240315055448.GA2253326@quokka> <xmqqy1ajqvkb.fsf@gitster.g>
Date: Fri, 15 Mar 2024 22:57:22 -0700
Message-ID: <xmqq8r2ioh19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F743B22-E35A-11EE-999D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I am tempted to queue v4 with the z/ -> y/ fix from this round,
> without any other changes from v4 to v5.

So, that is what I did before I pushed out today's integration
result.  I however have an "after the dust settles" clean-up patch
on top (not committed yet), which I am sending out for review.

------- >8 -------------- >8 -------------- >8 --------
Subject: diff.*Prefix: use camelCase in the doc and test titles

We added documentation for diff.srcPrefix and diff.dstPrefix with
their names properly camelCased, but the diff.noPrefix is listed
there in all lowercase.  Also these configuration variables, both
existing ones and the {src,dst}Prefix we recently added, were
spelled in all lowercase in the tests in t4013.

Now we are done with the main change, clean these up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * If we were early in the review cycle, we would strongly prefer to
   do a "preliminary clean-up" followed by the main change, as the
   clean-up step would be much less controversial and can be queued
   earlier before the main change solidifies.  But at v5 the main
   change is more or less perfect, so it is not worth rerolling to
   split the clean-up changes into preliminary ones and change to
   the main patch.  So this is written as an "on top, after the dust
   settles" clean-up patch.

 Documentation/config/diff.txt |  2 +-
 t/t4013-diff-various.sh       | 48 +++++++++++++++++++++----------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git c/Documentation/config/diff.txt w/Documentation/config/diff.txt
index fea89291c6..5ce7b91f1d 100644
--- c/Documentation/config/diff.txt
+++ w/Documentation/config/diff.txt
@@ -108,7 +108,7 @@ diff.mnemonicPrefix::
 `git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
 
-diff.noprefix::
+diff.noPrefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
 diff.srcPrefix::
diff --git c/t/t4013-diff-various.sh w/t/t4013-diff-various.sh
index cfb5ad3d8d..3855d68dbc 100755
--- c/t/t4013-diff-various.sh
+++ w/t/t4013-diff-various.sh
@@ -633,8 +633,8 @@ check_prefix () {
 	test_cmp expect actual.paths
 }
 
-test_expect_success 'diff-files does not respect diff.noprefix' '
-	git -c diff.noprefix diff-files -p >actual &&
+test_expect_success 'diff-files does not respect diff.noPrefix' '
+	git -c diff.noPrefix diff-files -p >actual &&
 	check_prefix actual a/file0 b/file0
 '
 
@@ -643,58 +643,58 @@ test_expect_success 'diff-files respects --no-prefix' '
 	check_prefix actual file0 file0
 '
 
-test_expect_success 'diff respects diff.noprefix' '
-	git -c diff.noprefix diff >actual &&
+test_expect_success 'diff respects diff.noPrefix' '
+	git -c diff.noPrefix diff >actual &&
 	check_prefix actual file0 file0
 '
 
-test_expect_success 'diff --default-prefix overrides diff.noprefix' '
-	git -c diff.noprefix diff --default-prefix >actual &&
+test_expect_success 'diff --default-prefix overrides diff.noPrefix' '
+	git -c diff.noPrefix diff --default-prefix >actual &&
 	check_prefix actual a/file0 b/file0
 '
 
-test_expect_success 'diff respects diff.mnemonicprefix' '
-	git -c diff.mnemonicprefix diff >actual &&
+test_expect_success 'diff respects diff.mnemonicPrefix' '
+	git -c diff.mnemonicPrefix diff >actual &&
 	check_prefix actual i/file0 w/file0
 '
 
-test_expect_success 'diff --default-prefix overrides diff.mnemonicprefix' '
-	git -c diff.mnemonicprefix diff --default-prefix >actual &&
+test_expect_success 'diff --default-prefix overrides diff.mnemonicPrefix' '
+	git -c diff.mnemonicPrefix diff --default-prefix >actual &&
 	check_prefix actual a/file0 b/file0
 '
 
-test_expect_success 'diff respects diff.srcprefix' '
-	git -c diff.srcprefix=x/ diff >actual &&
+test_expect_success 'diff respects diff.srcPrefix' '
+	git -c diff.srcPrefix=x/ diff >actual &&
 	check_prefix actual x/file0 b/file0
 '
 
-test_expect_success 'diff respects diff.dstprefix' '
-	git -c diff.dstprefix=y/ diff >actual &&
+test_expect_success 'diff respects diff.dstPrefix' '
+	git -c diff.dstPrefix=y/ diff >actual &&
 	check_prefix actual a/file0 y/file0
 '
 
-test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
-	git -c diff.srcprefix=y/ diff --src-prefix=z/ >actual &&
+test_expect_success 'diff --src-prefix overrides diff.srcPrefix' '
+	git -c diff.srcPrefix=y/ diff --src-prefix=z/ >actual &&
 	check_prefix actual z/file0 b/file0
 '
 
-test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
-	git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
+test_expect_success 'diff --dst-prefix overrides diff.dstPrefix' '
+	git -c diff.dstPrefix=y/ diff --dst-prefix=z/ >actual &&
 	check_prefix actual a/file0 z/file0
 '
 
-test_expect_success 'diff.{src,dst}prefix ignored with diff.noprefix' '
-	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff >actual &&
+test_expect_success 'diff.{src,dst}Prefix ignored with diff.noPrefix' '
+	git -c diff.dstPrefix=y/ -c diff.srcPrefix=x/ -c diff.noPrefix diff >actual &&
 	check_prefix actual file0 file0
 '
 
-test_expect_success 'diff.{src,dst}prefix ignored with diff.mnemonicprefix' '
-	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix diff >actual &&
+test_expect_success 'diff.{src,dst}Prefix ignored with diff.mnemonicPrefix' '
+	git -c diff.dstPrefix=x/ -c diff.srcPrefix=y/ -c diff.mnemonicPrefix diff >actual &&
 	check_prefix actual i/file0 w/file0
 '
 
-test_expect_success 'diff.{src,dst}prefix ignored with --default-prefix' '
-	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff --default-prefix >actual &&
+test_expect_success 'diff.{src,dst}Prefix ignored with --default-prefix' '
+	git -c diff.dstPrefix=x/ -c diff.srcPrefix=y/ diff --default-prefix >actual &&
 	check_prefix actual a/file0 b/file0
 '
 
