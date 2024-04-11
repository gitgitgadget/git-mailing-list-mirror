Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51413C806
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814951; cv=none; b=id4SvHOh3DnOtfOE9F6aEHeX45ihUHFg+IKNRLCitRE3Niiih8bW6W55HsJifC/YkHrlqnOSFa0RShUgEXZyyQLZ7+o+7wWxBVZqPqCn1W472BgffXV5SDfTRiP1RR4Kuc525EQowwzwjkiUKvb+ZyK50dNCtjdOFbadVUk2EVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814951; c=relaxed/simple;
	bh=y1yYjH/IYyRlanLz/eZIi/XCV+tHbfyQKyUva2PO284=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N5ePIniKNXGhiiypi2+EPZihwhjnB4jxiiqixNU7cGkLzONREoW8Ofk98XtIiVwn0prgrenPU1pFDP0NNGKC0lGZ615Ng/NHPd31jB8WpXmBmNR/VsMErzW0PYGimRsA90HWg+TJh6Mk88Yu5ChxcoBcPpCGKV5qeot2rcQzi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YTv97yvv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YTv97yvv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 420E4348D9;
	Thu, 11 Apr 2024 01:55:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=y1yYjH/IYyRlanLz/eZIi/XCV+tHbfyQKyUva2
	PO284=; b=YTv97yvvFMlBS5kdx0fwMe9IHqHYzMUmrpWFAhMSdqtDfSqDhaH0jC
	9l3vctYvn4M8gawmkO8x8wYiqgVJsTHaL0Uyi64W2At1iXvyG3cOUTJSgHz4El0P
	DBoDJSgeMQKDDae6DBueOsUlRcVsSaazviAeUbbxXn+M/a/Bm5jhc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A428348D8;
	Thu, 11 Apr 2024 01:55:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B732C348D7;
	Thu, 11 Apr 2024 01:55:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org
Subject: Re: [PATCH] mailsplit add option to include sanitized subject in
 filename
In-Reply-To: <CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
	(Jacob Keller's message of "Wed, 10 Apr 2024 20:22:02 -0700")
References: <20240409000546.3628898-1-jacob.e.keller@intel.com>
	<xmqqpluz2tau.fsf@gitster.g>
	<CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
Date: Wed, 10 Apr 2024 22:55:39 -0700
Message-ID: <xmqqedbcqw84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 209BC366-F7C8-11EE-908B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jacob Keller <jacob.keller@gmail.com> writes:

>> > I originally wanted to avoid the need for an option, but git-am
>> > currently depends on the strict sequence number filenames.  It is
>> > unclear how difficult it would be to refactor git-am to work with
>> > names that include the extra subject data.

The change may be a bit involved but depending on where you decide
to stop, it may not be too bad.

What is your design goal of this topic?  IOW, what is the maximum
corrupted ordering of patches in a single mailbox do you want to
recover from?

The easiest and cleanest would be if you assume that the messages
are in scrambled order, but are all from the same series, correctly
numbered, without anything missing.  A mbox may have 8 patches from
a 8-patch series, with their subject lines having [1/8] to [8/8]
without duplicates or droppages, without any other message that does
not belong to the series.  If that is where you are willing to stop,
then you can still name the individual messages with just numbers
(but taken out of the subject line, not the order the input was
splitted into).  "am" does not have to even know or care what you
are doing in mailsplit in this case.

THe next level would be to still assume that you stop at the same
place (i.e. you do not support patches from multiple series in the
same mailbox), but use the number-santized-subject format.  This
would be a bit more involved, but I think all you need to update on
the "am" side is where the am_run() assigns the message file to the
local variable "mail".  You know the temporary directory where you
told "mailsplit" to create these individual messages, so you should
be able to "opendir/readdir/closedir" and create a list of numbered
files in the directory very early in "git am".  Knowing msgnum(state)
at that point in the loop, it should be trivial to change the code
that currently assumes the 4-th file is named "0004" to check for
the file whose name begins with "0004-".

I personally am not at all interested in doing that myself, because
I do not see a reasonable way to lift the limitation of allowing a
mailbox holding patches from only one series, and if we assume that
a tool (i.e. "am" driving "mailsplit" in the new mode) with such a
limitation is still useful, the source of such a scrambled mailbox
must be quite a narrow and common one.  At that point, I suspect
that fixing the scrambling at that narrow and common source (e.g.
your "t.mbox.gz from public inbox server that cannot be told to sort
the messages in any order other than the arrival timestamp") would
be a much better use of our engineering resource.

