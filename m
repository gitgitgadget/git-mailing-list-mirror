Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3358EC433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C95239FD
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgLJGNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:13:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56505 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgLJGN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 01:13:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89AE8104A13;
        Thu, 10 Dec 2020 01:12:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ESvXrfdtPzDeGbQvlcC99LZMx8o=; b=VGL6qk
        mKd1mPVSbj0wlQLoP4tDJ1z9yk7T0PQNcUyErm9xXvzNmgBPwFZoh3KhzxdrUu9D
        ktdpx4jaXzgrt+yiWHLfXVp0TBhdVTYmxXV02cF0T0aOnODQ7xd/V2FEt8Q1le03
        TJs3/19v8D3/o4pWskCo8k8UsZ2o0Ak0cSU98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kljuy4KbMDYkv5czxRliESWQz2CW6rsM
        Z4LJSEoLJsD5uSY3PamuSmzcjd0BrFECFeBGUsiP0/afhoq9B0R/Hi4oUa4Iox/g
        3RcpdJceGngcFKHGvFmiErwBq8OYrqL+BGpX2Crr0S1Fo9LrM5DyrJd/S4KoW04d
        LfHF9P2Y4w4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81BED104A12;
        Thu, 10 Dec 2020 01:12:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9B3B104A11;
        Thu, 10 Dec 2020 01:12:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        <xmqqtusv362t.fsf@gitster.c.googlers.com>
        <xmqqpn3j32ka.fsf@gitster.c.googlers.com> <87k0tqdasa.fsf@osv.gnss.ru>
Date:   Wed, 09 Dec 2020 22:12:42 -0800
In-Reply-To: <87k0tqdasa.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        09 Dec 2020 22:44:37 +0300")
Message-ID: <xmqq5z5axk85.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B74549B6-3AAE-11EB-99E3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> My confusion originates from the fact that the code in revision.c sets
> rev->diff to 1 for -c/--cc , while it doesn't set it for -m, and this
> was the case *before* -c/--cc started to imply -p and -m.

Yes, all of this was from cd2bdc53 (Common option parsing for "git
log --diff" and friends, 2006-04-14).  We can see that "-m" is not
treated among the first class citizen in the output of "git show" on
the commit.  Namely, "-m" alone is merely a modifier for "-p" and
does not cause a diff to be generated (in other words, it only
affects the output if used together with "-p").

"git show cd2bdc53:git.c" would give you how "git log" looked like
back then, and how rev.diff field is used.

    static int cmd_log(int argc, const char **argv, char **envp)
    {
    ...

	prepare_revision_walk(&rev);
	setup_pager();
	while ((commit = get_revision(&rev)) != NULL) {
		if (shown && rev.diff && rev.commit_format != CMIT_FMT_ONELINE)
			putchar('\n');

We grab the next commit to show, and if we have already shown
something in the previous iteration, and if we are told to produce
patch output, we put an extra blank line after the patch for the
previous commit.  We omit that extra blank when showing the log
message in oneline format.  And then ...

		fputs(commit_prefix, stdout);
		if (rev.abbrev_commit && rev.abbrev)
			fputs(find_unique_abbrev(commit->object.sha1, rev.abbrev),
			      stdout);
		else
			fputs(sha1_to_hex(commit->object.sha1), stdout);
		if (rev.parents) {
    ...
		}
		if (rev.commit_format == CMIT_FMT_ONELINE)
			putchar(' ');
		else
			putchar('\n');
		pretty_print_commit(rev.commit_format, commit, ~0, buf,
				    LOGSIZE, rev.abbrev);
		printf("%s\n", buf);

... after showing the log message, if we were told to produce diff,

		if (rev.diff)
			log_tree_commit(&rev, commit);

we ask log_tree_commit() to show the patch.

		shown = 1;
		free(commit->buffer);
		commit->buffer = NULL;
	}
    ...

I think the code these days have most of the per-commit logic moved
to log_tree_commit() compared to the code we see above, but the
check at the beginning of log_tree_diff() we have, i.e.

    static int log_tree_diff(struct rev_info *opt, struct commit *...
    {
	int showed_log;
	struct commit_list *parents;
	struct object_id *oid;

	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
		return 0;

directly corresponds to the "if rev.diff is true, then call
log_tree_commit()" in the 2006 code.
