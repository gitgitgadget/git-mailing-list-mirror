Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826D024BD0C
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311790; cv=none; b=hoRDHPOwymW37QGeod2iRPy+bNMc6R5ov/dWiAZ3IColgxdnWS5qaWp/UKyJP567DVzI1MJ4gbp7stVJppUpj09SqCnV2T+lKmBJHQj7Z1pGKg4Sb5wTcOUV3X6/vcvAjTtiUtvnowAKXc4u8qaNH4KK9p6dfnPOkdAygxWjW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311790; c=relaxed/simple;
	bh=Tb8zWCHjhQFUyB4JDjdIeG0ctgi3l3U6XAn8+hrzJR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQlG3wz8xT9gnN38sj1gaoWdHiO/4Cegg6H/QxHeJEshOY5yMvx+3cDLzphar2GR4LvtdMOrp7SBQGxQSGLGHlKYTwmXANJPthEmc8gpCiollKzg2mwZZKEAG2TwOq3wznygL+n5c4uQlfwDiJXCVnIuV0x2rltugzGsY8SSF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xr70tFIl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xr70tFIl"
Received: (qmail 132605 invoked by uid 109); 19 Sep 2025 19:56:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Tb8zWCHjhQFUyB4JDjdIeG0ctgi3l3U6XAn8+hrzJR0=; b=Xr70tFIlDN6V6va0k++z6ZDYRlTgZ0nFNLDvipsfbW/lh7FtRpKucJnwdEBL8mDeWRKP1x8OhcTh99EA8z/ErO4s7kZJd4WrT+yEZSD4yZhDfaECN8kyTDkX3b+cpfTbNQY0IKt6MElJSYCwPH1sA09CIYf2l2uQ3kSmAtGY7c60ou6QKHkI5n4jwcqyWuu8m2rUv2uZoDcOvJAqGz+PhV+5iov7oJlDuEqmWZfFPutmz4wogtKX3+iV1RIEo4yYQgCNjOwigvVa+1mwi16YCklYHiIkqqCs5ZN8VK2SM2sM60YEeR+TEqyFAmFwHtJDxhjnphu1MUTro7KlyKF+6w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 19:56:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 209607 invoked by uid 111); 19 Sep 2025 19:56:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 15:56:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 15:56:26 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [BUG] git stash show -p with invalid option aborts with
 double-free in show_stash() (strvec_clear)
Message-ID: <20250919195626.GA2750626@coredump.intra.peff.net>
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
 <1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
 <xmqq4isy77qr.fsf@gitster.g>
 <xmqqldma5qha.fsf@gitster.g>
 <20250919172007.GA59895@coredump.intra.peff.net>
 <xmqqbjn65mxa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjn65mxa.fsf@gitster.g>

On Fri, Sep 19, 2025 at 11:15:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But really, I do not know that we need to NULL the whole thing. We have
> > given the caller the reduced argc. The only argv invariant we are
> > violating is that argv[argc] should be NULL (or in this case,
> > argv[left]). Anything after argv+left should be considered
> > uninitialized. So just:
> >
> >   argv[left] = NULL;
> >
> > would be enough, I'd think.
> 
> Even when strvec was passed and more than one element was eaten
> after parsing?  strvec_clear() goes by .nr not stopping at the first
> NULL IIRC.

Yes, there is a big can of worms here. ;) It turns out that many spots
with strvecs were relying on leaving these entries untouched, and so
setting any of them to NULL causes leaks.

I think I've got it mostly worked out, but that's why I haven't sent
patches yet. Stay tuned.

-Peff
