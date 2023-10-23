Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1421A1C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jTQz+ilX"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4DD7B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:10:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A3FC72783D;
	Mon, 23 Oct 2023 15:10:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ey9fp1WyuYH//0n1tMNirGqDCpJXPzNGku00Tv
	UEG1M=; b=jTQz+ilX5mIlSXQR4XBEGgKNBWi6SwOS493NnvqSR+3S+lZZu1XgGY
	iwS1fDkXwYtHZmZGQcmcJ2hw5w8TqvoRunvjq8EmcYchAA2RGPd5JTO6sTfjPdKd
	1IZUd3DNUF9/UJJmm39deOVGAGf1BBZwgu/WzYeyWdz4VeGaApniw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C5582783C;
	Mon, 23 Oct 2023 15:10:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 36F7E27838;
	Mon, 23 Oct 2023 15:10:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 04/11] t: convert tests to not write references via the
 filesystem
In-Reply-To: <ZTZ8ATohRe7GVu5D@tanuki> (Patrick Steinhardt's message of "Mon,
	23 Oct 2023 15:58:25 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
	<xmqq1qdru6ds.fsf@gitster.g> <ZTZ8ATohRe7GVu5D@tanuki>
Date: Mon, 23 Oct 2023 12:10:44 -0700
Message-ID: <xmqq1qdlnoi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DEA62152-71D7-11EE-8BFE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> OK, the original checks "if a random garbage file, which may not
>> necessarily be a ref, exists at $n_dir, we cannot create a ref at
>> $n_dir/fixes, due to D/F conflict" more directly, but as long as our
>> intention is to enforce the D/F restriction across different ref
>> backends [*], creating a ref at $n_dir and making sure $n_dir/fixes
>> cannot be created is an equivalent check that is better (because it
>> can be applied for other backends).
>> 
>>     Side note: there is no fundamental need to, though, and there
>>          are cases where being able to have the 'seen' branch and
>>          'seen/ps/ref-test-tools' branches at the same time is
>>          beneficial---packed-refs and ref-table backends would not
>>          have such an inherent limitation, but they can of course be
>>          castrated to match what files-backend can(not) do.
>
> I think initially it is beneficial to keep any such restriction and cut
> back new backends to match them, even though it's more work.

Note that the same thing can be said for "Can I have Main and main
branches?".  Loose refs on systems with case-sensitive filesystem
are not penalized, though.

In any case, I think we are in agreement.

>> I trust that this will be corrected to use some wrapper around "git
>> symbolic-ref" (or an equivalent for it as a test-tool subcommand) in
>> some future patch, if not in this series?
>
> Yup, this is getting fixed in a subsequent patch. I had two different
> options to structure this series:
> ...
> There were two reasons why I didn't like the first iteration:

Yup.  I tend to agree with the choice and criteria you made and used
here.
