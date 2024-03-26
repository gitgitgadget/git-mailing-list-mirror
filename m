Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E813C831
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490859; cv=none; b=Y/gI8yRuEu3hRgJr7iNSFXiRLaioZYGWYIAKA8gUVuHacwQ0nLA3rxwSETHeQ/fVdIDUTFHcavUHoKbWAsRHbbbIsfX7J8ecGInP+1ro3bb4PylISW9vs5lnobXY5LqjD0R+R4qQgpyzOZkzcq2U9+n2EstPZMrQjDJ/0cWGrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490859; c=relaxed/simple;
	bh=Mr23Ryv04jdbzG6t87yuzJGJos9wQO70D0vzKy/7Tq8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aeJwB4u2Pq5M4fuA0q23VuUwHMiee6JAotxj56u7l5NlT36MWLTgxWYpJQx6MuSFCVJntvW+b/SjRHI8H3rwEN7tZVI66nzssvIarhOwNB90I6VRPxYGOtJb7bfXUNsIoPewISjXZ4b/b4IO6Ee8fvE8ftOnqZ2OYwL3NoK2MLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v6VBdMsU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v6VBdMsU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EA401DA769
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:07:37 -0400 (EDT)
	(envelope-from schwern@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=message-id
	:date:mime-version:to:from:subject:content-type
	:content-transfer-encoding; s=sasl; bh=Mr23Ryv04jdbzG6t87yuzJGJo
	s9wQO70D0vzKy/7Tq8=; b=v6VBdMsUhY9iBs4qXpfDoLoe8+rUsomChPRqonETJ
	PSn2jpmBTulr5bHd5jJWN2r958MzI5lO3VKp1I+2tq/gUA9yjxT5fkYRo+JkeZsT
	y6vcrEaxfgBrCW/FEbHlRQA3j19m7XSvCnE6GgfVDg1qpx5deC94z67PazoIOe0c
	6o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16B561DA768
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:07:37 -0400 (EDT)
	(envelope-from schwern@pobox.com)
Received: from [10.2.197.236] (unknown [84.239.48.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72D9D1DA766
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:07:36 -0400 (EDT)
	(envelope-from schwern@pobox.com)
Message-ID: <ddeef5fe-d208-49e1-bbf1-5563df3dcf51@pobox.com>
Date: Tue, 26 Mar 2024 15:07:35 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Michael G Schwern <schwern@pobox.com>
Subject: Bug: `git check-ignore -v` changes the exit code.
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Pobox-Relay-ID:
 40ED34F4-EBBD-11EE-8F01-78DCEB2EC81B-02258300!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ tree
.
=E2=94=9C=E2=94=80=E2=94=80 dir_b
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 sub
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test
=E2=94=94=E2=94=80=E2=94=80 top

$ cat .gitignore
*

!/dir_b/
!/dir_b/**

$ git status --ignored
On branch main

No commits yet

Untracked files:
   (use "git add <file>..." to include in what will be committed)
	dir_b/

Ignored files:
   (use "git add -f <file>..." to include in what will be committed)
	.gitignore
	top

nothing added to commit but untracked files present (use "git add" to tra=
ck)


What did you expect to happen? (Expected behavior)

$ git check-ignore dir_b/sub/test
$ echo $?
1

$ git check-ignore -v dir_b/sub/test
$ echo $?
1


What happened instead? (Actual behavior)

$ git check-ignore dir_b/sub/test
$ echo $?
1

$ git check-ignore -v dir_b/sub/test
.gitignore:4:!/dir_b/**	dir_b/sub/test
$ echo $?
0

What's different between what you expected and what actually happened?

First, `git check-ignore -v` should have exited with 1 because that is=20
defined as "None of the provided paths are ignored". Exiting with 0,=20
"One or more of the provided paths is ignored", is clearly incorrect.

Second, it's confusing that `git check-ignore -v` shows matches to=20
negation patterns. The documentation says "Instead of printing the paths=20
that are excluded, for each path that matches an exclude pattern, print=20
the exclude pattern together with the path." which seems pretty clear,=20
but then there's this parenthetical... "(Matching an exclude pattern=20
usually means the path is excluded, but if the pattern begins with "!"=20
then it is a negated pattern and matching it means the path is NOT=20
excluded.)" which *implies* -v is also going to show unignored files,=20
but it's unclear.

An additional problem is the use of "excluded" to mean "ignored" and=20
"exclude pattern" which includes negated patterns which include. Oy.

The existence of --non-matching makes this extra confusing. The casual=20
reader can think "non-matching" means "paths which are not ignored"=20
rather than "paths which match no pattern". Again, the misunderstanding=20
hinges on realizing "exclude pattern" includes negated patterns which=20
include.

Anything else you want to add:

`git check-ignore`, `git check-ignore -v`, and `git status --ignored`=20
should all agree at least on what is ignored.

Verbose flags should not change the behavior of a command, they should=20
only add to its output. `git check-ignore` shows only ignored paths=20
while `git check-ignore -v` also shows unignored paths. One could argue=20
only the exit status is the true behavior, but people look at the=20
output. See=20
https://stackoverflow.com/questions/78216866/file-in-the-same-path-one-ca=
n-be-git-trace-but-others-cannot#comment137908188_78216923=20
for a real example of this causing confusion.

I think the issue is that `git check-ignore` is for checking which files=20
are ignored. Users expect --verbose to also show them why their file was=20
ignored, but --verbose also shows unignored files. This is unexpected.=20
The change in the exit status exacerbates the problem.

It would help to talk about "ignored files" rather than "excluded=20
files". It's called "check-ignore" and users edit their ".gitignore" fie=20
and read the "gitignore" docs (.git/exclude being rarely used).

I would also simply say "pattern". This avoids the confusion that=20
"exclude patterns" sometimes unexclude. gitignore only says "pattern"=20
and never says "exclude pattern". This also avoids the confusing=20
"negated exclude pattern", that is just a "negated pattern".

Ideally, I'd make --verbose just show the path + the last matched=20
pattern. Separate flag(s) change what is shown.

-v, --verbose
Print the matching pattern and the path.

-a, --all-matching
Show paths which match any pattern. If the path matches a negated=20
pattern (the pattern begins with "!") it will be shown despite not being=20
ignored.

The current behavior would be `git check-ignore -v -a <path>...`.

If -v has to remain backwards compatible, I would suggest...

-v, --verbose
Print the matching pattern and the path. If the match is a negated=20
pattern (the pattern begins with "!") the path is not ignored.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.3.0 Darwin Kernel Version 23.3.0: Wed Dec 20 21:28:58=20
PST 2023; root:xnu-10002.81.5~7/RELEASE_X86_64 x86_64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
