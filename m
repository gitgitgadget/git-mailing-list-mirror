Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F514659F
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391403; cv=none; b=i38haPHunJuiANQTDegpZPE/gQr8jyiYQUCyAO4rJcQHLkehXcRIyNGjF2eA7MPFMf85AtuRc/9yLQbY7UVLrFo53AlnTWw05KWpwg3r/xUONCKTW9R8HLfQibulrmfyqemjE3gYjzP7Rae2UUexSHSJbwVY/GqV7oXXeQDLgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391403; c=relaxed/simple;
	bh=Nzv3WtvnwbX4Ld+TVt41naiiC2A9fG+VaxU7it1MOe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dr+7TXdl8fmw3UlvQxE+Q7LRXZmWSOBkvYv8pZ1soIxXVlhfWV/jzhWdwrkCnjSJwLV7jcDX7vakd3TGcRv5g+6VwEPdHHYJbP9t5v7NCXnooV9s7VD609NC7VSqrZOy4FbYwOkYJAJaTp71syQtG1vL4cG8+50bnAK06kiOom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GPqlVmB2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GPqlVmB2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 34B2A2048B;
	Fri, 14 Jun 2024 14:56:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Nzv3WtvnwbX4Ld+TVt41naiiC2A9fG+VaxU7it
	1MOe4=; b=GPqlVmB2XUfB7jU611G18ybIqyC+mw/awXxHpmgfeXaweuozMnFjfh
	JkzO+IciaZmToCYc+uj2WWHX/dulAlhBsi+8jlGawTbeBAkEUDluVz5yWQoHg4oi
	WH6w5TM0Wqe9jTEyDBLNLumCTi0Xn2u1jIw77IKn5ZKW9LB3OFS1E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CFBC2048A;
	Fri, 14 Jun 2024 14:56:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61E2B20489;
	Fri, 14 Jun 2024 14:56:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: jialuo she <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v2 7/7] fsck: add ref content check for files backend
In-Reply-To: <CAH-kW5f0u1uFH7Y83e4Vp8avM_7MPLkDG7v9NPV1nL=wZ--wmw@mail.gmail.com>
	(jialuo she's message of "Sat, 15 Jun 2024 01:05:43 +0800")
References: <20240530122753.1114818-1-shejialuo@gmail.com>
	<20240612085349.710785-1-shejialuo@gmail.com>
	<20240612085349.710785-8-shejialuo@gmail.com>
	<xmqqr0d0iqey.fsf@gitster.g> <ZmvTI73P2fQ6AkOp@ArchLinux>
	<xmqqo783im5k.fsf@gitster.g>
	<CAH-kW5f0u1uFH7Y83e4Vp8avM_7MPLkDG7v9NPV1nL=wZ--wmw@mail.gmail.com>
Date: Fri, 14 Jun 2024 11:56:36 -0700
Message-ID: <xmqq1q4zfj4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D461E012-2A7F-11EF-AD87-C38742FD603B-77302942!pb-smtp20.pobox.com

jialuo she <shejialuo@gmail.com> writes:

> Instead, we should warn about the user when using
>
>   $ git branch branch-3 master
>
> It will create a new pointee here, I suppose we should warn the user
> here except HEAD ref.

The user created branch-3 as a symlink, fully expecting that the
pointee will be updated.

By the way, a seemingly normal branch looking symref is very handy
and that is what my "maint" branch looks like.  Right now it is
pointing at maint-2.45 (because 2.45.0 was the last feature release)

        $ git symbolic-ref refs/heads/maint
        refs/heads/maint-2.45

and I would imagine many other users are using the trick to maintain
multiple maintenance tracks.  They would be upset if their next "Now
2.46.0 release is done, let's start the 2.46 maintenance track"
mantra, which would look like so:

	$ git symbolic-ref refs/heads/maint refs/heads/maint-2.46
	$ git branch maint v2.46.0

starts to give an unnecessary warning.
