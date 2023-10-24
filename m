Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AE27EDD
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vegphAZj"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12412C
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 10:30:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A6801C909B;
	Tue, 24 Oct 2023 13:30:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4QQ9vkR0gn1BzLb0X0REm0Jgt4Wlk3kswoyKv0
	XJ5WI=; b=vegphAZjMVU4kYFAINJtUvqv/MHlb7Qwe/EMMw6brvkt5A+wynJqrh
	zs2gCTpE/oAGQ/MPhJw/z1jjr+cV8UO5er2i0XuE1XmEzb8xctYSEGB419o/gBqR
	03e4xKOKwGEKpPhzm4qxnxPu29y0dhI6RdooMuiahIfkyL/lEi9gc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 052FD1C9099;
	Tue, 24 Oct 2023 13:30:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C58101C9097;
	Tue, 24 Oct 2023 13:30:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
  phillip.wood@dunelm.org.uk,  Johannes Sixt <j6t@kdbg.org>,
  git@vger.kernel.org
Subject: Re: using oldest date when squashing commits
In-Reply-To: <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com> (Phillip Wood's
	message of "Tue, 24 Oct 2023 15:00:58 +0100")
References: <YjXRM5HiRizZ035p@ugly>
	<9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
	<a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>
	<ZTeZ3KEQLIVU/sq2@ugly>
	<138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com>
Date: Tue, 24 Oct 2023 10:30:01 -0700
Message-ID: <xmqqpm143p46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6E8BCA0-7292-11EE-B942-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> Unfortunately "fixup -C" only copies the commit message not the
>>> authorship
>> 
>>> (that's usually a good thing
>>>
>> why? what would that be useful for?
>> it seems rather counter-intuitive.
>
> In the same way that you do not want to change the author date when
> using a fixup to move a small hunk from one commit to another most
> users do not want to update the author information when they make a
> small change to a commit message using "fixup -C"

Exactly.

It would be OK to add "fixup -c --reset-author", but the default
should stay.  In addition, I wouldn't be able to use "rebase -i" to
make typofixes to commits made out of received patches if the
operation changes the authorship.

> "fixup -c/-C" were conceived as a way to reword a commit message at
> the same time as optionally fixing up the commit's content.

Yup, it still is a "fix", meaning the identity and the spirit of the
commit being fixed are unchanged.  What it aims to achieve, how it
implements the behaviour it wants to give its users, who thought of
that change, all that are the same as the original.  It may be a
nice addition to optionally allow users to use --reset-author (or
better yet, --author="Na Me <a@dd.re.ss>") with "fixup", but if the
"-c" variant can be concluded with "commit --amend --reset-author"
to achieve the same effect, that may be sufficient.

Thanks.


