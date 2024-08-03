Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF014D6F9
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722702589; cv=none; b=LBrIOWeg78FsUqgkYVHV7iyMCBKabyZUR5mFRGTqcUl3GznzoUR8VbXlEPyfHtF/eyFSZCyMgJqbutCdCR7SZuAfZ/pxXzeF73CQStPCxIQoMUYQMG0lcUlNnTcCRUiSCFGVsL8zVZgKNnSwwP8YrCyAjBG5+v2vMuWDa9/Db+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722702589; c=relaxed/simple;
	bh=sUXTDO6J4QKTzhrSC5PwHTsDEOKmZp4rE16lmntuWBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUmgKF28k0Sq38sZGqJrvz3SkgEDGDBsyjf1O+iZ6pO8apWmNwgSa0kNuZE1YOkJLwBTekkHPKnCcke1ZUoXwu5V9jgMpGIpXXVmDdjpPCilLbcuLySS6UH8etYqFzsdIFdDgXz5l6qxqe4hObWg9tUIO6LEFatYyPCvOvpSsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AK02f+Qw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AK02f+Qw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 848E1245F0;
	Sat,  3 Aug 2024 12:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sUXTDO6J4QKTzhrSC5PwHTsDEOKmZp4rE16lmn
	tuWBY=; b=AK02f+QwALQuruJn5dMKlXNslypvJT0FiPHdrJghWToZCm9bOiJmzJ
	dnmeU4JDydIepcM6/0P6NfMCUTtMb7gURqhBB1r06ajSR8SBM+RlHfv8uiPtWDce
	xXqMfdJ4i9olyOBPt5na0a6+bF9el/1Nm+Njg7rlx3zyoVBLEx2Zc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E23A245EF;
	Sat,  3 Aug 2024 12:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5782A245EE;
	Sat,  3 Aug 2024 12:29:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH][Newcomer] t7004-tag: modernize the test script
In-Reply-To: <dcded6a3-e284-4d52-b36f-dacc056bbc5b@gmail.com> (AbdAlRahman
	Gad's message of "Sat, 3 Aug 2024 17:34:46 +0300")
References: <20240802064719.513498-1-abdobngad@gmail.com>
	<xmqqttg2ewqm.fsf@gitster.g>
	<dcded6a3-e284-4d52-b36f-dacc056bbc5b@gmail.com>
Date: Sat, 03 Aug 2024 09:29:40 -0700
Message-ID: <xmqqmslt7eob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96439B60-51B5-11EF-BCBA-E92ED1CD468F-77302942!pb-smtp21.pobox.com

AbdAlRahman Gad <abdobngad@gmail.com> writes:

>> It is a good start.  There are other modernization opportunities in
>> this file, though.
>>   - Output from "test-tool ref-store" piped to "sed" means the exit
>>     status from an abnormal exit of "test-tool" is hidden.  They
>>     should be split into two commands.
>>   - Expected output file prepared outside test_expect_success that
>>     uses it.
>>   - Here-doc that does not interpolate leaving the EOF marker
>>     unquoted.
>
> Thanks for the review. I've just sent a follow-up v2 patch fixing the
> things you mentioned. I also found other issues like:
>
> some test_expect_success are seperated from its name like:
>
>    test_expect_success \
>    	'trying to delete tags without params should succeed and do nothing' '
>
> but I preferred to send the patch first as it was getting very long
> and I also wanted to make sure that I am on the right path and not
> just fixing unrelated things.

To deal with "is this getting too long?" you can split this into a
series of multiple patches, e.g.

    [PATCH 0/n] t7004: modernize the style
      cover letter that gives an overview of the series

    [PATCH 1/n] t7004: description on the same line as test_expect_success
      the one you pointed out above

    [PATCH 2/n] t7004: redirection operator
      the patch you sent earlier

    [PATCH 3/n] t7004: do not lose exit status to pipe
      split "test-tool ... | sed" pipeline into two commands
      to avoid losing exit status from test-tool

    [PATCH 4/n] t7004: one command per line
      fix lines like these:
	git tag -l >actual && test_cmp expect actual &&
      to
	git tag -l >actual &&
	test_cmp expect actual &&

    [PATCH 5/n] t7004: here-doc modernization
      use <<-EOF or <<-\EOF to indent here-doc
      use \EOF not EOF when not interpolating

    [PATCH 6/n] t7004: do not do things outside test_expect_success
      do not prepare expect and other things outside test_expect_success

would make a thorough series, while keeping each step still
reasonably short, I suspect.
