Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3E6BFC7
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099512; cv=none; b=cRMDem0dZDRGJix8MhPN0oqs0pzPL/50rh0+sp7YvE2qicXdjCxLYEC7VUlJuvFtXPgUgK9Jrkxrd55jBUyXnsKYDOpnx9ylj3KM7BzrHOp1lmcb++hiZDntmLDGvxmWvTv5mxOsEo2MDXvX652cO4paOMdTP4ZNpCzVpdUukeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099512; c=relaxed/simple;
	bh=OeLGyJd0pNnhHCdnJl1Cbk4Y5r+MYAFTKfYKbpT3l4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG1x+gFQrI9VvpSNoT0J/WFn0xM5RJxToDReTJDYQ/hm/+4Yqtq6MR3vQ+JZfnhTpSpt2VS4zvqMHRCWdoZ+SrQwuKenTS+BVNlPZCenP/vbB9bD7fnB1tPtAwi4oGEGkVsAYsq7uSMqIrJookJXyeYFt0ga2AdWF1k1DdMH+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Edz7fFxD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Edz7fFxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3489BC4CEC4;
	Mon, 23 Sep 2024 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727099512;
	bh=OeLGyJd0pNnhHCdnJl1Cbk4Y5r+MYAFTKfYKbpT3l4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Edz7fFxDZWJ8Av/ipkJ4UdcuR6F9TpDxHRAQI88Qv9b1DbfHdpG11ikXa8yWcCCU/
	 QoWqqL4SkCwjrlqglrS2V1zPesIspOR2q6UGhd5uP7Sedi0Z9SzmAZ4+zhYNzX7hQ7
	 BAtv2fnObKN2Hz+elXPdNgIqBsO2bX85N6bMoYA8=
Date: Mon, 23 Sep 2024 09:51:49 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
Message-ID: <20240923-spirited-lime-lyrebird-fe90d5@lemur>
References: <Zu78E+0Uk5fMSeQv@five231003>
 <xmqqsetr5wl1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsetr5wl1.fsf@gitster.g>

On Sun, Sep 22, 2024 at 12:15:22PM GMT, Junio C Hamano wrote:
> > I know there is also searching for "#leftoverbits" or "low hanging fruit"
> > on the list but the "good-first-issue" tagged issues on GitGitGadget are
> > probably more new-contributor-friendly than whole email threads.
> 
> Yes, even with these search terms, finding an issue to work on from
> the mailing list archive would not be suited for an absolute newbie
> for four reasons.

I can chime up and offer bugspray bot integration for the list. This is a new
tool I've been developing for integrating the mailing list with bugzilla. I've
been using it on the tools mailing list over the past year with reasonable
success.

It works something like this:

- a mailing list thread can be turned into a bugzilla entry by saying a
  trigger phrase like "bugspray track" or "bugspray tag <person>". This
  converts the entire existing thread into a bugzilla bug entry and makes the
  bot follow the conversation, adding any new mailing list messages to the
  bug. This is a two-way bridge, so someone can add things like large debug
  dumps or other files to the bug and have a notification about that go to the
  thread participants. Here's an example of a bug created from a thread using
  the "bugbot assign to me" trigger phrase:
  https://bugzilla.kernel.org/show_bug.cgi?id=219230

- the opposite also works: a bug created in bugzilla becomes a mailing list
  thread. Here's an example:
  https://bugzilla.kernel.org/show_bug.cgi?id=218821
  and here's a thread it created:
  https://lore.kernel.org/linux-mmc/20240922-b218821c6-a6dc79e2a03f@bugzilla.kernel.org/T/#t

- git commits are also able to close bugs via the Closes: trailer. E.g. here's
  one example:
  https://bugzilla.kernel.org/show_bug.cgi?id=217359

The bugspray bot integration is significantly different from Bugzilla's native
email support. The goal was specifically to not require bug participants from
creating a bugzilla account in order to be able to participate in the
discussion.

Bugs can, of course, be easily queried, assigned, and tagged with keywords
that can be filtered.

Bugspray is still in early development, but I plan to continue expanding its
set of features, because we hope to make bugzilla actually useful for kernel
bug reports.

-K
