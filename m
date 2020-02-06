Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED9C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2BC217F4
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dxhoefkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBFT2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:28:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58760 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFT2h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:28:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AADFCB7C68;
        Thu,  6 Feb 2020 14:28:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FeMB6YI6DgN03E8sZSHOreJmbio=; b=dxhoef
        ktWnzryvRYo06rYwg5mopEnMEO3925LINVht3glLNvPqbzAOhUgMkVa0uqT2BYwb
        VnAPSznJHnIFEC33Zk+GhWDbGsajt5jCb9sDDwWI/7iTpuNzgiIIqrd3TZ5fffqU
        YhKN4U8cmxh+avI984jAN2IBccPWV3L415FFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NpoxEzIqkKTwydWf8M6KL4hRWiZahNZg
        BKpFsm3hhBycAZj/0wbJu/LMXlD0df37c5TBmXp2LFZzoBihhDqp6CB00H00rFO0
        Y1eOgD9RlKOYrnzHwUJf60mb1YhAi+JUuvGhwjIohF+3FKT3W64X42iF72uJQvv4
        jl3G++fRJzc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2909B7C67;
        Thu,  6 Feb 2020 14:28:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9F41B7C66;
        Thu,  6 Feb 2020 14:28:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v3 1/5] git-p4: rewrite prompt to be Windows compatible
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <8881d76c46ce0af9a7e3c9e8d61c718beea24906.1581002149.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 11:28:27 -0800
In-Reply-To: <8881d76c46ce0af9a7e3c9e8d61c718beea24906.1581002149.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Thu, 06 Feb 2020 15:15:44
        +0000")
Message-ID: <xmqqwo8zecro.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DADFCA8E-4916-11EA-99A8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> The existing function prompt(prompt_text) does not work correctly when
> run on Windows 10 bash terminal when launched from the sourcetree
> GUI application. The stdout is not flushed properly so the prompt text
> is not displayed to the user until the next flush of stdout, which is
> quite confusing.

Is that the bug in raw_input(prompt_text) used in the source, or is
that the bug in your environment (whatever "the sourcetree GUI
application" is)?  I cannot quite tell if this is butchering code
that is perfectly working well for other people just to cope with a
broken invoker that is what really needs fixing, or if it is working
around a bug in raw_input().  If the former, the change is not what
we want, and if the latter, the change should go to Python upstream,
so either way, I am not sure if we want this patch without further
information.

Anybody on a similar platform have opinion on this?  I am OK as long
as this change does *not* break the program in an environment that
it is working fine, but that is not even clear.

> Change this method by:
> * Adding flush to stderr, stdout, and stdin
> * Use readline from sys.stdin instead of raw_input.
>
> The existing strip().lower() are retained.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 40d9e7c594..7d8a5ee788 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -175,7 +175,11 @@ def prompt(prompt_text):
>      """
>      choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
>      while True:
> -        response = raw_input(prompt_text).strip().lower()
> +        sys.stderr.flush()
> +        sys.stdout.write(prompt_text)
> +        sys.stdout.flush()

raw_input() is getting replace with input() in another series to
bring us to Python3 compatible world, but because you are getting
rid of its use, as long as the resulting code works with both
Python2 and Python3, we are happy ;-)

> +        sys.stdin.flush()

What does it even mean to flush the input stream here?  At least in
C, it is meaningless and causes an undefined behaviour.

> +        response=sys.stdin.readline().strip().lower()
>          if not response:
>              continue
>          response = response[0]

Thanks.
