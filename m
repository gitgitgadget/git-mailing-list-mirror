Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53C44C77
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912787; cv=none; b=uhMPhWv/v6CjboLQ66t9O73src/VARTOPaqEDNt5FSEgV1oTvqRCUa9+QP1pf7DSIJ2LJPqiKebDqESJZVoKzDtAF5nQtHchQ7VIElG6Gb62rKTKkc9B4YhCyhVPfNem7+Mbzsoe26HHhHCdQKJ7GlsTHJ2AybKjXg1W5T4PSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912787; c=relaxed/simple;
	bh=loQYMlgQrz1zuVO41i6BgW1xgL588+ltyTnI/rf/q/8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJRdJwd3hZgdbHXJ2WIXGw2/+K0X9OcWyQGRCp4eXskZzvtovrKype9Kq2CtAx5dhLD9HX0H4ozMxsZuLG1FVDCM6DorZtYxXg389DwretgbwSRoolCvuwaCyTPl132u3lDP14kCGcYupudNLisX9qjKQ9TgkqekkRavwpN/5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=A08jgM0W; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="A08jgM0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732912782; x=1733171982;
	bh=hBPYJ7s8j8pbrJ0mgJWnujwyJB7udOneiMc9owjY0Co=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=A08jgM0WIFu0et6uDkjb39gyELHHzrSWt1JY2dNf4iLMXxEYy5lzhUVw+Cc/yHISG
	 g/fL6GvcyTAvoQw4+nue8XlAgrdbhxdmPhQjYXVIwo3uY3j7riuAkGU7RuLwKtVBFa
	 +cfdE8HvvH7PbsP+TTCKufkTXc8PV0LAJqJdTj5mgj63DnQje9rnD9XFUQejOQbCya
	 E91q1pNJx7TPf3+E/2dnxXUCZBqEPdnXG6buRtTyoXvqjy+W+EhECTBGZN0w+1rwve
	 E1L4uaT0e5sbAAU0oQKtv0/Zgh5hbPwUelaxEYjOKv90+ozmeyXYpsM0DJkHQs3UCz
	 DTUI6+usoLdKA==
Date: Fri, 29 Nov 2024 20:39:36 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
Message-ID: <D5YYB5XQF1QG.1T6WKWPNUVXX2@pm.me>
In-Reply-To: <Z0n6uuNdQZCLqAz2@ArchLinux>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me> <Z0mgAt9ssu_32tTQ@ArchLinux> <D5YSBQXU7FYD.25KOIM1N3US88@pm.me> <Z0n6uuNdQZCLqAz2@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d3d49cbf636fa906e982fa1b1d463f5f4dfc7c10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 29, 2024 at 11:32 AM CST, shejialuo wrote:
> On Fri, Nov 29, 2024 at 03:58:16PM +0000, Caleb White wrote:
>> On Fri Nov 29, 2024 at 5:05 AM CST, shejialuo wrote:
>> > I somehow understand why we need to append a hash or a random number
>> > into the current "id" field of the "struct worktree *". But I don't se=
e
>> > a _strong_ reason.
>> >
>> > I think we need to figure out the following things:
>> >
>> >     1. In what situation, there is a possibility that the user will
>> >     repair the worktree from another repository.
>>
>> This can happen if a user accidentally mistypes a directory name when
>> executing `git worktree repair`. Or if a user copies a worktree from one
>> repository and the executes `git worktree repair` in a different reposit=
ory.
>>
>> The point is to prevent this from happening before it becomes a problem.
>
> If we could prevent this, this is great. But the current implementation
> will cause much burden for the refs-related code. In other words, my
> concern is that if we use this way, we may put a lot of efforts to
> change the ref-related codes to adapt into this new design. So, we
> should think carefully whether we should put so many efforts to solve
> this corner case by this way.

I'm not sure that any of the ref related code would need to change,
all the tests are passing and the ref code uses the worktree id
for anything worktree related.

> I somehow know the background, because we have allowed both the absolute
> and relative paths for worktree, we need to handle this problem.

This edge case exists when using absolute paths, so this is not
a consequence of now allowing relative paths.

>> >     2. Why we need to hash to make sure the worktree is unique? From t=
he
>> >     expression, my intuitive way is that we need to distinguish whethe=
r
>> >     the repository is the same.
>>=20
>> How do you propose to distinguish whether the repository is the same?
>
> I am sorry that I cannot tell you the answer. I haven't dived into the
> worktree. I just gave my thoughts above.

