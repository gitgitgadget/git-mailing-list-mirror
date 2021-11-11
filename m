Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9EBC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4E6117A
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhKKWzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:55:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54343 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhKKWzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 17:55:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0426FF32C4;
        Thu, 11 Nov 2021 17:53:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/3dqg2/lrD1n7cgcJpyVl6DgF4QoiRP/W10Jyv
        qxlFI=; b=bB+lcGIL1ZBOkHSJnkUlvXQ5bPSItYAv6MiLnBVZrjeoxe8mJi1yyQ
        fU2L4VU6xiN7XsVjAvb0wniFJqEEK+wILZzETe0ZGOTya29vvQLDsqz8EhnhVj/m
        JcO8o/QsIDtYqCCjcT+q3bPpeDR5ArrwFDbWnZg2QSCi1wACRKG0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E97F4F32C3;
        Thu, 11 Nov 2021 17:53:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37A07F32C1;
        Thu, 11 Nov 2021 17:53:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v2] protocol-v2.txt: align delim-pkt spec with usage
References: <20211027193501.556540-1-calvinwan@google.com>
        <20211111220048.1702896-1-calvinwan@google.com>
Date:   Thu, 11 Nov 2021 14:53:02 -0800
In-Reply-To: <20211111220048.1702896-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 11 Nov 2021 22:00:48 +0000")
Message-ID: <xmqqpmr6jodt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 206C7B2A-4342-11EC-B029-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> The current protocol EBNF allows command-request to end with the
> capability list, if no command specific arguments follow, but the
> protocol requires that after the capability list, there must be a
> delim-pkt regardless of the number of command specific arguments.  Fixed
> the EBNF to match. Both JGit and libgit2's implementation has the
> delim-pkt as mandatory. JGit's code is not publicly linkable, but
> libgit2 is linked below[1]. As for currently implemented commands on v2
> (ls-ref and fetch), the delim packet is already being passed through
>
> [1]: https://github.com/libgit2/libgit2/blob/main/src/transports/git.c

Thanks for an extra level of research. Very much appreciated.

Will queue.

>
> Reported-by: Ivan Frade <ifrade@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  Documentation/technical/protocol-v2.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 21e8258ccf..8a877d27e2 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -125,11 +125,11 @@ command can be requested at a time.
>      empty-request = flush-pkt
>      command-request = command
>  		      capability-list
> -		      [command-args]
> +		      delim-pkt
> +		      command-args
>  		      flush-pkt
>      command = PKT-LINE("command=" key LF)
> -    command-args = delim-pkt
> -		   *command-specific-arg
> +    command-args = *command-specific-arg
>  
>      command-specific-args are packet line framed arguments defined by
>      each individual command.
>
> base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
