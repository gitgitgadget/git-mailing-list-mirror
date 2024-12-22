Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B533F3
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734889709; cv=none; b=MPLZyx/345YWG9WCKvEOEHREEmjyF6zj4oSNXdE/RpetTmAhPMxtpAqn1vc5sWCLqQ9Ht7sNVv2CoXe+7OFWV/2MhhPPlBwJKwmPA+1C0QXC5GnhGIQN1hdwsAQBnZiyWn1MkhpjEfZxF7CY4Tu5CLq1g31fu3rU4T37ZyAypx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734889709; c=relaxed/simple;
	bh=ebQJiJeft2joPrVYjTSoTnt6/G0VdZnQTqQO5udptmM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NmDmvQXzt7s7txtC/M4LNrPTCvUiv3JPcrnKCk8B4vb4/0fclUzqjZB+iIyliLGqHcTPl/fTvmAFRK7eWgXrgOO0Y/6IzZ0+oOYpFs9cG54Y1tUyMAajFFWPDVkTHY6jpomtEgD+0QtLJhargjFe3EuYRxmF020cSv/T5qF3gNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BMHmEUp2862442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Dec 2024 17:48:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>,
        "'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>	<xmqq34ihc4zt.fsf@gitster.g> <xmqqmsgoc42a.fsf@gitster.g>	<01b201db53d3$0b5953d0$220bfb70$@nexbridge.com> <xmqqikrcc2i6.fsf@gitster.g>
In-Reply-To: <xmqqikrcc2i6.fsf@gitster.g>
Subject: RE: [PATCH 3/4] reftable/stack: fix zero-sized allocation when there are no readers
Date: Sun, 22 Dec 2024 12:48:09 -0500
Organization: Nexbridge Inc.
Message-ID: <028401db5499$ad9cb760$08d62620$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL8gfJLxKZaOGUyuC/X73rZCkMxpgIWlImYASUs8ysCCezeGQGktJCpAsjU4mGwYo8r8A==
Content-Language: en-ca

On December 21, 2024 1:31 PM, Junio C Hamano wrote:
>To: rsbecker@nexbridge.com
>Cc: 'Patrick Steinhardt' <ps@pks.im>; git@vger.kernel.org; 'Randall S.
Becker'
><randall.becker@nexbridge.ca>
>Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when
there are no
>readers
>
><rsbecker@nexbridge.com> writes:
>
>>>Applying these on the author-supplied base (ff795a5c5e) yields the
>>>same
>> tree as
>>>the result of merging my manual application of these four patches to
>> ps/reftable-
>>>alloc-failures into the same base.
>>
>> Ready to test this. Please let me know when and I will report results.
>
>If you want to start sooner
>
>    $ git checkout -b test ff795a5c5ed2e2d07c688c217a615d89e3f5733b
>    $ git am ... these four patches ...
>
>should give you the fix without anything else mixed in.  I'll push out the
usual four
>branches after integration testing, but it will be queued in 'seen' (just
above the
>point that corresponds to
>'next') first, before merging it to 'next' (and then down to 'master'
before -rc1).

FYI: 'seen' looks better now. I am having issues in t0211-trace2-perf.sh
with
undefined SSL symbols (SSL_get0_group_name), but am able to use git init
again.

