Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC246447
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343765; cv=none; b=IU1Kj2uIfQozqwnAyOKOQmes067uB4b478vIeKjwJYc37JPRbmvIary0pCG3ti3OEUJ81nmrZJQXO/DIQfdEMeHIBT3/erRoMsWdKimkFaDstdMVE94LFcJ3GranEskU76heAqrfMVWFXTh+0iFWc6/HFJMcIgccQ0h5YknG+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343765; c=relaxed/simple;
	bh=7f7mP8KYl7hTn6bk1bQjBfFpEe/V5DX0NIxbaqr5sNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRgTi//7Ch0QbYSL6RnjY4YAH9RyIhbo9g1TryBV2ZMlaem0kfHUHZ6XtGKqBMEhLoDQ0BbQor7JcIt4JhiXD6FGcJO4NPkLk7z9yCW1KGMTpVpPg0TvDcO5h6ZoAayx52SBUzbA7TSloJWxJheb3KewRkOx0daPNJCrDMWXAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DZgKhoVJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DZgKhoVJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 676F11DBC2D;
	Wed, 13 Mar 2024 11:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7f7mP8KYl7hTn6bk1bQjBfFpEe/V5DX0NIxbaq
	r5sNU=; b=DZgKhoVJZTgwDu4HqxvftYS6UvX7VQxSdI6r1XvOaPDTcpqt2qUgP1
	TuCHKUpzedRHWvSWqKgkXdRl1SjO6R/3P5xjf3UpXmermXh+tzYOsAajLuEPyMPD
	V5JjNgWAk6rPAPI48329mkggJsyDvOAQSeB4SO4JRn0N4k5pBxmxQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F4111DBC2C;
	Wed, 13 Mar 2024 11:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6F791DBC2B;
	Wed, 13 Mar 2024 11:29:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>,  git@vger.kernel.org,  David
 Heidelberg <david@ixit.cz>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <f8565251-2af1-470b-9b2d-798e3504b0d1@gmail.com> (Phillip Wood's
	message of "Wed, 13 Mar 2024 15:04:14 +0000")
References: <20240312231559.GA116605@quokka>
	<f8565251-2af1-470b-9b2d-798e3504b0d1@gmail.com>
Date: Wed, 13 Mar 2024 08:29:20 -0700
Message-ID: <xmqqbk7if8vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 772EB93A-E14E-11EE-ACCE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> With a custom prefix those scripts will break, having an option that
>> forces the a/ and b/ prefix helps. Plus the man page explicitly says:
>>    Use the default source and destination prefixes ("a/" and "b/").
>> So let's stick with that behaviour then.
>
> As I understand it the purpose of --default-prefix is to override all
> the prefix related config settings so this seems like a very sensible
> choice.

It would be nice to update the description of '--default-prefix' so
that nobody has to say "As I understand it" anymore ;-)

As we are selling .{src,dst}Prefix as a thing that sets the default
prefix, we'd need to break the loop somehow, and "hardcoded" below
is my attempt to do so, but I am not sure if I succeeded.

 Documentation/diff-options.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
index aaaff0d46f..62eaa46d84 100644
--- c/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -864,9 +864,10 @@ endif::git-format-patch[]
 	Do not show any source or destination prefix.
 
 --default-prefix::
-	Use the default source and destination prefixes ("a/" and "b/").
-	This is usually the default already, but may be used to override
-	config such as `diff.noprefix`.
+	Use the hardcoded default source and destination prefixes
+	("a/" and "b/").  This is designed to be used to override
+	configuration variables such as `diff.noprefix` and
+	`diff.srcPrefix`.
 
 --line-prefix=<prefix>::
 	Prepend an additional prefix to every line of output.
