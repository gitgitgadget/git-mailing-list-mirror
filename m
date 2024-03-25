Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A4745D9
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399614; cv=none; b=bNracaKJ9uSiAbjzTSgRbVsNGqvcEs1bPcd/tJG2QK6up0PXbdME0GgwQLHvXR9531IPxWGCLlppVV9uz6XHJvtcNMXUc2c/IvuYSYgkmJUd+FNkUDXE1R0eGC+CjuaS//WddDZ443m+9ei1IZaXZQ0vIr08ZnjRdNCG0wonwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399614; c=relaxed/simple;
	bh=hTqKqEcndSFJBEVzFSjE0+ZUSW7NVOFbpGtXHg4bVEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CKMb6m6TD6Wr4yeoOvkjQB2XeYQbjgXP9jmV0aWW1HbAF2gapZc0UICtIpKg1kW9eyYblWQTdDPP48LrTmatj6yehFSfkRROl23oQKBt8MGTwQ6K8o+ZKUW6hgHIeyNgF0ewnoayeLZQ7rXYWwg6ExZ7yUWWNkWeyZO1raytx60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rMeKX/fE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rMeKX/fE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ABC2230CDD;
	Mon, 25 Mar 2024 16:46:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hTqKqEcndSFJBEVzFSjE0+ZUSW7NVOFbpGtXHg
	4bVEc=; b=rMeKX/fEiUdKJhlGTiFYOtrqxRkvLLhpilDJFtGcny0R5wmDUG67cC
	5ZmoqNrMMf42gNw3Wxubpp9+0qEN4V6DvKlgcS12vtglTslu4RXB2JUXRFFEtSMj
	CJD/ruS3oTa4F9F03GlFfXevGWavpy2agGClvA74Eyri2OEGDPRmw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A1D5430CDC;
	Mon, 25 Mar 2024 16:46:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 086FD30CDB;
	Mon, 25 Mar 2024 16:46:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Cc: git@vger.kernel.org, =?utf-8?Q?Marcel_R=C3=B6thke?=
 <marcel@roethke.info>
Subject: Re: segfault with git rebase --abort
In-Reply-To: <7df26e3813ef76ee90c1fb02847bbb4b9bad630d.camel@rohdewald.de>
	(Wolfgang Rohdewald's message of "Sun, 24 Mar 2024 23:56:28 +0100")
References: <88a694de4a7f767613475ef1d19292a69eaccb07.camel@rohdewald.de>
	<xmqqle67pa7a.fsf@gitster.g>
	<7df26e3813ef76ee90c1fb02847bbb4b9bad630d.camel@rohdewald.de>
Date: Mon, 25 Mar 2024 13:46:47 -0700
Message-ID: <xmqqfrwehweg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD2ACFCE-EAE8-11EE-9F92-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:

> Am Sonntag, dem 24.03.2024 um 14:54 -0700 schrieb Junio C Hamano:
>> Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:
>> 
>> > git rebase -i
>> > 
>> > git rebase --abort # boom
>> > 
>> This thread _might_ be relevant.
>> 
>>  https://lore.kernel.org/git/20240218114936.1121077-1-marcel@roethke.info/
>> 
>> The "might" is because the symptom is a sign of corruption of the
>> rerere database but the discussion or the patch in there do not know
>> how such a corruption happened in the first place.
>> 
>> If you rebuild Git with Marcel's patch (there is v2 downthread, and
>> we have been waiting for a v3) and it improves the situation, please
>> do let us know.
>
> Yes, the patch resolved my problem. Thanks a lot!

Thanks for testing (and thanks, Marcel, for writing a fix).

>
> From the bash history below, this might be the sequence:
>
> (git 2.39)
>
> I think I forgot to remove one line of "<<<<<<< HEAD" before doing the first git add.
>
> Because git rebase --abort then told me about the lockfile, the segfault probably
> already happened with the second git rebase --continue.
> and from then on all git rebase --abort segfaulted.
>
> Oh - and I definitively did not mess around in .git
>
> I do have a backup of the repo, so if you want me to look up things ...
>
> git checkout master
> git rebase -i
> vi servertable.py
> git add servertable.py  # here I probably left that <<<< HEAD line
> git rebase --continue
> vi servertable.py 
> git add servertable.py
> git rebase --continue   # I think this already segfaulted
> git status
> df                      # plenty of free space
> git rebase --abort
> rm .git/MERGE_RR.lock
>
>
> Since the patch is about rerere, I now did:
>
> wrpc:~/tmp/kajongg (master|REBASE-i) git rerere status
> src/servertable.py
> wrpc:~/tmp/kajongg (master|REBASE-i) git rerere diff
> error: Could not stat .git/rr-cache/a8ec6f624ee23ef2e37148a8172ebac3c6639f93/preimage: No such file or directory
> fatal: unable to generate diff for '.git/rr-cache/a8ec6f624ee23ef2e37148a8172ebac3c6639f93'
>
> wrpc:~/tmp/kajongg/.git/rr-cache (GIT_DIR!|REBASE-i) ls -lrt | tail -3
> drwxr-xr-x 2 wr wr 4096 Mar 24 16:19 e6c7ce944f313fa718cad6875d4ee784c098868c
> drwxr-xr-x 2 wr wr 4096 Mar 24 16:19 d0a20608fa0aafd2b234cce432ce7af567c1a94a
> drwxr-xr-x 2 wr wr 4096 Mar 24 16:43 a8ec6f624ee23ef2e37148a8172ebac3c6639f93
> wrpc:~/tmp/kajongg/.git/rr-cache (GIT_DIR!|REBASE-i) ls -l a8ec6f624ee23ef2e37148a8172ebac3c6639f93/
> total 0
