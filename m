Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D31CF5FA
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266694; cv=none; b=MLzUn/S4Mtn6Awh09AUqNvET63tbV0fq+p2xiGGUzjJ3eKcobnvZL1UDFGCMuNecGk3SXeV0oXz4tZMliKg1kLcH2yrP4cVs0ApF/Arhfa5e+0cskfW1ZwVH6iuiZx3SG2JHO65W8PuE9tLyz9vYw00ff2iujUceOryeEXVuaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266694; c=relaxed/simple;
	bh=toYb8RXeiKNWbrR2bRC/1DshQ1FOd3lNBEjTajuB8Sk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pz59dDWfNXtPJ0UIVar974fM3203WagWZbQYMhrZBMUeJOTwnxnRckp6053YIR5zJxTuEkoByx+j550pWK5SepBhyYOBCeUyBmY+MMbMeLxMFUXA5ZTfmfkD3Pw/AjSWJQ31d/pichPu9jgi+4XTyzHQPnXaG3Dw9r0YvjjfzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PoM3HeY3; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PoM3HeY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730266690; x=1730525890;
	bh=toYb8RXeiKNWbrR2bRC/1DshQ1FOd3lNBEjTajuB8Sk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PoM3HeY3760NP64P2ATQEknjYZ8Ursizipn7sEHuXq4HFGx/0DNBKREWjsETTsuMH
	 Z8R89xUNKlDiBodDZdsAgYsREcl2UCrT4uPGYIZ4nsUERb32EUBKElZaVvi22weuA1
	 QO9dJdeL/cb/H4bbGiMAo1J09t9WSEznHyN9RqmbIFNSE2IWV459gMk3cvNKQBuRQw
	 djlsGAk472deY9zDcBvsEve5YzUyNXDoK/4Z/5Cjjg4OEexYFbSnbHY6EecDUAShX+
	 iWEf7HD2JPxbubFoApAlZ+EYJiihfjtc6ZjQUZKG8/dhKxnFueucQV3jNy5OSWYKDA
	 zk5XSaSSCgDxw==
Date: Wed, 30 Oct 2024 05:38:06 +0000
To: Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] worktree: add `write_worktree_linking_files` function
Message-ID: <D58WCL821YEF.1Y68WOUZ8RJLT@pm.me>
In-Reply-To: <ZyFn9xErajxzQo29@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-2-33a5021bd7bb@pm.me> <4a316a5f-9360-4f24-843f-bcbb5b3378c4@gmail.com> <ZyFn9xErajxzQo29@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 2cdb8b50156462092b806e416e4c007a3e961171
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 5:55 PM CDT, Taylor Blau wrote:
> On Tue, Oct 29, 2024 at 02:52:36PM +0000, Phillip Wood wrote:
>> On 28/10/2024 19:09, Caleb White wrote:
>> > A new helper function, `write_worktree_linking_files()`, centralizes
>> > the logic for computing and writing either relative or absolute
>> > paths, based on the provided configuration. This function accepts
>> > `strbuf` pointers to both the worktree=E2=80=99s `.git` link and the
>> > repository=E2=80=99s `gitdir`, and then writes the appropriate path to=
 each.
>>
>> That sounds like a useful change. I think it would be better to pass an
>> extra parameter "use_relative_paths" rather than relying on a global
>> varibale in worktree.c. Thank you for adding some documentaion for the n=
ew
>> function.
>
> Good suggestion. I definitely agree that this is a useful direction.

I didn't particularly care for the global variable either, but that was
the easiest way to get up and running. I don't want to just pass this
parameter around as that will result in changing about 6-7 function
signatures. What are some other ways settings have been propagated
into the internals? Right now, I'm thinking of just using
a getter/setter in the worktree API, which would remove the global
variable.

>> This might be better as a separate step so that reviewers can concentrat=
e on
>> the correctness of write_werktree_linking_files() when reviewing this pa=
tch.
>
> Indeed. This patch (even though the diffstat isn't overly large) is
> somewhat noisy just because of the number of spots that needed to be
> adjusted here.
>
> I wonder if another way to split this up (in addition to what you wrote
> above) might be to introduce the new function and convert one single
> caller in the first patch. Then subsequent patches can go one callsite
> at a time and convert them to use the new function.
>
> That way, each patch is easy-ish to verify in isolation. I know that
> results in some more patches, but I think that the additional clarity I
> imagine we'll get is worth doing so.

Sounds good, I'll split this up into multiple patches for each of the
subcommands. I'll also add the tests for that subcommand in the same
patch for context.

Best,
Caleb


