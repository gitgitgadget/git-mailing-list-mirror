Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1288C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513F3208A7
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J/VWvGpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFDRSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:18:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58605 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbgFDRSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:18:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6FDEBFCD2;
        Thu,  4 Jun 2020 13:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RxL1wLcOzsc06/kZ7UCZjO9RSww=; b=J/VWvG
        pnyUZvXtGJvCjQ1IbpcZ/YuWXkT4XjGAKKq3/PTfAjSompOkcvadFUWQcsvMc7fr
        fQC6gMLYc+mqW6vQFTovucRz2tW6uM7oiT1UO8lx1bAAGuyzESY30nA/xhETxeze
        z6FB82UnENYNG2bZeZwTt+tU+rZcwY+EWQC/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A/iAIdISk8lUgseNvSSbveS9VBuiFfWv
        AnHfdoUk9xmZ/hbkGozi3v4CHDLK2fE+ahwIKU7jOKcAYXppWoT8QqDMmjxY/hIo
        pIVPEA1hZGE2m2vsl0Z46/KksNFHaw4uQU1mk4o90hnvGq/J9rnC5fbYnnLR00nL
        YB6KoWnrJ+w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E6C0BFCD1;
        Thu,  4 Jun 2020 13:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4054BFCCF;
        Thu,  4 Jun 2020 13:18:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Shaun Case <warmsocks@gmail.com>
Subject: Re: [PATCH] sparse-checkout: avoid staging deletions of all files
References: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com>
        <7c34da8e-87b8-5236-4536-4d8fbc3f1e80@gmail.com>
        <CABPp-BFmFd7gxN7cd04GFD9kCFEMbfXdv7dHCYRB4z21AUpZWQ@mail.gmail.com>
Date:   Thu, 04 Jun 2020 10:18:33 -0700
In-Reply-To: <CABPp-BFmFd7gxN7cd04GFD9kCFEMbfXdv7dHCYRB4z21AUpZWQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 4 Jun 2020 08:05:06 -0700")
Message-ID: <xmqqsgfapx5i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BE995B4-A687-11EA-A70F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> My only comment on the test case is to see if you could use
>> the "check_files" macro instead of "ls". See 761e3d26
>> (sparse-checkout: improve OS ls compatibility, 2019-12-20)
>> for details.
>
> I attempted to do so initially, but that function fails badly when
> there are no files (other than the "hidden" files '.git', '.', and
> '..') in the directory.  The reason for this comes from the "printf
> '%s\n' *" -- the glob won't match anything and so it prints a literal
> asterisk, which is not helpful.
>
> I thought about writing an asterisk out to the expected file for
> comparison, but that just made the testcase look confusing.

Maybe.  It is clear that the implementation ignores the possibility
that it can be asked to check for an empty directory.

    list_files() {
            # Do not replace this with 'ls "$1"', as "ls" with BSD-lineage
            # enables "-A" by default for root and ends up including ".git" and
            # such in its output. (Note, though, that running the test suite as
            # root is generally not recommended.)
            (cd "$1" && printf '%s\n' *)
    }

The comment does not even talk about the possibility that glob '*'
may fail to glob anything.

Instead of letting the macro spend an extra subprocess, using ls
ourselves but in a bit more defensive way would help?  I.e.

	...
	# nothing checked out, expect "No such file or directory"
	! ls clone_no_checkout/* >actual &&
	test_must_be_empty actual
	test_path_is_missing clone_no_checkout/.git/index
	...


