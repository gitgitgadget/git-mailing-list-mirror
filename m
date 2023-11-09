Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFCDF58
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HCF4MpVH"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F72D4F
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:46:10 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 27B19293E6;
	Thu,  9 Nov 2023 02:46:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XJeQLqOhrrFNYsmL4upPlglEVkrzwtvb3tSfgr
	uDz1c=; b=HCF4MpVHR4MLH67Ez4PEa9OftcxT/rjBTgctnl1IuMKE5BqGB2HVzy
	fATziUl3uqeH7A0onGKpgomDQq59HK7pF9D7+pAccx6MblPsGQjH2fVPbEQ5B4qX
	+YXOSuDu4OikjIH4K/l6vmzw/Ck62Yp3ltAMvYHgdX3g6E8fiEbVw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FE00293E5;
	Thu,  9 Nov 2023 02:46:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B134F293E2;
	Thu,  9 Nov 2023 02:46:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] t/lib-httpd: dynamically detect httpd and
 modules path
In-Reply-To: <ZUyMFZ7c9_rlu5lk@tanuki> (Patrick Steinhardt's message of "Thu,
	9 Nov 2023 08:36:53 +0100")
References: <cover.1699428122.git.ps@pks.im> <cover.1699513524.git.ps@pks.im>
	<e4c75c492dd89fd7464db2b3028b2bb9e6addbf8.1699513524.git.ps@pks.im>
	<20231109073250.GA2698227@coredump.intra.peff.net>
	<ZUyMFZ7c9_rlu5lk@tanuki>
Date: Thu, 09 Nov 2023 16:46:05 +0900
Message-ID: <xmqqzfzn1i9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A61A236-7ED4-11EE-BBBA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, I was grepping for it in our codebase and saw other occurrences,
> so I assumed it was fair game. If we're going to convert it to the
> below, how about I send another patch on top that also converts the
> preexisting instances so that the next one grepping for it isn't going
> to repeat the same mistake?

Yup, an independent clean-up would be fine.  Now we need to find a
way to give better visibility to CodingGuidelines, which already
says this:

 - We do not write our "test" command with "-a" and "-o" and use "&&"
   or "||" to concatenate multiple "test" commands instead, because
   the use of "-a/-o" is often error-prone.  E.g.

     test -n "$x" -a "$a" = "$b"

   is buggy and breaks when $x is "=", but

     test -n "$x" && test "$a" = "$b"

   does not have such a problem.

