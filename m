Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2ABBA4A
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264830; cv=none; b=JGJlxznBKuvN5uIraKsLl2Hc7UyTlfyfHusEc6tXJzU0GRcYnX/yXkm7lRZdKGwSOV6kLrG2xC+p1EWQHQHXoAlji9oE1hQ1u4x8Lc3VEINPA50qN8y4XLwW9ksCJl+UhwMn9Z5jZzxq4psjF2yuiXWWfteKWF2YnzKGzA2op4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264830; c=relaxed/simple;
	bh=e+/VqPNIO3kNMz7W0QHrDe5BEVMcyDwAOdHW4vdStLE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkBCnRvko0wYXPj1by5YgDdagunlZC2BkoukRt67dx1qByg+/VKVDOWZcBpSdEhpGas21LBzbe+wRTMgb1yRmDAUSgzVbSt0jqdv/WY9t6D7h1SsHRXT5PEHwMCaExtQX1DeMLlYooOK39YX6h/8ZkqI1xd6navVylCX5KIwgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CrHHliVp; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CrHHliVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730264826; x=1730524026;
	bh=6oeViDL/Ervea8O7KP2WqP8N/b+4PbZ0JnOWgNzwuqc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CrHHliVpe2Ih0dsSSboxufAB0672DEQopL3bX87mZ8exFtgZSX42o5a7qsNuCu627
	 50XOyBGU4I83zj5wjvpqCqmFT65U8yrW4jZ4lE/pE5Jh+uXCNeDjC6MvOy+a1P2aJW
	 3PS7XYnPyDqafn54OwUZU0cykuaFn5s0kOg0mNPBoBUKkJfNaSjO+/RFaTqDO0p/2/
	 5hWSM+AeTjL+XMlI5Ot+zEqvbWkp4ayd5GgWbtdAR3zFOdTb5xgN2hPhvZNLwVgrMV
	 kRv8db93qLtTOD1JSA8bW2z9rVtOpv4EcqqkEJoQA4Cf3Oo/gYNpWxEbJK9t8w8lD3
	 H4lJORQD0JoxA==
Date: Wed, 30 Oct 2024 05:07:01 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative path linking
Message-ID: <D58VOSCN68T0.3EZBA39222AUC@pm.me>
In-Reply-To: <ZyEsfpcnAGCg+W6N@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me> <ZyEsfpcnAGCg+W6N@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 5dc2ab0ef3f567006494ee231e244bfc736ed917
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 1:42 PM CDT, Taylor Blau wrote:
> On Mon, Oct 28, 2024 at 07:09:37PM +0000, Caleb White wrote:
>> diff --git a/Documentation/config/worktree.txt b/Documentation/config/wo=
rktree.txt
>> index 048e349482df6c892055720eb53cdcd6c327b6ed..44b783c2774dc5ff65e3fa23=
2b0c25cd5254876b 100644
>> --- a/Documentation/config/worktree.txt
>> +++ b/Documentation/config/worktree.txt
>> @@ -7,3 +7,8 @@ worktree.guessRemote::
>>  =09such a branch exists, it is checked out and set as "upstream"
>>  =09for the new branch.  If no such match can be found, it falls
>>  =09back to creating a new branch from the current HEAD.
>
> I would have thought there would be a blank line in between this and the
> section on worktree.guessRemote. ASCIIDoc doesn't require it because
> this is a labeled list, but it does improve the readability of the raw
> ASCIIDoc itself.
>
> So not a big deal, but if you end up sending out another version of this
> series it would be nice to include.

I'll add the blank line in the next version of the patch.

>> +worktree.useRelativePaths::
>> +=09If set to `true`, worktrees will be linked to the repository using
>> +=09relative paths rather than using absolute paths. This is particularl=
y
>> +=09useful for setups where the repository and worktrees may be moved be=
tween
>> +=09different locations or environments.
>
> This is a good start, but I have a few suggestions on top that I'm
> curious of your thoughts on. First: what is the default? Users
> should have some insight into what the default is. Likewise, they should
> know that that the default behavior does not introduce the repository
> extension, but that setting this configuration to 'true' does.
>
> Maybe something like the following on top?
>
> --- 8< ---
> diff --git a/Documentation/config/worktree.txt b/Documentation/config/wor=
ktree.txt
> index 44b783c277..666cb3c190 100644
> --- a/Documentation/config/worktree.txt
> +++ b/Documentation/config/worktree.txt
> @@ -7,8 +7,13 @@ worktree.guessRemote::
>  =09such a branch exists, it is checked out and set as "upstream"
>  =09for the new branch.  If no such match can be found, it falls
>  =09back to creating a new branch from the current HEAD.
> +
>  worktree.useRelativePaths::
> -=09If set to `true`, worktrees will be linked to the repository using
> -=09relative paths rather than using absolute paths. This is particularly
> -=09useful for setups where the repository and worktrees may be moved bet=
ween
> -=09different locations or environments.
> +=09Link worktrees using relative paths (when "true") or absolute
> +=09paths (when "false"). This is particularly useful for setups
> +=09where the repository and worktrees may be moved between
> +=09different locations or environments. Defaults to "false".
> ++
> +Note that setting `worktree.useRelativePaths` to "true" implies
> +enabling the "relativeWorktrees" repository extension, thus making it
> +incompatible with older versions of Git.

