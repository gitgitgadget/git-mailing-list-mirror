Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF001BE246
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662757; cv=none; b=CUXGyDMxTiKZSJNLgedTdouDlwVezxxVEih1e/6wl30bJHGv36kJFxJcG9OUQBTLHl/N7rGtLtWN0Re3nndT0FVH26O7fjV2HBnwKcHVWQSsSW5FVt8AyBF3C5zwnTxSi1X/Vi/VwmMMHcGQEM/dyJPI82B2ZC5NMzL0uMgIpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662757; c=relaxed/simple;
	bh=xwdET2pYtfsKmGtisTq5ww4je2GlUWuKCwcbpXGKWnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ot+twfuoYCJNh8ogI8k8eCf4rpmnzhNeAMNsEhvWEjipbrk9XnMJIxOQxHfEgI/I9l2xKBHhbo65OkP3aBYUDoeGUHtAtjYmd4Hsv6wNwdrOXRGV5Rt/GSJf8/uHRjDRVExPxiDj7R6Oa9XeW9R94NdGiySbsNLFgjzHd3KnPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XqcbnTkZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XqcbnTkZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB00F34C71;
	Wed, 14 Aug 2024 15:12:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xwdET2pYtfsK
	mGtisTq5ww4je2GlUWuKCwcbpXGKWnE=; b=XqcbnTkZexFRe63CKXbbYP7wsr2U
	zK0/BrANz0AtqyzqosGmlSaZBTdnF9vL4jG75ihnuqbIZnzrTg9UZA9pj9WPSJsf
	B19bqi4PoPt5QgfHxmwTpreA4XYsgxiDYRFGKx0uNLdEi+FbWMivx0X9NH9c87cI
	2h7shG9dyEOTQtw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E378634C70;
	Wed, 14 Aug 2024 15:12:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C4C034C6F;
	Wed, 14 Aug 2024 15:12:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Jeff King <peff@peff.net>,  Jacob Keller <jacob.e.keller@intel.com>,
  Josh Steadmon <steadmon@google.com>,  Git mailing list
 <git@vger.kernel.org>,  Anthony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH] format-patch: add support for mailmap file
In-Reply-To: <CA+P7+xrHDX-=fqJTM7_4cQp5PJz6QKbM78JG5tYtZXJLbiVmDg@mail.gmail.com>
	(Jacob Keller's message of "Wed, 14 Aug 2024 10:43:39 -0700")
References: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
	<2mvexuxcaow45ifnqmrvpn2yz2ecxzazsbo5ui7xaiwwpzt7hr@mvl6ehbrhrp6>
	<c0724297-1748-474c-998e-803e6a062a12@intel.com>
	<20240814072637.GA2077794@coredump.intra.peff.net>
	<CA+P7+xrHDX-=fqJTM7_4cQp5PJz6QKbM78JG5tYtZXJLbiVmDg@mail.gmail.com>
Date: Wed, 14 Aug 2024 12:12:32 -0700
Message-ID: <xmqqjzgiyl3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 28C0CE22-5A71-11EF-86E0-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Aug 14, 2024, 12:26=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>> On Tue, Aug 13, 2024 at 05:20:41PM -0700, Jacob Keller wrote:
>> > The internal tree commits are already baked and can't be changed. We=
 can
>> > of course fix the generated patches from these commits manually. It
>> > seemed convenient to get mailmap to do this for us.
>>
>> I think that makes sense, especially if the caller is specifically
>> asking to enable address mapping. I do wonder if the new format.mailma=
p
>> might be surprising for some callers, though. For example, would a
>> rebase using the "apply" backend quietly rewrite commit authors using
>> the mailmap?
>>
>> -Peff
>
> Ya, I think the config probably doesn't make sense thinking about it.

This depends on what an average user's perception is.  People like I
would know intimately that "format-patch" is just a glorified "log"
with special features, so I wouldn't be surprised if somebody sends
in a bug report saying "git -c log.mailmap=3D1 format-patch" does not
honor the mailmap.  In other words, people may expect "git log -1 -p
--format=3Demail HEAD" and "git format-patch -1 --stdout HEAD" to be
pretty similar.

> In our case, it may be more useful to have the mailmap not at
> format-patch time but instead at email time...

And probably you want not the regular mailmap but the custom one
meant to be used only by send-email to ignore the recipient.  You'd
still want to see who wrote it back when they were employed with you
in "git log" output, and not having them in your regular mailmap
would be a way to do so.  You can instead choose to use your regular
mailmap to map them to their current address, which is what we seem
to do here in this project, but it would probably be less common in
$Corp settings.  If the mailmap you give to send-email maps these
dead mailboxes to some known pattern (e.g. a fixed string in the
e-mail part, like "A U Thor <invalid@invalid>"), teaching send-email
to recognise them would be trivial.

Thanks.



