Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA1C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 22:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F0121835
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 22:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdrDrHqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLQWpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:45:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51166 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQWpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 17:45:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so32351pjb.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 14:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQSTeLc0Q+K0EZpPT6qh8uzYt9ILxoQ+cJ5Q/AOIuds=;
        b=QdrDrHqZFWES33pnpDhNe5mTHBvdLsYA/X6g0z0wRdf8ZOIVUlNehx5UxbRlau7xX8
         6VB5gHmNv4jW23k09fpnS1WtFEqPYLh7DsndbEAjsQFJZmgHz2qXwJNt2lveLaz/x30d
         twdbEoK68B65GHAymbpCwGgeHSu5CEPEsT/GH738Ttv3cU39EfdphFCZqfQhNzeu+xCG
         xPjuF0JUds6O2foZD4MB9pH0B+PwP1/Y1tbgPpVjkC3kI1uDepVWmEO1xM/m/1lVSgK3
         D+KzP78RSCEeQNHWfyBCE65n7Pxc7i1F5y3DFwGElsQcfBswFc3kfphPU0lUAXqdM/M7
         H7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQSTeLc0Q+K0EZpPT6qh8uzYt9ILxoQ+cJ5Q/AOIuds=;
        b=BaAN5MA8nqUWzo6XscoiLrkXI0LI/TrBGNZRPgUc3XVBqk5n1T+tze+ATRnFsoytVB
         mmzuBcE9qL41RYdDty6Zca2h6fKLGw7ypJ4Fquas9PZeKrjpagV0q30nYfN/7u1oMZ2e
         F0ZLZf0VK/MifTWrY0zyX76zRxMJ/yH0sqtMX8eu6oH56d8Hg+9jJUe/8qwdh6N6Y3Ok
         BBgPVJrNXwYd/xsvooDblUYjn1rz7DaFLQQOz0/CeFqbQjsxBccW58hYvEkehdMvqJzl
         H4NB5+jyQa4ZWTtoGA/j6O5tGov78xP/GZWoh7CbChHRgOkg8e0Kv9N/cfE82fuTuXqE
         CY8g==
X-Gm-Message-State: APjAAAV2wfXAA8YD215wEFaq2ilGzKTWgKJCeBFigufkRhWdFxWh0z0F
        KgdrMo41ssV5Td2dNQOzY//w4w==
X-Google-Smtp-Source: APXvYqwqiKS6mdzjxktps1tyrbjga0eP5TEurEeaOCBhbKJFHPM82jm7/t7ORtZgVrf9paN8Ob0Z9A==
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr445243pls.96.1576622746388;
        Tue, 17 Dec 2019 14:45:46 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t187sm59051pfd.21.2019.12.17.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:45:45 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:45:41 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] commit: display advice hints when commit fails
Message-ID: <20191217224541.GA230678@google.com>
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
 <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 09:17:22AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Display hints to the user when trying to commit without staging the modified
> files first (when advice.statusHints is set to true). Change the output of the
> unsuccessful commit from e.g:
> 
>   # [...]
>   # Changes not staged for commit:
>   #   modified:   builtin/commit.c
>   #
>   # no changes added to commit
> 
> to:
> 
>   # [...]
>   # Changes not staged for commit:
>   #   (use "git add <file>..." to update what will be committed)
>   #   (use "git checkout -- <file>..." to discard changes in working directory)
>   #
>   #   modified:   ../builtin/commit.c
>   #
>   # no changes added to commit (use "git add" and/or "git commit -a")
> 
> In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
> 2013-09-12) the intent was to disable status hints when writing to
> COMMIT_EDITMSG, but in fact the implementation disabled status messages in
> more locations, e.g in case the commit wasn't successful, status hints
> will still be disabled and no hints will be displayed to the user although
> advice.statusHints is set to true.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  builtin/commit.c                          | 1 +
>  t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2db2ad0de4..4439666465 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -961,6 +961,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	 */
>  	if (!committable && whence != FROM_MERGE && !allow_empty &&
>  	    !(amend && is_a_merge(current_head))) {
> +		s->hints = advice_status_hints;

Hm. This looks like it turns hints back on specifically for this case,
but might not fix other places where ea9882bfc4 turned them off.

I think the intent of that commit was to not put hints into the editor,
so does it make sense to instead wrap this guy:

  /*                                                                       
   * Most hints are counter-productive when the commit has                 
   * already started.                                                      
   */                                                                      
  s->hints = 0;  

in "if (use_editor)"?

I didn't try it on my end. Maybe it won't help much, because we think
we're going to use the editor right up until we realize it's not
committable?

I wonder which other cases that commit got rid of hints for by accident.

 - Emily

>  		s->display_comment_prefix = old_display_comment_prefix;
>  		run_status(stdout, index_file, prefix, 0, s);
>  		if (amend)
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 46a5cd4b73..3d76e8ebbd 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -382,4 +382,13 @@ test_expect_success 'check commit with unstaged rename and copy' '
>  	)
>  '
>  
> +test_expect_success 'commit without staging files fails and displays hints' '
> +	echo "initial" >>file &&
> +	git add file &&
> +	git commit -m initial &&
> +	echo "changes" >>file &&
> +	test_must_fail git commit -m initial >actual &&
> +	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
> +'
> +
>  test_done
> -- 
> gitgitgadget
