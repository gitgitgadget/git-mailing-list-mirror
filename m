Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188F30100E
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449124; cv=none; b=B00bJzWEj/AtuDoQB/jYSJ3PvggUy0oCdadsotnBUmMqX39l1cw3gJJGCUG5FISUjEnJm4mcF61Dt3vUZm8Zuiz4nw2OVzNFBy0m06EcJIHWvNM880z9yV8HJcYrSMgG3QG4xiEbZTEgpYDUkio5s60KstSRUD5dOXSvSWs4wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449124; c=relaxed/simple;
	bh=LAzp7tbM/vg7yzUNIa8s9bkyGlg7hrXTbFciNxk6fRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbSel+OHYTp6lwkodFbLfvDqqbYqV9nw4iM0NqPMJlS6aBeKE1eFiizeF3dTjtPW91T/dNTcqugKKQD8Md7xGyg66wkvuLY17R+4P/S97u3OHGSrCxa3GtkafE1GU6tmKxJTa/0cFMNyS+t9RGpDZMr3Plug3joTUm8BMKrNP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gMNHM1HTRzRnlY;
	Fri, 22 May 2026 13:25:18 +0200 (CEST)
Message-ID: <190c909d-4c17-488f-9ebe-f7927ebf7e87@kdbg.org>
Date: Fri, 22 May 2026 13:25:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] branch: add --forked <branch>
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
 <f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
 <273103d7-c816-4cde-9e89-b630c37b0749@kdbg.org> <xmqqse7kt0ge.fsf@gitster.g>
 <CAHwyqnX=zvjpy3w8qn+H7L_Ncxs5+tK5Va-Lr4ZXX=XYLs2YZQ@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAHwyqnX=zvjpy3w8qn+H7L_Ncxs5+tK5Va-Lr4ZXX=XYLs2YZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.05.26 um 12:49 schrieb Harald Nordgren:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> The icing on the cake would now be that
>>>
>>>     git branch --merged origin/main --forked origin/*
>>>
>>> provides the list of branches forked from origin that have already been
>>> integrated.
>>
>> Yup, that is very nice.  Also with "--merged" replaced with
>> "--not-merged", i.e., "our work building on top of origin's, and
>> still need to be finished", would give us a good list to work on.
> 
> This is nice, but I think this would require an overhaul of other
> infra as well, maybe better to do as a follow-up?
This can certainly be done as an extension in a follow-up patch. But the
UI must still be planned accordingly, i.e., --forked can only take a
single argument. For example, in

    git branch --forked foo bar

'bar' is the pattern of branches to show. The "list" is filtered
according to '--forked foo'. That is, if 'bar' was not forked from
'foo', the output is empty.

You would have to require

    git branch --forked foo --forked bar

to list all branches forked from 'foo' or 'bar'.

In the first implementation, you can restrict uses of other options with
--forked or even with a branch pattern. But you cannot be loose by
accepting multiple branch patterns with one --forked option, because
that would later clash with --list mode.

-- Hannes

