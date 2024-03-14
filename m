Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60147138A
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403742; cv=none; b=T4p8Wtw0wv6EKKR4U+MPx4BoS2jkDtbOU2ieSPrN4oehgfMBjoObW30BX+602DnbBPU+5Xw3Sb1/llrlotnnYiLyGpQ3+zSxcUBoOj6Dlbejilc7G8+u2Zu2E10tpXozT1MoNcVBNuEDlTTaciJyHhJ36u39CscllW5qGhOZaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403742; c=relaxed/simple;
	bh=9pIavKQ0e8p7ijyWR8QFz9zOEprb436RifSeb8/4tIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ssoIwLMCVw6CuBQdp2R6/KTDtNSfadFXN4KE8QlGqdNrhdABLKl1P3x9sooJgFZLu1EQncSiPT8ZLM+YwteZwp6K4KJcnKws1XIrIO3nwLJx6fti7XMAc8P/ot+aScIlPEKfJ9MEw9B95X223Sa5jii0xEAw3K41KhJ3a2pXKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=idPfrpYb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="idPfrpYb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31FA71DB9BE;
	Thu, 14 Mar 2024 04:09:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9pIavKQ0e8p7ijyWR8QFz9zOEprb436RifSeb8
	/4tIg=; b=idPfrpYbVfE9qgqLzKTdOBIrxuEv1ebI402D0gTyKSQwUpSzjC8GT9
	90AQfg0WeRnRHpPOalAXFxXS4RW/M542JG+9nVzpSjqgntwNbGBZv0ke2OZk7HZV
	N2tr8uRRa7ROOlrGXnHPGDpYn+24GIKhUOQ13VSX9QZDgt//uLwrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 18C751DB9BD;
	Thu, 14 Mar 2024 04:09:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6743F1DB9BB;
	Thu, 14 Mar 2024 04:08:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mohit Marathe <mohitmarathe@proton.me>
Cc: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Mohit Marathe <mohitmarathe23@gmail.com>,
  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 2/2] patch-id: replace `atoi()` with
 `strtoi_with_tail()`
In-Reply-To: <boJAHbg3xUqJ1hriFJu3QNlF9CYWbP9x9zu9mcV1jk1SI2WGAOes-wU1MMBZBWvMxs6VTkhlfE59iMEnYcDTOUTxA-3M72kvOJN613jaygw=@proton.me>
	(Mohit Marathe's message of "Wed, 13 Mar 2024 15:01:19 +0000")
References: <boJAHbg3xUqJ1hriFJu3QNlF9CYWbP9x9zu9mcV1jk1SI2WGAOes-wU1MMBZBWvMxs6VTkhlfE59iMEnYcDTOUTxA-3M72kvOJN613jaygw=@proton.me>
Date: Thu, 14 Mar 2024 01:08:58 -0700
Message-ID: <xmqq34st1bhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1C9FDDA0-E1DA-11EE-A9DC-25B3960A682E-77302942!pb-smtp2.pobox.com

Mohit Marathe <mohitmarathe@proton.me> writes:

> I am writing to inquire about the status of this patch. 

Thanks for pinging.

Please be kind to fellow project members by including a URL under
https://lore.kernel.org/git/ to the original discussion.  In general
there needs to be a reason why a patch should be applied, but a lack
of reason why a patch should be applied is good enough reason why a
patch may not have been applied so far.  I cannot offhand recall
what problems the patch had or if there were additional problems in
the patch that was left unaddressed.

Thanks.
