Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677982421A
	for <git@vger.kernel.org>; Thu, 16 May 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876339; cv=none; b=iwahHMLfwHtw48ZaMxYE8VDeYOeRpLvRNLaSC3lhI3jZSk/ot8wMdGOTJ1t1/9O7R1wqhwKYAhBkR1MjdVstXTXScC8FgDsc/oNZRuGdJ4kVhnnbRETKooPrFlNbK79PPaOBDZx9KwxjEcbV212MD9Ax80KA2o+A2K6tgI1/Jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876339; c=relaxed/simple;
	bh=Sj9us/ah14hKDqPxb5OzG0HQDe/Fy0K/T4mD80b4W4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Izo4TazGBvlIgjxVy/dDGp+hWGmWQn+ED4XBbmvUuwz1aPebOz/4QL4G2Fv2r+gatj7U1wyDt/IKBQQno6sGN4ehf9e+46mZMRq2ZJCD7NKUetffe+8c9I+n6efPWZdv6xKmcSTJWioChk5u1Acaf8275PjzyRcYZfs+IZpUxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YKpiB+cG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YKpiB+cG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17F44264BB;
	Thu, 16 May 2024 12:18:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Sj9us/ah14hKDqPxb5OzG0HQDe/Fy0K/T4mD80
	b4W4g=; b=YKpiB+cGoSMtpbGh840p4+/6bxZfT6I1z7fSlKXqay9WmFlQZAHnSC
	zOdPJTO6QoBtbp0FfH+hWId81gnbHipoH6PICGZraYoXL6CrWdKGP30nsBHNA76p
	qzq0DGE/1WmcbrhtuOvB5c59/IBgowLcYKnZcl2GOt68stI+FlVu0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E286264BA;
	Thu, 16 May 2024 12:18:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C120264B9;
	Thu, 16 May 2024 12:18:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH v2] merge: avoid write merge state when unable to write
 index
In-Reply-To: <pull.1731.v2.git.1715836731784.gitgitgadget@gmail.com> (Kyle
	Zhao via GitGitGadget's message of "Thu, 16 May 2024 05:18:51 +0000")
References: <pull.1731.git.1715836120584.gitgitgadget@gmail.com>
	<pull.1731.v2.git.1715836731784.gitgitgadget@gmail.com>
Date: Thu, 16 May 2024 09:18:54 -0700
Message-ID: <xmqq7cftspap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE0A5FB2-139F-11EF-BF1F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Zhao <kylezhao@tencent.com>
>
> Currently, when index.lock exists, if a merge occurs, the merge state
> will be written and the index will be unchanged.

"Currently, " is superfluous in this project, as by convention our
proposed log message begins with an observation of the current
status (and "what's wrong in it" follows) in the present tense.

My guess, from reading the tests, of the situation this patch
attempts to handle is something like this?

    When running a merge while the index is locked (presumably by
    another process), the merge state is written in SUCH and SUCH
    files, the index is not updated, and then the merge fails.  This
    leaves the resulting state inconsistent.

> If the user exec "git commit" instead of "git merge --abort" after this,
> a merge commit will be generated and all modifications from the source
> branch will be lost.

I do not think this is accurate description of the "an user action
can make it worse".  In reality, if the user runs "git commit", a
safety kicks in and they get:

    fatal: Unable to create '.../.git/index.lock': file exists.

In fact, your "How to reproduce" below the three-dash line removes
the stale index.lock file before running "git commit".

    From this state, if the index.lock file gets removed and the
    user runs "git commit", a merge commit is created, recording the
    tree from the inconsistent state the merge left.

may be a better description of the breakage.

But stepping back a bit, I do not think this extra paragraph is
needed at all.  If there were a competing process holding the
index.lock, it were in the process of updating the index, possibly
even to create a new commit.  If that process were indeed running
the "git commit" command, MERGE_HEAD and other state files we write
on our side will be taken into account by them and cause them to
record a merge, even though they may have been trying to record
something entirely different.  So regardless of what _this_ user,
whose merge failed due to a competing process that held the
index.lock file, does after the merge failure, the recorded history
can be hosed by the other process.

In any case, to prevent the other "git commit" process from using
"our" MERGE_HEAD and other state files to record a wrong contents,
the right fix is to make sure everybody who takes the lock on the
index file does *not* create any other state files to be read by
others before it successfully takes the lock.  That will also
prevent "git commit" we run after a failed merge (and removing the
lockfile) from recording an incorrect merge.

I do not offhand know if returning 2 (aka "I am not equipped to
handle this merg e at all") is a good way to do so, but if it is,
then the patch given here is absolutely the right thing to do.

>...
>     How to reproduce:
>     ...
>     git merge source-branch
>     rm .git/index.lock
>     git commit -m "4"

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index e5ff073099a..f03709ea4be 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -236,6 +236,16 @@ test_expect_success 'merge c1 with c2' '
>  	verify_parents $c1 $c2
>  '
>  
> +test_expect_success 'merge c1 with c2 when index.lock exists' '
> +	test_when_finished rm .git/index.lock &&
> +	git reset --hard c1 &&
> +	touch .git/index.lock &&

Do not use "touch" when the timestamp is not the thing we care
about.  In this case, you want that file to _exist_, and the right
way to do so is

	>.git/index.lock &&

which already appears in t7400 (it uses a no-op ":" command, but
that is not needed).

Other than that, the patch looks good to me.

Thanks.
