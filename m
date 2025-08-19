Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5A26E17A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633077; cv=none; b=btUd/xWhjPbmd2jPLMb1rVw5gjgkIh+l+/PKxlPhE36+jTJwZjgoJ5fqlDjq701qwpDx3qZUssmexETMJo4JH/vFnNyr2U653h4dcwosxo9ceWZoAHtdfoXbjcypTp0hdxtZg6DyLqdpTwVwk5c/FHokTdcdefU0aWj7WpBg0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633077; c=relaxed/simple;
	bh=uQLsoeO4wuzyFP1ZAze56Qk7wEBLFamrOtAPWjcIT6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOG15lY2uzE7fkh3vwyQL7fizsdrp+8r2BQm9BxOAoDzZFnQSgcOTpm3WJUDlEVfWgvNXrMaui9hXUMV7/Ny+xY34j6a+vadxVVoRybjdFMzK9P/SMCU8q2x8GU3SI9xf9EmB0xQaIqeEohQyjzwB1MUQ+dC4lk6BV0ztHMNQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4c5zfF26nrz7R23q
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:09:25 +0200 (CEST)
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4c5zf259pWzRq1V;
	Tue, 19 Aug 2025 21:09:14 +0200 (CEST)
Message-ID: <9e04fa29-f5e5-450c-8a00-a67a4c230640@kdbg.org>
Date: Tue, 19 Aug 2025 21:09:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Graphical tool to merge and reorder commits
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
 "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
 <xmqqplcsiimq.fsf@gitster.g> <aKQws631-giQS5Qr@pks.im>
 <aeb06554-77b5-4f07-a659-7b6825d6f3e4@rd10.de>
 <260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at>
 <xmqqplcre0el.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqplcre0el.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.08.25 um 18:33 schrieb Junio C Hamano:
> Bernd Petrovitsch <bernd@petrovitsch.priv.at> writes:
>> On 19.08.25 10:35, R. Diez wrote:
>>> - A - B - fixA1 - C - fixA2 - D - E
>>> [...]
>>> - A+fixA1+fixA2 - B - C - D - E
>>
>> - `git rebase -i HEAD~11` (or so;-)
>> - move fixA1 and fixA2 under A and change "pick" to "fixup" for fixA1 and fixA2
>> - save and exit the editor
>>
>> And done.
> 
> I hope we all know that ;-).  But the question was if there is a GUI
> tool to let you do so without knowing how to move lines in your
> editor or how to edit "pick" and change it to "fixup", I think.
Half-GUI is to keep `gitk --branches HEAD &` open for easy diff
inspection and `git gui` next to it for easy staging of (partial)
changes. The workflow is then

    # fix bugs
    # git gui: stage all or partial changes
    # gitk: search commit

    git commit --fixup 123abc

    # git gui: stage more changes
    # gitk: search commit

    git commit --fixup def456

    git rebase -i --autosquash HEAD~11   # or so ;)
    # fixup commits are already at the correct positions

Bonus feature: After staging, press F5 in gitk, select the green commit
("Local changes check in to the index..."), right-click in the diff
panel on a removed line[*], select "Show origin of this line", and you
are right at the commit that you want to fix up.

[*] works also for context lines, but it is less obvious which one to
choose.

This workflow requires useful commit message summary lines. If you have
only identical silly summaries like "fix bug" or "new feature",
--autosquash doesn't know which one you mean.

-- Hannes

