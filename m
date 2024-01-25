Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF96341A
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208877; cv=none; b=oj6U9WL7W1I1BEi44+VsAu5OWJqfWjpJlwscKY3gXwTXa+3qNQqx+zoEo3RHPwkCh6jeni8S090V3YNPo7xQ8lvEwlZ7CNsnchg2y5HONW/KbdgoMW0WUmG8JhEUf5yzBBftNRashu1AI6nl/FWnRMjL/QnK9PLK/pjnMzXe8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208877; c=relaxed/simple;
	bh=kPiXhe19mMEJxt8J/7QxRFQ2PeRmiJLZeYfOL8i/UMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jt8gu0TJjKbGqbnsRiw/R2DzcgUvKZZmpJlQz6c3gui6h607WL259dlkhqzdKbryP20CuLpeWVnqIK/wijx4MzBDlAGI9WU0Q7o15sWy9fy3ISzCLsSv2VnH7TANMvybQ03TccUWwX9qPmlRrsncP0anPjvxURsrrSdUD+Ya2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QSUzcp8y; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QSUzcp8y"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 459F61C4440;
	Thu, 25 Jan 2024 13:54:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kPiXhe19mMEJxt8J/7QxRFQ2PeRmiJLZeYfOL8
	i/UMs=; b=QSUzcp8y8xaQu9kdaw012W7TYD0/OFgvhJgGrClGyHKVRte9pHLjg4
	/9uKDd8xfQXt3P8YGeNNWksbuSLShzug4aG9+08sGjP74DPLTaFgDeHJLFHg727N
	yhU2ucnwk06LiUnoHkYx193mHf3pzBCEjgdxhdW3WU1QzKWuHyah8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E25F1C443F;
	Thu, 25 Jan 2024 13:54:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99B561C443E;
	Thu, 25 Jan 2024 13:54:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Frank Schwidom
 <schwidom@gmx.net>,  git@vger.kernel.org
Subject: Re: partial commit of file-to-directory change, was Re: Bugreport
In-Reply-To: <20240120004628.GA117170@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Jan 2024 19:46:28 -0500")
References: <20240119132551.GA31532@debian64>
	<ZasCZ0YetzmlBFvw@tapette.crustytoothpaste.net>
	<20240120004628.GA117170@coredump.intra.peff.net>
Date: Thu, 25 Jan 2024 10:54:32 -0800
Message-ID: <xmqqjznxw8ev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2DC4AE1E-BBB3-11EE-9786-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Jan 19, 2024 at 11:14:47PM +0000, brian m. carlson wrote:
>
>> > $ git commit . -m +
>> > error: 'd' does not have a commit checked out
>> > fatal: updating files failed
>> 
>> I can confirm this behaviour[0], and it's definitely wrong that it
>> thinks `d` is a submodule.  It does, however, work if you do `git commit
>> -m +` (that is, without the .), which makes sense since the relevant
>> change is already staged in the index.
>> 
>> I'm not going to get to a patch or more thorough investigation, but
>> perhaps someone else will.
>
> I peeked at this a bit earlier; I didn't come up with a solution, but
> here are a few more details.

I didn't either X-<, and the thing is somewhat nasty, as there are two
states (HEAD and the index) involved.

 * For paths that do not match the pathspec, we want to take the
   version from the HEAD.  For paths that do match the pathspec, we
   want to take the version from the working tree.  And after making
   the partial commit with such changes, we want to make the same
   change to the index to prepare for the next commit.

 * With the way the code is currently structured, we find paths that
   appear either in the index or in the HEAD to match against the
   pathspec.  This is so that we can honor an earlier "git rm" since
   we read HEAD.

 * Then we check each of these paths that are either in the index or
   in HEAD that matched the pathspec.  If it is missing from the
   working tree, we would remove it from both the temporary ndex
   used for the partial commit, and the real index that we'll
   continue to use after the partial commit.  If it exists in the
   working tree, we would take the contents of it to update.

   For the purpose of this operation, a path D that was a blob in
   the index should be _removed_ when it is a directory in the
   working tree (i.e. made room to create D/F).  And we should not
   add D/F when running "git commit D" or "git commit D/F", because
   the partial commit does not "git add" (it only does "git add -u")

In the example in the discussion, we had D that was a blob and got
replaced with a directory.  If we did "git add -u D", we would just
have removed D from the index, so the partial commit should do the
same.  Which means we need to know the type of the thing we expect.
But list_paths() only returns a list of path names, and does not
give us the type of the thing we expect.  We use the same list
twice, once to update the temporary index (which we create by
reading HEAD) and update the paths listed there from the working
tree.  And the same list is used again to update the real index
(which is what the user had before starting the command) and update
the paths listed there from the working tree.  The tricky part is
that the type of (or even existence of) D may have changed between
the HEAD and the index, but we want to perform the same operation to
the real index with respect to the paths we touched to create the
partial commit.

Naively, add_remove_files() looks like an obvious place to see if
the path is in the working tree (which we already do) *and* compare
it with "the type of the thing we expect", but the thing is that
this function is called twice with different index (once with the
temporary index that started from HEAD, i.e. oblivious to what the
user did to the index since HEAD; then again with the real index
with the changes the user made since HEAD), so we cannot just say
"let's see what this path D is in the index".

I _think_ we would need to update list_paths() so that it records a
bit more than just pathnames that match the pathspec, namely, what
should be done to the path, by doing lstat() on the working tree
paths.

