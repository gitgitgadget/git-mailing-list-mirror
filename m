Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B9EC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5FC60FDA
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbhIMVlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 17:41:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54457 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346827AbhIMVk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 17:40:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A93CD6069;
        Mon, 13 Sep 2021 17:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bwlEhfT5dpwLIEagftkc/z0wYHKtb2V/PmZUBo
        IUiG8=; b=cDwvaD4XcTkRryizC6WRD04U3kHlxZVt1Ml3vf0N8OZVjxFXaTIkHM
        hDM8RAfqRYjDPquLcDGp5nGQXL39ouxSiDW3APYUdM4wKKMWZFRME3u3H2O/u6FM
        +SYBj1hcHs7JC4mZCYn3EclJciyaRY0WJw7CVeNoxjqdjOUIkFZOc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21DE6D6068;
        Mon, 13 Sep 2021 17:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B45AD6067;
        Mon, 13 Sep 2021 17:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
References: <20210913194816.51182-1-chooglen@google.com>
Date:   Mon, 13 Sep 2021 14:39:39 -0700
In-Reply-To: <20210913194816.51182-1-chooglen@google.com> (Glen Choo's message
        of "Mon, 13 Sep 2021 12:48:16 -0700")
Message-ID: <xmqqwnnkcfz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19DC2278-14DB-11EC-890D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +Let's write v2 as its own topic branch, because this will make some things more
> +convenient later on. Create the `psuh-v2` branch like so:
>  
> +----
> +$ git checkout -b psuh-v2 psuh
> +----

What's missing here is on which branch this new description expects
the user to work on.  From its name, I am assuming that psuh-v2 will
be modified while leaving psuh untouched, but spell your expectation
out.

The following review is based on the assumption that the user is
expected to futz with psuh-v2, leaving psuh intact.  If that is not
the case, it is a strong sign that you caused confusion on one
reader by not spelling out your expectation.

I do not think it is a good suggestion at all to use a new topic
branch, especially a one that forked from the tip of the original
submission, and work on that branch to produce the new round.  It
would be much better to create a topic branch or a lightweight tag
"psuh-v1" that points at the old tip and keep working on the same
branch.  But that is a separate story.

> +When you're ready with the next iteration of your patch, the process is fairly
> +similar to before. Generate your patches again, but with some new flags:
>  
>  ----
> -$ git format-patch -v2 --cover-letter -o psuh/ master..psuh
> +$ git format-patch -v2 --range-diff psuh..psuh-v2 --cover-letter -o psuh/ master..psuh
>  ----

Before the "Generate your patches again", there would have been
"rebase -i" of the original commits that went into "psuh" (v1).

But you do not necessarily have to touch all the commits during
"rebase -i" session.  What happens when the first few commits did
not need to be touched?

Since the --range-diff says psuh..psuh-v2, these early and
unmodified commits are excluded from the range, no?  That would mean
what appears to be commit #1 in the range-diff on the new side would
not be the [PATCH 1/n] of the output, no?

And the command line says to format master..psuh, which is
puzzling.  Shouldn't it format the updated psuh-v2 branch?

> +The `--range-diff psuh..psuh-v2` parameter tells `format-patch` to include a
> +range diff between `psuh` and `psuh-v2`. This helps tell reviewers about the
> +differences between your v1 and v2 patches.

See above.  The range-diff may fail to tell the fact that there are
a few bottommost commits that are the same by omitting them.

Perhaps it would make it easier to manage if we used psuh-v1 as the
anchoring point to represent where the tip of the last round was?

With something like:

	$ git checkout psuh
	$ git branch psuh-v1 ;# optional -- "git tag" is also OK.
	... work work work with "rebase -i" ...
	$ git format-patch -v2 --cover-letter -o psuh/ \
		--range-diff master..psuh-v1 master..
	# ..psuh-v1 can be ..@{yesterday} or whatever reflog reference

we do not have to worry if "rebase -i" left the bottommost commits
untouched or silly things like that.  

> +The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
> +you may notice that your v2 patches, are all named like
> +`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
> +prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
> +be prefaced with "Range-diff against v1".
> +
> +Afer you run this command, `format-patch` will output the patches to the `psuh/`
> +directory, alongside the v1 patches. That's fine, but be careful when you are
> +ready to send them.

It is unclear what "That's fine, but" is trying to convey.

I'd replace it with something like:

	You can refer to the old v1 patches while giving the final
	proofreading on the v2 patches, but you now need to say "git
	send-email psuh/v2-*.patch" to send them out ("*.patch" would
	match both v1 and v2 patches).

Thanks.
