Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A517187550
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148723; cv=none; b=ZASad7QQD21ho8itGoJwwM+84sRfRX/QbXiX1+xCi/4ifBahYFtlg2ajBN14oL7K3CReezC9ooUgXGxScRwZ6mfXWYMwLbsQBweVVsqtaw7KdfXcCgAelh/hZOMKfIYJj+NsZvH6fSuOuYLFvcw1sOA+lugH/0E9DYHNB0wWoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148723; c=relaxed/simple;
	bh=Vkn8iO+55BHuaJ9kEFSMlxupkfSDhaAktAiqrFYaXc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1IWABrXFcJuo/PVbHD69+f5r1EqExIh/zd+jQ9y1w/tGJRhE05LYbKCvbBS7/IO/hV+krwHnwl+y0zuslRES5jtVF5izbXjbfYAZi2UhNGqaz9/p5IDROmVR8kYwz6Bpnjn8OlCK5uPkISlMnn3ZJaAov8CqOk5vQ4Hle76zxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1tYtjh-00GHfc-1b;
	Fri, 17 Jan 2025 21:18:37 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1tYtja-00D2cD-0l;
	Sat, 18 Jan 2025 06:18:30 +0900
Date: Sat, 18 Jan 2025 06:18:30 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connect: address -Wsign-compare warnings
Message-ID: <20250117211830.75prk6e2u3qlatwt@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20250117074909.1430067-1-mh@glandium.org>
 <xmqqo705mjw7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo705mjw7.fsf@gitster.g>

On Fri, Jan 17, 2025 at 09:26:32AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Most of the warnings were about loop variables being declared as ints
> > with a condition using a size_t, whereby switching the variable to
> > size_t fixes the warning.
> >
> > One other case was comparing the result of strlen to an int passed
> > as an argument, which turns out could just as well be passed as a
> > size_t, albeit trickling to other functions.
> 
> As long as the blast radius is limited (like this one, which most of
> the cascades were within the callchain of file-scope statics), and
> the changes of type is going in the right direction (in this case, I
> see all are using size_t for length that may come from or compared
> with the result of strlen(), which falls into that category), such a
> change is very much welcomed.
> 
> Even if the primary objective is to squelch the -Wsign-compare and
> even if we are talking about a line in packet_reader object, which
> would not exceed 64k bytes and using size_t is way overkill, that
> is.  I personally do not think -Wsign-compare cleanliness is buying
> us all that much, compared to the amount of code churn.  But this
> one is well within the level that I can tolerate ;-).
> 
> Will queue.  Thanks.

Do you want me to address Patrick's comments?

Mike
