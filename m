Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C61BDA82
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826362; cv=none; b=hWILl7VNHh6zDhWrLbcrSRcY7HwysZ3OjysL+iyI09DgV8lz6LIdLmGLFezEkJ2vXFPnjHOr22gGdlZ0+CsdhG45GWXXU0SHAJgRWWkQi+dSfVk/OOuzyIQ6dCrr/7EP86prFDodk0v0GXfQ0Wr2C+Whu0ZI6kzR0Ab8LJ+7TS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826362; c=relaxed/simple;
	bh=6QsIEnmqbLDGYmyFXROts8JuUFk2Qs/Cvm77NKr9iEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aca1DZ1iziRtEq97g10/bQkREFhLZI9Db+6kZSFibl2k8SUc4uafiv6u8jKw7Buc83wAy775gXXy5DvU6U9agw9Pl7liakhNn22aaFgBBcmpFgEaYKUboKnsg1Hv+8ifUWpqD2WTQ7qSl2b6s5bZYAutgoqh+sCzcuiWlBq8Tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pnd15yR7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pnd15yR7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 46F762DF8A;
	Fri, 16 Aug 2024 12:39:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6QsIEnmqbLDGYmyFXROts8JuUFk2Qs/Cvm77NK
	r9iEU=; b=Pnd15yR7/vBYIm/VL7wV4OJTgR5NUMk9jT6kKUCAzCEWRnjxJW1Lj+
	xbKvpZ0qgNZBy2pt561H1lnHMRDiMVy4NjwGtWR1W6khCctyXvWr9Ue4D6jKq4ta
	6d7W6yaVII8GjqmRDo2Ow58xzoxTtYhzF4m8HjF+E8lxyBugTsYSw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DF172DF89;
	Fri, 16 Aug 2024 12:39:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A66A12DF88;
	Fri, 16 Aug 2024 12:39:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  karthik nayak <karthik.188@gmail.com>,
  git@vger.kernel.org
Subject: Re: [RFC] Implement ref content consistency check
In-Reply-To: <Zr8Wkudjn5n1Zm0y@tanuki> (Patrick Steinhardt's message of "Fri,
	16 Aug 2024 11:06:31 +0200")
References: <ZrtrT1CPI4YUf5db@ArchLinux>
	<CAOLa=ZQVkmyVWAxyjrEQoEJ+gKJoJjfFqsDvr_A15FHGX1w=rQ@mail.gmail.com>
	<Zr4EqESHSnQET1Xg@ArchLinux> <Zr8Wkudjn5n1Zm0y@tanuki>
Date: Fri, 16 Aug 2024 09:39:12 -0700
Message-ID: <xmqqzfpcl8wf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 122B8E44-5BEE-11EF-9D17-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > > 1. For the regular ref which has a trailing garbage, we should warn the
>> > > user. This is the most simplest situation, we could reply on
>> > > "parse_loose_ref_content" to do this.
>> > > 2. For the symref, we could also rely on "parse_loose_ref_content" to
>> > > get the "pointee", and check the location of the "pointee", check the
>> > > name of the "pointee" and the file type of the "pointee".
>> > > 3. FOr the symbolic ref, we could follow the idea of 2.
>> > 
>> > Just to understand clearly, when you're talking about 'symbolic ref' you
>> > are referring to symbolic links?
>> 
>> I am sorry about this. It's symbolic links here.
>
> Wait, is it really symbolic link? I don't think so, you actually were
> talking about symbolic refs correctly.

In #2, yes.  I think #3 is about what to do with a random symbolic
link inside or near .git/refs/ hierarchy, which may or may not meant
as a symref.  I agree that we should assume that the user meant them
to be used as symrefs, check its validity the same way as a textual
symrefs, and complain if they look bogus.

> And checking the format of both normal and symbolic refs does make sense
> in my opinion.

Yup.
