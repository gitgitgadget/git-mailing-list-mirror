Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7B13E3E4
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273440; cv=none; b=QTTdREg3h8fOhj+EZ8MgxiAmtn12M4gC4vTVn3qmWtSc9IsoMKQ70hAMRxVXJR6LlChRfPAPthLQdP57tuN9SG8l1DWtUcN1iNOJr0mSSLUFqPy2db+lekNZsLnwm+wd58SDtW38V0JOXnq2FMFZiVp3UiZrbnTVThDhccokyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273440; c=relaxed/simple;
	bh=ePDmJZh1v0JGhibb4PT950mpdW24XCVHhzbSAbkZQc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMDyYTBjNAqYT3wy5vUC6I7AA451djYTIjr2YMuwz/Xp3p+QtNlgUfrFQRwFYnUKjojZCTZiACY0+JEkGsetV3zOpdgxBxVwe0AC94GjgYPJDW3+fKZ369LJfu5C4JjjBDFTjJ/Nj3334ZsfFRrsSlh2Roe+0bMD7xWt6+rwjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xN7iZU8s; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xN7iZU8s"
X-Envelope-To: el@horse64.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1718273432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ePDmJZh1v0JGhibb4PT950mpdW24XCVHhzbSAbkZQc0=;
	b=xN7iZU8sc3ncgaCZPHiOpe38RgXbKI+MoOaWTwXOupcSicM9/v0lHFtUIMx+LqITUuM0Pn
	aZORW2+PdzCKESKsC73we7hI/TnBNKsGh3o5IAn5qTPyP94kkKmsS5dN28R0eQ8yGrtpI0
	/uUsF3t7FTCbjXVQ87KxHYSrhkT5Vi8=
X-Envelope-To: gitster@pobox.com
X-Envelope-To: nasamuffin@google.com
X-Envelope-To: peff@peff.net
X-Envelope-To: rsbecker@nexbridge.com
X-Envelope-To: git@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon claes <toon@iotcl.com>
To: ellie <el@horse64.org>, Junio C Hamano <gitster@pobox.com>, Emily
 Shaffer <nasamuffin@google.com>
Cc: Jeff King <peff@peff.net>, rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
In-Reply-To: <f5c24dfc-8d35-4418-b8f6-0a03d70c0917@horse64.org>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
 <xmqq5xug1qrf.fsf@gitster.g>
 <f5c24dfc-8d35-4418-b8f6-0a03d70c0917@horse64.org>
Date: Thu, 13 Jun 2024 12:10:19 +0200
Message-ID: <87msnpjgqc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

ellie <el@horse64.org> writes:

> Sorry for again another total newcomer/outsider question:

Don't apologize for asking these questions, you're more than welcome.

> Is a bundle or pack file something any regular git HTTPS instance
> would naturally provide when setup the usual ways?

Yes and no. Bundle and packfile format can used in many places.
Packfiles are used to transfer a bunch of objects, or store them locally
in Git's object database. A bundle is a packfile, but with a leading
header describing refs. You can read about that at
https://git-scm.com/docs/gitformat-bundle.

> Like, if resume relied on that, would this work when following the
> standard smart HTTP setup procedure
> https://git-scm.com/book/en/v2/Git-on-the-Server-Smart-HTTP (sorry if
> I got the wrong link) and then git cloning from that? That would
> result in the best availability of such a resume feature, if it ever
> came to be.

As mentioned elsewhere in the thread, on clone (and fetch) the client
negotiates with the server which objects to download. Because the state
of the remote repository can change between clones, so will the result
of this negotiation. This means the content of the packfile sent over
might differ, which is disruptive for caching these files.

That's why the proposal of bundle URI or packfile URI is suggested. In
case of bundle URI, it will tell the client to download a pre-made
bundle before starting the negotiation. This bundle can be stored on a
CDN or whatever static HTTP(s) server. But it requires the server to
create it, store it, and tell the client about it. This is not something
that's builtin into Git itself at the moment.

This is not really related to the Smart HTTP protocol, because it can be
used over SSH as well. But when such file is stored on a regular HTTP
server, we can rely on resumable downloads. Only after that bundle is
downloaded, the client will start the negotiation with the server to get
missing objects and refs (which should be a small subset when the bundle
is recent).


--
Toon
