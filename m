Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A13C30
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659522; cv=none; b=ft7scpOPHTFuK30ZUvjKkOz4V88vvB1tRwSN7WzB8dHAdtqFf4oWtolEiMPY9muPGlXF0+PpFOB5TLsY0/GVkhsIPtVmqiRYTUeITjHQUeOrdeIpRs3/3qQWILvQDJHXRpkVnZRXZrByjlx720ErDFKR0lqUJR73nyOdI1ECd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659522; c=relaxed/simple;
	bh=uTsY4rZmm0AjpEUhjCYjSTlVFywaOJX/9dMHp5vMTk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkq2D0hE1B8TqlFJ9gYSbkAL8DuslqRXDDJrHh8/AhnwAbjtilNAb/psM5bZP5rmYVhYAAIWiYG56COLGF9mCjetmGFdxewTVIUhPKlw7wHXMjMPLPyrz98OvBeHt2Xw78zkQqTJUdr3MCQc5WCX63VTe778BFHIKKIE3SAo9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bQdF43lvSz7QSD2
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 08:18:32 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4bQdDv5GxWzRpKl;
	Mon, 23 Jun 2025 08:18:23 +0200 (CEST)
Message-ID: <d9561ef1-f67c-492a-b9bd-5adf55cf4868@kdbg.org>
Date: Mon, 23 Jun 2025 08:18:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Resubmittimg Bulgarian translation of git-gui
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org
References: <20250615122631.41988-3-ash@kambanaria.org>
 <92e92b77-f8b1-4e7c-b426-be09e3f2030e@kdbg.org>
 <CAP6f5M=cYn_XBN=-zw0ezqFskOSjZiVQwQ60f8k4mb2dYqM-vQ@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAP6f5M=cYn_XBN=-zw0ezqFskOSjZiVQwQ60f8k4mb2dYqM-vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.06.25 um 19:11 schrieb Alexander Shopov:
>> not .. obvious, even with `git show --ignore-matching-lines='#:'
>> --color-moved`. Is there a way to enforce a stable order in the .pot
>> file and/or the merged .po files?
> 
> Sadly no. The -s/--sort-output is deprecated (plus it is counter productive).
> https://www.gnu.org/software/gettext/manual/gettext.html#index-_002ds_002c-msgmerge-option
> 
> The default is -F/--sort-by-file which is kind of saner.
> https://www.gnu.org/software/gettext/manual/gettext.html#index-_002dF_002c-msgmerge-option
> 
> It may cause jumping around in case a translatable string that was 
> available in one file, becomes available in a file sorted earlier
> than the format but nothing is 100% proof.

That is acceptable and is mitigated somewhat if the diff is viewed with
--color-moved.

As far as I can see, the order of files that are passed to xgettext is
stable. We use $(wildcard lib/*.tcl), which is specified to produce a
sorted list of file names. If xgettext doesn't do anything silly, this
should produce a stable .pot file.

> Sorting is not enough for sane diffs. As the location data also 
> contains line numbers - adding a line before a message pushes its
> location down.
> 
> The way I read your message:
> - you are OK with a translator choosing to submit po-files without 
> location info. This will make commits and diffs shorter and more
> understandable and reduces the growth of the repo The info is not
> used during runtime and is easily recoverable - generate the pot and
> merge the translation.
> - you are at least interested in moving the infrastructure to this workflow.

All correct.

> In such a case next time I submit a gitk/git-gui translation I will
> voluntarily remove the locations.

An update of the Makefile rules would also be desirable, so that a
simple `make update-po` produces the new format.

-- Hannes

