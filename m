Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391BF157A6B
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104420; cv=none; b=Sq3gxDKHQE7IBaTCO1ffF24+jRA9InWksRkJY/cTYrYJpJH1FecKlyAxTc1hinzugpcUg4uLoSfks3dNt03hXrFDVxx8Z6tWfQoDX0Y8gjR56utEMe3HQlMq0rkj4U59ZmPzrypXt0wGUf5RhECpFUuGKDoZjiKrhxyOIc2simU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104420; c=relaxed/simple;
	bh=WWBLU04IAkTYpynexurUGGZRfNgDqSBgR3oqJ9iocHU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZK/wTfzlUyr8e4e0votKhaVS6Ssg5gSafkI39LXV5Y73FroPM9Hjw+13V+ct7eTIWS6ycxxt+sz59jB0d9k9WqNE8rGN9pXAL46K59o+YGqZCu0AxTQFw+E2UK3RWYc+MfETKLEbYktQcr3MUOwnth6Jk0lAeVKGEFyE6ImWtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b=23tHFfRT; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b="23tHFfRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=haxx.se; s=silly;
	t=1749103989; bh=WWBLU04IAkTYpynexurUGGZRfNgDqSBgR3oqJ9iocHU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=23tHFfRTGFuyAp6bt5k5yp9v+6mH14a2aRgWgiQ6lJIx5bUG5gHlUJAbotuhmkoD7
	 i6l0WpcdIxh9ee8KV0TGi/xK6v5hO/jIF85PO+/Zc4JxTUadyIe+Zoh81E07w9TaXo
	 8J62Rx5YEpLS90TJ5KT5NS4qnLZHC1V8qGNqhh8a4XZf+Qitm6u8YWTj6vBrMj/HTI
	 5uQFH6ZrQVvhnXaXlt8FBilZ7Pn5hnmNkV4W1xMPpdE5x9jOgAH/Yj2/4IEJ+9SVsL
	 8STRdc4BvpZPRWl3brf1nHrtc03KASmBMwFiUxIfIRxc/7PTNQtWmwtmzxYnmPUt+g
	 EwVbqfNK4ZzTA==
Received: by silly.haxx.se (Postfix, from userid 1001)
	id 35CFD74DCA; Thu,  5 Jun 2025 08:13:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id 352117DA1F;
	Thu,  5 Jun 2025 08:13:09 +0200 (CEST)
Date: Thu, 5 Jun 2025 08:13:09 +0200 (CEST)
From: Daniel Stenberg <daniel@haxx.se>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] curl: fix symbolic constant typechecks with
 curl_easy_setopt()
In-Reply-To: <20250604205622.GC1510819@coredump.intra.peff.net>
Message-ID: <r1197994-o3so-6453-q16n-6n3on33n4nrp@unkk.fr>
References: <20250604205505.GA1510724@coredump.intra.peff.net> <20250604205622.GC1510819@coredump.intra.peff.net>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 4 Jun 2025, Jeff King wrote:

> It seems kind of weird to me that curl doesn't define these constants as
> longs, since the point of them is to pass to curl_easy_setopt().

Agreed. Mostly just because of my lack of imagination when I added them a long 
time ago.

We have over recent times updated several public option related defines to 
better help applications to get int vs long right, but I have clearly missed 
to do that for this particular set.

I intend to fix this omission, but since you want to support building with 
lots of old curl versions as well, this correction probably won't help you for 
another decade or so... :-)

-- 

  / daniel.haxx.se
