Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4CFC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D76920692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc7+Zw08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfLIQIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:08:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45089 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:08:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so16767403wrj.12
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YTqO0FcgD22BkY0tV+yrkpyAnOJZla4wwOwoQ57bAwY=;
        b=Fc7+Zw08Iw0725IF0RMiKm47yFDJqr3eHiTvDeRD3Z8ohAzEU/jb/XOb1efpFE8S6u
         SR2gi9p32z/lBUAa7cWetOY3ZVjX0OvXcY9ayckefiZJeFafxkVM/X95H7ExvKuefJQm
         WYABSVE7NQZ2LS/jfXdQfk0HlPCxRKx6cjsQ3ZoMF2Y+sYl2W8BXs/p1zG76xjglfENm
         XbKNJYd/mGFBnIDLM2CD8ysUY7Fts75C5b7zKHW+mRQvnpOR3At9Kh6+9RdtOfTynSNi
         tU0n1JTWqxrS1+N/k1wXaPw97lQCCzLbJdM26hqug3QHOAqWKbbzcpV+W2vi2q9iqPBN
         09VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YTqO0FcgD22BkY0tV+yrkpyAnOJZla4wwOwoQ57bAwY=;
        b=C5zP7Q+abSO4PXKf1VYkpPAvlYhbLHwE7+VLEGnP0vB4wdz+7MOYlFtvzQRtbwjpUZ
         IMF0Oyq/Iw0kLMtteqPZkeHh80Z/8xQ6OOG4vEIepSgAHHA1IYCBE1hSbv22LGphC2Qr
         3ZENBHpDX8UEg1EJSvbiJTtR06Ai5cRV7gPHPwTMxcDAWajmW1nccVNL3r6e0VOiu5aR
         Zrd/IeYc5As8tXo1iJqtjPyETPZHfLmXuZCeDq7Niwt4GPv7RsQm1EoG02u7x/433TWO
         1xnPgKSRPpG78GKIa/gwk/5BzMvHkpjFt+4gdI6YBh37RGLd+sP74yMhsTw9tNu2Omy7
         PZjQ==
X-Gm-Message-State: APjAAAXsWCvXPB5VE77HNMhIVApClIW2t6rsEW81r3tvD2mDzn8E6wSI
        mg63uDdNK1rNy7frt4Ca/GRBbSG0
