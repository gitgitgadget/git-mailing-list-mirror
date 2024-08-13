Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAA2E630
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569503; cv=none; b=QodlAGAbShZqadpYmWpvyYTrlQBQ3N8o/48aOKpNoxWZB1VUdMlTC3Squ/ie6asjmJUy+8F1U8DhJQ6hqqeL7Jqt0HE+00Ox4yfbW6HDeKcAZaVJvWkoXSvTXZv8JLAL8oD/H4j7mDfCWwdbCGuHthT5ndr3VUriOoNVJqWb2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569503; c=relaxed/simple;
	bh=TIX9cCR4zztZzePtiCSJmxtfG2f0z9T5BCBeb2kSVSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=khFPVctilrBtjSx7MnHxUdtkdsm78Wek4JQ9YjaloNx9JEH0IVgyWFubX9k0E5bOnegRhYIxMyXMZiDt3a8SzqEkRmUXqazPyLxgeAK0JLNTtrA8E+tGFUEkvUhwEuplSOERPa/U39+Rf/qFHj0J2t3xp0pAe1sbDC4EL9NMw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wo3QZjoN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wo3QZjoN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75CF1360E6;
	Tue, 13 Aug 2024 13:18:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TIX9cCR4zztZzePtiCSJmxtfG2f0z9T5BCBeb2
	kSVSI=; b=wo3QZjoNHG3xcZlSEYEolWmzYcdDqVDbEggx0OUUK6slZ69BAGUXro
	QjheNUw8k6UZfASfUFj5UY+8plj3jTPJ5OnR/S8FyleZo5J/N6EHJ/7zwiSAHfxs
	sZPTUu5GcU451ns/TBRCoKhe+Br0aM2a4EHHZnEF5OLvQe2HtAbJk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E3C7360E5;
	Tue, 13 Aug 2024 13:18:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BED24360E4;
	Tue, 13 Aug 2024 13:18:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Phil Sainty <phil@catalyst.net.nz>,  pclouds@gmail.com,
  git@vger.kernel.org,  hvoigt@hvoigt.net,  me@ikke.info,
  rafa.almas@gmail.com
Subject: Re: Adding nested repository with slash adds files instead of gitlink
In-Reply-To: <8436c2bf-45cf-8009-14cd-c5ca708ece08@gmx.de> (Johannes
	Schindelin's message of "Tue, 13 Aug 2024 14:48:47 +0200 (CEST)")
References: <s5wr0azfeh9.fsf@catalyst.net.nz> <xmqqed6zht04.fsf@gitster.g>
	<8436c2bf-45cf-8009-14cd-c5ca708ece08@gmx.de>
Date: Tue, 13 Aug 2024 10:18:15 -0700
Message-ID: <xmqqle105oko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 081FF884-5998-11EF-9FD3-BF444491E1BC-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> Abusing a long standing bug does not make it a feature. I'm not
>> >> opposed to having a new option to keep that behavior, but it should
>> >> not be the default. If you use it that way, you're on your own.
>> >
>> > Was such an option ever worked on?
>>
>> No.
>>
>> I do not recall hearing anybody who have been active in the
>> development community saying anything good about such an option.
>> For the past 6 or so years, nobody who actively works on git thought
>> it was an interesting and/or useful thing to work on.
>>
>> I cannot quite say that they thought that it is actively a bad idea
>> to offer such an option, though.
>
> I have encountered the wish quite frequently to be able to make changes in
> a subdirectory and have them reflected as a commit that is both part of
> that subdirectory's revision history as well as part of the containing
> project's.

Let me make sure I understand the above.  You create a commit to
contain the change in the submodule and at the same time create a
new commit to bind the updated submodule commit to superproject
tree.  If that is what you are talking about, of course, that would
be a nice thing to have.  Sort of "commit --recursive".  It is still
debatable what to do with the log messages, though (you want to
leave in the submodule an explanation that is understandable in the
scope of the submodule, while you want to record in the superproject
a bigger picture reasoning).

But I did not get the impression that it is what the original poster
wants.  My reading of the original thread (this is a resurrection of
an antient thread dating back to 2018) was that you have a submodule
at path S, you muck with a file in S/file, and you want to commit in
the context of the superproject, having the superproject track S/file
in its history (not just S gitlink).

And that is quite different from what you said.
