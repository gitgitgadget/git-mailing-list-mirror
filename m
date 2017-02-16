Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189801FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 20:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbdBPUyL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 15:54:11 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35112 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933105AbdBPUyK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 15:54:10 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so2367674pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZP4GXfqzL+Avbr8e8Vt8FBsQkgBhDKq+RCxrS5p2c1E=;
        b=ED53PZaS9U5DUzhJW+h4pefZMdxa9ed6bYy1nyCr2+OlE9WfPIir8zNMS3Gry6570B
         HesFBMznlYgolx90zJY1H+sOZ6bpGyL2/RQYvxwr+j4phQeyQnhU7cc9s8/LjduF0Nle
         9zpNGFi1b3xjeqH/LbdY852/aUjFZq2M7kGpLGFG77Ma7CzEzlVudhase2eVgOY18Gg4
         QPWIkeZsqS8Wvs4YH/BGgr8i9lebx3jIzYHbvUe3TILy7S8VhUEuSbLClAGPJLw5t8L3
         F4VFYYoCyDaiMzZ3vEOpn9RiDiGr3xWEtbzyFQTeQXB5szi5LKYL7d568oe/R9AxwtWG
         OCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZP4GXfqzL+Avbr8e8Vt8FBsQkgBhDKq+RCxrS5p2c1E=;
        b=CeUXxa+ne3vTM988+wWkREBDrF38sANXUhcZ8HJDb4PQZhSO2xFQ2UAGn+M/egJMoK
         1n4glSf7zO32JZ4s5p2gbuDcPWWMujQMhylKAYdkQOgP72YKCgCS+v3mTAr16jBwqf8f
         DtsJvLDE1aDByEkk5H+YBg5PRqwNYV/Vv7KhPbMXvm3o2C4WS5iJFCdNYLdIDqDVzncS
         ut0YnNrZf35Js89eeYjqsuFgPYx8Om/9Yt/jW77x7uDeoC+BqjJK8vt6TpbVUWrWtqSA
         WWWpjXHMjMK1fgege5YPqQvh0hZ503U614MLMEtMxHk9zFhLQf7BEbB4eZyS5QoP6q9W
         Id+g==
X-Gm-Message-State: AMke39kecjZdolmAX2lLn9zBy39f9EMcEbtUf6z5QvU2K92NqPzZFhdWihUUwLL55SHR9A==
X-Received: by 10.98.44.10 with SMTP id s10mr4945037pfs.161.1487278449922;
        Thu, 16 Feb 2017 12:54:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id l188sm15292723pfl.28.2017.02.16.12.54.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 12:54:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 05/15] connect_work_tree_and_git_dir: safely create leading directories
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-6-sbeller@google.com>
Date:   Thu, 16 Feb 2017 12:54:08 -0800
In-Reply-To: <20170216003811.18273-6-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:38:01 -0800")
Message-ID: <xmqqh93tx3f3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch we'll use connect_work_tree_and_git_dir when the
> directory for the gitlink file doesn't exist yet. Safely create
> the directory first.
>
> One of the two users of 'connect_work_tree_and_git_dir' already checked
> for the directory being there, so we can loose that check.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  dir.c       | 32 +++++++++++++++++++++-----------
>  submodule.c | 11 ++---------
>  2 files changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 4541f9e146..6f52af7abb 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2728,23 +2728,33 @@ void untracked_cache_add_to_index(struct index_state *istate,
>  /* Update gitfile and core.worktree setting to connect work tree and git dir */
>  void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  {
> -	struct strbuf file_name = STRBUF_INIT;
> +	struct strbuf gitfile_sb = STRBUF_INIT;
> +	struct strbuf cfg_sb = STRBUF_INIT;
>  	struct strbuf rel_path = STRBUF_INIT;
> -	char *git_dir = real_pathdup(git_dir_);
> -	char *work_tree = real_pathdup(work_tree_);
> +	char *git_dir, *work_tree;
>  
> -	/* Update gitfile */
> -	strbuf_addf(&file_name, "%s/.git", work_tree);
> -	write_file(file_name.buf, "gitdir: %s",
> -		   relative_path(git_dir, work_tree, &rel_path));
> +	/* Prepare .git file */
> +	strbuf_addf(&gitfile_sb, "%s/.git", work_tree_);
> +	if (safe_create_leading_directories_const(gitfile_sb.buf))
> +		die(_("could not create directories for %s"), gitfile_sb.buf);
> +
> +	/* Prepare config file */
> +	strbuf_addf(&cfg_sb, "%s/config", git_dir_);
> +	if (safe_create_leading_directories_const(cfg_sb.buf))
> +		die(_("could not create directories for %s"), cfg_sb.buf);
>  
> +	git_dir = real_pathdup(git_dir_);
> +	work_tree = real_pathdup(work_tree_);
> +
> +	/* Write .git file */
> +	write_file(gitfile_sb.buf, "gitdir: %s",
> +		   relative_path(git_dir, work_tree, &rel_path));

The above does somewhat more than advertised and was a bit hard to
grok.  Initially I thought the reason why pathdup()s were delayed
was perhaps because you pathdup() something potentially different
from the given parameter to the function (i.e. new code before
pathdup() may tweak what is pathdup()ed).

But that is not what is happening.  I suspect that you did this to
avoid leaking allocated memory when the code calls die().

If the code was written like so from the beginning, I do not see a
reason to move the pathdup() up to deliberately make it leak [*1*].
But as a part of this change, I found it distracting and getting in
the way of understanding the change.  If you really care, it is
nicer to do it to reviewers as a separate preparatory clean-up step,
or follow-up standalone clean-up patch after the series settles.

The comment "prepare config file" was misleading; it is preparing
the place the config file will be created (same for "prepare .git
file").

It is a good thing to do to make sure git_dir_ exists and it should
be mentioned in the log message.  Adding "Do the same for the place
where the per-repo config file is created". at the end of the first
paragraph should be sufficient.

Thanks.


[Footnote]

*1* it is arguable a small piece of unfreed memory before exit() or
    die() is worth called "leak", though.
