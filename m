Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325829DB64
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075873; cv=pass; b=okB2sIbuaJXO2yaMCQuB518ntgTxnr5clymvpwQAo9ZoBl7dBM4Xq3kZUwebuahpGnh+wo8dlpwKf7WheW9Z33AOg0UMzhjFYjopMxFSN1uw3QJdl8T06ITukZRbfmFh5l8Bam17oxeghDzi33kGIsxbWEI7lmCOt0OnGLSzAwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075873; c=relaxed/simple;
	bh=zfSA6hj74zJmKE1rxMogIh4ZeJpCf6KTPeJmDxEl/vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GI80H4vgvCRA32BIQr4YfHNlxt3UkwS9HT8w3XHawZxDop0KRF8srpc+xq/SngbcHjvfhHnbep7o29qaRgeZs3IVzfh6Eh7/gXzOC+w007hQw3/haKTYSBLjqBlWQDuUCmySViEPrOmaLCMONZXXQG0nR5lqGxDdRm8s1zFhLH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ShepvIJ2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ShepvIJ2"
ARC-Seal: i=1; a=rsa-sha256; t=1769075855; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SLWUg7qgWbEgso42BuFwHiM45vJMJBooWigFF8+mdUDeheZRCvQOqXyoqPhux0xZ5u5ZAF/Wj2iOYOcP3SZRm+o3Xx8uzNNKT6+59QuUCR/joszUhYuhVu79KbMmbSmnjvHlEOYsA6t9LBAC5sAbG+0TjVfwVAhzghqAcV4dPeg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769075855; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zfSA6hj74zJmKE1rxMogIh4ZeJpCf6KTPeJmDxEl/vo=; 
	b=KiPsS7pWs6PfOJ6ZJkI7ULDs4YQn2Wi8dsu16BoUbxWYv2/owhsYZ1mmbH3FclRp75X7mHZ2QfUqCDvA0LFUtOU99A9IHbl7CYPqVbMNmZZi0kpABqLBA/C9XkAjfwzQLvoLkdtwWdEVmZnxeotcYu0JQLBpyqmjGBtJQBMvBIU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769075855;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=zfSA6hj74zJmKE1rxMogIh4ZeJpCf6KTPeJmDxEl/vo=;
	b=ShepvIJ2jesP8nA0w5aO5GFmn7i/mpSVdfW2yUEubj4LaKIpweXEnK4Efv4To/9M
	dPXtY5KqpRh9uBIL6qvuhfy2D9gzhR5hqY0wvKu7CKV2oWCMWqx4i5RdsDIolXJfkKG
	/zDotCCqX+85ufINB6QWtFp92W0iGZfUq2/fsLdA=
Received: by mx.zohomail.com with SMTPS id 1769075852786960.6370857309895;
	Thu, 22 Jan 2026 01:57:32 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Emily Shaffer <emilyshaffer@google.com>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to
 stdout
In-Reply-To: <ba1444a7-0c61-42ea-94dc-cd1670ebf3fa@app.fastmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-11-adrian.ratiu@collabora.com>
 <ba1444a7-0c61-42ea-94dc-cd1670ebf3fa@app.fastmail.com>
Date: Thu, 22 Jan 2026 11:57:20 +0200
Message-ID: <87a4y6q8an.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 21 Jan 2026, "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> wrote:
> On Wed, Jan 21, 2026, at 22:54, Adrian Ratiu wrote:
>> Child input feeding might hit the 100ms output poll timeout as a
>> side-effect of the ungroup=0 design when feeding multiple children
>> in parallel and buffering their outputs.
>>
>> This throttles the write throughtput as reported by Kristoffer.
>>
>> Peff also noted that the parent might block if the write pipe is full
>> and cause a deadlock if both parent + child wait for one another.
>>
>> Thus we refactor the run-command I/O loop so it polls on both child
>> input and output fds to eliminate the risk of artificial 100ms
>> latencies and unnecessarily blocking the main process.
>>
>> This ensures that parallel hooks are fed data ASAP while maintaining
>> responsiveness for (sideband) output.
>>
>> It's worth noting that in our current design, sequential execution
>> is not affected by this because it still uses the ungroup=1 behavior.
>>
>> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>
> Thanks for rewriting the commit message to include some user-level
> behavior/symptoms.

Thank you as well for all the feedback.

I just noticed that I wrote in the title "stdout" instead of "stderr"
(the streams are merged in all hooks with the exception of pre-push),
so maybe it's better to just use input and output.

Will fix in v8.
