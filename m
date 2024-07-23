Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC873D55D
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748515; cv=none; b=jQOEgbrUGjimKdtcawnKedLp0TIYJJNVqh18/47lpVlVJI55dU5FyrSbR12ag/H/hXznzIF05g2ua2+uomM1fiUdDvj/O9Wo5hIUXcxVS1feQCsMYNnBDJYEQ2SECEbnyBiYAE+l2KJv0mqS6VYimHfOURZu8G9X1g8top8ch3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748515; c=relaxed/simple;
	bh=ksShVy8riI/8xo7L2mYd6v9LYr4q9b4yufPnKQmvgTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELLZW5wVz0sETTz15Bhzjmf7PONpghfqFcQiwg+e0h33vZmta0QiOa6aSzPvHlut9IO4PhQhRUWzgPx0VOmgPLStohj7RFVxH/wJJL0bNjYdaaDSYJ2eEedIs385foYl3oS3cjQLMKJBdt+WgAPH1zLz6y8+rm5G7TfVG3AlWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dtpRzUOA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dtpRzUOA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E4AD1F855;
	Tue, 23 Jul 2024 11:28:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ksShVy8riI/8xo7L2mYd6v9LYr4q9b4yufPnKQ
	mvgTg=; b=dtpRzUOAfblyDYNJgh7vFqZtOGClmgorga4CbJLjsadACSl9+9T7Vp
	Szt8PXxXhhPyUycMqd3io4/Zcj6vH5PPPeLFZRR/jcAGtDBiJ2IiwAik4AnCOXLE
	g8aclXCTqhAWp7tUgGM+Zav3UehwCm0bkUh11UhhCT21NCslBMW8Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 960FC1F854;
	Tue, 23 Jul 2024 11:28:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB20C1F851;
	Tue, 23 Jul 2024 11:28:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] CodingGuidelines: document a shell that "fails"
 "VAR=VAL shell_func"
In-Reply-To: <20240723033418.GA1838963@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Jul 2024 23:34:18 -0400")
References: <xmqqjzhd81la.fsf@gitster.g>
	<20240723033418.GA1838963@coredump.intra.peff.net>
Date: Tue, 23 Jul 2024 08:28:27 -0700
Message-ID: <xmqqfrs03z6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36350C82-4908-11EF-A638-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Jul 22, 2024 at 04:10:41PM -0700, Junio C Hamano wrote:
>
>> Over the years, we accumulated the community wisdom to avoid the
>> common "one-short export" construct for shell functions, but seem to
>> have lost on which exact platform it is known to fail.  Now during
>> an investigation on a breakage for a recent topic, we found one
>> example of failing shell.  Let's document that.
>
> My recollection was that FreeBSD's /bin/sh was the culprit, but I
> couldn't find any mention digging in the archive. However, I just
> checked on a FreeBSD 13 VM, and it does have the same problem (that the
> one-shot variable is not exported). I don't think that changes anything
> for your patch, but just reinforces this part:
>
>> This does *not* mean that we can freely start using the construct
>> once Ubuntu 20.04 is retired.  But it does mean that we cannot use
>> the construct until Ubuntu 20.04 is fully retired from the machines
>> that matter.
>
> since now we have one other instance.
>
> I thought it also had the issue that the variable would remain set in
> the caller after the function returned, but it does not seem to do so
> now (if it ever did).

Yeah, that one is also what POSIX leaves to the implementation, if I
recall what I read there.

So here is how the part looks like in my tree right now.  

Thanks.

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 2151ec51b8..52afb2725f 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -212,11 +212,11 @@ For shell scripts specifically (not exhaustive):
    "command args" is running is handy, but this triggers an
    unspecified behaviour according to POSIX when used for a command
    that is not an external command (like shell functions).  Indeed,
-   some versions of dash (like 0.5.10.2-6 found on Ubuntu 20.04) and
-   AT&T ksh do make a temporary assignment without exporting the
-   variable, in such a case.  Do not use it for shell functions.  A
-   common workaround is to do an explicit export in a subshell, like
-   so:
+   dash 0.5.10.2-6 on Ubuntu 20.04, /bin/sh on FreeBSD 13, and AT&T
+   ksh all make a temporary assignment without exporting the variable,
+   in such a case.  As it does not work portably across shells, do not
+   use this syntax for shell functions.  A common workaround is to do
+   an explicit export in a subshell, like so:
 
 	(incorrect)
 	VAR=VAL func args
