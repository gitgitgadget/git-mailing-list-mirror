Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E45FB87
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934046; cv=none; b=q2oFGFVaAhcUNPRqgrKCumsDkIUqiWL2xYsudAv30/O8zgLppwfAgGDps0h/F2YfcFDqhRi+tmpLNEm4zazua/SvSVhorQbB6zYDlC5TvgTie9ciNYrBpMR73GotMMYs4DT6+M45BYhPssNV/KHNwVhA3hNcT+DXW6kpGdApYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934046; c=relaxed/simple;
	bh=3SXbWb5nSoeFeXW5Wzbn9tsG8sDBxitTPfeMyaDgALY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDX5fJ/lam0bwWP2B+Wvj74HYi8dttmuRfX3QB9FmBXkJpRow4vjBarl/t7mSvbNGrKHeygoWIs7I0FnREmfKlWe4PIPlgVRg2Hc7oatu7dacbL+lHCWprnPDtXLmR4bymRKDKw7YMAxDPc2vzb7Pv4/QEH1tHO9Tjpym30Hn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LE9S3gXc; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LE9S3gXc"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A00B32815;
	Fri,  8 Mar 2024 16:40:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3SXbWb5nSoeFeXW5Wzbn9tsG8sDBxitTPfeMya
	DgALY=; b=LE9S3gXcawXasWJq58dCoyy9OiKvWD9NwrU28J6OaRctXWOj1dgkq9
	g84GDShbSzRYPPcAyT5jRt2HdrewyEb9FOHsD2o67abrB5iqKs50jOvge+9fBCMr
	THKIm9iOWYezbEuoWM8o07BUZgg345mxzyDiYmlxmbnievjHLR1u4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 920F032814;
	Fri,  8 Mar 2024 16:40:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CC9D32813;
	Fri,  8 Mar 2024 16:40:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] checkout: cleanup --conflict=<style> parsing
In-Reply-To: <1fb1c84a-b6b3-4e3e-896f-5fb93cff57a6@gmail.com> (phillip's
	message of "Fri, 8 Mar 2024 16:22:28 +0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
	<xmqq1q8khf8t.fsf@gitster.g>
	<1fb1c84a-b6b3-4e3e-896f-5fb93cff57a6@gmail.com>
Date: Fri, 08 Mar 2024 13:40:37 -0800
Message-ID: <xmqqsf10flm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 819E9290-DD94-11EE-A0EB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

> Hi Junio
>
> On 08/03/2024 16:15, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> We could use OPT_CALLBACK() to accept the incoming string, parse it
>> and store it in opts->conflict_style and that would be a way to
>> avoid the extra member.
>> 
>>> +		opts->conflict_style =
>>> +			parse_conflict_style(opts->conflict_style_name);
>> When I saw the change to xdiff-interface in an earlier step, I
>> thought parse_conflict_style() was a potentially confusing name.
>> You can imagine a function that is fed a file with conflict markers
>> and say "ah, this uses diff3 style with common ancestor version" vs
>> "this uses merge style with only two sides" to have such a name.
>> parse_conflict_style_name() that takes a name and returns
>> conflict_style enumeration constant would not risk such a confusion,
>> I guess.
>
> Those are both good suggestions - I'll re-roll next week

Thanks.
