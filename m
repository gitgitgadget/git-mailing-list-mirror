Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8B33E7
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266063; cv=none; b=CMpKhciWs6CX6naLLBLDhJ6ckxzvd2dD2S1OFjnHRtDj6ctTZcaKx/vef9WIpbmeUw1UJV/BEHaifKikK5VX4cSsAKdYaCJNVJtF1ku0JcxUufFWyot3btTkkG3kbznIruIKLEbPp6ZBh7c4++eLTHQELYZEBREB2YMPJ/H3k7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266063; c=relaxed/simple;
	bh=wTholhR22MyejetPhYeKDDR3ufZkZ7nEobbNEHGl/W4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+e5FOyEuYkTF5F/KqnULqLm6S6Wm+ArTH7LTtWtOuxTVhd/wS0lKNz5RgW4Fr5shLCgRvw4JftDskq0bhaV4jcqST+dZ8pQ4Eis3C+VfCoVqmavcbb9l/YddK35EfOfS/An2tDdrdENx478AJZ73ygPcz22lT6xm1bmxop18Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qAGlj9cI; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qAGlj9cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730266059; x=1730525259;
	bh=jbtVSTUZfpF4/Cx0OpTGEqUv0E/3LDpSckJx8m9pMCg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qAGlj9cI+isRUroSuaDIp02Vi/lVInle2tFqJIGcfUy3C9KuWfHbQa/CvxKJXVw91
	 u5wcootuG3U06tyzmHrp7lz5XRhJBoTkSA37pKTxyUqKJhNZyMwEfUUqJzLlxqMmeT
	 kJw4fI0EeaHNax3Uee68R53dt4ANMh2yAuEZzaZx3H3qd46LdJD9Gf4ZEy3ZAF25vB
	 NJmi1UCtY/0U60jDmAn1vq/XfhLW5C2sa2VmDHTqDeZyxf/wSe414Z3Q55uUE6pwOK
	 GiRqULF1OUgDVxdb/o/gSPmjKUZa+anG3M5DiHcF/1nXcbGOPKwcxS9EWkTZeFXhei
	 6H4AbWjffc09g==
Date: Wed, 30 Oct 2024 05:27:33 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative path linking
Message-ID: <D58W4HPIF8VX.2TWFTU2A2VSYY@pm.me>
In-Reply-To: <0bea06b8-11d0-497f-88e1-153cb61eb06d@gmail.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me> <0bea06b8-11d0-497f-88e1-153cb61eb06d@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: fb1e14bed2a5384bcdc85a84691fe3bc279511c8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 9:52 AM CDT, Phillip Wood wrote:
>> This patch introduces the `--[no-]relative-paths` CLI option for
>
> "This patch" is a bit redundant, I'd say "Introduce a
> `--[no-]-relative-paths ..`

I removed "patch".

>> `git worktree {add, move, repair}` commands, as well as the
>> `worktree.useRelativePaths` configuration setting. When enabled,
>> these options allow worktrees to be linked using relative paths,
>> enhancing portability across environments where absolute paths
>> may differ (e.g., containerized setups, shared network drives).
>> Git still creates absolute paths by default, but these options allow
>> users to opt-in to relative paths if desired.
>
> This sounds good, I'm not sure the patch actually implements anything
> other than the option parsing though. I think it would make sense to add
> these options at the end of the patch series once the implementation has
> been changed to support them. I'd start with patches 4 and 5 to add the
> new extension setting first, then refactor worktree.c to handle creating
> worktrees with relative or absolute paths and set the extension if
> appropriate, then add the --relative-path option to "git worktree"

That makes sense, I can reorder the patches as you described.

>> Using the `--relative-paths` option with `worktree {move, repair}`
>> will convert absolute paths to relative ones, while `--no-relative-paths=
`
>> does the reverse. For cases where users want consistency in path
>> handling, the config option `worktree.useRelativePaths` provides
>> a persistent setting.
>>
>> In response to reviewer feedback from the initial patch series[1],
>> this revision includes slight refactoring for improved
>> maintainability and clarity in the code base.
>
> Please don't mix cleanups with other code changes as it makes it hard to
> check that the cleanups don't change the behavior.

Fair enough, I'll separate the cleanups into their own patch.

>> +worktree.useRelativePaths::
>> +=09If set to `true`, worktrees will be linked to the repository using
>> +=09relative paths rather than using absolute paths. This is particularl=
y
>> +=09useful for setups where the repository and worktrees may be moved be=
tween
>> +=09different locations or environments.
>
> I think it would be helpful to spell out the implications of this to the
> user - namely that you cannot use older versions of git on a repository
> with worktrees using relative paths and it may break third-party
> software as well.

I've added a note that you cannot use older versions of Git with
worktrees when using relative paths.

>> +--[no-]relative-paths::
>> +=09Worktrees will be linked to the repository using relative paths
>> +=09rather than using absolute paths. This is particularly useful for se=
tups
>> +=09where the repository and worktrees may be moved between different
>> +=09locations or environments.
>
> Again we should spell out the implications of using relative paths.

This has been revised to simply point to the config docs.

>> +With `repair`, the linking files will be updated if there's an absolute=
/relative
>> +mismatch, even if the links are correct.
>> ++
>> +This can also be set up as the default behaviour by using the
>> +`worktree.useRelativePaths` config option.
>> +
>>   --[no-]track::
>>   =09When creating a new branch, if `<commit-ish>` is a branch,
>>   =09mark it as "upstream" from the new branch.  This is the
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index dae63dedf4cac2621f51f95a39aa456b33acd894..c1130be5890c905c0b648782=
a834eb8dfcd79ba5 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -134,6 +134,9 @@ static int git_worktree_config(const char *var, cons=
t char *value,
>>   =09if (!strcmp(var, "worktree.guessremote")) {
>>   =09=09guess_remote =3D git_config_bool(var, value);
>>   =09=09return 0;
>> +=09} else if (!strcmp(var, "worktree.userelativepaths")) {
>> +=09=09use_relative_paths =3D git_config_bool(var, value);
>
> As we're trying to remove global variables from libgit.a as part of the
> libification effort I'd be much happier if "use_relative_paths" was
> declared as a "static int" in this file and then passed down to the
> functions that need it rather than declaring it as a global in "worktree.=
c".

I can create a getter/setter in the worktree API to handle this, but
I'd rather not pass it as an argument to every function that needs it as
that would be a lot of changes. All of these functions would need their
signatures updated to include the new parameter:

- `add_worktree()`
- `update_worktree_location()`
- `repair_worktree_at_path()`
- `repair_worktrees()`
- `repair_worktree()`
- `write_worktree_linking_files()`

>> diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
>> deleted file mode 100755
>
> There's no explanation for this change in the commit message

I added an explanation for this deletion.

Best,
Caleb