X-Google-Smtp-Source: APXvYqwWdympcqiF9HPqxjU8DEHtoVFHqnk3oNoy+pmOit21OB5Y49u+pooyF4aQEIx/QwE0X88ZbA==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr2885099wro.375.1575907706686;
        Mon, 09 Dec 2019 08:08:26 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id p17sm27667111wrx.20.2019.12.09.08.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:08:26 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] rebase-interactive: warn if commit is dropped with
 `rebase --edit-todo'
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
 <20191202234759.26201-3-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b399fe9c-0b76-c7ac-7f88-48b31a7e2ce3@gmail.com>
Date:   Mon, 9 Dec 2019 16:08:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191202234759.26201-3-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 02/12/2019 23:47, Alban Gruin wrote:
 > [...]
> diff --git a/sequencer.c b/sequencer.c
> index 181bb35f5f..75d5ad0496 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4271,8 +4271,20 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>   	if (read_populate_opts(opts))
>   		return -1;
>   	if (is_rebase_i(opts)) {
> +		struct todo_list backup = TODO_LIST_INIT;
> +
>   		if ((res = read_populate_todo(r, &todo_list, opts)))
>   			goto release_todo_list;
> +
> +		if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
> +			todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
> +			res = todo_list_check(&backup, &todo_list);
> +			todo_list_release(&backup);

This causes problems if the user edits the todo list and then later runs 
'git rebase --continue' after resolving conflicts as the backup todo 
list has a bunch of commands that have already been processed but they 
are seen as missing

This test fails

test_expect_success 'rebase.missingCommitsCheck = error after resolving 
conflicts' '
	test_config rebase.missingCommitsCheck error &&
	(
		set_fake_editor &&
		FAKE_LINES="break 2 3 4" git rebase -i A E
	) &&
	git rebase --edit-todo &&
	test_must_fail git rebase --continue &&
	echo x >file1 &&
	git add file1 &&
	git rebase --continue
'

I think it would be better to write a file if the check fails when 
editing the todo list and check for the presence of that file when 
continuing and error out if it exists. This would also allow --edit-todo 
to only remove the backup file if there are no outstanding errors from 
the last edit and so check that those errors are fixed by the second 
edit. I think we'd only want to do this if rebase.missingCommitsCheck is 
set to error.

Best Wishes

Phillip

> +
> +			if (res)
> +				goto release_todo_list;
> +		}
> +
>   		if (commit_staged_changes(r, opts, &todo_list))
>   			return -1;
>   	} else if (!file_exists(get_todo_path(opts)))
> @@ -4986,12 +4998,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
>   	return res;
>   }
>   
> -static const char edit_todo_list_advice[] =
> -N_("You can fix this with 'git rebase --edit-todo' "
> -"and then run 'git rebase --continue'.\n"
> -"Or you can abort the rebase with 'git rebase"
> -" --abort'.\n");
> -
>   /* skip picking commits whose parents are unchanged */
>   static int skip_unnecessary_picks(struct repository *r,
>   				  struct todo_list *todo_list,
> @@ -5089,11 +5095,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		todo_list_release(&new_todo);
>   
>   		return error(_("nothing to do"));
> -	}
> -
> -	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
> -	    todo_list_check(todo_list, &new_todo)) {
> -		fprintf(stderr, _(edit_todo_list_advice));
> +	} else if (res == -4) {
>   		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
>   		todo_list_release(&new_todo);
>   
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 29a35840ed..9051c1e11d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1343,6 +1343,89 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>   	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>   '
>   
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
> +	test_config rebase.missingCommitsCheck ignore &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
> +	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
> +	git rebase --continue 2>actual &&
> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test_i18ngrep \
> +		"Successfully rebased and updated refs/heads/missing-commit" \
> +		actual
> +'
> +
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
> +	cat >expect <<-EOF &&
> +	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
> +	Warning: some commits may have been dropped accidentally.
> +	Dropped commits (newer to older):
> +	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
> +	To avoid this message, use "drop" to explicitly remove a commit.
> +	EOF
> +	tail -n4 expect >expect.2 &&
> +	test_config rebase.missingCommitsCheck warn &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
> +		git rebase -i --root &&
> +	cp .git/rebase-merge/git-rebase-todo.backup orig &&
> +	FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
> +	head -n5 actual.2 >actual &&
> +	test_i18ncmp expect actual &&
> +	cp orig .git/rebase-merge/git-rebase-todo &&
> +	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual.2 &&
> +	head -n4 actual.2 >actual &&
> +	test_i18ncmp expect.2 actual &&
> +	git rebase --continue 2>actual &&
> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test_i18ngrep \
> +		"Successfully rebased and updated refs/heads/missing-commit" \
> +		actual
> +'
> +
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
> +	cat >expect <<-EOF &&
> +	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
> +	Warning: some commits may have been dropped accidentally.
> +	Dropped commits (newer to older):
> +	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
> +	To avoid this message, use "drop" to explicitly remove a commit.
> +
> +	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
> +	The possible behaviours are: ignore, warn, error.
> +
> +	You can fix this with '\''git rebase --edit-todo'\'' and then run '\''git rebase --continue'\''.
> +	Or you can abort the rebase with '\''git rebase --abort'\''.
> +	EOF
> +	tail -n10 expect >expect.2 &&
> +	test_config rebase.missingCommitsCheck error &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
> +		git rebase -i --root &&
> +	cp .git/rebase-merge/git-rebase-todo.backup orig &&
> +	test_must_fail env FAKE_LINES="2 3 4" \
> +		git rebase --edit-todo 2>actual &&
> +	test_i18ncmp expect actual &&
> +	test_must_fail git rebase --continue 2>actual &&
> +	test_i18ncmp expect actual &&
> +	cp orig .git/rebase-merge/git-rebase-todo &&
> +	test_must_fail env FAKE_LINES="1 2 3 4" \
> +		git rebase --edit-todo 2>actual &&
> +	test_i18ncmp expect.2 actual &&
> +	test_must_fail git rebase --continue 2>actual &&
> +	test_i18ncmp expect.2 actual &&
> +	cp orig .git/rebase-merge/git-rebase-todo &&
> +	FAKE_LINES="1 2 3 4 drop 5" git rebase --edit-todo &&
> +	git rebase --continue 2>actual &&
> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test_i18ngrep \
> +		"Successfully rebased and updated refs/heads/missing-commit" \
> +		actual
> +'
> +
>   test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
>   	rebase_setup_and_clean abbrevcmd &&
>   	test_commit "first" file1.txt "first line" first &&
> 
