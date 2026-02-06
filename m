Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236582DC798
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371319; cv=none; b=kr5cutzFxjBYqnFUtYe3/MgK/yLYnFpk0mttzyI5RxLurM9HIpL201abcY3BMi25xQPA092h4ZpSOqhEVlQhH07GHajK+gSGbL5IjrJgUn4ih12bNz7WKkIK5YOE32IU1KxTK4w4e1FH8bp+xr/SsBhjzePuAp+WJ+9skNqyBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371319; c=relaxed/simple;
	bh=lmYZgEVViPDeKshFAp9U12cCH3MKqdalcXz9AROca+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OhX3IKI4nu2EKHoA0jLiXHzMFcoS2V5MSRn4h6ejwN+QYsWMHbRd+dw9QFtrLZcRDazEsyd04Em6J3Dc5ubgVR1IMvfq19XafsJEOuoQ+oeN4lW1AceNyUTu5yFj11xt8t0oiQOrz4Vsarn01ZU+zSO6rg8HtXW0Dty6Lz+A11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHaH8BiV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHaH8BiV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770371318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1wpXfTME4Yn6CsfCH7pxz+Excz29VSCWEf8/tyUGkDU=;
	b=hHaH8BiVRWSpbhK7O0OR/ost4H9495T7crXBftnA/7K4QZUHg0NLYf009hvevg27GTVjmu
	CoETTXKcUrFWTZgm80yXEzLVF8Dt2clPxrTM0XVcwIWaUO2HKFbYK/LUFqWnigJWtoFHsy
	SyahvK9QmAidkfaMo87pT1KAn4/hGis=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-FrcbyDXUP0WS5ISgL_0Smg-1; Fri,
 06 Feb 2026 04:48:34 -0500
X-MC-Unique: FrcbyDXUP0WS5ISgL_0Smg-1
X-Mimecast-MFC-AGG-ID: FrcbyDXUP0WS5ISgL_0Smg_1770371313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 951B119560A7;
	Fri,  6 Feb 2026 09:48:33 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19DC41800465;
	Fri,  6 Feb 2026 09:48:31 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.keller@gmail.com>,  Matthias Beyer
 <mail@beyermatthias.de>,  git@vger.kernel.org
Subject: Re: git-am applies commit message diffs
In-Reply-To: <20260206092423.GB2761602@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 6 Feb 2026 04:24:23 -0500")
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
	<CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
	<lhutsvuuu18.fsf@oldenburg.str.redhat.com>
	<20260206092423.GB2761602@coredump.intra.peff.net>
Date: Fri, 06 Feb 2026 10:48:29 +0100
Message-ID: <lhujywqtd76.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Jeff King:

> On Fri, Feb 06, 2026 at 09:59:31AM +0100, Florian Weimer wrote:
>
>> Isn't the format-patch output already unambiguous because the sequence
>> of diffs is preceeded by the non-diff statistics section, and only then
>> the commit message follows?  It's just not possible to process this
>> correctly in one pass because only at the end of the input, you know
>> that you have just seen the to-be-applied diffs.
>
> That diffstat is optional, and not parsed by the receiving format-patch
> at all. Keep in mind that in the world for which it was originally
> designed, people were not necessarily using Git to generate their
> emails. They could be patches emailed by random folks using "diff"
> themselves.

Is the git am format that flexible in practice?  I often have trouble
applying patches with git am that were created with git format-patch
and have to resort to plain old patch instead.  As a user, I definitely
get the impression that it's not a type of tool that gets a patch
out of an email message, no matter what the cost.

Thanks,
Florian

