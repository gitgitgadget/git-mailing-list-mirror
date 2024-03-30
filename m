Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7CEAC6
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711817360; cv=none; b=A2cQx2KMCYfuuDaMw9tzyuDHJN9qXguq8oe6PUeulC5jfQnwrXA3OV/N8XeDATJiIS3cgCl7My0eYmYUOhIHioIPgTAsu3GPUDrnyWwFzLvcQXtyHCMVBSMhtsre4k7QS9Pz+PWHFnEb8j2S7+O0pOwwFI+yWLpJS386KyKJTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711817360; c=relaxed/simple;
	bh=YUvSIoNr1Ti3srInkw2D+70CmqHtSAblFkQuNE2ZjUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSL9trPBQaUhjX5472cb2brftOjP/3T+dY7qWimkd5ZoDBGZ7kHit2d4cwgtAYOcCqUPDT8xNdwli2vgfvFGtugOmTaLcOU7YW2Q/JHN9V/BrC4g6F7YAzWFm24qWtYrqk1MFMUSvcw6GbkcIZQExx/Eg2yhIzkj3mCnaWupYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YeOY/KXI; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YeOY/KXI"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19B111EE104;
	Sat, 30 Mar 2024 12:49:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YUvSIoNr1Ti3srInkw2D+70CmqHtSAblFkQuNE
	2ZjUo=; b=YeOY/KXIJySJ/KN8JCj0mFT1RhGcfI4vfRHUMe19nS63i7ugrHVxwJ
	VrogFG+cRFlbapcs4RjLhgjg4I9FL2opcvb771weLvVzHx3FAEccnNQVgDPhr3jI
	yUdcJyOM4Q15K0IuXLKizxBissgVE9xXILaAW92GkZOWduJwAvaow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 103761EE102;
	Sat, 30 Mar 2024 12:49:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A93F1EE101;
	Sat, 30 Mar 2024 12:49:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] builtin/add: error out when passing untracked
 path with -u
In-Reply-To: <b3j7l2ncstdiaxojtollxddmxvkbbeciou25yptguttr5qugmx@y3bzqbdxkyaw>
	(Ghanshyam Thakkar's message of "Sat, 30 Mar 2024 19:48:11 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240329205649.1483032-5-shyamthakkar001@gmail.com>
	<xmqqzfugvhnf.fsf@gitster.g>
	<b3j7l2ncstdiaxojtollxddmxvkbbeciou25yptguttr5qugmx@y3bzqbdxkyaw>
Date: Sat, 30 Mar 2024 09:49:15 -0700
Message-ID: <xmqqh6gnmzqs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 72059A0E-EEB5-11EE-88F4-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> On Fri, 29 Mar 2024, Junio C Hamano <gitster@pobox.com> wrote:
>> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>> > +	if (take_worktree_changes)
>> > +		exit_status |= report_path_error(ps_matched, &pathspec);
>> 
>> Hmph, are we sure take_worktree_changes is true only when
>> add_renormalize is false?
>> 
>> >  	if (add_new_files)
>> >  		exit_status |= add_files(&dir, flags);
>> 
>> If report_path_error() detected that the pathspec were faulty,
>> should we still proceed to add new files?  This is NOT a rhetorical
>> question, as I do not know the answer myself.  I do not even know
>> offhand what add_files_to_cache() above did when pathspec elements
>> are not all consumed---if it does not complain and does not refrain
>> from doing any change to the index, then we should follow suite and
>> add_files() here, too.
> Sorry if I'm missing something, but in your last line after '---', do you mean
> that we should proceed even after report_path_error() detected error like in
> the above patch or perhaps something like this:

We roughly do:

	if (add_renorm)
		exit_status |= renorm();
	else
		exit_status |= add_files_to_cache();
+	if (take_worktree_changes)
+		exit_status |= report_path_error();
	if (add_new_files)
		exit_status |= add_files();

I was wondering if we should refrain from adding new files when we
exit_status is true to avoid making "further damage", and was
wondering if the last one should become:

	if (!exit_status && add_new_files)
		exit_status |= add_files();

But that was merely because I was not thinking things through.  If
we were to go that route, the whole thing needs to become (because
there are other things that notice errors before this part of the
code):
	
	if (!exit_status) {
		if (add_renorm)
			exit_status |= renorm();
		else
                	exit_status |= add_files_to_cache();
	}
	if (!exit_status && take_worktree_changes)
		exit_status |= report_path_error();

	if (!exit_status && add_new_files)
		exit_status |= add_files();

but (1) that is far bigger change of behaviour to the code than
suitable for "notice unmatched pathspec elements and report an
error" topic, and more importantly (2) it is still not sufficient to
make it "all-or-none". E.g., if "add_files_to_cache()" call added
contents from a few paths and then noticed that some pathspec
elements were not used, we are not restoring the previous state to
recover.  The damage is already done, and not making further damage
does not help the user all that much.

So, it was a fairly pointless thing that I was wondering about.  The
current behaviour, and the new behaviour with the new check, are
fine as-is.

If we wanted to make it "all-or-none", I think the way to do so is
to tweak the final part of the cmd_add() function to skip committing
the updated index, e.g.,

         finish:
        -	if (write_locked_index(&the_index, &lock_file,
        +	if (exit_status)
        +		fputs(_("not updating the index due to failure(s)\n"), stderr);
        +	else if (write_locked_index(&the_index, &lock_file,
                                       COMMIT_LOCK | SKIP_IF_UNCHANGED))
                        die(_("unable to write new index file"));
 
And if/when we do so, the existing code (with or without the updates
made by the topic under discussion) needs no change.  We can do all
steps regardless of the errors we notice along the way with earlier
steps, and discard the in-core index if we saw any errors.

The renormalize() thing is not noticing unused pathspec elements,
which we might want to fix, but I suspect it is far less commonly
used mode of operation, so it may be OK to leave it to future
follow-up series.

Thanks.
