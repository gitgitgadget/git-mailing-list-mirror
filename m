Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5503200D2
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iM4YB0AM"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF3DA3
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:45:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A0D27273F2;
	Fri, 20 Oct 2023 13:45:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+6WYU0jJh80cza0OFqQpCX4e6JTGdk3wsHziIf
	YxZlo=; b=iM4YB0AMOiaoKL6RJ/b5Jjmz0pJdG/gZlHjygg449W/Z8YqVb0yF3h
	j6VAMzKzpg9mjrNsuZfsyATjjcZNx+73Fkd7CnG9/Emnc8va3NIds3++9AVvtK+X
	EdlwD5E9GbANnRK4H1ZEv9YTIvpgAh7JaALiTst4rOzHLCldtvM4Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A0B3273F1;
	Fri, 20 Oct 2023 13:45:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2FDCD273F0;
	Fri, 20 Oct 2023 13:45:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 3/3] rev-list: add commit object support in
 `--missing` option
In-Reply-To: <CAOLa=ZT6qEsVfNETYua=RjjepDsXFj8uSdphS2LR1gGK1_sGFg@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 20 Oct 2023 16:47:11 +0200")
References: <20231016103830.56486-1-karthik.188@gmail.com>
	<20231019121024.194317-1-karthik.188@gmail.com>
	<20231019121024.194317-4-karthik.188@gmail.com>
	<xmqq4jimuv26.fsf@gitster.g> <xmqqttqmtcc2.fsf@gitster.g>
	<CAOLa=ZR4Qd9x-zVv9OtL7KTU00W2uT-kxdhKOLFZbi5cnHdiSQ@mail.gmail.com>
	<CAOLa=ZT6qEsVfNETYua=RjjepDsXFj8uSdphS2LR1gGK1_sGFg@mail.gmail.com>
Date: Fri, 20 Oct 2023 10:45:31 -0700
Message-ID: <xmqqh6mlqjb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 77CE4130-6F70-11EE-BB88-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Was trying to use bit number 12, which coincides METAINFO_SHOWN in
> builtin/blame.c.
> From skimming over the code, METAINFO_SHOWN is used only within
> blame.c and there
> should not be collisions here since blame.c doesn't set the
> do_not_die_on_missing_objects bit
> either.

Thanks for researching.  It sounds like it may be a better bit to
steal than the one used by the commit-graph, as long as there is no
reason to expect that blame may want to work in a corrupt repository
with missing objects, but when it happens, we may regret the
decision we are making here.

Thanks.
