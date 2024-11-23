Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60886AAD
	for <git@vger.kernel.org>; Sat, 23 Nov 2024 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732340532; cv=none; b=csee7GVjRTpcpZYu3BWqWyN3GGmqMNEJrj4B331mJGprFaCgYOKDHenZR92q3HVXZfTw7GhOKmlOyVF9775qrw4vL4Go0JJc4DGidLymd3pJzgf5q6EchjiKvSzeOx8ifuO7Sk93VXN/IAZnQ9blOitN/t4+fNVB/WgdGZE6mJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732340532; c=relaxed/simple;
	bh=h+43U8B4eNu8dUzeAvIEMQy7iKMvTCKG0jRnJJMI9e0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNyyjZCrtjOxWI+pskDTSIldqHEua9zF6bU+ef9u//8VXn6osiBsuxwbaly3+6QmdrN8ApUfcoyt9jyKfLDTkhOhnYsYnC3lROhmwWS3pOjrkrNhUfx1E3mCCjAsRnNCp/e47Mfq9JfWn0wMzNYienGIYWvIrC35i5++FJX6ekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WKxNBnqn; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WKxNBnqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732340521; x=1732599721;
	bh=n0n2A6CvcdQLS7T5H+9JqBmUqCvUJbLZbhGg4o2wpNE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=WKxNBnqnCsnZkwpyhW0i0mv1rsjSy+uZOspOFpvZ+5FeoxuBdUmuxQcxHe+yPX3Fl
	 PPC8q6mx8cPGSFGjyFUFt3SgQdL6cQgjsxWe05Z0ZBX+KPDGW3XMZEgvVxk5ixBNAk
	 12izMEfYcLnkLbf7ljf0WrwDUDFeFj8bBuwBKaMA/22cQ+QbGlbDmGbcRQRjnpU3sb
	 25bLsy2/OzYyM2CnTNdmpGnaRl66NMCkb2y0a1TqK3Psau51bRZvBaC3+ZY6/B048g
	 UVjHVNEB/cAy+L2GnaaVWylZ1txqsHRyUnmTCQoBsHr5Xenixc3VYVUS8uvPPJksIP
	 KsXTNwpW5doxw==
Date: Sat, 23 Nov 2024 05:41:55 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 7/8] worktree: add relative cli/config options to `repair` command
Message-ID: <D5TBGJS8FWBE.3QYEZWZUS0C71@pm.me>
In-Reply-To: <135739ad-6722-449b-9f9b-31c0bbc9f9cb@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-7-07a3dc0f02a3@pm.me> <135739ad-6722-449b-9f9b-31c0bbc9f9cb@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 2fe1e88d529000b84986c777ac8a7628331f4d42
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 22, 2024 at 9:55 AM CST, Phillip Wood wrote:
> On 01/11/2024 04:38, Caleb White wrote:
>> +test_expect_success 'repair relative worktree to use absolute paths' '
>> +=09test_when_finished "rm -rf main side sidemoved" &&
>> +=09test_create_repo main &&
>> +=09test_commit -C main init &&
>> +=09git -C main worktree add --relative-paths --detach ../side &&
>> +=09echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
>> +=09echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
>> +=09mv side sidemoved &&
>> +=09git -C main worktree repair ../sidemoved &&
>> +=09test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
>> +=09test_cmp expect-gitfile sidemoved/.git
>> +'
>
> These tests looks sensibile, we should probably check that "git worktree
> repair" repects worktree.userelativepaths. I wonder if we have any
> coverage of repair_worktrees() as I think in these tests the problem is
> fixed by repair_worktree_at_path() before we call repair_worktrees().

I'll add a test case for this.

>>   test_done
>> diff --git a/worktree.c b/worktree.c
>> index 6b640cd9549ecb060236f7eddf1390caa181f1a0..2cb994ac462debf966ac51b5=
a4f33c30cfebd4ef 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -574,12 +574,14 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
>>    * pointing at <repo>/worktrees/<id>.
>>    */
>>   static void repair_gitfile(struct worktree *wt,
>> -=09=09=09   worktree_repair_fn fn, void *cb_data)
>> +=09=09=09   worktree_repair_fn fn,
>> +=09=09=09   void *cb_data,
>
> Style wise leaving "fn" and "cb_data" on the same line would be fine.
> That applies to all the functions.

Ah, good to know---I'm used to every argument being on its own line but
I can revert.

>> +=09else if (use_relative_paths =3D=3D is_absolute_path(dotgit_contents)=
)
>> +=09=09repair =3D _(".git file absolute/relative path mismatch");
>
> Comparing ints as booleans makes me nervous in case we have a non-zero
> value that isn't 1 but is_absolute_path() returns 0 or 1 and we know
> use_relative_paths is 0 or 1.

Yes, both are either 0 or 1, so this should be safe.

>>   =09if (repair) {
>>   =09=09fn(0, wt->path, repair, cb_data);
>> -=09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, wt->=
path, &tmp));
>> +=09=09write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
>
> We used to update only the ".git", now we'll update both. In the case
> where we're changing to/from absolute/relative paths that's good because
> we'll update the "gitdir" file as well. In the other cases it looks like
> we've we've found this worktree via the "gitdir" file so it should be
> safe to write the same value back to that file.

Yes, there is an edge case that a file is written with the same (correct)
contents, but I think this is acceptable given that it would be more
complicated to check if the contents are the same before writing (which
would involve reading the file).

>> [...]
>>   void repair_worktree_at_path(const char *path,
>> -=09=09=09     worktree_repair_fn fn, void *cb_data)
>> +=09=09=09     worktree_repair_fn fn,
>> +=09=09=09     void *cb_data,
>> +=09=09=09     int use_relative_paths)
>>   {
>>   =09struct strbuf dotgit =3D STRBUF_INIT;
>> -=09struct strbuf realdotgit =3D STRBUF_INIT;
>>   =09struct strbuf backlink =3D STRBUF_INIT;
>>   =09struct strbuf inferred_backlink =3D STRBUF_INIT;
>>   =09struct strbuf gitdir =3D STRBUF_INIT;
>>   =09struct strbuf olddotgit =3D STRBUF_INIT;
>> -=09struct strbuf realolddotgit =3D STRBUF_INIT;
>> -=09struct strbuf tmp =3D STRBUF_INIT;
>>
>>   =09char *dotgit_contents =3D NULL;
>>   =09const char *repair =3D NULL;
>>   =09int err;
>> @@ -779,25 +783,25 @@ void repair_worktree_at_path(const char *path,
>>   =09=09goto done;
>>
>>   =09strbuf_addf(&dotgit, "%s/.git", path);
>> -=09if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
>> +=09if (!strbuf_realpath(&dotgit, dotgit.buf, 0)) {
>
> This works because strbuf_realpath() copies dotgit.buf before it resets
> dotgit but that does not seem to be documented and looking at the output =
of
>
>      git grep strbuf_realpath | grep \\.buf
>
> I don't see any other callers relying on this outside of your earlier
> changes to this file. Given that I wonder if we should leave it as is
> which would also simplify this patch as the interesting changes are
> swamped by the strbuf tweaking.

I'd like to keep this if that's okay. All of the strbuf tweaking was
so that way there is a consistency the variable names across the
implementations---all the calls to `write_worktree_linking_files()` use
`dotgit` and `gitdir` as the strubuf names so it should be easier to
follow now.

Best,

Caleb