Sounds good to me. I'll update.

>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree=
.txt
>> index 70437c815f13852bd2eb862176b8b933e6de0acf..975dc3c46d480480457ec485=
7988a6b8bc67b647 100644
>> --- a/Documentation/git-worktree.txt
>> +++ b/Documentation/git-worktree.txt
>> @@ -216,6 +216,18 @@ To remove a locked worktree, specify `--force` twic=
e.
>>  This can also be set up as the default behaviour by using the
>>  `worktree.guessRemote` config option.
>>
>> +--[no-]relative-paths::
>> +=09Worktrees will be linked to the repository using relative paths
>> +=09rather than using absolute paths. This is particularly useful for se=
tups
>> +=09where the repository and worktrees may be moved between different
>> +=09locations or environments.
>
> This paragraph is redundant with what you wrote in git-config(1). I
> think all we want to say is that it overrides the setting of that
> configuration variable, and refer users there with linkgit.

I agree. I'll update this paragraph to refer to the config documentation.

>> ++
>> +With `repair`, the linking files will be updated if there's an absolute=
/relative
>> +mismatch, even if the links are correct.
>
> This is worth keeping.

Keeping this as is.

>> +This can also be set up as the default behaviour by using the
>> +`worktree.useRelativePaths` config option.
>> +
>
> This should get folded into my suggestion above.

Done.

>> diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
>> deleted file mode 100755
>> index a3136db7e28cb20926ff44211e246ce625a6e51a..000000000000000000000000=
0000000000000000
>> --- a/t/t2408-worktree-relative.sh
>> +++ /dev/null
>> @@ -1,39 +0,0 @@
>
> Was removing t2408 intentional here? I don't see the tests being
> re-added elsewhere in this patch (though they may be introduced
> elsewhere later in the series, I haven't read that far yet). Either way,
> it may be worth mentioning in the commit message to avoid confusing
> readers.

Yes, this was intentional. This was added in the original round when the
default was changed to use relative paths. I added more comprehensive
tests in the various worktree files to cover the new functionality. I
will make sure to mention this in the commit message.

>> diff --git a/worktree.c b/worktree.c
>> index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..de5c5e53a5f2a758ddf470b5=
d6a9ad6c66247181 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -14,6 +14,8 @@
>>  #include "wt-status.h"
>>  #include "config.h"
>>
>> +int use_relative_paths =3D 0;
>
> I wondered whether 'use_relative_paths' should be static, or if we need t=
o extern it in
> from somewhere else in the tree. But we do, from worktree.[ch], which
> seems reasonable. It would be nice if there was some way to thread that
> into the worktree.h API, but I think that this is a reasonable measure
> to take for now.

I can add a getter/setter to the worktree API so we're not using a
global variable.

>> +
>>  void free_worktree(struct worktree *worktree)
>>  {
>>  =09if (!worktree)
>> @@ -111,9 +113,9 @@ struct worktree *get_linked_worktree(const char *id,
>>  =09strbuf_strip_suffix(&worktree_path, "/.git");
>>
>>  =09if (!is_absolute_path(worktree_path.buf)) {
>> -=09    strbuf_strip_suffix(&path, "gitdir");
>> -=09    strbuf_addbuf(&path, &worktree_path);
>> -=09    strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
>> +=09=09strbuf_strip_suffix(&path, "gitdir");
>> +=09=09strbuf_addbuf(&path, &worktree_path);
>> +=09=09strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
>
> Whitespace change?

Yes, this was added in the original round, I didn't notice that it used
4 spaces instead of a tab. I had fixed this in v4 of the original round,
but this was merged in v3 so I just went ahead and fixed it here.

>>  =09CALLOC_ARRAY(worktree, 1);
>> @@ -725,12 +727,15 @@ static int is_main_worktree_path(const char *path)
>>   * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we=
 may
>>   * be able to infer the gitdir by manually reading /path/to/worktree/.g=
it,
>>   * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
>> + *
>> + * Returns -1 on failure and strbuf.len on success.
>>   */
>>  static int infer_backlink(const char *gitfile, struct strbuf *inferred)
>
> Should this return an ssize_t instead, then? I don't think we're going
> to have worktree paths that are actually larger than INT_MAX, but it
> seems hygienic and good to prevent any accidental overflow issues.

I thought about this, but you'll run into OS limits long before you hit
INT_MAX. However, I can make this change to be hygienic.

Best,
Caleb

