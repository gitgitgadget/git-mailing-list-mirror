Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717354B5A9
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8KuelaG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 965FA19E80;
	Thu, 11 Jan 2024 16:47:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i2x6sWco/3Fdy2ETjyGUqBJp9ymVwdlL05JuIr
	mrUrk=; b=M8KuelaG+/Npizg7UaR7/qYvSICDfaRTDkmFGHIQAKZ95wpZ2m+sKv
	ZfOCpHR0uzcarURCUdFmKphoRzUBLHoSpLkNT6jdETbLs8f/eBKxsdD0g/d5v5HT
	CD+njPmxdwpAaz34HBnoSUHik2ttYC8BXiy18/cl8cBDClnRJsa8g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FE5519E7F;
	Thu, 11 Jan 2024 16:47:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50CFB19E7E;
	Thu, 11 Jan 2024 16:47:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  wanja.hentze@bevuta.com
Subject: Re: [PATCH v3] builtin/revert.c: refactor using an enum for cmd-action
In-Reply-To: <20240111200627.64199-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Thu, 11 Jan 2024 21:06:27 +0100")
References: <xmqqsf33fy3t.fsf@gitster.g>
	<20240111200627.64199-1-mi.al.lohmann@gmail.com>
Date: Thu, 11 Jan 2024 13:47:48 -0800
Message-ID: <xmqqzfxbee4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 10E6DA4E-B0CB-11EE-A3D0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Michael Lohmann <mi.al.lohmann@gmail.com> writes:

> This is done to avoid having to keep the char values in sync in
> different places and also to get compiler warnings on non-exhaustive
> switches.
>
> In the rebase `action` enum there is the enumeration constant
> `ACTION_NONE` which is not particularly descriptive, since it seems to
> imply that no action should be taken. Instead it signals a start of a
> revert/cherry-pick process, so here `ACTION_START` was chosen.
>
> Co-authored-by: Wanja Henze <wanja.hentze@bevuta.com>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
>
> On 11. Jan 2024, at 20:37, Junio C Hamano <gitster@pobox.com> wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> > I think ACTION_NONE was intended to covey that the user did not pass
>> > one of the OPT_CMDMODE() options like "--continue" as there isn't a
>> > "--start" option. I don't have a strong opinion between "_NONE" and
>> > "_START".
>>
>> I agree with you why NONE is called as such.  If "revert" does not
>> take "--start" (I do not remember offhand), I would think it would
>> be better to follow suit.
> My point was that yes, it might be in sync with what the user passes in
> as arguments, but when I followed the code and saw lots of references to
> ACTION_NONE I was puzzled, since my intuition of that name was that
> _no action_ should be taken (which did not make sense to me).

I know you wrote that ;-).  But _NONE is "no action was specified",
and has been so for a long time in the context of "rebase". I do not
see any confusion expressed there.  I do not expect to see any
confusion here, either, if we were to introduce these new enum.

