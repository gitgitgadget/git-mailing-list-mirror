Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A847A0B8
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851540; cv=none; b=gcRPmoH6RD8HoRDyNwNqPrByvdCOQJ2I99lKTRfiu4jNHcWB95sAinM/ECbxPrS+sj2CY+S9pZy6eQ/Gw9wisRIBP+ylBkx+4AcGnR8MclZa0W7CRDDbW7K2KMvZTYHnQbdb5Bb2vLBBob/NXzkCiup5fzPm4e4IMjV72y0mP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851540; c=relaxed/simple;
	bh=UOPESU3juTbe7053uKReYQP+Yaf/naqV9fW9DYuFrdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEgjuFDAS0jVI9qZvseABYLttg0J3ihc741k4Y/cg4H1hAs9nN0sDvSHZ1HVPSJ0SQKh/XCtZmQb7IUJ6CnQALtIhqptxYJihUEy530zfFoo40brNRhB8ztbDVancggLKynuJ13ZY72nRdZriyCN1jYqc1/HnUFXJRfLn9vjVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=FLGydqGX; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="FLGydqGX"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BBF16240101
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 22:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1782851535; bh=cUaXFtrR+8sIH4zeJ+AB4Pu+ZNyqSAXpktY+17Rr/4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=FLGydqGXa6o+KtjciSxD2c4jea15mo6qyRnMN1+IEJgE+u6oWrsykGSjFt8AhQvCe
	 Pz6CHlXCvwoTmhknkqPH4pXboFU80UkPTZNnCBYDO/e9IgZ6J5dvY0gQEaxdKUQ5iW
	 ff+bKhmm5z6WsKk8HV+U/P5tvDnO7IZsu6CiBuEmPlcre7OgAIj4jfxkNp1stdEjrz
	 YkiOxEY1e2VkV9MfwPeIgl0GZA2gpwqo3pG9X5ZwWp3zGO8emPMvgCDo+WacLm3w9m
	 ZujiPgZ/feG+UMqQhJoPW/WjTUN2DFL1wY9+x/iQ7bOfnul91JAyXBJ0/IvPbUQatt
	 ngiEvKnmFAESA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gqZZR2KyMz6trs;
	Tue, 30 Jun 2026 22:32:15 +0200 (CEST)
Message-ID: <7df1312b-c5d0-462a-a03f-9f07e7338de1@posteo.net>
Date: Tue, 30 Jun 2026 20:32:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: git-blame vs. abbrev
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
 <xmqqy0fvreps.fsf@gitster.g>
Content-Language: en-US
From: Laszlo Ersek <laszlo.ersek@posteo.net>
In-Reply-To: <xmqqy0fvreps.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/26 21:49, Junio C Hamano wrote:
> Laszlo Ersek <laszlo.ersek@posteo.net> writes:
>
>> Hi,
>>
>> when git-blame is passed the "-b" option ("Show blank SHA-1 for
>> boundary commits"), shouldn't git-blame *stop* reserving a commit
>> hash nibble for the caret that otherwise marks boundary commits?
>>
>> More directly, I find it inconvenient that git-blame shows commit
>> hashes that are one nibble longer (13) than my "core.abbrev" (12)
>> setting; that makes cutting and pasting commit hashes from the
>> git-blame output into a git-rebase TODO list cumbersome.
>
> I never knew that the parser in rebase did not want to see a longer
> abbreviation; shouldn't it take 16 hexadecimal abbreviation from the
> result of letting the user edit the list, even if it initially gave
> 12 hexadecimal abbreviation, as long as these extra 4 hexdigits do
> not break the commit object name?  That is a more serious usability
> bug that needs to be fixed, if it is the case, I would think.

Ugh, I'm very sorry; I failed to describe my problem precisely. When I
wrote "cutting and pasting commit hashes from the git-blame output into
a git-rebase TODO list", I actually meant pasting the commit hash from
git-blame into the *search box* of the editor that keeps the git-rebase
TODO list open.

Basically I want to fix up a line of code in a patch in a longer patch
set, but don't know off-hand which patch in the set introduces that line
of code. So git-blame gives me a commit hash, and subsequently, I run
git-rebase, would like to jump to the TODO line with that commit hash,
and change the action from "pick" to "edit". And this *lookup* is what
fails, because the hash from git-blame is 13 nibbles long, but the
hashes in the git-rebase TODO list are 12 nibbles long. I always have to
remember to remove the last nibble in the search box; otherwise, there
is no match.

> FWIW, even if your core.abbrev says you want 12, if two objects share
> the same 12 hexdigits as the prefix, you do end up getting 13 or more,

Indeed, but that does not matter in practice (to me anyway); a 12-nibble
prefix length suffices for very large projects, and if ever there were a
collision, I'd just increase the length permanently to 13 nibbles. The
specific length is not relevant; agreement between git-blame's output
and everything else dealing with commit hashes in git is what I'd like
very much.

> so a parser that insists on exact 12 hexdigits sounds like a bug.
>
Apologies again, that (implied) bug existed only between my chair and
keyboard. :)

> Just for the sake of aesthetics, I agree that when we are not showing
> the boundary mark, it would make sense not to reserve one column that
> we know we will never use.  But unless there is a mistaken parser that
> insists on 12 hexdigits when 13 hexdigits you give uniquely identify
> the same object, I suspect you wouldn't even notice that the
> hexadecimal digits you see on the screen have one digit longer than
> usual ;-).

That's it precisely! :) I do *not* notice that the hash from git-blame
has one more hexadecimal character than the central abbrev setting; so I
just go ahead and blindly cut n' paste it, using the mouse, from the
terminal, to the editor search box that's displaying the git-rebase TODO
list. And then I don't understand why the lookup fails (until I realize
that I have forgotten, yet again, to strip the last nibble from the
commit hash coming from git-blame).

Once again, sorry about misstating the problem / use case!

Laszlo
