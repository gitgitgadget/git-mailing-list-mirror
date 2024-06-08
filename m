Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075621A0D
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717888340; cv=none; b=h/zhDtyMK0Jsys1mpo5KdQlYjR79ZLm6y1yNxJzA70601DjsKsQ0Gtp4oUtI2jkF5zJAZdtm/dV00i+R6dARmFD/u92GSEGB7L8GQTzdRIR2DNfQ9yzpffuKOzXtx9rdIX/22NM4U98/CVLgW4BWABbxDCg67NOHKEYTJtGalqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717888340; c=relaxed/simple;
	bh=tiPWUyDxWkpRLHQ9xwEg92BslDHPHiWumI2Ztz2rasE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=byT5o5pWd5vjPx1bidRFqdS7puTE1TUq5neTNI1uzbA70St35S5/LXxC++l5wG4y43Dg5DBS6AG9tRFPniz+JpWt+cbMXkc+fb/qWzTnY1m/GZpFeAdgQHRQqiAv9stoADIKgtyIKCoLTudBcjh6YiG/aZS103qsr9RgK+r45gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HPdAEdgf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPdAEdgf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6B7B3A3C1;
	Sat,  8 Jun 2024 19:12:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tiPWUyDxWkpRLHQ9xwEg92BslDHPHiWumI2Ztz
	2rasE=; b=HPdAEdgfUCvshgHptx5EkPzaWxjkWCLwMrvzharTfii/mDE3gan08t
	bV5R18Pv7AkboM0lMbMR+Lw7djVmoj2Ysi7QoTKVkXzE/wu19kddKK1xdIOFiwHw
	GGPMpmWvU7UvXTqPnvsNqYx7BIekAzrq8dS+XUulLTMUi/E0v05xk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DB393A3C0;
	Sat,  8 Jun 2024 19:12:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DE053A3BF;
	Sat,  8 Jun 2024 19:12:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] ci: detect more warnings via `-Og`
In-Reply-To: <20240608092855.GE2390433@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Jun 2024 05:28:55 -0400")
References: <20240606080552.GA658959@coredump.intra.peff.net>
	<cover.1717742752.git.ps@pks.im> <xmqqwmn0eazm.fsf@gitster.g>
	<20240608092855.GE2390433@coredump.intra.peff.net>
Date: Sat, 08 Jun 2024 16:12:15 -0700
Message-ID: <xmqqsexnav1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8C747766-25EC-11EF-935F-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Jun 07, 2024 at 01:47:25PM -0700, Junio C Hamano wrote:
>
>> I am not sure how annoying people will find the V=1 output.  It is
>> irrelevant that it is in a collapsible section.  What matters is if
>> it helps those who *need* to expand that collapsible section to take
>> a look, or if it clutteres what they have to wade through.
>> 
>> When studying a build failure, I rarely found the exact command line
>> given by V=1 helpful, but YMMV---while I am not 100% convinced, let's
>> take the series as-is, because not losing information may sometimes
>> help even when we need to visually filter out extra clutter.
>
> I had the same thought. I have used V=1 for debugging, but usually
> debugging Makefile changes locally (i.e., why is my option not being
> passed correctly). I don't think I've ever wanted it for a CI run.
>
> And I do think people see the output. It may be in a collapsible section
> on the site, but:
>
>   - you'd uncollapse that section if there is a build failure, and now
>     your error messages are that much harder to find
>
>   - if you look at the output outside of the site, you'll see the
>     uncollapsed sections. And I usually view them in a local pager using
>     curl[1].
>
> I guess I won't know until I see it in action, but I have a pretty
> strong suspicion that it will be annoying.

https://github.com/git/git/actions/runs/9424299208/job/25964282150#step:6:573

I _knew_ that this run will fail compiling the updated timestamp
parsing logic in date.c but it still took me a while to find the
exact error.

I typed "date.o" in the search box, which showed 5 hits (first two
are false hits to fuzz-date.o and test-date.o), with

    3rd hit on l.566 "gcc -o date.o ... long long command line"
    4th hit on l.594 "Makefile:2758: recipe for target 'date.o' failed"
    5th hit on l.595 "make: *** [date.o] Error 1"

Nitice that the error message with "date.c" is on 571 but with each
line being very bloated to around 10 physical lines on screen, it is
very far from either 3rd or 4th hit.

So, this time it was annoying.  But I suspect I'd be praising the
wisdom of using V=1 if I were hunting for some breakage caused by
tweaks in command line generation that broke the build or something,
so I dunno.

    
