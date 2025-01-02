Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51282899
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735838602; cv=none; b=n2LHhjRlspnsE+/ljV+zlQMb0sEzIjqYhn3H3UD3c4MJlCV9C179VM38odf9xEKwIDHyO6aWcvj2/KbcupbjkpKQK/yvQKTuPKMpLvyM0FA1PQ/KPA9Qhq3XmzmLdJGlKIqhJ4XAodYJEWBlypCyMy4UqUORTH+NDrMS+lkM6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735838602; c=relaxed/simple;
	bh=b9g3ZjoMwOUj8pdAPnwP5zIl1LTvRMmTtEVsN/vmau8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDHh0r34rSxbDNbwV2CPPC9B/DIUS/KJcqVmoyJevd9AFbJpHMMOG0N8WpEZNkZmk0Vsqp9M6vQWWegCpvAv3PH7M+VQguo80q8P3HjlxnHSyro0GFBOmATHbzU2cEwsFSyXWX7n7Vl5/7mU9fULgI6MU5S46M56w1tklKziUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YPD7K4KHjz1r3wv;
	Thu,  2 Jan 2025 18:23:09 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YPD7K3phTz1qqlW;
	Thu,  2 Jan 2025 18:23:09 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id lCIGz7DcDJnb; Thu,  2 Jan 2025 18:23:08 +0100 (CET)
X-Auth-Info: 7XZCtmlItVka0rCXUSzHnBYdGJwdBp/k8+DFFB5sc8YMBy2IztwKQLwjuuagB8b2
Received: from igel.home (aftr-82-135-83-36.dynamic.mnet-online.de [82.135.83.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu,  2 Jan 2025 18:23:08 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 816AC2C2293; Thu,  2 Jan 2025 18:23:08 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,  Andy Koppe
 <andy.koppe@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: meson-test syntax error
In-Reply-To: <xmqqed1luqqq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 Jan 2025 08:26:05 -0800")
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
	<Z3ah2YQSx4ZreBpK@google.com> <xmqq5xmxwabj.fsf@gitster.g>
	<Z3avRmaMr70FOs8A@google.com> <xmqqr05lusvp.fsf@gitster.g>
	<xmqqmsg9ussz.fsf@gitster.g> <xmqqed1luqqq.fsf@gitster.g>
X-Yow: I have a TINY BOWL in my HEAD
Date: Thu, 02 Jan 2025 18:23:08 +0100
Message-ID: <87a5c9uo3n.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jan 02 2025, Junio C Hamano wrote:

> And
>
> 	$ make SHELL=/bin/dash test
>
> does not seem to pass SHELL=/bin/dash down when it does this part of
> the Makefile
>
>         test: all
>                 $(MAKE) -C t/ all
>
> at the top level.  Oh well.

Command line options (which include macro definitions) are passed
implicitly to sub makes via the MAKEFLAGS env var.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
