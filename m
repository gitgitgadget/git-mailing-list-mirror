Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05837133291
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306687; cv=none; b=pO9Hh+Hf66hEzwIMFT+VMh40tiatrmUIxE00RqN9AcYg+oX1DGzlDLVFve8I/YQQy16stVfDC8qjwu/HsHE/pwHRM2s/IH5LhbBUatS4OoFD/A/U6IweykgLC2Bk8WW6ezo5PqOEBwN7Q7xa3LLm9dwzffXqtvl9ytNUAldU60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306687; c=relaxed/simple;
	bh=py/JqKXo4WvEUKQPd9KWFQDuX/gOstkELM29MoMgUZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdrCH8CNigi4uIAhgFHplrevHRoJrdoKuIOLMrevpsUtKgbmgO8MF7/VcwmhlUuMqJ9AvvBx0BR0ooLFK4lRjrIdlCi9sB0kzprsrnzfKMt0KqgbfKEPOE64wauUIVsFCxdw4rjFiVscQu6VWUsn3a7rFKIsZCUOj/Tc61fMXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hAIKOsbO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hAIKOsbO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB33A1D3501;
	Tue, 16 Apr 2024 18:31:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=py/JqKXo4WvEUKQPd9KWFQDuX/gOstkELM29Mo
	MgUZo=; b=hAIKOsbO0MRskXHo3w0RvlzDANqEOpSyFXZdXowNdCP1paucT2zhHO
	/xf8lDJvn+Ixl3oI5k7P/nr0mtDCs1ZFEWRkvn3HpcFMcBGnzwZi86XAKhirBBjH
	2Yko7JKNn0gxnXxG8dVnY4tjwyPv9cB3Zl0qM5zGpYMHBdbvruZe8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E12FC1D3500;
	Tue, 16 Apr 2024 18:31:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 439831D34FF;
	Tue, 16 Apr 2024 18:31:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Josh Triplett'" <josh@joshtriplett.org>,  <git@vger.kernel.org>
Subject: Re: [PATCH] advice: Add advice.scissors to suppress "do not modify
 or remove this line"
In-Reply-To: <046c01da903e$d6d97ac0$848c7040$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 16 Apr 2024 16:44:06
	-0400")
References: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>
	<Zh7NZhB1n2o1k7jI@localhost> <xmqq7cgxdp0i.fsf@gitster.g>
	<046c01da903e$d6d97ac0$848c7040$@nexbridge.com>
Date: Tue, 16 Apr 2024 15:31:17 -0700
Message-ID: <xmqqv84hc53e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B038C8C-FC41-11EE-86A7-25B3960A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

>>>> This is useful advice for new users, but potentially redundant for
>>>> experienced users, who might instead appreciate seeing two more lines
>>>> of information in their editor.
>>>>
>>>> Add advice.scissors to suppress that explanation.
>>>
>>> Following up on this patch. Happy to rework if needed.
>>
>>I am not personally interested in the feature myself, and I doubt it would
> help the
>>end-user experience very much.  You'd need to find somebody else to cheer
> for the
>>topic ;-)
>
> I am having a bit of trouble understanding the use-case for
> this. Is it limited to linkgit? Under what circumstances would I
> need to use such capabilities?

When you run "git commit" from the command line without specifying
any message, you'd get an editor spawned for you with something like
this in the file ("--- >8 ---" and "--- 8< ---" are for illustration
purposes in this message).

    --- >8 ---

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    #
    # On branch next
    # Untracked files:
    #	+runme.sh
    #	P
    #
    --- 8< ---

But when you run "git commit --cleanup=scissors" (or use the
equivalent configuration variables), you'd get this instead.

    --- >8 ---

    # ------------------------ >8 ------------------------
    # Do not modify or remove the line above.
    # Everything below it will be ignored.
    #
    # On branch next
    # Untracked files:
    #	+runme.sh
    #	P
    #
    --- 8< ---

The new advice configuration is to suppress the two lines from that
message template.

I agree that a bit more background information should be given in
the proposed log message to help readers.  It should mention when
this new setting is relevant (e.g., when the "--cleanup=scissors"
option is in effect), at least.

I suspect that the same configuration variable wants to also control
the "helpful" comment in the "normal" case, in which case the name
of the configuration variable would need to be rethought.




