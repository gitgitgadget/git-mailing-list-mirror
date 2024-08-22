Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0E1CB31B
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339248; cv=none; b=s6MlFQX55Syk9CO8WemvMpUhP+gfB4/NCpSHvI2ge5CrsjRSIa8N2ASNsLcsAHtQeFzHmYMjyWjFK1Wip0lfAkvzdnYgBa8SoGMV8JexAj5nsW0HSPjiIVkVaDN7cYc2BRuUHs1DRH54QN4jRMq1ZaTG/sI147myWY1HJIZdThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339248; c=relaxed/simple;
	bh=656dMq95XkqjD22JJbHPyK30fWdCfGfLXSvBXX5yPjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rcmNGa2J8/UvdtfDcETvfK9GpIzFse1WM6KK8RXkQihpon8eBCvB0Najsm8ZURA38tObAiIN85v8jmTbKRZ7q11NJlRDoM7hipn3PbtE/s7kMLaG3vouK5UZfInHpJczHs7Uc29BzKNRJT1ohWUO61vy0IPlDIRc0R2jFxDX+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o0IdPQoH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o0IdPQoH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 50BC6190E7;
	Thu, 22 Aug 2024 11:07:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=656dMq95XkqjD22JJbHPyK30fWdCfGfLXSvBXX
	5yPjE=; b=o0IdPQoHmTdus7UBRP4SPjflL/9N5YQR479Cnc31x3Qp5aqwsWooGi
	3X94to6wB0UF9uUbbQ5W6xn4PGCaCAYwdeLDFCMXHW8AinG079d2jHGdo9RUwWdj
	K+kZeNu9GY8nZ5muyXb72AKc1FrthaTNU2Hg8khRG40dsxVq8EmnE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 48F1C190E6;
	Thu, 22 Aug 2024 11:07:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A157F190E5;
	Thu, 22 Aug 2024 11:07:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ahmed Akef <aemed.akef.1@gmail.com>
Cc: ahmed akef via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] docs: explain the order of output in the batched
 mode of git-cat-file(1)
In-Reply-To: <CAH64z8Ji59amg5Y=cBJzFKt_XiB0A5re35g9jHPWS6AoyGpRWw@mail.gmail.com>
	(Ahmed Akef's message of "Thu, 22 Aug 2024 09:31:57 +0200")
References: <pull.1768.git.git.1724232485264.gitgitgadget@gmail.com>
	<pull.1768.v2.git.git.1724234729288.gitgitgadget@gmail.com>
	<xmqqa5h5ztd9.fsf@gitster.g>
	<CAH64z8+dScuQbvu1aHnodE7VpCvgU2djbJhQDff76iyeFtpdTw@mail.gmail.com>
	<CAH64z8KUWSNii_U5k5fAz3q9cu34+pOWk2Rmw-60x7iOKOD8gQ@mail.gmail.com>
	<CAH64z8Ji59amg5Y=cBJzFKt_XiB0A5re35g9jHPWS6AoyGpRWw@mail.gmail.com>
Date: Thu, 22 Aug 2024 08:07:14 -0700
Message-ID: <xmqqv7zsvbod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 37A70BFE-6098-11EF-B22D-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Ahmed Akef <aemed.akef.1@gmail.com> writes:

Administrivia: please do not break the discussion thread by dropping
In-Reply-To: and / or References: headers.  For those who are
following from sidelines, this is a reponse to

    https://lore.kernel.org/git/xmqqa5h5ztd9.fsf@gitster.g/

>> * "as they have been read from stdin"; drop "from stdin" here, as
>>   we already know we are talking about the mode that reads object
>>   names from the standard input and there is no need to repeat it.
>
> it is needed to explain that git will not do any optimization to the
> order of paths
> before printing the output.

I do not think "from stdin" is necessary for that.  The sentence
begins ...

>  If `--batch` or `--batch-check` is given, `cat-file` will read objects
> +from stdin, one per line, and print information about them in the same
> +order as they have been read from stdin. By default, the whole line is
> +considered as an object, as if it were fed to linkgit:git-rev-parse[1].

... by explaining that the command reads from the standard input, and
does something to each in the same order as they were read.  If you
already said you are reading from the standard input, the order you
read them is the order youread them from the standard input.

Drop the "from stdin" from "as they have been read from stdin".
