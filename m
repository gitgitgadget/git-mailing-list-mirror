Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3961A1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNCgi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:36:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62648 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKNCgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:36:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFA6C2E28B;
        Wed, 13 Nov 2019 21:36:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YNlgraXYD4pPNtM3Ia+rnMQ5CMc=; b=HFG+Cg
        WdbbOUb8a3BLXjwk0fCKqlsrxkRJtLbgi0bpxtfx67aRz9J6MZLxx6rtWkICs5W4
        XG90AuKQIpIbVsjjqWs/9aud4XghvooRXWJKxk71d8bD5lQgXvTO9b9OL4dQJ/OV
        KJqLkBoDDOBTe+c69K9dx5kQn05Bm6bfBzkvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fr/eRgkcbeJQqak/vpGqtNZef1LaJpwI
        NLMdl5bnsBXvQnqzDsnttErmfZM3idzStEcqkzqPwYXIc1PDtZRq/xH+Bn6D86jA
        8yuZR51RlGrQiMfqC+TZQlWdNQRojEhVYOikEiNEoB7oIJzVAIv41EQufGHsm4B4
        1/wI157rHY4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6AAF2E28A;
        Wed, 13 Nov 2019 21:36:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B5A42E289;
        Wed, 13 Nov 2019 21:36:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/2] Feature: New Variable git-p4.binary
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
Date:   Thu, 14 Nov 2019 11:36:36 +0900
In-Reply-To: <pull.465.git.1573679665.gitgitgadget@gmail.com> (Ben Keene via
        GitGitGadget's message of "Wed, 13 Nov 2019 21:14:23 +0000")
Message-ID: <xmqq5zjn9oaz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94B1DC5E-0687-11EA-8769-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Issue: Using git-p4.py on Windows does not resolve properly to the p4.exe
> binary in all instances.
>
> Two new code features are added to resolve the p4 executable location:
>
>  1. A new variable, git-p4.binary, has been added that takes precedence over
>     the default p4 executable name. If this git option is set and the
>     path.exists() passes for this file it will be used as executable for the 
>     system.popen calls.
>     
>     
>  2. If the new variable git-p4.binary is not set, the program checks if the
>     operating system is Windows. If it is, the executable is changed to
>     'p4.exe'. All other operating systems
>     (those that do not report 'Windows' in the platform.system() call)
>     continue to use the current executable of 'p4'.

I do not use Windows nor git-p4, but the above two changes make
sense to me at the design level.  One thing that needs to be updated
is the configuration variable, though.  It is more in line with the
other parts of the system to name this "git-p4.program", because
binary-ness does not matter much to you, as long as the named thing
works correctly as "p4" program replacement.

Seeing "gpg.program" is used in a similar way, it also is tempting
to call it "p4.program", but no other parts of Git other than
"git-p4" uses P4, and the "git-p4." prefix is to collect variables
related to "git-p4" together, so calling it "p4.program" may not be
a good idea---it would hurt discoverability.  "git-p4.p4program"
may be OK, if we anticipate that git-p4 may need to use (and its
users need to specify paths to) external programs other than "p4",
but it probably is overkill.

Thanks.
