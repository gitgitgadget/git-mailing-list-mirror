Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014B3BBF4
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882041; cv=none; b=QkwFYZVNhECQE6etKzh8pheUG1omNU7EYgu5otTSLEDbuXC04ExkiQoCP/BqvSj90skiK156O5PEgUg/x/R1EPkajISjNDOAqJtNpSMO2yyHpEMNn7/2AmJAKjLjOrIbEzhkCN/XLtapLWI5kw7k6S/2iHhgnha37IQdF2GM8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882041; c=relaxed/simple;
	bh=o47zssUKmpwYUgQcB7rv/xxUwL+qLVtSxioGWj0+ESo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HAaUXu8I1qnWemV45aL/RaiBVV1In2PCVrCt2PO29FtUBC/A7YDUXIBeoob3LGwGLNSb6aFKFhALn5DVfj+3FJ0Hg9LzBlzgtNLizkGbKtI04iZIFKOtCZvqR1fntTvA+rDoBoeQIiDtk16OswXbN6zK1Ig01lmBw/7FJI1yHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ihSW3QzH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ihSW3QzH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 83196297EB;
	Tue, 19 Mar 2024 17:00:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o47zssUKmpwYUgQcB7rv/xxUwL+qLVtSxioGWj
	0+ESo=; b=ihSW3QzHqP1P99fqc1/IOy3FY4NRvnUKaGRh4SUX8HF9NwyQXOXuH8
	kJ1vuw0nOScv0Pc52LcjMUiyRegkNpGWp6gR25tQAoEp4RF+ic+707mzA0BzH5dX
	+8/3aNJYLz5y5ExzOiIBRzX+qafPwTkUXIyZ6o1FGAqxlTg2dCJOU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C273297EA;
	Tue, 19 Mar 2024 17:00:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01A82297E9;
	Tue, 19 Mar 2024 17:00:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ignacio Encinas <ignacio@iencinas.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] t: add a test helper for getting hostname
In-Reply-To: <20240319205753.GB1159535@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 19 Mar 2024 16:57:53 -0400")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<20240319183722.211300-2-ignacio@iencinas.com>
	<xmqq8r2eneut.fsf@gitster.g>
	<20240319205753.GB1159535@coredump.intra.peff.net>
Date: Tue, 19 Mar 2024 14:00:34 -0700
Message-ID: <xmqqo7balyx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB9A1B48-E633-11EE-933C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> I think you need to lose the exit status. Or alternatively do:
>
>   hostname=$(test-tool xgethostname || echo unknown)
>
> See my other reply.

As "test-tool xgethostname" runs exactly the same codepath as
"includeIf hostname:blah" feature, I would actually prefer for a
failing "test-tool gethostname" to _break_ this test so that people
can take notice.


