Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94AC41F461
	for <e@80x24.org>; Wed, 15 May 2019 05:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfEOFZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 01:25:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50440 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOFZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 01:25:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E00CA14463B;
        Wed, 15 May 2019 01:25:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=abL1bWuU6AP/SW39tAI5FiwiLwc=; b=P0Sa7k
        D6pvZAWMFjfevpyL7xXrB7lGYr7LhZot3MT5IzRGdFH3P7uj+citarMVfxtN26Ka
        Zhk5iYDMy/skUp4a1ho/DM7jZ+k7PSL5eRhUn25QL+X+Bn8/wemaj4rRWgy7QuGi
        YIV6vl2WPnWN4kTnuRkCn9XH2cLYEthFMKH5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U7AL9A4mSfp2L1qJahMsB2XH3LpaSYBY
        seZb9N6Ccz5T7T8JvtK0Ajf7rYLnEQ+4TIi6nu9rN6NTkUVttmZ7vLiqpzqIJw3B
        OIe67fvp4TRud7ELDQuhQky22zK5xuH3vZD0BsJzDyDX+FpFucCavaGX1jnhDQaH
        zUKwRqX5nbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89FD3144639;
        Wed, 15 May 2019 01:25:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92761144631;
        Wed, 15 May 2019 01:25:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Mike Mueller <mike.mueller@moodys.com>
Subject: Re: [PATCH 1/1] p4 unshelve: fix "Not a valid object name HEAD0"
References: <pull.183.git.gitgitgadget@gmail.com>
        <fc580e902bedb92b5caea8047c1ddd1c9fc822f6.1557502383.git.gitgitgadget@gmail.com>
Date:   Wed, 15 May 2019 14:25:00 +0900
In-Reply-To: <fc580e902bedb92b5caea8047c1ddd1c9fc822f6.1557502383.git.gitgitgadget@gmail.com>
        (Mike Mueller via GitGitGadget's message of "Fri, 10 May 2019 08:33:05
        -0700 (PDT)")
Message-ID: <xmqqd0kk70ib.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9BA4B7A-76D1-11E9-BE04-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mike Mueller <mike.mueller@moodys.com>
>
> git p4 unshelve was failing with these errors on Windows:
>
> fatal: Not a valid object name HEAD0
> Command failed: git cat-file commit HEAD^0
>
> (git version 2.21.0.windows.1, python 2.7.16)
>
> The pOpen call used by git-p4 to invoke the git command can take either a
> string or an array as a first argument.  The array form is preferred
> however the extractLogMessageFromGitCommit method was using the string
> form, which makes the caller responsible for escaping the command text
> appropriately (see https://docs.python.org/2/library/subprocess.html)

Rewrite the sentence that begin with "The array form is
preferred...", as it is somewhat unreadable.  "X is preferred
because Y; however Z was using the other one" would be
understandable.

> Somewhat ironically, the carat character is the escape character in

s/carat/caret/ everywhere.

> Windows and so should be escaped (HEAD^^0).  Without the extra carat, the
> OS was passing an escaped 0 to the git command instead, and the git
> command was rejecting the invalid object name "HEAD0"
>
> The behaviour can be confirmed by typing ECHO HEAD^0 at the command-
> prompt, which emits HEAD0.
>
> The solution is simply to use the array format of passing the command to
> fOpen, which is preferred and used in other parts of this code anyway.
>
> Signed-off-by: Mike Mueller <mike.mueller@moodys.com>
> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 5b79920f46..0b5bfcbc5e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -737,7 +737,7 @@ def extractLogMessageFromGitCommit(commit):
>  
>      ## fixme: title is first line of commit, not 1st paragraph.
>      foundTitle = False
> -    for log in read_pipe_lines("git cat-file commit %s" % commit):
> +    for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
>         if not foundTitle:
>             if len(log) == 1:
>                 foundTitle = True
