Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5B1465A2
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227138; cv=none; b=DPMtkXYMag/Mjs2pX5TslwTf0rtKpNz9sLj4gcFiaiC5IFScOhyi9u48b9U+WPJA55rVxR9PvV5E41NV5ndmyDI59+G5REbICIsD42a3ITH5DuvcRE6aWx8FQpG9zGHs2MWnu65nP5ZaZS/Ld8bsNPA7HfX7OnHUffYbkWdDNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227138; c=relaxed/simple;
	bh=McbwVLOq82XSS/hGmKCiuySYjRfnOpFiH2AvvXlqFhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NWH3fyX13ToUNuGuJuWnT0FN5CrsaTF4NKiDZR4X/fzAb85C+q9O8radQs6uzLKFa/DxwLzpFoAHirf4CZZaX3QvTviGib/YShhCIq7db9kPCkMK94zHHUX94i6Ui2kQCkLmkVVmAjKgG2QsB5tKt+90FQueIb+MskUun9Lqo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yVcdj90I; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yVcdj90I"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A0292E8FB;
	Fri,  9 Aug 2024 14:12:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=McbwVLOq82XSS/hGmKCiuySYjRfnOpFiH2AvvX
	lqFhY=; b=yVcdj90Ivy9KPWdvQqC5NcaH7Kms0zfJb+0o/jD/Z00qbavZgBRx1Y
	seBgLYVkurIORblWpxgO2hHaUeCHSxCOW2jke9SzFUSMvjRJkBYQhhum7LrZtYVz
	HMD7s6hgSFU6j34VkUOdQA0O39dS7csQ/bcGRsD8JHfmDeFrFI91k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9110F2E8FA;
	Fri,  9 Aug 2024 14:12:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 846F72E8F6;
	Fri,  9 Aug 2024 14:12:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/4] t: move reftable/readwrite_test.c to the unit
 testing framework
In-Reply-To: <20240809111312.4401-2-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Fri, 9 Aug 2024 16:35:41 +0530")
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-2-chandrapratap3519@gmail.com>
Date: Fri, 09 Aug 2024 11:12:11 -0700
Message-ID: <xmqqwmkpd0qs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E722D720-567A-11EF-85F8-BF444491E1BC-77302942!pb-smtp20.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable/readwrite_test.c exercises the functions defined in
> reftable/reader.{c,h} and reftable/writer.{c,h}. Migrate
> reftable/readwrite_test.c to the unit testing framework. Migration
> involves refactoring the tests to use the unit testing framework
> instead of reftable's test framework and renaming the tests to
> align with unit-tests' naming conventions.
>
> Since some tests in reftable/readwrite_test.c use the functions
> set_test_hash(), noop_flush() and strbuf_add_void() defined in
> reftable/test_framework.{c,h} but these files are not #included
> in the ported unit test, copy these functions in the new test file.
>
> While at it, ensure structs are 0-initialized with '= { 0 }'
> instead of '= { NULL }'.

OK.

> -		EXPECT(buf->buf[off] == 'r');
> +		if (!off)
> +			off = header_size((hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
> +		check(buf->buf[off] == 'r');

Why not "check_char(buf->buf[off], ==, 'r')"?

>  	}
>  
> -	EXPECT(stats->log_stats.blocks > 0);
> +	check(stats->log_stats.blocks > 0);

Why not "check_int(stats->log_stats.blocks, >, 0)", which you used
in the t_log_write_read() function?

While reading this step, I looked for use of check() that is not
rewriting EXPECT_ERR(x) to check(!x) as suspicious.  The above two
(and a !memcmp() that is OK) were the only three such uses of
check(), I think.

Thanks.

