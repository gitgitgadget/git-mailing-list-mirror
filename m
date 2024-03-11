Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE147F58
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173841; cv=none; b=AdjydM4aahrmuS4dm0O0KL0JeMSmE3CzjoezexNq77msA9nCe6fXUQdhBL8ZX6QUkNsx3OMLr/tZGstREoA9F/x3twS6Nnj70ZUefOKDEoqG30CvH33ZOKWv+IziOHDi0p8b3RnjdiOF4w8TpH1qU9GN1kebyXnC+HCX7C5TUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173841; c=relaxed/simple;
	bh=CEQhewU20shcuVPBiQV9ws1n+p1t6OhdKb3X/maSwWQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=U463Es1FE5HP+Sx83MJmO6cyje2dRPUp4Tl3t3NonMrWJyAGpq4uUWn5m9c8Ttv1XOBxy0dP6OXSYRQMAz9GbFKgIAAp7hJzAiA6Bn5YXYEuevPADGqgR5037+NEqAoMwHGOj0akOnNw8tjtPkTHm+BfKiGGS1vW3L3Y9/Abipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kRrsMmzQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kRrsMmzQ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710173834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GozNhggyliMazGCd59VDRpoi1TkzRzQuc9wt2PoH73s=;
	b=kRrsMmzQqX9EDkf7cxVBKw2xnbY3cp+hOmphu5DwGEqi2C/xOI5hvuUw6FsR7oskXxQ+2H
	X3f9PvPRHaQANdSH9hM1T5ysVXZVMhCGlvHpNU+eDqhmDd1TDeDycFhgdsAoMkHG6k4b4O
	9zjLSGncwfPNP8snuA/MrhbI+oKU8wmRDr2S+vhrjEf9mweM63TnfOJjRIXvRVtrV4C1EC
	zr/tkD8nJ4xrwV9dil5ODJGN/Ba2SbttmmzJOETpbzabjC1Q2VZ3OPizmcFpAz/YuZcuBN
	zkli1br6Vkd7eQlYG1x+Yw3gg2P5GlwSGdIiEiSEt08gIxcrHIM5y1fFvxBZbg==
Date: Mon, 11 Mar 2024 17:17:13 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, rsbecker@nexbridge.com, Ralph Seichter
 <github@seichter.de>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <xmqqy1apudvv.fsf@gitster.g>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g>
Message-ID: <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 13:55, Junio C Hamano wrote:
> "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Ralph Seichter <github@seichter.de>
>> 
>> Introduce the ability to append comments to modifications
>> made using git-config. Example usage:
>> 
>>   git config --comment "changed via script" \
>>     --add safe.directory /home/alice/repo.git
>> 
>> based on the proposed patch, the output produced is:
>> 
>>   [safe]
>>     directory = /home/alice/repo.git #changed via script
> 
> For readability, you probably would want to have a SP before the
> given string, i.e.,
> 
> 	variable = "value" # message comes here

Let me interject...  Perhaps also a tab character before the "# 
comment",
instead of a space character.  That would result in even better 
readability.
