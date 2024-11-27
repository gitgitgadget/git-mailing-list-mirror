Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87821FCF63
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717506; cv=none; b=KAD2QW0pDYhz59o1F40EcdsTh+c8dBtE9twwB1MWNHA2DGcanvmQ7Q4Vb/7h/GzLli1WKwyjyTdZXiBZ3QKY2FXJDzrSRr/E2WQPagLzD0GDHj22IzRiHc0VqoNCnR6PtSQ/s9jslTlnXOJGbFxfFVENqpV78u4rf9KKdrFOBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717506; c=relaxed/simple;
	bh=FRPYczkv8SQU++McJLenQNFWD0LSdkfO6v3FCT0h74w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKxTZpHf5D70PGGAMX9curiSplCd2E/fM2DIvStiazXq0M2I0Crr0+IbO+Z/z5r4NdSi/4I+dSdJ5UiSOCYBb0N3neB/LFL0I/ov+f28MpDTLtnS2Zmj+iqpB1t8lX31A8AihtxC4teosarI1bQN7tcBdksWun2jYLiIjZKRp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H3wn1g5T; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H3wn1g5T"
Received: (qmail 5094 invoked by uid 109); 27 Nov 2024 14:25:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FRPYczkv8SQU++McJLenQNFWD0LSdkfO6v3FCT0h74w=; b=H3wn1g5ToXbd50XKGIf63hlM235rkC+yvpagK0IRNI6QpjdW6D5hHjpZg1Mi1PMFdxESV1FeGkbBTMZ3t6ShpCoEFQaW35HG2VAsWNbzQjx2ATeEPTeohtK6/jVFh5pQH4XxogbWCwpURRbe7B1CiCuplU05fSWzp8Qr24e0wyg7s/OmCmZDUGtxCNvEX4xwftl9Q9d4No93S3l3a9Wque1nLl0EJUFKk92P9izBZ0Y1zZr3lhYhMBagOmHATuTbGPOVhM1HOW2Ole//EhyJ0qpEZepKRTXy0SmnHOE1lbyzRiHq5QLTwbNGBrWqncWzPkn+mIKItQvx5ysz+0b/zA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Nov 2024 14:25:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 748 invoked by uid 111); 27 Nov 2024 14:24:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2024 09:24:59 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Nov 2024 09:24:58 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: disallow "." and ".." path components
Message-ID: <20241127142458.GA1712@coredump.intra.peff.net>
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
 <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
 <Z0Vxb4OVJYeAdgds@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0Vxb4OVJYeAdgds@pks.im>

On Tue, Nov 26, 2024 at 07:57:57AM +0100, Patrick Steinhardt wrote:

> On Mon, Nov 25, 2024 at 07:00:48PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> > 
> > If a user specified e.g.
> >    M 100644 :1 ../some-file
> > then fast-import previously would happily create a git history where
> > there is a tree in the top-level directory named "..", and with a file
> > inside that directory named "some-file".  The top-level ".." directory
> > causes problems.  While git checkout will die with errors and fsck will
> > report hasDotdot problems, the user is going to have problems trying to
> > remove the problematic file.  Simply avoid creating this bad history in
> > the first place.
> 
> Makes sense.
> 
> More generally this made me wonder whether we should maybe extract some
> bits out of "fsck.c" so that we don't have to duplicate the checks done
> there in git-fast-import(1). This would for example include checks for
> ".git" and its HFS/NTFS variants as well as tree entry length checks for
> names longer than 4096 characters.

I had the same thought, but I think the right code to be using is
verify_path(). That's what ultimately is used to let names into the
index from trees, from update-index, or from other tools like git-apply.

So I'd consider that authoritative, and fsck is mostly trying to follow
those rules while looking at only a single tree at a time. But
fast-import should have the whole path as a string, just like the index
code does).

-Peff