That's fine, I'm just not really sure about how such a thing would be
done. To me, the unique id is the easiest and most intuitive. The
repository generally has no knowledge of other repositories on the
system (as far as I am aware).

>> Do you have any sources for these tools? Because I'm not aware of any.
>> Any tool that needs the actual worktree id should be extracting the id
>> from the `.git` file and not using the worktree directory name.
>
> I am sorry that my words may confuse you here. These tools are just the
> git builtins. Such as "git update-ref" and "git symbolic-ref".

Ah, I understand now---I thought you were talking about external tools.
All internal git builtins use the worktree id, the actual directory name
of the worktree is inconsequential. So nothing should need to change.

>> > In other words, there is no difference between the worktree id and
>> > worktree name at current.
>>
>> This is NOT true, there are several scenarios where they can currently d=
iffer:
>>
>> 1. git currently will append a number to the worktree name if it already
>>    exists in the repository. This means that you can create a `develop`
>>    worktree and wind up with an id of `develop2`.
>> 2. git does not currently rename the id during a `worktree move`. This
>>    means that I can create a worktree with a name of `develop` and then
>>    execute `git worktree move develop master` and the id will still be
>>    `develop` while the directory is now `master`.
>> 3. a user can manually move/rename the directory and then repair the
>>    worktree and wind up in the same situation as 2).
>>
>
> Thanks for this information. I am not familiar with the worktree. I just
> have learned the worktree when doing something related to the refs. So,
> it is true that worktree id and worktree name are not the same.
>
> But that's wired. For any situation above, it won't cause any trouble
> when the user is in the worktree. Because the user could just use
> "refs/worktree/foo" to indicate the worktree specified ref without
> knowing the worktree id.
>
> So if a user moves the path from "worktree_1" to "worktree_2" and wants
> to do the following operation in the main worktree:
>
>     ```sh
>     git update-ref refs/heads/master \
>         worktrees/worktree_2/refs/worktree/foo
>     ```
> It will encounter error, because the worktree id is still the
> "worktree_1".
>
> But when the user create the worktree using the following command:
>
>     ```sh
>     git worktree add ./worktree_1 branch-1
>     ```
>
> The name `worktree_1`(path) will be the worktree id. So, when moving the
> path "worktree_1" to "worktree_2". The user won't know the detail about
> the worktree id. The user (like me) will just think that "worktree_2"
> will be the new worktree id.
>
> That does not make sense. It's impossible for the user know the mapping
> between the worktree name and worktree id.

It's not impossible, the user can always look in the `.git` file.
However, I have added the id to the `worktree list` output to more easily
associate the id with the worktree.

>> One thing we can do is to add the worktree id to the `git worktree list`
>> output so that users can see the id and the name together. This would
>> make it easier for users/tools obtain the id if they need it without
>> having to parse the `.git` file.
>>
> This is a good idea, if we need to use this way. And we may also need to
> add documentation.

I have implemented this and added documentation.

> As you can see from above, the main problem is that we allow some ref
> interactions between the main-worktree and linked-worktrees.
>
> The reason why I use this example is that I am afraid that the user will
> create a new symbolic ref in the main worktree which points to the
> linked-worktree ref.
>
> When the user create a worktree, it is natural to think that there is no
> difference between the worktree id and the worktree name. And will use
> "worktrees/<worktree_id>/refs/worktree/foo" to access the ref in the
> worktree.
>
> And It's OK to add hash / random number to the worktree id if worktree
> is totally independent. However, at now, we allow some interactions
> between the main-worktree and linked worktrees (even the linked
> worktree and another linked worktree).
>
> When doing above, the user must know the worktree id. But at now
> worktree name is not the same as worktree id.
>
> So, I don't know...

Interactions between the main and linked (and linked with other linked)
worktrees is not a limiting factor here.

>> As stated above, git already appends a number to the worktree name if it
>> collides with an existing directory. Always appending a unique suffix
>> should actually make things simpler / more consistent in the long run
>> because the worktree id will always be different from the name instead
>> of occasionally being different.
>
> In general, I agree with your way now after knowing the truth that
> worktree name is not the same as the worktree id. However, it seems that
> the situation is a little complicated.

I see where you're coming from, but I do not believe that the situation
is any more complicated than it already is. All internal git code uses
the worktree id which is already not guaranteed to be the same as the
worktree directory name, so nothing is changing on that front.

Best,

Caleb

