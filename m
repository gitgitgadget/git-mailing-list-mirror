Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32A379C40
	for <git@vger.kernel.org>; Fri, 22 May 2026 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779426658; cv=none; b=LqNyF5Fn6aN6sszSQ18Fc08OEhEgDTIParyd9XsSb3ZSOAwzGqtlOqPZEnI77hOr7MaNS/ORaP06ef18rN4bJ61MyXCaKvGgM7pYgWoblr6eOQXeuAgbQgEo/T8m59rV5nHNNFnbNvqOQ/jWEgYjuxLWQYiBwU9gNt8zJeWqQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779426658; c=relaxed/simple;
	bh=J96gmn+XHTYOZXWeUQHUPbTUgKe7bHOAViSopd1nVHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAHbVLKnI9kT0FdUL1os9zY8mQlOnL7FauA8PAhNgyO3t3WBjXr017hEN2RIo+OiATm8hBh1tJPzo0qq3JqyXkAgRKZqn6Xrv9/ms5QRFBPBYyoUPd9o3gKZa56HLe2zfKRZd7a1zmN6mBGDo6coV4zNk/tajwYrTkr6dm0HRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UCvYF3Gz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UCvYF3Gz"
Received: (qmail 47056 invoked by uid 106); 22 May 2026 05:10:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=J96gmn+XHTYOZXWeUQHUPbTUgKe7bHOAViSopd1nVHY=; b=UCvYF3GzXYq7m7K3uEoXHgvXmZrC29zS7d3EKyyFz35A2PQQcxTEp6IrSVuGoOhXI8Q72UvYIOP2Yrmg7e0zX6wtxDDdMS3YI/n00cK09PWFpa+5OKqWV0phhgq5JENCSwFLCxwXOWCOak0I9OVsUsyMqVKWXbk9ranaRcLVDnUE9w7rRn4EWPwTZC6rq50D6Cd/ojadYGmeGVsy2MflFa4y+4Zus8Ki7dfl1cF0ZKZYYvV7rm2lJoa34zvwd/33+6YUdw8VQJd9OVHZxluzwFHdhBVS2cMKVwFzV/IDITBEepGMDpb82XtOCJsAywDjaN8HouxJGa/FHNN2Qs7PYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2026 05:10:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 98995 invoked by uid 111); 22 May 2026 05:10:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2026 01:10:53 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 May 2026 01:10:48 -0400
From: Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"newren@gmail.com" <newren@gmail.com>, "ps@pks.im" <ps@pks.im>,
	"oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
	"code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Message-ID: <20260522051048.GA862219@coredump.intra.peff.net>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
 <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
 <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
 <2f7eea03273ffaacc50a9ae186673da88fc3345f.camel@oracle.com>
 <cf52154c-1275-4a4b-957e-5aa17f22705c@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf52154c-1275-4a4b-957e-5aa17f22705c@kdbg.org>

On Thu, May 21, 2026 at 04:36:05PM +0200, Johannes Sixt wrote:

> Am 21.05.26 um 11:59 schrieb Siddh Raman Pant:
> > The timeout is for the failure path, where the external helper has
> > already stopped following that protocol or is blocked on something
> > outside git's control. Since git starts the helper and puts it on the
> > log/grep path, git also needs a bounded way to recover when that helper
> > does not make progress. Otherwise an optional note source can prevent
> > the main git command from completing.
> 
> That Git communicates with a process that looks like it stopped is the
> normal case, for example:
> 
> - Output is sent to the pager. The user can take their time to study the
> output. All the while, git waits patiently for the user to advance the
> pager.
> 
> - Git fetch transfers large amounts of data across the network. Most of
> the time it waits for data to arrive and does nothing. The peer process
> looks like it hangs. Git does not decide to kill the connection at any
> time. It is the user's decision to do so.
> 
> If the notes provider hangs, then it is not on Git to decide when it has
> waited long enough.

Yeah, I agree with your point of view. If I understand this patch series
correctly, it is about adding an external process to map commit ids to
note data. So I can think of some existing features that are quite close
to that in nature, none of which use timeouts:

  - textconv filters and external diffs which process data in the middle
    of a git-log invocation

  - long-lived clean/smudge filters map blobs to arbitrarily large text

  - cat-file's batch mode maps object ids to user-specified data about
    that object

As you note, it's up to the command to be well-behaved. Git should
notice and respond appropriately if the command closes the pipe, of
course. Sometimes a timeout can help with a poorly behaved command, but
IMHO it is not worth the cost of non-determinism that it brings.

Moreover, the bits touching run-command here make me nervous, especially
after the challenges we saw in the child-cleanup topic that was reverted
just after v2.54. There is often a shell interposed between Git and the
sub-command, and we don't always know how the shell will react to
signals. Using SIGKILL will eventually get us _something_ to wait() on,
but it might not even be the process we care about!

I don't really care much about this external-notes feature one way or
the other, but if we are going to do it, I don't see any reason why it
would not behave like all of the other similar parts of Git.

-Peff
