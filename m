Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519F7C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FE964E31
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCQSP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:15:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59912 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhCQSPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:15:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8808A880C;
        Wed, 17 Mar 2021 14:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OfnRbUr0IrcDvvf9wRaUN2DNEcY=; b=IPu+Ob
        SPzBD/D3C3ZUjEim4xiQk/QqgeSBgFqpJ5kbQMR87BJEXy1WnLEJxMf1vuoCuHb4
        CEdOd3NDGuFz2BuJDF3mM5BRblnN4HsoSy96/SpDHRwZUW6Q596sFU2OQoH7f7+n
        NpnHViQ/eyyGOV+8rlFfc3K+iW1I9T2OzIWsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=So9MdXzUd1xwg6oef/kY5ZbsN95IDNqq
        7K5LhrwN2MWBifiDSkOxO+bqFMlo4lrqv+oaxpJT0lbk4lL4I9X3tT6FNJwL4Aeo
        gd2wZ0HFrESRrXnXNbpOHItHkv6GP1BSf4Nbe6TeKCDryyRGrC8TXJ+zGpOZaaj9
        ZHFJs+rIilU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D902FA8807;
        Wed, 17 Mar 2021 14:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD211A87CA;
        Wed, 17 Mar 2021 14:15:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SURA via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, SURA <sura907@hotmail.com>
Subject: Re: [PATCH] builtin/fetch.c: clean tmp pack after receive signal
References: <pull.890.git.1615863217226.gitgitgadget@gmail.com>
        <YFEpGGLBgLSdR40V@coredump.intra.peff.net>
Date:   Wed, 17 Mar 2021 11:15:07 -0700
In-Reply-To: <YFEpGGLBgLSdR40V@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Mar 2021 17:54:32 -0400")
Message-ID: <xmqqsg4twst0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B58AD844-874C-11EB-91E8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 16, 2021 at 02:53:36AM +0000, SURA via GitGitGadget wrote:
>
>> In Gitee.com, I often use scripts to start a time-limited
>
> Not related to your patch, but I think this name falls afoul of Git's
> trademark policy. See:
>
>   https://git-scm.com/trademark
>
> There's also some discussion in this thread:
>
>   https://lore.kernel.org/git/20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net/

Thanks.  On somewhat related to this patch, we also ask contributors
to use their real names so that we do not render the Signed-off-by:
procedure meaningless.

> This isn't quite true. "git gc" will clean up the temporary files, but
> only if the mtime is sufficiently old. The purpose here is to give a
> grace period to avoid deleting a file that is actively being written to.
> However, we use the same grace period that we use for deleting
> unreachable objects, which is absurdly long for this purpose: 2 weeks.
> Probably something like an hour would be more appropriate (since the
> mtime is updated on each write, this would imply a process not making
> forward progress).

I agree that for temporaries the two-week default is way too long,
and I am OK if we decide to shorten the expiration for them
separately from the known-to-be-good-but-unreferenced objects.

> Likewise, we have a tempfile cleanup system already.
>
> I think this hunk:
>
>> @@ -336,6 +339,7 @@ static const char *open_pack_file(const char *pack_name)
>>  			output_fd = odb_mkstemp(&tmp_file,
>>  						"pack/tmp_pack_XXXXXX");
>>  			pack_name = strbuf_detach(&tmp_file, NULL);
>> +			tmp_pack_name = pack_name;
>
> ...can just call register_tempfile(). It should also record the result
> so that we don't try to unlink() it after we've already moved it away
> from its temporary name (though it's fairly unlikely for somebody else
> to have used the name in the interim).
>
> I think you'd want to do the same for the tmp_idx_* files, too. Likewise
> for ".rev" files we create starting in v2.31.
>
> I think it would also make sense in create_tmp_packfile(), which is used
> during repacking (a different problem space, but really the same thing:
> if repacking fails for some reason, we probably shouldn't leave a
> useless gigantic half-finished packfile on disk).
>
> We should possibly also do so for tmp_obj_* files. Those can be written
> for a fetch or push via unpack-objects (as well as normal local
> commands). They're not usually as big as a pack, obviously, but I think
> the same principle applies.
>
>> [...]
>
> It would be nice to see some tests covering this functionality, too.
> Reproducing it with signals is likely to be racy and not worth it. But I
> think that right now index-pack reading a bogus pack (say, one that
> fails fsck checks) will leave the tmp_pack_* on disk. And it would not
> if we cleanup tempfiles (again, this would be on any exit, not just
> signal death, but I think that is what we'd want, and also what
> register_tempfile() will do).

Sounds like a good medium difficulty leftover bit.

Thanks.
