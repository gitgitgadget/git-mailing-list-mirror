Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D456C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiBJQfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:35:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiBJQfx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:35:53 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55303128
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:35:54 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D69517FDB7;
        Thu, 10 Feb 2022 11:35:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jWNvY0NOPEuCkFR5lnPaizY3ZYaTNXopE87cv7
        lEzyI=; b=RKJpPi0hDETo0p0kneItNRd7NjBwiJ3VyWIyVGPfCv2vIiL8uS8ffz
        2MDY/bJa4sZV1waWkP2kF9RSfJIdeXogAaLoELvdULZeQJlv06DszPGgUl9PbVLr
        5uTEY2/90+8um04WvGMzWDX92dLFXjyzZ6ktbrlWNgBwOtfkkxW4g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 447EE17FDB6;
        Thu, 10 Feb 2022 11:35:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A138717FDB5;
        Thu, 10 Feb 2022 11:35:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
References: <xmqqczjvxy3o.fsf@gitster.g>
        <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
Date:   Thu, 10 Feb 2022 08:35:47 -0800
In-Reply-To: <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 10 Feb 2022 07:50:37 -0800")
Message-ID: <xmqqiltmwufw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80C1854E-8A8F-11EC-9640-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>    One thing that makes me worried somewhat is what I did not touch,
>>    namely, how pseudo refs are defined.  I know MERGE_HEAD is very
>>    special and it may be impossible to coax it into refs API for
>>    writing, so the text there makes sense for it, but there are
>>    other all-caps-and-directly-under-dot-git-directory files like
>>    ORIG_HEAD and CHERRY_PICK_HEAD that are written using the refs
>>    API, so the description would have to be updated there.
>
> I'm not quite following; why would the description need to be updated?
>  Sure MERGE_HEAD is written without using the refs API, but we didn't
> mention how the pseduorefs were written in the description, and all of
> MERGE_HEAD, CHERRY_PICK_HEAD, ORIG_HEAD, REVERT_HEAD get written
> per-worktree so doesn't "pseudorefs like MERGE_HEAD" cover it as far
> as the reader is concerned?

Here is how pseudo refs are defined.

[[def_pseudoref]]pseudoref::
	Pseudorefs are a class of files under `$GIT_DIR` which behave
	like refs for the purposes of rev-parse, but which are treated
	specially by git.  Pseudorefs both have names that are all-caps,
	and always start with a line consisting of a
	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
	pseudoref, because it is sometimes a symbolic ref.  They might
	optionally contain some additional data.  `MERGE_HEAD` and
	`CHERRY_PICK_HEAD` are examples.  Unlike
	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
	be symbolic refs, and never have reflogs.  They also cannot be
	updated through the normal ref update machinery.  Instead,
	they are updated by directly writing to the files.  However,
	they can be read as if they were refs, so `git rev-parse
	MERGE_HEAD` will work.

Points that may need to be looked at in the world where files
backend is not the only ref backend are:

 - "are ... files under `$GIT_DIR`" may no longer be true, once some
   of them are stored in reftable, for example.

 - "followed by whitespace" may be an irrelevant detail for the
   purpose of this paragraph.

 - CHERRY_PICK_HEAD, as written in sequencer.c::do_pick_commit(),
   use update_ref() to write a named file out, so "followed by
   whitesspace" (and other cruft, like MERGE_HEAD does) certainly
   does not apply.

 - Also "cannot be updated through the normal ref update machinery"
   is no longer true.  sequencer.c::do_pick_commit() even calls
   update_ref() with REF_NO_DEREF to ensure "cannot be symbolic
   refs".

 - "never have reflogs" would make sense for the current set of
   pseudorefs (does reflog on CHERRY_PICK_HEAD, for example, have
   real use case?), but I do not know if it stays that way.  I do
   not care too deeply either way, but I want to avoid over
   specifying things.

What worries me the most is that we cannot simply say "all-caps
names that end with '_HEAD' all behave like refs except that they
will not be symrefs without reflog." MERGE_HEAD is the only known
exception if I am not mistaken, and I am OK to single it out as an
oddball.  The current description however gives that there are a lot
more differences _among_ pseudorefs.


