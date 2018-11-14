Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C002F1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 14:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeKOAvM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 19:51:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63722 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbeKOAvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 19:51:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA4E0120217;
        Wed, 14 Nov 2018 09:47:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J4nO8fv98JecE88Q4n4ZoFuUZ4s=; b=takSfd
        QSxF/NrUBYpIH07ZMV3e/89zRrWmKjFZjbP+x8Cfmb/cuLuDNMtDpH1aYj7k8e4c
        TVRPVF+raE2a6tRmaz5R1pych9TiRVbFvEXOG64XMFQiPkTehQYbvpbQfmyUry0X
        mOINiRbWwQ/tz0uDz6/5sgRcQJzMKas977VcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uYbBIK2P2kJz8GGFwRlOu+kOtiJO6KN7
        nvCFVzISblSbTwrOOVwVndWS7RyoAeJyhfC7038wH8HcGknOeExNzJ74PPXDkfS8
        1ZIqOTTcygEOOUBd+Br+R+Iz6vAR1EDJBwGEPVaIFItPvICn+sQ8koy1ocVi+0MV
        kPHRZB+thFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A02F0120216;
        Wed, 14 Nov 2018 09:47:35 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DEA612020E;
        Wed, 14 Nov 2018 09:47:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] tests: explicitly use `git.exe` on Windows
References: <pull.73.git.gitgitgadget@gmail.com>
        <cd314e1384312cd5b0c0031efd40c6442074e11c.1542030510.git.gitgitgadget@gmail.com>
        <xmqq5zx0p7ej.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811141422270.39@tvgsbejvaqbjf.bet>
Date:   Wed, 14 Nov 2018 23:47:33 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811141422270.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 14 Nov 2018 14:24:45 +0100 (STD)")
Message-ID: <xmqqefbnn2be.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 392BF390-E81C-11E8-930B-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The latter half of this change is a good one.  Given what the
>> proposed log message of this patch says
>> 
>>     Note also: the many, many calls to `git this` and `git that` are
>>     unaffected, as the regular PATH search will find the `.exe` files on
>>     Windows (and not be confused by a directory of the name `git` that is
>>     in one of the directories listed in the `PATH` variable), while
>>     `/path/to/git` would not, per se, know that it is looking for an
>>     executable and happily prefer such a directory.
>> 
>> which I read as "path-prefixed invocation, i.e. some/path/to/git, is
>> bad, it must be spelled some/path/to/git.exe", I am surprised that
>> tests ever worked on Windows without these five patches, as this
>> line used to read like this:
>> 
>> 	"$GIT_BUILD_DIR/git" >/dev/null
>> 	if test $? != 1
>> 	then
>> 		...
>> 
>> Wouldn't "$GIT_BUILD_DIR/git" have failed (and "executable not
>> found" hopefully won't produce exit code 1) and stopped the test
>> suite from running even after you built git and not under the
>> test-installed-git mode?
>
> "$GIT_BUILD_DIR/git" did not fail until I regularly built with Visual
> Studio (and my Visual Studio project generator generates a directory named
> "git" to live alongside "git.exe").
>
> And when it failed, I patched Git for Windows. Fast-forward, years later I
> managed to contribute the patch we are discussing right now ;-)

OK, I still cannot read it out of what you wrote in the proposed log
message without aid, but in essense the crux of the problem is that
invoking "some/path/to/git" finds "some/path/to/git.exe" only when
there is no "some/path/to/git" directory at the same time, and if
that directory exists, tries and fails to execute that directory,
and the change in this patch protects us from that problem.

Did I get it right?  I'd really prefer to see it more clearly
written in the log message so the next person who reads "git log"
do not have to ask the same question to you.

Assuming that I read it correctly, I think this patch as a whole
makes tons of sense as a change to make the invocation more robust.

Thanks.
