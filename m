Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB684308F15
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541954; cv=pass; b=TwupjAirOmZgs5ANQ5keCc/4V7r4z+pw5Jbzq5XmDJLhIU3jKZVaT63U8Xb0f1wXkXLEFY9vg6wktoltInCisyweeoO1HZqPzJ4UuZ//soF9Dm2O/L44gN4X2zslMZVCTV/xDP1PUciZR5kw/62PE0d7lEntl1715qUt2gUsnjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541954; c=relaxed/simple;
	bh=+aEELw9+KJXWWENiG2IkoV7FYS0TGPk7+Wn37P0iodA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pg+lhe4ZBBrmlKerH6xeMbdmlcdpCKycLiKu8jC87h58gjBYKxRkOCDm5HBO6GziPnrQXwgzkn5hxb4KPc7Bvj9q3iE7vadL0L+Pu4U8w/HYc8bihbi/G4AOoMqTR0QoULEYYdxqQXH4yu2hQWZ/T+h7jisJrfVN04KTOOp/fjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cec93h1O; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cec93h1O"
ARC-Seal: i=1; a=rsa-sha256; t=1772541941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ndiFYMMgFb4ztd6oJGINk7JzhT8h0TaIwJX3unlAxd9bZBdcalfuS6CvQ3JYGxNLDBPLwkngOWdFt7XbKTy0YLinoW2tR90VFZHVA29JvohpsdXBq6hjdAP+Bkn9sZTAWJHCBSogFgP4nC3ata07wNseeDDoqG039p/eory0Z+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772541941; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VRhfZmPNfc7YyRLo7mV+4skdFz6/NnbOxuMi3V2RFRg=; 
	b=OxAi6pfzD9CaO9/5koY43MC4xHPPziV4P7HDunvB3LEyGy+EkBT+vQD6oBM1b9RI+DN18jt90FjzBQ51ANZ5W2+4U0ICdm3vqguf3C7yh45UW4gcNFkAWuQ4sL4G+Q5goeOlptwaOVNXYCYl8sZqZgIP6hUEBRhxl/cIBXHACIY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772541941;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=VRhfZmPNfc7YyRLo7mV+4skdFz6/NnbOxuMi3V2RFRg=;
	b=cec93h1OUBDz0wYQ8IpBe0Mfn0VyOvnAU8/fq0dswvXQLOHjt4qTLiuy99698wUC
	3v1RtnIqjNAZATCa9WdBwIUkIWZwr7njk2CZH+9DpVY/MymX4BziDwOmmEC4TBwRTfy
	Siz1qX1GE4jK8gRyAXjj+CC0fsuFR1pbT2QSm9q8=
Received: by mx.zohomail.com with SMTPS id 1772541938693245.0080303997919;
	Tue, 3 Mar 2026 04:45:38 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Emily Shaffer
 <emilyshaffer@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] builtin/receive-pack: avoid spinning no-op sideband
 async threads
In-Reply-To: <aaZ7eXtUSWSS_igX@pks.im>
References: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
 <20260302191704.1814567-2-adrian.ratiu@collabora.com>
 <aaZ7eXtUSWSS_igX@pks.im>
Date: Tue, 03 Mar 2026 14:45:34 +0200
Message-ID: <875x7dozdd.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 03 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Mar 02, 2026 at 09:17:04PM +0200, Adrian Ratiu wrote:
>> Exit early if the hooks do not exist, to avoid spinning up/down
>> sideband async threads which no-op.
>> 
>> It is important to call the hook_exists() API provided by hook.[ch]
>> because it covers both config-defined hooks and the "traditional"
>> hooks from the hookdir. find_hook() only covers the hookdir hooks.
>
> Just out of curiosity: will `find_hook()` eventually be removed? I saw
> that we still use it for the "proc-receive" hook in git-receive-pack(1)
> for example, which feels a bit fishy to me.

The answer is a big YES and I actually thought about this while fixing
the regression yesterday (unrelated to proc-receive).

All hooks should use the new hook.[ch] APIs which provide clearer
functions like hook_exists() and all direct find_hook() / run-command 
invocations should be removed.

> In any case, if this is an oversight then this can be handled in a
> subsequent patch series, if you ask me.

Yes, this can be done incrementally in a subsequent patch so that
proc-receive can also benefit from hook.[ch] features like being able to
specify it via configs.

It was out of scope for the initial patches, so I didn't pay too much
attention to it, but it should be rather simple to convert. I do plan to
convert it as well.

The end goal is to make find_hook() static (not exported outside hook.c)
once all its external uses have been converted.
