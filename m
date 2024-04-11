Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E109205E0D
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870760; cv=none; b=pZYcl/w/V+K3smhbFjunTwCp5oOOW5nRhluNueynjFOqs8a+Six4l9ivbYqXw1reNoXQALOwglJxSsaqGkl7vz/5sxiFBJD367u6d1geEApU3jNyvBKjXfi1gI3IF/LHLwQE+8t7mpqNs7HkbX9hhiHv4+8A1ablrQECl75Uxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870760; c=relaxed/simple;
	bh=8RCAfeRxBOMAiPh3I8Tkt4qjBy1inY2tL2KzHBDZC5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rObu9yIUNMHRKoMFX9CHDtGs/Aw2PWcICqMEeyTQzRNTZLGWtXrq3mibseSU6jyQkl2LHut16hJiJ2tmxUq6h9axuV5TJYZicU2KIsacxgWdABmU9tf15m/S80RG0ecVvl9tyujspDwWWcNTp75MwDD+bqIlfRWY063KflBNqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OzHVf+W4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OzHVf+W4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E0B283A4EC;
	Thu, 11 Apr 2024 17:25:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8RCAfeRxBOMAiPh3I8Tkt4qjBy1inY2tL2KzHB
	DZC5M=; b=OzHVf+W4RAHqhZ51y3v7y6w30mXiNuXGFluJ49Z7urnjjWTcNDlnxe
	7G9d+IcA4/nnPufe2qNJ96W9BX/CM02D/yZcDYRXOkWQDM2ZGpS326847i+e0Fi+
	K5yDw8dsIviDFOaGjJlkIQGsPUQxUnvSS5Zl7wvvFhc+8foIL7NQE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D8D2B3A4EB;
	Thu, 11 Apr 2024 17:25:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A2AD3A4EA;
	Thu, 11 Apr 2024 17:25:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [PATCH] mailsplit add option to include sanitized subject in
 filename
In-Reply-To: <5a25d75c-cc27-49d9-a49d-39f657fd17f4@intel.com> (Jacob Keller's
	message of "Thu, 11 Apr 2024 11:52:23 -0700")
References: <20240409000546.3628898-1-jacob.e.keller@intel.com>
	<xmqqpluz2tau.fsf@gitster.g>
	<CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
	<xmqqedbcqw84.fsf@gitster.g>
	<5a25d75c-cc27-49d9-a49d-39f657fd17f4@intel.com>
Date: Thu, 11 Apr 2024 14:25:52 -0700
Message-ID: <xmqqfrvrr3q7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 13EBDFAC-F84A-11EE-83F2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

>> THe next level would be to still assume that you stop at the same
>> place (i.e. you do not support patches from multiple series in the
>> same mailbox), but use the number-santized-subject format.  This
>> would be a bit more involved, but I think all you need to update on
>> the "am" side is where the am_run() assigns the message file to the
>> local variable "mail".  You know the temporary directory where you
>> told "mailsplit" to create these individual messages, so you should
>> be able to "opendir/readdir/closedir" and create a list of numbered
>> files in the directory very early in "git am".  Knowing msgnum(state)
>> at that point in the loop, it should be trivial to change the code
>> that currently assumes the 4-th file is named "0004" to check for
>> the file whose name begins with "0004-".
>
> Yea, we pretty much just have to get the git-am process to work with the
> new names. I can look at using opendir/readdir here instead.

Not "here", but probably just after you called "mailsplit" and saw
it return.  After that nobody should be adding more split mail
messages to the directory, so you do it once to grab all filenames.

> Ya I don't care much about multiple series. I care more about making it
> handle scrambled series better than it does now. I download series off
> of lore.kernel.org (public-inbox based) and those seem to routinely have
> series out-of-order. I suspect this is because it bases them on arrival
> date and sometimes certain mailers get it out of order when sending.

Yeah, and that is why I said it would be a better use of the
engineering resource to fix it at the source.  Such a fix will
benefit folks with existing versions of "git am", not needing to
wait for your improved version.

Thanks.
