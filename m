Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5F382
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275914; cv=none; b=BpCtTxh1/Qb+0/gfL9oq67AfWXO0VRXVvPajPS+YXcadkgS2nQ5b3Q3Cixc7cNBxfbTmQARWbwu1QP1+JmQCHX2o6pecDyUL2OIWDOsabgfxjg4EZNd84Z1K10zcIhRsK9+CaKPv60KvHVGzEtueciBmMWvW0ATSik8SSJZZPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275914; c=relaxed/simple;
	bh=n1tjChmrmxLDNtVW2TDBOeigDxUkeRKihuMnF9mpk1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7RzfFzFyADC4A5WwlxlQGKt+jFuOKKciOqLZ5Qyz0UarTM8A3LScWisvjJG/p8EQZu7XUzzuw3ruE4AMwnRWiwMR7rs6xcXtSnDsVGfzVcN6R9AoXybS9yUgutOo4G6o9stKRYe7cnZyx/raOk4O+Hith2TQ7cz8H6Arh8iflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yPr47M7F; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yPr47M7F"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 55AE430DDA;
	Tue, 12 Mar 2024 16:38:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n1tjChmrmxLDNtVW2TDBOeigDxUkeRKihuMnF9
	mpk1U=; b=yPr47M7F9gprRzUO2LWoXbM6xdCRAVZhHQ8nhdeVMOPW4zWIWv5FNG
	farXQsxG/l42MG1mez0/IR/RdmogxHGKeApNXqnHS2D/FlYa9STxTxxp5z7Iddlm
	KtX0Q0CBsVdbktnPxvfQ4hAWxVgT8itZ2plZqyhSR13IF5OxPZXEs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E3F930DD9;
	Tue, 12 Mar 2024 16:38:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF6D630DD8;
	Tue, 12 Mar 2024 16:38:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  rsbecker@nexbridge.com,  Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH] t5601: exercise clones with "includeIf.*.onbranch"
In-Reply-To: <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 12 Mar 2024 13:35:11 +0100")
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
	<0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>
Date: Tue, 12 Mar 2024 13:38:26 -0700
Message-ID: <xmqqo7bjjid9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7BBDB134-E0B0-11EE-8A56-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success 'clone with includeIf' '
> +	test_when_finished "rm -rf repo \"$HTTPD_DOCUMENT_ROOT_PATH/repo.git\"" &&
> +	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +
> +	test_when_finished "rm \"$HOME\"/.gitconfig" &&
> +	cat >"$HOME"/.gitconfig <<-EOF &&
> +	[includeIf "onbranch:something"]
> +		path = /does/not/exist.inc
> +	EOF
> +	git clone $HTTPD_URL/smart/repo.git repo
> +'

Hmph, isn't the end-user expectation more like if you clone with
"git clone -b something" then the configuration stored in the named
file to take effect, while "git clone" that would never place you on
that something branch would ignore that missing file?  Is this only
the latter half of the pair?

Thanks.
