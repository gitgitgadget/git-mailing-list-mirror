Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA5136327
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613556; cv=none; b=FIQUIjEytj4pi8A14RQm0UQp0nNCHv9fT/NSVIX6EbjS+xMhEEZo0AHQrXgn2Pqn3Qr09FSnLFJmVvHUkyO4LN5ynizKI3CrZuoNkGdJUvPFdbDBVUyDuRs7BCTKQRvTm2uGW1HuNseLk9C1VM1IkziO1AZ9xhU0t46nVhz1z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613556; c=relaxed/simple;
	bh=b6Fa+myUM2E1PHfE6jciBPo4q+mzPDQTeH3JClElPqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXDPA3j//xoXysW9TlH1/n8yhW2yFMQGYRaJksGuCL4tESKtt+XoAQnvzfU0egKzlQ/LAk2pkyzgg5tFNjQ1e6M/3DTahp7wIj1rGdt2cRRjb+N/ziK8O7KAEpNhZSCWsN/H4IoW5q44aRAn5QZEReCKlGwDEkoKCcbpWC/AXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=M4tMGbWK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="M4tMGbWK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1722613548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q72QJa/EufI0T0kTUDWekO4dGJQYLFtmfOLT77+q8U0=;
	b=M4tMGbWK/m3nI3pv5rMONzGLZGGheJLpY9Kcm0hrMy6vQe7alCGja3vo+mwp1ANSmgBLAL
	744j4tCaRiTOrkPH84wzIXZH3DGWg5w1DYzny95XZjuckJ3rLslRZ+nsTiO9DEYME1StsN
	penuGSgHyjD8ipeqZ2IKdmlxPHQG9BE=
From: Toon claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/3] clone: remove double bundle list clear code
In-Reply-To: <ypkmgjgobu2tn36o7qzultltknaz35qysrfe4y4kce67uysdxk@edmxls7p36mx>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-2-toon@iotcl.com>
 <ypkmgjgobu2tn36o7qzultltknaz35qysrfe4y4kce67uysdxk@edmxls7p36mx>
Date: Fri, 02 Aug 2024 17:45:34 +0200
Message-ID: <875xsj9bdt.fsf@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> From the commit message though, I thought the added test might have
> something to do with the changes to when `transport->bundles` was freed.
> I wonder if it would be a good idea to expland on this further in the
> commit message. Or since the added test is somewhat unrelated to this
> patch, maybe it should be a separate patch?

I added this test case because I wanted to debug the code path where the
remote advertises bundle URIs, all other test cases use --bundle-uri.
This helped me to debug the code and understand where the
`transport->bundles` are freed. Although this test case does not fully
touch the code path of the code that's removed, but it was close enough
to hack a few extra lines and understand what happens. Since I wrote
that test anyway, I felt I might as well submit it.

-- 
Toon
