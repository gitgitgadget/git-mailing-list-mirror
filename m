Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FCD20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033264AbdAJU1B (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:27:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55433 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1031728AbdAJU0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:26:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9166C5F97A;
        Tue, 10 Jan 2017 15:26:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pbEyw0/Ybjo23cHwWX1b8EubnbA=; b=VrsAZN
        CuC99L8VOF/bSzrmlG9fKqZzHbDBWBtVojbgiQnce2wO3JJP2BGZxpvSCk0bndDT
        FNdXfiManBMXM22/FnXngBFidSMis5GQfDKuwFsPRSf8CzjrpENlvNjUByeBP469
        G3uwfS+sY2jrFvfk1qvVAufu9iIcJAcXrQgYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d/TJVG6i2Ef68nz549hXV4zlVgFdEDzY
        38qM4l+E+5NvZu/IVNUlghwX5qsn33ty46KcubmQ76mWu5uUmsjr8WGW/wsisf1p
        v+u8yh5129zaV+GaX/IxieJCLgpekpFyUB+Sdogh4y3kbwi0vvu0+iG6SpXq+F2A
        q+0d3cX0GHs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 880EC5F979;
        Tue, 10 Jan 2017 15:26:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D714A5F978;
        Tue, 10 Jan 2017 15:26:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: git-mergetool to be used for rebases as well?
References: <20170110185421.2638-1-sbeller@google.com>
Date:   Tue, 10 Jan 2017 12:26:47 -0800
In-Reply-To: <20170110185421.2638-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 10 Jan 2017 10:54:21 -0800")
Message-ID: <xmqqvatmr794.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CFDF0B2-D773-11E6-80E0-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>     $ git status
>         rebase in progress; onto ...
>         You are currently rebasing branch '...' on '...'.
>
>         Changes to be committed:
>                 modified:   ...
>
>         Unmerged paths:
>                 both modified:   ...
>
>     $ git mergetool
>         No files need merging
>     $ git diff <file name>
>         diff --cc <file name>
>         index ...
>         --- a/file
>         +++ b/file
>         @@@ ...
>           content
>         ++<<<<<<< HEAD
>          +  content
>         ++=======
>         +   content
>         ++>>>>>>> other commit
>         content
>
>
> The mergetool used to work apparently, but stopped for rebases.
> I noticed in neither t7610-mergetool.sh nor any rebase test the combination of
> rebase and mergetool is tested.

The above redacts too much to be useful for guessing, but are you by
any chance being hit by a recent regression, i.e. have rerere enabled
and running mergetool from a subdirectory?

See <20170109232941.43637-15-hansenr@google.com> (and previous
rounds).
