Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540552F61
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178908; cv=none; b=Z1EsguPvHulZrNenzIMaSEXOuAqn2WxnnQxQM/YE86Tw69dSWhtBF26PSjIgA3PIcRQZga1un9mTMYprJ69SRvgQKCFZKUAHe8/RV1i797Q8r+w3Ez9ZN/dyp5+xaYXlI9gPOGr9iwSzuEuea/KVz0Q+JTgz4+3/JATptcml/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178908; c=relaxed/simple;
	bh=vtNbixLpI8yTecVquK5AsBNONGP10aXjrNUBPSBJ9IA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/0X+0/++6a/tQB2UtmgRjDdR7HYCotLcCBZh+LKCyXwX8CNiy27whuz/D4ClfzGF13ca05hWpgwSJp+0oksGyc0v7lNsdiUVhvSfDtMWoWaBs3fOuDP8LhpIKrBnu7Y3yvV7Qw9j04IMksfBBeczTrmhxQTG8wgBDntjAF3kB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fh3zNdOz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fh3zNdOz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E91626063;
	Mon, 11 Mar 2024 13:41:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vtNbixLpI8yTecVquK5AsBNONGP10aXjrNUBPS
	BJ9IA=; b=fh3zNdOzADViQQVafqnLZSmEFzVaevn0LW9NHQ4+MqFasjujf9RDy1
	ZPVy81D+uH5+VlSS/X+pbX1B61PJMfXusiXiJ5h66koDOQ/YPpPjpfCT3ckRtbkY
	VPWNLSpcsfgbZ33w7EVg3X3qnu2cjTJTJqu2BrcLC108MQT9TxMPg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 59D8126062;
	Mon, 11 Mar 2024 13:41:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4B2926061;
	Mon, 11 Mar 2024 13:41:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] checkout: cleanup --conflict=<style> parsing
In-Reply-To: <f0c88900-63d3-46ed-9cb8-fc7c3fc07c28@gmail.com> (phillip's
	message of "Mon, 11 Mar 2024 14:36:16 +0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
	<xmqq1q8khf8t.fsf@gitster.g>
	<f0c88900-63d3-46ed-9cb8-fc7c3fc07c28@gmail.com>
Date: Mon, 11 Mar 2024 10:41:41 -0700
Message-ID: <xmqqcys0sm22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FA1C924-DFCE-11EE-9CBE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

> On 08/03/2024 16:15, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> parse_conflict_style_name() that takes a name and returns
>> conflict_style enumeration constant would not risk such a confusion,
>> I guess.
>
> Can I just check if you mean that we should convert XDL_MERGE_DIFF3
> and friends to be an enum, or are you happy to leave them as
> pre-processor constants and have parse_conflict_style_name() return an
> int?

The latter.  I was only wondering what the good name for the new
function was and did not mean to imply that we want conversions from
C preprocessor macros to enums.

