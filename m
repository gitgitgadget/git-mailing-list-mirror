Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE58C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 13:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2B3224F8
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bmYVnKKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfLENzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:55:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63538 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLENzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 08:55:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B816195EF;
        Thu,  5 Dec 2019 08:55:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vXxYgk6wu47pq8GiIUxeO/2nPkM=; b=bmYVnK
        KiRuGzZUFq3eA8v/swTj//R9uIo9iZBrCEL8cbyXvLgKyFZauf3z19MYnGpZrgBZ
        GJ4Y668fh/EDWIdvXKPXTzvXQLLREEg29AonUCTi9HiAPPOw3uDczC/8T310rj5v
        1cXKBIYq+QaqW8m/1xza5iUH5asWCGeHxhGuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wRH4njfVJZq6S9TXBumKiHRwOTu4uCv0
        vQOjXzLtgEoHGfnxiOrHsihTAJhtT5KSKlf9yLeGMVwUsMZialppZyBI31cKpakI
        P3AlEp6cDwJKr711FN6YQMt/43uiqBaPnHljJ4zq4avH/EyKTsQo/Cqvt5W6xHvp
        XkEWA+U32XQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22F1A195EE;
        Thu,  5 Dec 2019 08:55:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 680BD195ED;
        Thu,  5 Dec 2019 08:55:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v4 08/11] git-p4: p4CmdList  - support Unicode encoding
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <e1a424a955071414a634a703a85f1969f968bb0f.1575498578.git.gitgitgadget@gmail.com>
Date:   Thu, 05 Dec 2019 05:55:14 -0800
In-Reply-To: <e1a424a955071414a634a703a85f1969f968bb0f.1575498578.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Wed, 04 Dec 2019 22:29:34
        +0000")
Message-ID: <xmqqk17a27y5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD421188-1766-11EA-BF8F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> The p4CmdList is a commonly used function in the git-p4 code. It is used to execute a command in P4 and return the results of the call in a list.

Somewhere in the midway of the series, the log message starts using
all-caps AS_STRING and AS_BYTES to describe some specific things,
and it would help readers if the first one of these steps explain
what they mean (I am guessing AS_STRING is an unicode object in both
Python 2 and 3, and AS_BYTES is a plain vanilla string in Python 2,
or something like that?).

> Change this code to take a new optional parameter, encode_data that will optionally convert the data AS_STRING() that isto be returned by the function.

s/isto/is to/;

This sentence is a bit hard to read.

This change does not make the function optionally convert the input
we feed to the p4 command---it only changes the values in the
command output.  But the readers cannot tell that easily until
reading to the very end of the sentence, i.e. "returned by the
function", as written.

We probably want to be a bit more explicit to say what gets
converted; perhaps renaming the parameter to encode_cmd_output may
help.

> Change the code so that the key will always be encoded AS_STRING()

s/key/key of the returned hash/ or something to clarify what key you
are talking about.

> Data that is passed for standard input (stdin) should be AS_BYTES() to ensure unicode text that is supplied will be written out as bytes.

"Data that is passed to the standard input stream of the p4 process"
to clarify whose standard input you are talking about (iow, "git p4"
also has and it may use its standard input, but this function does
not muck with it).

