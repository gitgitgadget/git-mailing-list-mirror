Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB8A20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbcJDRbL (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:31:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752537AbcJDRbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:31:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55B44415B4;
        Tue,  4 Oct 2016 13:31:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NiReoCDGOfHVfFuyqBOrRN0uLS8=; b=JvlxTZ
        zb9vaNQLDB4mEVYLBPnsHJbl/ZIy1fLWe3tT8rC6QJJs4yYrZd9B3GaOi21HJG7p
        Jm33agWo3aZfyqvqOl1QgzdzNNwh694NgU+EKYgdXR+XHoEVoC62m8OO7j9LJxHA
        DUpjn6zJLpWYJ21LC8ph8bXniSr4CVBq7nHw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qId1uWJBiJS4x15iXIT2jzlXbkwLvq5h
        Okq7hBu9zaD6Dl27R9VW6UW7tkkN0XcaXbS8C3O+Xh3geI+4JIUj8NlvKEzZfvPi
        lE9xYWNVfonk9EOvz/T/rSSRa1bZmtlflcLgRGiwBuhKf2IGC/kq2LkSUzvwFd4D
        WP00NDkpWv4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E688415B3;
        Tue,  4 Oct 2016 13:31:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA0A9415B2;
        Tue,  4 Oct 2016 13:31:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jeremy Morton <admin@game-point.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reference a submodule branch instead of a commit
References: <57F29FEF.30700@game-point.net>
        <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
        <20161004113625.GB20309@book.hvoigt.net>
        <CAGZ79kZWtAU6YG4Qz9_Gwk2db5L2kPCCKrN+64hMYDovRjiLRw@mail.gmail.com>
Date:   Tue, 04 Oct 2016 10:31:06 -0700
In-Reply-To: <CAGZ79kZWtAU6YG4Qz9_Gwk2db5L2kPCCKrN+64hMYDovRjiLRw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Oct 2016 10:07:09 -0700")
Message-ID: <xmqqshscuilh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56253458-8A58-11E6-9E9A-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>
>> We already have options to support these kinds of workflows. Look at the
>> option '--remote' for 'git submodule update'.
>>
>> You then only have to commit the submodule if you do not want to see it
>> as dirty locally, but you will always get the tip of a remote tracking
>> branch when updating.
>
> I wonder if we could make that convenient for users by not tracking
> the submodule,
> i.e.
> * we have the information in the .gitmodules file
> * the path itself is in the .gitignore
> * no tree entry
>
> Then you can update to the remote latest branch, without Git reporting
> a dirty submodule locally, in fact it reports nothing for the submodule.
>
> It sounds like a hack, but maybe it's worth looking into that when
> people want to see that workflow.

It IS a hack.  

But if you do not touch .git<anything> file and instead say "clone
this other project at that path yourself" in README, that would
probably be sufficient.
