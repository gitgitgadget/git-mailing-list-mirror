Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5E9C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EAC64EFD
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhCRVbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:31:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55858 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhCRVar (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 17:30:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40F1AAEEDF;
        Thu, 18 Mar 2021 17:30:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=32r1dAAqI8cyo1S5mAPX0c3UBfI=; b=GK+zy7
        VMkfVTY1By2ykVOx2U1Qmtp8dWwY3Zf4bc3LyVK7sbrDm44rypX7NGPQUQq33z+O
        Yh7zqRF3WvJ1R0QEYqE4jHt6+75JvlIAw8uK26msySXMy1PDnhTdY+hRGCbvCZ1f
        bI9388ily4tkGcPIe67yIkNksAolgX97uCATQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fwI6imG79kjB6ahJcrfe9mhwShvlQmSW
        a6nDz36myUyivoadd/F/TlVVXTPiGi44Rw7w1SB9FFDDK0SHObD3yomn/eUGbW1j
        vnix2Sc4uCKxp3f7GnSlhBmtbHx/VMsYSDtRjHFAglds09hCLuY6/M52QClPgBeq
        i7Nus27YcFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37CB3AEEDE;
        Thu, 18 Mar 2021 17:30:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAF6DAEEDD;
        Thu, 18 Mar 2021 17:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Drew DeVault <sir@cmpwn.com>, Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
        <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
        <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
        <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
        <C9YDEO8Z8J96.262IOS9IW6F39@taiga>
        <YFEh2LxvsSP+x7d2@coredump.intra.peff.net>
Date:   Thu, 18 Mar 2021 14:30:45 -0700
In-Reply-To: <YFEh2LxvsSP+x7d2@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Mar 2021 17:23:36 -0400")
Message-ID: <xmqq4kh8rvy2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3326668A-8831-11EB-A77A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So you definitely need to "somehow" know that a URL is meant to be used
> with Git. And that makes me somewhat sympathetic to your request.

Nicely summarized.  I am also sympathetic to the cause, but I do not
see upside in tucking the information to the URL syntax.  Even if we
limit ourselves to the CI context, I do not see how the repository
location alone is sufficient (e.g. "build the tip of this branch of
that repository every time it gets updated" already needs more than
the repository location).

> The downsides I see are:
>
>   - one of the advantages of straight http:// URLs is that they can
>     accessed by multiple tools. Most "forge" tools let you use the same
>     URL both for getting a human-readable page in a browser, as well as
>     accessing the repository with the Git CLI. I'd hate to see https+git
>     URLs become common, because they add friction there (though simply
>     supporting them at all gives people the choice of whether to use
>     them).
>
>   - I'm also sympathetic to brian's point that there's a wider
>     ecosystem. It's not just "git" that needs to learn them. It's jgit,
>     and libgit2, and many tools that work with git remotes.

Yup.
