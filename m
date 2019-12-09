Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D295C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2342068E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgnIPmH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLIUZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:25:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62621 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLIUZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:25:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73C479F7E9;
        Mon,  9 Dec 2019 15:25:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V5Gft9JzVPnAzCsB1qQtYK2Uc2A=; b=jgnIPm
        H5JuAp1U8ijUAQGo9wWAovzeCe1Q8omBRVWP5XxfzSJTxgVsb3G55kPXoEEdvr7J
        t1I9iS/RIfBHW/ghaBPGdWWOYkEvPnKikaApEeamfCgDBiMUzA13lY+MDq5/ShKQ
        Vg2gZXb7dNvMa0iozmM2NiyAYMv9+s/DTWgJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jFewJWUh0FH2FGMMHdvodw2KU6YIz6v1
        dkHGV9IcixEYEqtIpAu/u/UbHywvAR2G2ji6QPKKOuUafaWAWMmRrX5mY1q/lLZZ
        KMCmIs7/tjQWi3AGsNwA0+7tpppgNrS5bAySOKV5u2Xt+JHhMBb358vwNuH1dd+b
        FvxZMEmCzrc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BA1C9F7E8;
        Mon,  9 Dec 2019 15:25:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90DDC9F7E6;
        Mon,  9 Dec 2019 15:25:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v5 04/15] git-p4: change the expansion test from basestring to list
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
        <7170aface2270e8c46439c5c1e01d2b18cdf6fd0.1575740863.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 12:25:42 -0800
In-Reply-To: <7170aface2270e8c46439c5c1e01d2b18cdf6fd0.1575740863.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Sat, 07 Dec 2019 17:47:32
        +0000")
Message-ID: <xmqq8snlutyx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13C89C3C-1AC2-11EA-9795-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The original code used 'basestring' in a test to determine if a list or
> literal string was passed into 9 different functions.  This is used to

s/literal/a &/, probably, but I do not thin this is about "literal"
at all.  Perhaps "if a list or a string was passed ..." is what you
meant, as the code seems to have two ways to represent a command
line in the program, one as a single string with possibly multiple
tokens on it, separated with IFS and quoted just like you would feed
to shell, and the other as a list of strings, each element being a
single argv[] element for the command to be invoked.

So the issue is that isinstance(X, basestring) used to be how you
are supposed to see if X is a "string", and the logic were built
around "if we have a string, then keep the command in a string when
manipulating, and otherwise what we have must be a command line in a
list".  But because Unicode string is not an instance of basestring,
the logic no longer work, so you'd flip the polarity around to use
"if it is not a list, then we must have a command in a string".

Which makes sense.

> determine if the shell should be invoked when calling subprocess
> methods.

This is mostly true, but the use in p4_build_cmd() and the second
use among the two uses in p4CmdList() are different.

	Some codepaths can represent a command line the program
	internally prepares to execute either as a single string
	(i.e. each token properly quoted, concatenated with $IFS) or
	as a list of argv[] elements, and there are 9 places where
	we say "if X is isinstance(_, basestring), then do this
	thing to handle X as a command line in a single string; if
	not, X is a command line in a list form".

	This does not work well with Python 3, as there is no
	basestring (everything is Unicode now), and even with Python
	2, it was not an ideal way to tell the two cases apart,
	because an internally formed command line could have been in
	a single Unicode string.

	Flip the check to say "if X is not a list, then handle X as
	a command line in a single string; otherwise treat it as a
	command line in a list form".

	This will get rid of references to 'basestring', to migrate
	the code ready for Python 3.

or something like that?

