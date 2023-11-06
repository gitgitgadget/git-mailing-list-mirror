Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C22EB0A
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p1kyRPIP"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD7944AE
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:25:11 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E6363BAD4;
	Mon,  6 Nov 2023 18:25:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OdiPPJuD2fvuPQ7fQQD6sBdyMTDC4WzH9W/39l
	e32VQ=; b=p1kyRPIPMPPqPouFLWwL+o+tgjnMTHWlYPbiKx9eZxkBKPrp0+xkP9
	c3U4UpmuWBpC24FTWSJOr4slDSQAWFzo4ljQEaVdJcr+g8jjI58hmFBZNjbm4v06
	rMpbxnhS9ibQEj8ihTmYJAoJasIMLn05e8ozkSmJcVuo039W36BBg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 86D3A3BAD3;
	Mon,  6 Nov 2023 18:25:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 877033BACF;
	Mon,  6 Nov 2023 18:25:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: magic-less pathspecs that start with ":" not processed as
 expected.
In-Reply-To: <CAMmZTi-JJ6=Uw_+r50hKMYf34D0NtqXhaA=f+11+wAQBjqA7_g@mail.gmail.com>
	(Joanna Wang's message of "Mon, 6 Nov 2023 10:54:03 -0500")
References: <CAMmZTi-JJ6=Uw_+r50hKMYf34D0NtqXhaA=f+11+wAQBjqA7_g@mail.gmail.com>
Date: Tue, 07 Nov 2023 08:25:04 +0900
Message-ID: <xmqqlebacvn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B84C4C46-7CFB-11EE-97A5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Joanna Wang <jojwang@google.com> writes:

> I believe this is due to parse_short_magic() not handling the case where
> ":" is part of the file name rather than a prefix for pathspec magic.

Also, ":<path>" is a notation for the object name sitting at <path>
in the index, so giving it from the command line is ambiguous, too.
I thought that ./:<path> would be a common way to talk about such a
path to git commands?

    $ date >./:now.txt
    $ git add ./:now.txt
    $ git rm ./:now.txt

I do not offhand remember where this is documented, but I agree that
we need to make sure that we give help to users on things like this
("how do I add a file whose name begins with a dash" is another
question I think we hear from time to time).

Thanks.
