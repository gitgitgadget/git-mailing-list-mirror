Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8590C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BFC2074F
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wokkObPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgDGPYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:24:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55987 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgDGPYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:24:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07E40447DE;
        Tue,  7 Apr 2020 11:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=myDJSqzxFkTBy6XHcIzSWD9UqJU=; b=wokkOb
        PVBLRzqtrBEVbKkjxK7x92eh1APIyceFPrDfNGUHP+o31fEHvTMHLrzaAGqm5ny1
        F0lPqsJxWA++RnGWE5AW83ec+Wrvm56REeGCbPRn8ZORrsmC/PZilPAxJ4A8xcdC
        NHZBcQrsirQ9FwsIObc5ooMMFCRNeYEj/xzRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WaGo4i1kkgL9+Cu9VgiVg4yWbgV+ts3R
        gRN2DFBjoSpFYsqA08Qbf2f1nrb2oz2Q9gNRbZtM8kA0HqcGe77zOr5EkZLi8FEL
        AxeIstMsE+WXJ0Ifkz5nNqS0RVGZ9DFn7JOPCzAiRetjjH2uYcs0MbuGoWpTuRXE
        YpaHDpiv8cY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1F04447DD;
        Tue,  7 Apr 2020 11:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71F85447DC;
        Tue,  7 Apr 2020 11:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v12 0/5] bugreport: add tool to generate debugging info
References: <20200406224526.256074-1-emilyshaffer@google.com>
Date:   Tue, 07 Apr 2020 08:24:06 -0700
In-Reply-To: <20200406224526.256074-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 6 Apr 2020 15:45:21 -0700")
Message-ID: <xmqqlfn7tj3d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2A0CC72-78E3-11EA-B73C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since v11, reordered tests per SZEDER's comment so that the
> test_when_finished lines come first in each test.
>
> Emily Shaffer (5):
>   help: move list_config_help to builtin/help
>   bugreport: add tool to generate debugging info
>   bugreport: gather git version and build info
>   bugreport: add uname info
>   bugreport: add compiler info

Overall it was a pleasnt read.

Just to avoid misunderstanding, those comments in which I envisioned
a way to report versions and attributes on different parts of "git"
(and I expect we'd be reporting versions and add-ons to tools like
'wish' that runs gitk and git-gui, 'perl' and 'python' in a similar
way---by finding them on the $PATH and asking them who they are) are
NOT "without these, the bugreport tool would not be useful", but "we
will in time need these, so let's keep them in mind" issues [*1*].

So, I am hoping that this is ready to move to 'next'.

Thanks.


[Footnote]

*1* What we saw here in the review showed us a very good starting
point to report the version of the source one binary was built from,
and the compiler and library that binary was built with, and various
attributes of the system that is running that binary.  Thanks to
step [1/5], these helper functions can also be linked to help other
parts of "git" (like the transport) report the first two (some code
may further need to be moved so that they can be called from the
built-ins and standalones).  The system that the binary is running
on would be the same anyway, so there is no need to duplicate that
part of the report.
