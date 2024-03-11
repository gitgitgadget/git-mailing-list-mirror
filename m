Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F99482CF
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177158; cv=none; b=J01BvqQi6Z/zhzvX0Jkyc+BOhyW40vgcwCS4Av23p4GsyrK2s7dQ2g5WeliEF3CZ/VeJAej/yuHo0jSF6EYf1JT7bFUDwElL48sTn4GakqbiPuFf5U+nNRKFd8WLBwtfRNw3kjNjcg6Gt4trsm72kqDNt8OByIjaMIsRWDlT73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177158; c=relaxed/simple;
	bh=uIjiKhrfaQ9kwNICzMsAyvWieBO24ghb2fudUsR+Kek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XaDDuRCgqFL/doaKdOa5Ap7qpNYJLOgAcL8DJ9wJtdwy03f1UXeLz6Js3RNDvmO3KZ/ncSZvcsnn8fpeF9RsIG8YTjNcX9hTdcX7T3iq4Q9mcJLFpb8oPvVi1vgP/pb3GvUOXrSFHC2ZGtUR4dhs7fmAtVc5wZlpQlx2mpJlwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JFAPwzxZ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFAPwzxZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1557A25D3D;
	Mon, 11 Mar 2024 13:12:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uIjiKhrfaQ9kwNICzMsAyvWieBO24ghb2fudUs
	R+Kek=; b=JFAPwzxZw3vu9IAz1gHJbxyvNxXbUM17ljzIRlyTMs0qVZVhvjMYlm
	nbSPiv50rxWrVUmOMyDYg7V/GVhtKCkIw8TCmk946v0Nl9mxc+T7ML6MrUBLSpiN
	nufbJ9V/K3s6SaSSKjjg/QRCepvQfpkKJwcEZ33Ig2BZQHYn2xZkA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E34225D3C;
	Mon, 11 Mar 2024 13:12:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4CC025D3B;
	Mon, 11 Mar 2024 13:12:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  ZheNing Hu <adlternative@gmail.com>,
  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/2] builtin/am: allow disabling conflict advice
In-Reply-To: <f06dcfad-e4b8-4cb7-8728-f5fb018f7be0@gmail.com> (phillip's
	message of "Mon, 11 Mar 2024 10:54:18 +0000")
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
	<3235542cc6f77779cca1aeff65236e16b0a15d76.1710100261.git.gitgitgadget@gmail.com>
	<f06dcfad-e4b8-4cb7-8728-f5fb018f7be0@gmail.com>
Date: Mon, 11 Mar 2024 10:12:30 -0700
Message-ID: <xmqq5xxsu1z5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8CFE591C-DFCA-11EE-A0CC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

> Hi Philippe
>
> On 10/03/2024 19:51, Philippe Blain via GitGitGadget wrote:
>> diff --git a/builtin/am.c b/builtin/am.c
>> index d1990d7edcb..0e97b827e4b 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -1150,19 +1150,23 @@ static const char *msgnum(const struct am_state *state)
>>   static void NORETURN die_user_resolve(const struct am_state *state)
>>   {
>>   	if (state->resolvemsg) {
>> -		printf_ln("%s", state->resolvemsg);
>> +		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", state->resolvemsg);
>>   	} else {
>>   		const char *cmdline = state->interactive ? "git am -i" : "git am";
>> +		struct strbuf sb = STRBUF_INIT;
>>   -		printf_ln(_("When you have resolved this problem, run
>> \"%s --continue\"."), cmdline);
>> -		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
>> +		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\"."), cmdline);
>> +		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
>
> I think you need to append "\n" to the message strings here (and
> below) to match the behavior of printf_ln().

Good eyes.  You'll get the final "\n" but the line breaks inside the
paragraph you give to advise*() functions are your responsibility.
Even though advice.c:vadvise() handles multi-line message better
(unlike usage.c:vreportf() that is used for error() and die()) by
giving a line header for each line of the message, we do not wrap
lines at runtime.

> Apart from that both patches look good to me, thanks for
> re-rolling. It is a bit surprising that we don't need to update any

Thanks, both, and indeed it is a bit surprising.

> rebase tests. I haven't checked but I guess either we're not testing
> this advice when rebasing or we're using a grep expression that is
> vague enough not to be affected.
