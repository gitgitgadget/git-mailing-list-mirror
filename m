Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7480C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 20:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7BB208B8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 20:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ulk6V6/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgI2U4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:56:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56322 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgI2U4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 16:56:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D80C876D4;
        Tue, 29 Sep 2020 16:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y7E3A7HnKhMmPdE9AH6j1/IrGEE=; b=ulk6V6
        /4BNziDTSw5bBVXs1UhXQEUX+B+427pLqwQia3ydHzXfF4mPUW1VvC7ddxQqVpjd
        eqbDnwKNIsfG7JPzmlc7hgd7KyiNblztMZMVWlh68csFXlkhnPetEJ/lI6+ri/Hd
        z5DjpNVNtMW6zT8S7sng2uhW3NeKJTf68kbnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FfNvj6hj9ujAdoVbRQkZs45In5q5wfpr
        2F7sASgGFap6Ha98LM0ZtPSXIzcuOl4h9d4PM8yVoa5BJY3dVOsOLjrOLVObQ/3f
        w2h9jqU/tn4i2Qh5nFFf+zQUkOYTKdfK1uy7n9GZFNESUeuwgDscB1lEH1+vgt7w
        /zCXcxi5SI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 945DD876D3;
        Tue, 29 Sep 2020 16:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0E32876D2;
        Tue, 29 Sep 2020 16:56:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH v9 0/6]Finish converting git bisect to C part 2 subset 1
References: <20200924123340.52632-1-mirucam@gmail.com>
Date:   Tue, 29 Sep 2020 13:55:59 -0700
In-Reply-To: <20200924123340.52632-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 24 Sep 2020 14:33:34 +0200")
Message-ID: <xmqq5z7wi9pc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E281992-0296-11EB-9F16-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> These patches correspond to a second part of patch series 
> of Outreachy project "Finish converting `git bisect` from shell to C" 
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> This patch series version is composed by the first six patches of the
> previous version due to a bug discovered during the test stage, that 
> affects the rest of the patches and that needs to be fixed before 
> sending them.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v9-subset1.
>
> I would like to thank Johannes Schindelin for reviewing this patch series
> and to Christian Couder for his advice and help.
>
> General information
> -------------------
>
> * Rebased on 385c171a01, (Fifteenth batch, 2020-09-18).
>
> Specific changes
> ----------------
>
> [4/6] bisect--helper: reimplement `bisect_autostart` shell function in C
>
> * Add `|| exit` to bisect-autostart call in shell script.
>
> ---

This hasn't seen any responses, but seeing the difference between v8
and v9 is so small and obviously good, and there weren't anything
glaringly wrong spotted in v8, I'd say this is ready to advance to
'next'.

Anything I missed in the previous or this review round?

Thanks.

>
> Miriam Rubio (4):
>   bisect--helper: BUG() in cmd_*() on invalid subcommand
>   bisect--helper: use '-res' in 'cmd_bisect__helper' return
>   bisect--helper: introduce new `write_in_file()` function
>   bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
>
> Pranit Bauva (2):
>   bisect--helper: reimplement `bisect_autostart` shell function in C
>   bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
>     functions in C
>
>  bisect.c                 |  13 +-
>  builtin/bisect--helper.c | 269 +++++++++++++++++++++++++++++++++++++--
>  git-bisect.sh            |  70 +---------
>  3 files changed, 274 insertions(+), 78 deletions(-)
