Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8ECC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJUFqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJUFqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:46:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067B20DB7E
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:46:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A9151CDE1A;
        Fri, 21 Oct 2022 01:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vd2RyYlg6BJY+naW/lCZ3mleAVSmz8XjXG8Qj2
        orkRk=; b=v/inVoenijHc8hAi8s5P4i3ffIcX3uQ8+tDGfXXlbR6dbiR9sTZo7J
        P3XdhbKuPC+0+2/rF2DW50HMkvFkQZLvy/KXwhs9vf6mMbKw4JwHeDhJVArNqQ2n
        ozT11uZLXBtDUDYuKAYDIu7eGYy7h5ZiQGKILgEQNuaGEZKRsDadg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12DAC1CDE19;
        Fri, 21 Oct 2022 01:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B94A1CDE18;
        Fri, 21 Oct 2022 01:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/6] run-command: add pipe_output_fn to
 run_processes_parallel_opts
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
        <20221020232532.1128326-2-calvinwan@google.com>
Date:   Thu, 20 Oct 2022 22:46:17 -0700
In-Reply-To: <20221020232532.1128326-2-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 20 Oct 2022 23:25:27 +0000")
Message-ID: <xmqq4jvxpw46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF209B7E-5103-11ED-B134-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Add pipe_output_fn as an optionally set function in
> run_process_parallel_opts. If set, output from each child process is
> first separately stored in 'out' and then piped to the callback
> function when the child process finishes to allow for separate parsing.

In my review of one of the previous rounds, I asked which part of
this functionality fits the name "pipe", and I do not think I got a
satisfactory answer.  And after re-reading the patch in this round,
with the in-header comments, it still is not clear to me.

It looks more like sending the duplicate of the normal output to a
side channel, somewhat like the "tee" utility, but I am not sure if
that is the intended way to be used.

