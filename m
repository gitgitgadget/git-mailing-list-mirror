Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E6E20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 22:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbdLEWVU (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 17:21:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752660AbdLEWVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 17:21:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C412B8DC7;
        Tue,  5 Dec 2017 17:21:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4D4EPfyPliDZ/2xbbnWLOixuY3U=; b=WGUgvv
        9Y1uEqHYQZybNvDaA4yB36/ExHNvY+8aNNqgHCkKDMmvpKZABi5xzmohNPq/ALjB
        x8bSyHi3FnyLWDXXuVf2iJbyjqTxfgxILqx/sIhVwf5Qt1zbBEep+VE1fbwYmG8E
        OL/noL+bUmtCTj+wKOE34vLwvOFnEyWfX0Kdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i/kmP+vCP7B5dC4uQSVwNij0fMly09bz
        IagGEqPrkPhCNTVM+JqbhPQGaqz7/ppkLj2H8WFIJxoTVdO87xpp86SuGcoHO5Lx
        n0t5V44EFS3nvBjGlZ6E73MVIaySzTDt6NoJ6q9gYEGQ2pqSjH9GjCgd+pHHaRct
        Ju6hj8k498s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14378B8DC6;
        Tue,  5 Dec 2017 17:21:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82B02B8DC1;
        Tue,  5 Dec 2017 17:21:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH v2 0/9] rebase -i: add config to abbreviate command names
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171205175235.32319-1-liambeguin@gmail.com>
Date:   Tue, 05 Dec 2017 14:21:04 -0800
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com> (Liam Beguin's
        message of "Tue, 5 Dec 2017 12:52:26 -0500")
Message-ID: <xmqq374oizov.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95C79170-DA0A-11E7-B8A6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> This series will add the 'rebase.abbreviateCommands' configuration
> option to allow `git rebase -i` to default to the single-letter command
> names when generating the todo list.
>
> Using single-letter command names can present two benefits. First, it
> makes it easier to change the action since you only need to replace a
> single character (i.e.: in vim "r<character>" instead of
> "ciw<character>").  Second, using this with a large enough value of
> 'core.abbrev' enables the lines of the todo list to remain aligned
> making the files easier to read.
>
> Changes in V2:
> - Refactor and rename 'transform_todo_ids'
> - Replace SHA-1 by OID in rebase--helper.c
> - Update todo list related functions to take a generic 'flags' parameter
> - Rename 'add_exec_commands' function to 'sequencer_add_exec_commands'
> - Rename 'add-exec' option to 'add-exec-commands'
> - Use 'strbur_read_file' instead of rewriting it
> - Make 'command_to_char' return 'comment_char_line' if no single-letter
>   command name is defined
> - Combine both tests into a single test case
> - Update commit messages
>
> Changes in V2:
> - Rename 'transform_todo_insn' to 'transform_todos'
> - Fix flag name TODO_LIST_SHORTE{D,N}_IDS

I've replaced this series and pushed out the result.

Thanks.
