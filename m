Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C11C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 03:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC08C221EB
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 03:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nbb5GaJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375125AbgJWD5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 23:57:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61877 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375112AbgJWD5k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 23:57:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5F198583E;
        Thu, 22 Oct 2020 23:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JFO9BSDH2ZIafpoT86JY4psQwYE=; b=Nbb5Ga
        J4ZcK20hZxotumjN0UWDllIS52YUuXjeCXbeu7GkLvyxDpCUq1IMA/qNLi0HwV4L
        aajVAhbTN0kN4rkiYqD7SaKyXVDU+MgQAt8RSTJC8Ih9oZsytRXl6RCzycVhDPyC
        Gnan/kfT3XlpSULVgrCe1pZEhG955vFJ3GhP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gz29+ovr0juQU9snRTXi5GEprs+Ych+6
        RC3A9ojeGvZjCwa2xmhDt8MwRrh7NSc6wGosLy3VGFld1N/vBEFdqaG8yne42r9J
        aBzAvRsgWCoMoY/N9nQUSM2VzR1FHp2n66oUpfZIBsQO76b10CPH2I9Hpr9Lt2DD
        IP/3dW8jc7s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D676C8583D;
        Thu, 22 Oct 2020 23:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EBA58583C;
        Thu, 22 Oct 2020 23:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: demonstrate difference between 'am' and 'apply'
References: <20201016205232.2546562-1-emilyshaffer@google.com>
        <20201016205232.2546562-3-emilyshaffer@google.com>
        <xmqqk0vpalcy.fsf@gitster.c.googlers.com>
        <20201022231311.GE2774782@google.com>
Date:   Thu, 22 Oct 2020 20:57:36 -0700
In-Reply-To: <20201022231311.GE2774782@google.com> (Emily Shaffer's message of
        "Thu, 22 Oct 2020 16:13:11 -0700")
Message-ID: <xmqqtuulk30v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3A0B43C-14E3-11EB-8609-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> As "git apply" is primarily meant to work on "git diff" output, and
>> it does not necessarily work on an arbitrary mbox (think: MIME), I
>> do not think "if you do not want to make commit, use apply" is a
>> good suggestion to begin with.  They serve completely different
>> purposes and take different form of inputs.
>
> Okay. I think I use 'git am' to apply individual mails, which also can
> be applied with 'git apply';

Yes for 'am', sometimes for 'apply' (think: MIME).

> "This command applies patches from email (e.g. the output of 'git
> format-patch', or an mbox), preserving metadata and creating commits.

Yeah, something like that.  

    This command takes a mbox, each message in which is a piece of
    e-mailed patch, which typically is output of `git format-patch`.
    For each message, the patch text is applied to the current
    branch and recorded as a commit, with the authorship information
    and log message taken from the e-mailed message.

> Use <git-apply> to apply patches (e.g. the output of 'git format-patch'
> or 'git diff') to the worktree without creating commits."

Calling 'git format-patch' output 'patches' the same way as 'git
diff' output is inviting confusion.  The plural 'patches' makes
the confusion worse.

    Use `git apply` when you have diff (e.g. `git diff` output) to
    use to modify the working tree files and optionally the index.

Thanks.
