Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F0C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EAD6104F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbhHEUha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:37:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63766 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbhHEUha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:37:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D6061413D1;
        Thu,  5 Aug 2021 16:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ir3++GK9JtyFNdjm9Tz/AnDPc2Yew82bW364VP
        4LVko=; b=FY/ycGwo/JVZmA1f8TzdyhVSSuGv/Pl8dgS5Ugh1Ltb+W9em+jD7Mj
        uRnt8Gb+i5lkBCmCuycXv6VAkpVDWKbAvvgtKwW9YfBy/VTCK/gqI8ZO09IOT2pz
        61GDPUE1PxBuepZVdG/GWa4+3xpFmem3tQCYfY7pcIsWQU9RAC+sY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53B011413CE;
        Thu,  5 Aug 2021 16:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2428F1413CD;
        Thu,  5 Aug 2021 16:37:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC] [PATCH v2 4/9] dir: libify and export helper functions
 from clone.c
References: <20210805071917.29500-1-raykar.ath@gmail.com>
        <20210805074054.29916-1-raykar.ath@gmail.com>
        <20210805074054.29916-5-raykar.ath@gmail.com>
Date:   Thu, 05 Aug 2021 13:37:10 -0700
In-Reply-To: <20210805074054.29916-5-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 5 Aug 2021 13:10:49 +0530")
Message-ID: <xmqqim0jk4qx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9840AA4-F62C-11EB-A27F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> These functions can be useful to other parts of Git. Let's move them to
> dir.c, while renaming them to be make their functionality more explicit.

Hmph, guess_dir_name_from_git_url() is not all that more clarifying
than the original, at least to me.  For a file-scope static helper,
it probably was good enough with a short name with no function doc,
but we should describe what it does in comments in dir.h and come up
with a suitable name, taking input from that description.

> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  builtin/clone.c | 118 +-----------------------------------------------
>  dir.c           | 114 ++++++++++++++++++++++++++++++++++++++++++++++
>  dir.h           |   3 ++
>  3 files changed, 119 insertions(+), 116 deletions(-)

Again "show --color-moved" helps to see that these two helper
functions are moved across files without any change other than the
names, which is good.

> @@ -1041,8 +927,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (argc == 2)
>  		dir = xstrdup(argv[1]);
>  	else
> -		dir = guess_dir_name(repo_name, is_bundle, option_bare);
> -	strip_trailing_slashes(dir);
> +		dir = guess_dir_name_from_git_url(repo_name, is_bundle, option_bare);
> +	strip_dir_trailing_slashes(dir);

So, what does this new public helper function guess?  The name of
the function says it guesses a directory name, but it is not just
any directory name, but a directory with some specific meaning.

Here repo_name has the URL the user gave "git clone", and even
though there are some code before this part that computed on the
variable, it hasn't been modified.  And "from_git_url" is a good way
to indicate that that is one of the input the function uses to guess
the name of "the directory with some unknown specific meaning".

I think this codepath wants the new directory to create as the
result of "git clone" operation in "dir".  So, even though I still
do not have a good answer to the earlier "this is not just any
directory but with some specific meaning---what is it?" question,
adjectives that are appropriate for the "directory" to answer it
may be along the lines of "new", "resulting", "cloned", etc.

> diff --git a/dir.h b/dir.h
> index b3e1a54a97..76441dde2d 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -453,6 +453,9 @@ static inline int is_dot_or_dotdot(const char *name)
>  
>  int is_empty_dir(const char *dir);
>  

We would want docstring here for the function (and possibly rename
the function to clarify what kind of "dir" we are talking about).


> +char *guess_dir_name_from_git_url(const char *repo, int is_bundle, int is_bare);
> +void strip_dir_trailing_slashes(char *dir);
> +
>  void setup_standard_excludes(struct dir_struct *dir);
>  
>  char *get_sparse_checkout_filename(void);

Thanks.
