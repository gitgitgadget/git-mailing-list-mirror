Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDCC207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032719AbdDTW64 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:58:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54510 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1032455AbdDTW6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:58:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 705737A04C;
        Thu, 20 Apr 2017 18:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PArQhAbp+ZTR/LFyVzfcHLazasA=; b=pWswau
        +85nLzY74Kcrtz415tvbWR9L5KDP+GCs/9mszOtE0c6fbqC5jMn8sNTX5oUCSUzx
        ohuhMeUEmrT1n1xRY3fzJk5HeUA2HA1vIo9kGPEVyihOSqA8Kjd0AvPsxtWzIDCl
        /dTSsMXAWJN4WjzAXAjmJLHI1LDIQSiAUcldo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L0nHJBXhzp2NmLRqKT/yuTLldSQJKJtv
        hT3gxj9S05aefUzUCCIYZeWzY7vwKnCaZR9LIs3MPvu0HYjedPVjNNfKWXVo1JPh
        BsR1CymkQCdwF8wO4h9xbaMQBJ2Ny5nvBQO6z6RTjwYjJuQD9uiyrY+pxXLOVNH0
        nDcZqUs2fwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67CBD7A04A;
        Thu, 20 Apr 2017 18:58:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F96B7A049;
        Thu, 20 Apr 2017 18:58:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
Date:   Thu, 20 Apr 2017 15:58:52 -0700
In-Reply-To: <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com> (Lars
        Schneider's message of "Thu, 20 Apr 2017 11:48:09 +0200")
Message-ID: <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED0B980C-261C-11E7-959A-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> * bw/forking-and-threading (2017-04-19) 11 commits
>> - run-command: block signals between fork and execve
>> - run-command: add note about forking and threading
>> - run-command: handle dup2 and close errors in child
>> - run-command: eliminate calls to error handling functions in child
>> - run-command: don't die in child when duping /dev/null
>> - run-command: prepare child environment before forking
>> - string-list: add string_list_remove function
>> - run-command: use the async-signal-safe execv instead of execvp
>> - run-command: prepare command before forking
>> - t0061: run_command executes scripts without a #! line
>> - t5550: use write_script to generate post-update hook
>> 
>> The "run-command" APIimplementation has been made more robust
>> against dead-locking in a threaded environment.
>> 
>> Will merge to 'next'.
>
> There might be a problem on Windows with this (that's just a hunch, i can't test this right now):
> https://travis-ci.org/git/git/jobs/223830474

Thanks for keeping an eye on Travis output. My eyes learned to
ignore the Windows section as its failures often seem to be due to
timing out.
