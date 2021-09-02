Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E304C433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2884561054
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347564AbhIBWUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:20:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64257 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbhIBWUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:20:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0632EFB31;
        Thu,  2 Sep 2021 18:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LCNxrKz9OCSPjFsBy6MMJNfhuNfL1zo7RJ87wC
        3fLAs=; b=tSFpek2YyT0Pa5L9JxYSCUEZvrHZpCTQ+Oj/WdgX8CUiRTS5n4Nd7r
        T0me+s+Zw9ZNKvYrEGXYRD/syuvFhwPx4tmVgUYFNzdmv1QbAS1DqFKA8Y6FbCxY
        Pu2CkM/ZqCs9SdKxoOOP4ZUatu3+eH11MDZcOF4t4HouOK1glId4c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6747EFB30;
        Thu,  2 Sep 2021 18:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56E66EFB2F;
        Thu,  2 Sep 2021 18:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v6 3/6] run-command: make `exists_in_PATH()` non-static
References: <20210902090421.93113-1-mirucam@gmail.com>
        <20210902090421.93113-4-mirucam@gmail.com>
Date:   Thu, 02 Sep 2021 15:19:06 -0700
In-Reply-To: <20210902090421.93113-4-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 2 Sep 2021 11:04:18 +0200")
Message-ID: <xmqqk0jyipt1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA077C7C-0C3B-11EC-880C-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Removes the `static` keyword from `exists_in_PATH()` function
> and declares the function in `run-command.h` file.

"Remove" and "declare", as if we are giving an order to somebody
else to make these changes.

> The function will be used in bisect_visualize() in a later
> commit.
>
> Mentored by: Christian Couder <chriscool@tuxfamily.org>
> Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  run-command.c |  2 +-
>  run-command.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index f72e72cce7..390f46819f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -210,7 +210,7 @@ static char *locate_in_PATH(const char *file)
>  	return NULL;
>  }
>  
> -static int exists_in_PATH(const char *file)
> +int exists_in_PATH(const char *file)
>  {
>  	char *r = locate_in_PATH(file);
>  	int found = r != NULL;
> diff --git a/run-command.h b/run-command.h
> index af1296769f..54d74b706f 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -182,6 +182,18 @@ void child_process_clear(struct child_process *);
>  
>  int is_executable(const char *name);
>  
> +/**
> + * Search if a $PATH for a command exists.  This emulates the path search that

The first sentence does not make sense to me.  Isn't this for
checking if a command exists in one of the directories on $PATH?

	Check if the command exists on $PATH.

may make more sense, especially since "search" may hint that the
caller may be able to learn where it exists, which is not the case.

> + * execvp would perform, without actually executing the command so it
> + * can be used before fork() to prepare to run a command using
> + * execve() or after execvp() to diagnose why it failed.
> + *
> + * The caller should ensure that file contains no directory separators.

Consistently use "command" instead of "file" and rename the
parameter in the prototype below from "file" to "command".

Alternatively, you can rewrite the first paragraph above to make
sure that it is clear to the readers that "command" it refers to is
actually the "file" parameter the function takes.  A rewrite of the
first sentence I just rewrote above may become

	Check if an executable "file" exists on $PATH.

which does not look too bad, but "executing the file so it can ..."
and "to run a file using..." smell a bit strange, and that is why I
suggested to consistently use "command" instead.

> + *
> + * Returns 1 if it is found in $PATH or 0 if the command could not be found.
> + */
> +int exists_in_PATH(const char *file);

Thanks.
