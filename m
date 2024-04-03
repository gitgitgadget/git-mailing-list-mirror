Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493A14A62A
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162579; cv=none; b=V07A5i6OYU3YdAZqAAAyZOFJGhI3QApLeLgxxa2yrE3s5iPf+D5qK+1nDhwPxh5MGaBtEIL1qonCkRCEKkkIxjpXq1DP+zolbUOD+ftbNdkOE0A1yFrrxn4bE7jp6HbWUtJSSHJ5/pFfC6jREGMaUf9t91LoUYoNTLSqdIhjvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162579; c=relaxed/simple;
	bh=50nQsU667Rc60MRXpJl0KFmKQcoMeBPTDikZI1Khk4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c70qnlNih8zcNPh48t33AdoeCKdgC546BwwkOGm+TOXLf/kdDm+P4I+cxRan4xcC0KcURlmlWD8lukB1O0A3y8yNcRm6NC46Vn9PZk2hyPi0A7/c6/fwdkIybcwKMBCj3FIwS/AXCVY4VAmmVpAsHiCg0XNrB/pbyv/k+5sPZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xzaSa4Hc; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xzaSa4Hc"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DEA221EBE27;
	Wed,  3 Apr 2024 12:42:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=50nQsU667Rc60MRXpJl0KFmKQcoMeBPTDikZI1
	Khk4Q=; b=xzaSa4HcJz5s8QPSbm4w9HYUcVxRnAu1oTTqeGjWlvYi1QS9kssafZ
	Ax1yTXUpz6xIvkaT02HbJw4tLCtImaWnRw6Y97zKjYI7oiG/8UxyKPl8qcHCDSCu
	6q36GgfBPiu0hc85IxL5OQ098HAYGAnDeS8cA4Dv/P4HAjEDwFCQw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5B2C1EBE26;
	Wed,  3 Apr 2024 12:42:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F87F1EBE24;
	Wed,  3 Apr 2024 12:42:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: git <git@vger.kernel.org>,  JGit Developers list <jgit-dev@eclipse.org>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: reftable & jgit compatibility
In-Reply-To: <64970945-5E37-4792-9F37-790CFD82A1BF@gmail.com> (Luca
	Milanesio's message of "Wed, 3 Apr 2024 16:51:04 +0100")
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
	<64970945-5E37-4792-9F37-790CFD82A1BF@gmail.com>
Date: Wed, 03 Apr 2024 09:42:55 -0700
Message-ID: <xmqqjzle8kj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3912C588-F1D9-11EE-8794-25B3960A682E-77302942!pb-smtp2.pobox.com

Luca Milanesio <luca.milanesio@gmail.com> writes:

> Hi Han-Wen,
> Thanks for completing the ref-table on JGit and kicking off the work on CGit.
> ...
>> So far I have always been able to read JGit reftables using the C / Go
>> code, but it would be good to systematically test this, ie. generate a
>> bunch of tables using JGit and check that passing them through the C
>> code (read & write) leaves them unchanged. Or perhaps check in some
>> tables as golden reference data.
> ...
> I am happy to experiment the support on GerritHub.io, we have over 40k repositories !

Thanks.
