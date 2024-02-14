Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAA322E
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870256; cv=none; b=NfvSsRisoeFwFczOxANLRo0bw41nQShTAAhODBZ4KyHO2Bw3lP7JsZKcZ61PkIUi9d1kiqhouq8XuZW50JUpdhOP1lYw2k7dwsWTyF5kRAlHdE+saBDDcN2heWHJLxw71Pz1kae8lbvjh5Wnl98expD/6IUa/kKXTUmdB+mT/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870256; c=relaxed/simple;
	bh=tOqXHVdlR85gUJlK1WQGh19KTIjz/4FAUcIswSsKW+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u5gcGKyqzg8SMBzChzJCdRRMbhBGyRUXj3gD9aB53FR83/8v3AEf99VRykSxBqylINfgSRHKbHcmvACEzI5yCaP4hTkgz+IDHiy/2zi7hacT1AvZffXgP2eJYmaLNp8TQmTrmD/ngtKejkpK4xOUmhAZ+WTmso1iW5MUZexGRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hx4iNZk1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hx4iNZk1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D1B8B1CB212;
	Tue, 13 Feb 2024 19:24:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tOqXHVdlR85gUJlK1WQGh19KTIjz/4FAUcIswS
	sKW+Q=; b=hx4iNZk1r4yvnp2vvfOBE7Dtn+CIj3YWng+Gz/KP1rz3uK1/0pS8dM
	ERKNSIHe1gP5MgEt/AV5/r8CIDpFvXz7SwAHqBDo8lrZvsnv9m5UXhM9Ylmxs3iU
	dGg6y/MBzzejvQkTNz5+etmFwmn1FUFJRbpp+aZdYqZOjNv8SgH5w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA1291CB211;
	Tue, 13 Feb 2024 19:24:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37DB21CB210;
	Tue, 13 Feb 2024 19:24:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Philippe Blain via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] completion: add and use
 __git_compute_first_level_config_vars_for_section
In-Reply-To: <996fab96-82b1-0b54-3a09-0ecc18d68a11@gmail.com> (Philippe
	Blain's message of "Sat, 10 Feb 2024 12:27:05 -0500")
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	<838aabf2858b73361be8e8579bc80826e1cfd4c3.1706534882.git.gitgitgadget@gmail.com>
	<ZcSF1mJ-JXQLmoZ5@tanuki>
	<e8642ad8-bdc9-00d6-39b5-81dd399e60ec@gmail.com>
	<xmqqwmrcb5q8.fsf@gitster.g>
	<996fab96-82b1-0b54-3a09-0ecc18d68a11@gmail.com>
Date: Tue, 13 Feb 2024 16:24:11 -0800
Message-ID: <xmqqa5o328r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 612D12FC-CACF-11EE-863B-25B3960A682E-77302942!pb-smtp2.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> A silly question (primarily because I do not much use the indirect
>> reference construct ${!name}).  Does the assignment with printf need
>> to spell out the long variable name with "_${section}"?  Can it be
>> 
>>     printf -v "$this_section" ...
>> 
>> instead, as we already have the short-hand for it?
>
> No, unfortunately neither "$this_section" nor "${!this_section}"
> work, so we must use the long name.

Hmph, this does not match my experiment, though.  What am I doing
wrong?

        bash$ vname=foo
        bash$ foo=bar
        bash$ set | grep foo
        foo=bar
        vname=foo
        bash$ printf -v "$vname" "%d" 1234
        bash$ set | grep foo
        foo=1234
        vname=foo
        bash$ echo $BASH_VERSION
        5.2.21(1)-release

