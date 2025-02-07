Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281601DE3C2
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922620; cv=none; b=Z5c1AbQgGAr+UBr9+dy8i+ygRPz5Fgb1mdA6Z2q2+UDbYndmNjDfaI7BsonMEn36AGwWqoRr/miU778itMp1VxegDa1x9ZpBjcI4HOhvCIGUdKNAksf1pgM/+3MfhJkG3onBSnQNvdKrHcAnolX2/kP0WPnOLZ7/XGw1QDSApX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922620; c=relaxed/simple;
	bh=nkzKkV8aTxKbrdCtHHzinQPO6E7eLzqLGEfZKdCbaHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WsLAHJ5eq4EoeFA8y2GhyaZQbA8QwAR0/cfvj8T05qnGKfXY2BSHoFrmbi+MQ5EaPHQZs/q4TRdCNRlfUMIuWt9QJEBdQpE/hWqdbyMXvZ5EzkGFV/mSDL654GJbERflfpT8+5z+KyIqeduYv/5nyHic4nTWrRipOSW4XEhdpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nVXTIHyv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nVXTIHyv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738922613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LWnYe/wtaaEfbQfEIBdMTs/ga9ZFpueT4Fygnc7Nf4Y=;
	b=nVXTIHyvyOU7cJCnvwF/OG00o4tVkQ8wugPG7QCfXEIplbP+Qdnow5a0AI03EU8O+EuyXy
	TVHoWVgi8kbZpOVGjimuhh11/qoWd3mQ2npKk3BQ4WcTcedvcIWKE8JDEDFmNf1Veu9/gl
	FbhTrWZvu6YU88G4UYGazaPbLVm+G+U=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Justin Tobler
 <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v4 14/18] reftable/basics: stop using `UNUSED` annotation
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-14-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
 <20250206-pks-reftable-drop-git-compat-util-v4-14-603d276d5f95@pks.im>
Date: Fri, 07 Feb 2025 11:03:15 +0100
Message-ID: <87bjve3wd8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Stop using the `UNUSED` annotation and replace it with a new
> `REFTABLE_UNUSED` macro. The latter is a weaker guarantee compared to
> `UNUSED` as it only suppresses unused parameters without generating a
> warning in case a parameter marked as unused is in fact used. But it's
> good enough, and by relaxing the behaviour a bit we avoid having to wire
> up compiler-specific logic.

I see MAYBE_UNUSED is defined as `__attribute__((__unused__))`, which as
far as I can tell is independent on the compiler, and has the same
effect as the implementation in this patch. Would it make sense to use
that defition instead? Or did you intentionally choose a statement that
will sit on a separate line so it's more obviously that line needs to be
deleted whenever the parameter is put in use?

-- 
Toon
