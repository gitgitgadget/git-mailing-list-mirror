Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B1273FE
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910666; cv=none; b=fQG4BhaqOtuKwjI6WKca5nqpIDMTdKL7amGArxKeayMezhIb5bBuPhab2hpIM6imNen35QldPXRShec1QUZNwldmpvtPB1AclGSw7sjE7IcwiGB5xJJ/+Jr7qwFwDEQKVaWb1SzjwPAho1aHOj+iYjrIi3icuy/OSHp1slW2wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910666; c=relaxed/simple;
	bh=gPYZGm240Hf1Ameuli61cg0BOMNotIQfrtQxlTQs+dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmeT57yj28tIucOb7BpDiWyJh+zG+zb9cBKy4EwqXkN04EuF3sdTzWSUKizSLfrgPkBZRApVaZx/eMKFhkTr/WJeiUks3JL1xRrICHsdRqYYK6fCaquzo8er/OeBqU6PA3X/zEGQM3+whXjvlhVqiJxO0sZMud7quQULzFyCqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ViSTmwf6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ViSTmwf6"
Received: (qmail 194166 invoked by uid 109); 3 Sep 2025 14:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gPYZGm240Hf1Ameuli61cg0BOMNotIQfrtQxlTQs+dU=; b=ViSTmwf6zpEsqtW1CkKkW5bieE8ZLmlfQFMPXpSIugmrlRbxMgkO5R/5CfBKJQcS+xr1y/6LHrb1TZiV3xbt9qst5Yl8IeOBsUPXzXacyJjWkkgRalAloFJua6t94E6U27hmNc6dg/s2tSnZvrl2eVXKf8/EtCqWo9CMS7DDY3LQ5op2obDuQ71pLWJwicugQWXjtIJlnnWYZ1q3aHMcP2Xy5Tm4jqmDqCa5GWijhE2F9/fmUiYMNZue3h4KPmf27O4dmcPqBMNJq+kWG8LdqarXlRONicD7xxVXYVlk8xODL0A7VU+LwHKGrigEI/JmSaYYSKlvHr5Xl9PqxlEZfw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Sep 2025 14:44:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 342014 invoked by uid 111); 3 Sep 2025 14:44:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Sep 2025 10:44:23 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Sep 2025 10:44:23 -0400
From: Jeff King <peff@peff.net>
To: elhmn <elhmn42@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: Reference transaction hook is unable to find the old_oid for
 pre-existing refs
Message-ID: <20250903144423.GC1884731@coredump.intra.peff.net>
References: <CACpeKQ=sPOc2AqsMT--2tu=BMEK9MaCAq5=PTG5w49gbRcQgVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACpeKQ=sPOc2AqsMT--2tu=BMEK9MaCAq5=PTG5w49gbRcQgVQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 04:11:05PM +0200, elhmn wrote:

> Then ran `git update-ref refs/heads/master A`  which logged:
> ```
> 0000000000000000000000000000000000000000
> 01077b2840db5baea0084921d8f3158a240e8d85 refs/heads/master
> ```
> 
> But I expected:
> ```
> 9b18557013105bb7a7bf681f18757084ada9d948
> 01077b2840db5baea0084921d8f3158a240e8d85 refs/heads/master
> ```

I don't think the first value is the old value of the ref; it's the old
value that was passed in to the transaction. From githooks(5):

         For each reference update that was added to the transaction, the
         hook receives on standard input a line of the format:
  
             <old-value> SP <new-value> SP <ref-name> LF
  
         where <old-value> is the old object name passed into the
         reference transaction, <new-value> is the new object name to be
         stored in the ref and <ref-name> is the full name of the ref.

You didn't specify an old value, since your "update-ref" command only
gave the refname and the new value. So you are "force updating" the ref
in the sense that it will be overwritten regardless of the previous
value. The same doc goes on to say:

         When force updating the reference regardless of its current
         value or when the reference is to be created anew, <old-value>
         is the all-zeroes object name. To distinguish these cases, you
         can inspect the current value of <ref-name> via git rev-parse.

So I think it is behaving as documented. It is a little unfortunate that
a transaction hook cannot tell the difference between "the ref must not
currently exist" versus "the caller did not specify the old value". An
empty string or something for the latter would have allowed that. But it
is too late to adjust the interface now. Possibly we could pass an extra
bit of information to say whether an old value was passed, but I think
it's tricky to do it in a backwards compatible way (e.g., we cannot just
do so in an environment variable, because the value may be different for
each ref that comes over stdin).

-Peff
