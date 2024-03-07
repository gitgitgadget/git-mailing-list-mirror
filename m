Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948512FB3E
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835434; cv=none; b=c6ZdeBl7zz22keIjjNT/5wbIMSJ9gMSa8iIAY4z7LxK8qQmUCYlL4LogZEuqu5qSRKJGC6sq+ByOqDf82d1oukK6MYdQZ7Dv7GzJ+p+AZ6+hZp90DYAegp45d7P9c7j0wmqPd9RqOcbMWlrmJvlZ3iD8DJYXmvfmDnkBeoMK+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835434; c=relaxed/simple;
	bh=O/yO1SsdUrR5/TjKEwgop7Ac9BZd6IDvwpCY8Dlx4eU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oVTo8dppmksLkt8iUCr1u9O8pImKnVAHinqpTtYr31FtW+A2vXXlF3MJ884vPkAhtGotjuhjOIgPBbZvePSk87jd0GUkJfZnZO2DVEdJUHGFkueLfzgw80jUQY+Y/A2Wu4f38JQ91xdBYnbWoQO3HdOSaI3+Nvlo8sn9CBYhKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sm9PTN4A; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sm9PTN4A"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B94E1EE584;
	Thu,  7 Mar 2024 13:17:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O/yO1SsdUrR5/TjKEwgop7Ac9BZd6IDvwpCY8D
	lx4eU=; b=Sm9PTN4AzQnqcokDNAo4Z68fMSH7v3bf4hfd1SxL50p13C85UyiHfC
	t1stfsOjXUApWoZPk+uM+nMP3wEnrv8vtCV+d/eEv0RG3S+OzjdkIH0xe9RlNqPJ
	BuDG45CZ6LAdOda/IV6I0KyXZKFFgb4qns6NtejpMZglF7WkpdKgg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B8FD1EE583;
	Thu,  7 Mar 2024 13:17:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE4561EE581;
	Thu,  7 Mar 2024 13:17:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aryan Gupta <garyan447@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Aryan Gupta via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt [ ]" <ps@pks.im>,  =?utf-8?Q?Michal_Such=C3=A1nek_=5B_=5D?=
 <msuchanek@suse.de>,
  =?utf-8?Q?Jean-No=C3=ABl_AVILA_=5B_=5D?= <jn.avila@free.fr>,  Eric
 Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] tests: modernize the test script t0010-racy-git.sh
In-Reply-To: <CAMbn=B73boxu1HDy2UHGz83wxnE7=udmbSv4nFsV+ngA0Bn0Sg@mail.gmail.com>
	(Aryan Gupta's message of "Thu, 7 Mar 2024 15:23:49 +0100")
References: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
	<pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com>
	<CAP8UFD31udQB2e=+G-LpCevuS+JxQdWqwaq=5qvGEn21595faQ@mail.gmail.com>
	<CAMbn=B73boxu1HDy2UHGz83wxnE7=udmbSv4nFsV+ngA0Bn0Sg@mail.gmail.com>
Date: Thu, 07 Mar 2024 10:17:03 -0800
Message-ID: <xmqqjzmdnbz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E6B8BCAA-DCAE-11EE-88C4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Aryan Gupta <garyan447@gmail.com> writes:

> I thought that there were some bugs in GGG due to which it sent some
> headers which were not syntactically correct. So I tried sending it again.
> And that was the whole purpose of this.

I was wondering about the same thing.  I still see an unwanted "[ ]"
around Kristoffer's e-mail address that will break responding to the
message in your [PATCH v4] e-mail that can be seen at

  https://lore.kernel.org/git/pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com/raw

so, the experiment revealed that it did send some headers were
broken.

Thanks for a clarification.
