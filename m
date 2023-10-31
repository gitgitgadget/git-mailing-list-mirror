Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF91117
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mXHSWDEN"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C887AE4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:33:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EDEE216C4;
	Tue, 31 Oct 2023 01:33:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Az9o/0+we2lAEJmBIJp5ANlhwAwcC2Ok55bRKW
	mM+iY=; b=mXHSWDENqmivp+Hhr1T4hfnOKHrV17FKsbRGiYpY/4NThYDcFOmpFi
	mrQpdhP5oBpOCj8dR6MBcy11g9EaGUe5feycFZpBrJZLxvoZpSD2fad95vAKeHuT
	BhCMSfTeEJHB+kQL0PEWcIPh0QmOE3B2/rtv8mS9BzaxrC2zJN3dg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 38455216C3;
	Tue, 31 Oct 2023 01:33:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3FD4D216C2;
	Tue, 31 Oct 2023 01:33:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Tony Tung <tonytung@merly.org>
Subject: Re: [PATCH] sequencer: remove use of comment character
In-Reply-To: <xmqqa5rzadlh.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	31 Oct 2023 08:35:06 +0900")
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
	<xmqq7cn4g3nx.fsf@gitster.g>
	<CABPp-BE6_nuMeiqOAMGwP8SH=d1+i57-STgTNKU8-Gnkv2jW=Q@mail.gmail.com>
	<xmqqa5rzadlh.fsf@gitster.g>
Date: Tue, 31 Oct 2023 14:33:05 +0900
Message-ID: <xmqqcywv4ar2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F888A6D0-77AE-11EE-B499-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> I thought the point of the comment_line_char was so that commit
>> messages could have lines starting with '#'.  That rationale doesn't
>> apply to the TODO list generation or parsing, and I'm not sure if we
>> want to add the same complexity there.

Earlier I said

> Thanks for a healthy dose of sanity.  I noticed existing use of
> comment_line_char everywhere in sequencer.c and assumed we would
> want to be consistent, but you are right to point out that they are
> all about the COMMIT_EDITMSG kind of thing, and not about what
> appears in "sequencer/todo".

but with something as simple as

    $ git -c core.commentchar='@' rebase -i master seen^2

I can see that the references to comment_line_char in sequencer.c
are about the commented lines after the list of insn in the
generated sequencer/todo file, so even though the rationale does not
apply, isn't this already "broken" in the current code anyway?

Thanks.
