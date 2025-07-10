Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B72AEF1
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142698; cv=none; b=BQmSYvzmLfrUIr0pomqGY5q/eQolewJB3SnTXdMbg//BiI38yHSs4bF9/mnMIu18IWJGEoTsKxODcpvmH99ts42N8BVD8axXguc3Cqg5KV2PTqBxncEVtVoC92bg1xj2++u01dFxrAh984uTI/FLeG57T7MF5cd6CeOcyq2H2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142698; c=relaxed/simple;
	bh=0B0ZuiM2IK1i3JL16j6pUw3r9tVYdV4AKNI3i+alzQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHyh981M/6y5jHU9rSfbH2LhdcjNP6u4/vT5Yt64pUx+rs2Lw6OfeJOsdcIqoQqunr+6BkwLFSSd40RvNsNfMqILLcJYrFpBR+teRLEx8Z2MY2ISuhOIgDmzUUSmpf4wKzZdmHwaQr0RV0FgY92r3ZwRE0JihgyWkifgtjZZnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0SfDnYfN; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0SfDnYfN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752142689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0E66EEOUJ1yq8f1RoD80Mrg1PdK4t0kqJMn9s9XI30=;
	b=0SfDnYfNvdbLcVXhW1+HYOTmoE+W2+g0Hwt0onoqZaDXovaa7QPx5wIhnvj2Rq32o/54ks
	FT2kSsAuSY+vX3TnmnhmBGAWTJjBD0WWbosLm97JlsFVF/tfape0jwWBeApQ9Y7c30rSMQ
	DCxDRtEI3v6GxaxHvRllvRMFpW8vjiU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Subject: Re: [PATCH RESEND] sane-ctype: fix compiler error on Amazon Linux 2
In-Reply-To: <aG-HMnO11lCYgPiY@pks.im>
References: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>
 <aG-EfIfyXxmS_x22@pks.im> <aG-HMnO11lCYgPiY@pks.im>
Date: Thu, 10 Jul 2025 12:17:56 +0200
Message-ID: <87ldowcpt7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Meanwhile, I'll include the patch as an attachment.

I have tested the patch on the Docker image we saw the failure on and
this patch fixes the issue.

If anyone is curious, on that system <ctype.h> is included through:

    In file included from /usr/include/openssl/kssl.h:72:0,
                     from /usr/include/openssl/ssl.h:165,
                     from git-compat-util.h:226

Doesn't matter much, because the patch makes sense to me.

-- 
Cheers,
Toon
