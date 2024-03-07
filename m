Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63D130E5D
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834397; cv=none; b=sCrkuiuizKQyaOjaoj+Tj4raiP95B6QebQAGuWrIlXa5/SzkXYrZ/CAoj8e+u3+yFbLItsEdZggvStZI1h5fFLtOmb998WIsdLMR2XUihzMQXvRPA8uPGu7gOgemH55qYW6QSPD/b2ZSTWwnLeP3ezIuTRXdOuOkhQzNUj8EmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834397; c=relaxed/simple;
	bh=PflcLd5zasy+KQ4y7CMh0skBcJNyNK/Lh4Sze82mdhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWkI5O5vcDAzQJMbWZfYEvXv2byalzX6kgnJDEs91zjMCExZ67knyHLc/mbMpVBLKBj+cQjAdVwKlljUQ8/yzrPZuiW73saWklTaC4aXfR6fSRHlkButNt2onnxli04VkvzEoKRVQaa7uPPQKkgSsirph3VvA93iaIquM/ZW2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b0CU/v3n; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b0CU/v3n"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA2EB27EC5;
	Thu,  7 Mar 2024 12:59:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PflcLd5zasy+KQ4y7CMh0skBcJNyNK/Lh4Sze8
	2mdhw=; b=b0CU/v3n7KDQ1Z3S/jzBF2poC+u0Df215tIxgGekL9WyORqTZGdAyW
	ccMg0MRQPb7v/zcV+VN0/Uo2RPc+Ov9quFyXLxRl2jn6tiqWQCyU/Es+m9ZEnA/p
	337Na701D0mFCqDqTpgHphod6KawkXwKdy7/dDM2wCkQcap0rh9pM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B2BFB27EC4;
	Thu,  7 Mar 2024 12:59:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42F7227EBF;
	Thu,  7 Mar 2024 12:59:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
In-Reply-To: <Zelb8ldHh4Lnlh7Z@tanuki> (Patrick Steinhardt's message of "Thu,
	7 Mar 2024 07:17:22 +0100")
References: <cover.1709549619.git.ps@pks.im>
	<02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
	<6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
	<Zehav4V_8GGZG94Q@tanuki> <xmqqedcntj06.fsf@gitster.g>
	<Zelb8ldHh4Lnlh7Z@tanuki>
Date: Thu, 07 Mar 2024 09:59:50 -0800
Message-ID: <xmqqo7bpncrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F46C000-DCAC-11EE-8AB3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> It is consistent. The problem is rather that `mks_tempfile_m()` takes a
> mode as input, but still ends up applying the umask to that mode.

Ah, OK.  

> Thus,
> using that function without a subsequent call to chmod(3P) would end up
> mishandling "core.sharedRepository".

It is understandable because this is meant for tempfile; you want to
create it, expect to use it yourself and not by others, before you
are done with it.  There is no place in this sequence where you need
to open access up to those who share access to the repository.

The rest of the message is primarily for my own education.

I got a bit curious how other parts of the system does this.  For
example, writing an loose object calls git_mkstemp_mode() with 0444
and then finalize_object_file() calls adjust_shared_perm() after it
renames the file to its final name at the end.  A tight umask like
0700 may demote the original 0444 to 0400, but adjust_shared_perm()
expands the 0400 appropriately.

The index file is more interesting.  We bypass the whole mkstemp
thing (as we know the final filename and add .lock after it), and
the call chain looks like this:

    repo_refresh_and_write_index() ->
      repo_hold_locked_index() ->
        hold_lock_file_for_update() ->
          lock_file() ->
            create_tempfile_mode() ->
              open()
              activate_tempfile()
              adjust_shared_perm()
      refresh_index()
      write_locked_index() ->
        commit_locked_index() ->
          commit_lock_file_to() ->
            rename_tempfile().

After we create the file with open() and before returning to the
caller, hold_lock_file_for_update() already sets the permission
bits correctly, so the "committing" phase to rename the written
lockfile into its final place becomes merely a rename without any
futzing with permission bits.

So in short, for a file that we intend to create, write, and then
commit to the final name, we use at least two approaches:

 - Let mkstemp_mode() do its thing, and fix the permission bits
   later with adjust_shared_perm().

 - Let hold_lock_file_for_update() take care of the permission bits.

I sense there might be some clean-up opportunities around here.
After all, lockfile is (or at least pretends to be) built on top of
tempfile, and it is for more permanent (as opposed to temporary)
files, but it somehow wasn't a good fit to wrap new tables in this
series?

Thanks.
