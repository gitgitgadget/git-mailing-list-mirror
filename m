Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18A1332A9
	for <git@vger.kernel.org>; Wed,  8 May 2024 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211745; cv=none; b=lEqyoaEn6urEPKCbat3ECDAJfD+ZYh73SMMxC1lrolnAzXFAzq2GT1WWATpaHlWFFgz0JhF3TgSVnxHoQaFsu2qjTDlJmf/OJDUOqBlGP3tMwvWfmQzzOn+74bV2tgQIgMuXV3XCKfMt/XSLBosHW9HEICABu73X+8GWEyWFTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211745; c=relaxed/simple;
	bh=GMzRHPBp0baI2zvS2Zk5dvQ8aG6BVzHdV51pK9jvkBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JrpdjhK47UOwd3MCIDCmkJgldLGrTC6TyGW2b2uWZsGdnF6B+F80CeS5eev3u87Vwg5JmYQ9dRd/clMD4TTYC42DW11ZI5VzXdxGRGgQl0XJHDM7NHijaoouRD3JsEkvph998D8L+cRKKOVq3EOqLI3GuJuCW9H4Quh5ObBOG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v58xw6Fg; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v58xw6Fg"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 130891E611;
	Wed,  8 May 2024 19:42:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GMzRHPBp0baI2zvS2Zk5dvQ8aG6BVzHdV51pK9
	jvkBw=; b=v58xw6FgkoB5byP9zq4m6H5NDnqOP5umbxxygZZLEO/bSEkPl43ThG
	At8REYpeXGmioJjeN8tYpuFW7WWWoTtIhdPgMWwe9k5wce7+8qeVTh0phFJ9hMvM
	qD5U5EjKJJC0DaTy4Kaw8atl3YMSrN1fTTsNF1UssKI02buHzjI38=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B5111E610;
	Wed,  8 May 2024 19:42:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 730941E60F;
	Wed,  8 May 2024 19:42:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] reftable: prepare for re-seekable iterators
In-Reply-To: <cover.1715166175.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 8 May 2024 13:03:33 +0200")
References: <cover.1715166175.git.ps@pks.im>
Date: Wed, 08 May 2024 16:42:11 -0700
Message-ID: <xmqqwmo3x44s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 986542B4-0D94-11EF-9412-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> To address this inefficiency, the patch series at hand refactors the
> reftable library such that creation of iterators and seeking on an
> iterator are separate steps. This refactoring prepares us for reusing
> iterators to perform multiple seeks, which in turn will allow us to
> reuse internal data structures for subsequent seeks.

;-)

> Note: this series does not yet go all the way to re-seekable iterators,
> and there are no users yet. The patch series is complex enough as-is
> already, so I decided to defer that to the next iteration. Thus, the
> whole refactoring here should essentially be a large no-op that prepares
> the infrastructure for re-seekable iterators.
>
> The series depends on pks/reftable-write-optim at fa74f32291
> (reftable/block: reuse compressed array, 2024-04-08).

There is another topic on reftable to make write options tweakable,
whose addition of reftable/dump and reader_print_blocks interface
needs to be adjusted to this change, I think.



 reftable/reader.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git c/reftable/reader.c w/reftable/reader.c
index 2ea830bdb6..fd516e01db 100644
--- c/reftable/reader.c
+++ w/reftable/reader.c
@@ -841,7 +841,7 @@ int reftable_reader_print_blocks(const char *tablename)
 		},
 	};
 	struct reftable_block_source src = { 0 };
-	struct table_iter ti = TABLE_ITER_INIT;
+	struct table_iter *ti;
 	struct reftable_reader *r = NULL;
 	size_t i;
 	int err;
@@ -854,11 +854,14 @@ int reftable_reader_print_blocks(const char *tablename)
 	if (err < 0)
 		goto done;
 
+	REFTABLE_ALLOC_ARRAY(ti, 1);
+	table_iter_init(ti, r);
+
 	printf("header:\n");
 	printf("  block_size: %d\n", r->block_size);
 
 	for (i = 0; i < ARRAY_SIZE(sections); i++) {
-		err = reader_start(r, &ti, sections[i].type, 0);
+		err = table_iter_seek_start(ti, sections[i].type, 0);
 		if (err < 0)
 			goto done;
 		if (err > 0)
@@ -867,10 +870,10 @@ int reftable_reader_print_blocks(const char *tablename)
 		printf("%s:\n", sections[i].name);
 
 		while (1) {
-			printf("  - length: %u\n", ti.br.block_len);
-			printf("    restarts: %u\n", ti.br.restart_count);
+			printf("  - length: %u\n", ti->br.block_len);
+			printf("    restarts: %u\n", ti->br.restart_count);
 
-			err = table_iter_next_block(&ti);
+			err = table_iter_next_block(ti);
 			if (err < 0)
 				goto done;
 			if (err > 0)
@@ -880,6 +883,6 @@ int reftable_reader_print_blocks(const char *tablename)
 
 done:
 	reftable_reader_free(r);
-	table_iter_close(&ti);
+	table_iter_close(ti);
 	return err;
 }
