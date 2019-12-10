Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F8FC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 05:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEEB20663
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 05:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w7lHDRFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfLJFUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:20:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60222 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfLJFUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 00:20:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE6FB1B307;
        Tue, 10 Dec 2019 00:20:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=esUD7EcNUYOmklp9kY/PqgCs2og=; b=w7lHDR
        FxNLOC5aH11iMQTvDozsnT2Lh2ZiEzRFETSTSlr/gzhCBUNL+lH4e5z72kTXLrLV
        s6yqXcvUPdS1b4mWFOUh/rracOujTHXZNejgZEwlWbZyL7pLNb6zJNXx24nN4osl
        1lZsUpHt5aqPRFIRWhxpfIxElJP8x+H/7iWA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FqOuvyuNMLr9tSF1Tok8FTcayL5/cbGY
        25EI7JW0Uzo/d2mx0qfzAZZsqE/ga6PFiQtzfWOqIrkWhq7PBYwwZOPeo39ud3Xa
        FuLRFes079fAwiLyPJKJ/qUDMPkOp6OMj2EcXTJhNqkwoxuGrOkDoLsL3MG43mu0
        EqPkcQCUKcs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E69981B305;
        Tue, 10 Dec 2019 00:20:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DAB01B303;
        Tue, 10 Dec 2019 00:20:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 8/8] test-lib: clear watchman watches at test completion
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
        <e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com>
        <xmqqwob5ru27.fsf@gitster-ct.c.googlers.com>
        <bfa73fab-ce2c-a05e-3568-cd406dd5c31f@gmail.com>
Date:   Mon, 09 Dec 2019 21:20:12 -0800
In-Reply-To: <bfa73fab-ce2c-a05e-3568-cd406dd5c31f@gmail.com> (Derrick
        Stolee's message of "Mon, 9 Dec 2019 20:49:36 -0500")
Message-ID: <xmqqo8wgsqnn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE45A93A-1B0C-11EA-99D1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Hm. That is a good point. Can we assume that our version of grep has
> a "-F" or "--fixed-strings" option? ([1] seems to say that "-F" would
> work.)

$ git grep "grep -F" -- \*.sh

is your friend ;-) 

And never use https://www.gnu.org/ manual as a yardstick---you will
end up using GNUism that is not unavailable elsewhere pretty easily.

> [1] https://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html#index-grep-programs
>
>> What are these stripping of ", and " about?  Could you tell readers
>> how a typical output from the program we are reading from looks like
>> perhaps in the log message or in-code comment around here?
>
> Watchman outputs its list of paths in JSON format. Luckily, it formats
> the output so the path lines are on separate lines, each quoted.
>
> For example:
>
> {
> 	"version": "4.9.0",
> 	"roots": [
> 		"<path1>",
> 		"<path2>",
> 		"<path3>"
> 	]
> }

Yeek; how is a dq in path represented?  by doubling?  by
backslash-quoting (if so how is a backslash in path represented)?
By something else?

It's OK at least for now to declare that our test repository does
not contain any funny paths, but in the longer run does the above
mean that we somehow need to be able to grok JSON reliably in our
tests?  It may not be such a bad thing especially for longer term,
as there are other parts of the system that may benefit from having
JSON capable output readers in our tests (e.g. trace2 code can do
JSON, right?)..

