Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D502485CC1
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970166; cv=none; b=dT3k4ErCgsx0Qalc96f9kJJf7hTmP86EPfeBW01T01tADzbILd+9qQ13uaUS6QKBqZ0Y5WtFjdxMtXEm24OJ3O03GSbDnwMtJo+J5+I3Omv5FZcX0noG16IcGgSd8jbbGZ3B8InENkTG+PgtuGxtzoDLqi24jaszWXMcmB9wWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970166; c=relaxed/simple;
	bh=opuwyRwqykQ2+UrJROjiZ4tMss4yq9jCiw8cyYy0ExE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAs4v0LQlbue8HiRu2Qd28pacfCe/PDVAJJXgRoem6BuYdDJRIlEWt8d8JbDzkZZqvDKhmeuz2iZw5v846rudj/g+hQrHpzSqJSshqKkB9RgYrkGY6owAZRFoYYOQ84r2tu/0qXonFBdGvpgLXKLe/aCt7ZV4EtbieW7ylArE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ReZdBLwZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ReZdBLwZ"
Received: (qmail 68992 invoked by uid 106); 14 Oct 2026 09:29:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=opuwyRwqykQ2+UrJROjiZ4tMss4yq9jCiw8cyYy0ExE=; b=ReZdBLwZ+Zd7QLK87ggKchJrrPS+CvCsh+oTZDSYWumBLggCdkFm2kRuzNxkTVnOTNeozECnaZ4cDTzuDSYmGy5Zjbe2p7v4qmXQqfQ4ajXtQsXOef4/yk4qTzTJoVVUgAxxKyQZDG/9xD0ErnyMR6bCnuKopGPBfRUX6weXTuN51CH4OHRXRKaqF5gBSzhF/Re1+nB7Gg/QnKOG8uEMQWo+C9BSJrrLUEoCcFKOlX73QcgiGEJ5G2JW4xSZibNQteBrlPv3ghwcqCtPdqE3CzUD+vNQtWhDCEMMGLRAP+cyzIf7XzzeEq/vPeYZkYPqnucg23psvYO6Ng7flQFyMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:29:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35842 invoked by uid 111); 14 Oct 2026 09:29:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:29:28 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:29:23 -0400
From: Jeff King <peff@peff.net>
To: Antoni Borowski <antekborowski11@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [Microproject] describe: pluralize tag/commit count messages
Message-ID: <20261014092923.GA1344504@coredump.intra.peff.net>
References: <20261013204351.428800-1-antekborowski11@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013204351.428800-1-antekborowski11@gmail.com>

On Tue, Oct 13, 2026 at 10:43:51PM +0200, Antoni Borowski wrote:

> These two verbose messages hardcoded the English plural form
> ("tags"/"commits") inside _(), which is wrong both grammatically
> (e.g. "found 1 tags") and for i18n, since other languages have
> different plural rules than English.
> 
> Switch both to Q_() so gettext picks the correct singular/plural
> form based on the count.

OK. The patch looks obviously correct, though I do find it a little
funny that we bother to translate these debug messages in the first
place.

I wonder if there is even really value in keeping "--debug" here at all.
But that is a somewhat bigger change.

The patch here seems OK to me in the meantime (and totally fine for a
microproject).

-Peff
