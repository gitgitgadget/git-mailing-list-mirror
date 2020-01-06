Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81674C33C9B
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4339E206DB
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGRiTLNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgAFRKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:10:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFRKw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 12:10:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so50406230wrl.13
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PB8pbqk2tNJ0RuryPejJBzNJmlavAcYIUR1i/8XP+8w=;
        b=NGRiTLNoANmtgr7iFJ6UwXkUH3s23ot1Tki5gTp6MAwPBydvga88f6qlOV8HDuX+qT
         9DCFD68047UgdQTHiRpscRrr8BLtsO2vyOXC6I1z3n+dfDiDYhHS6xXwcK5erJfRbqQA
         xtBPd/zrt1tQEFOhDtC0p7+jrhJf5iCtdvaSf/8T3Mr5eeI1AqGq8cr8QeE++2dt2gWt
         D3mhO4EvE9JBno9TnKrerWH2pQ4SOG9nx9asXdLXZt4mXxqp7b3oaWegKLEQVCklDdeQ
         Zvi/UUgBuYsNuvv1wqqZ4GFrC9r+5q9Ni5+DoMaF93UxhCre2mc8ZEHQx+jqsX3fTQ8t
         tLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PB8pbqk2tNJ0RuryPejJBzNJmlavAcYIUR1i/8XP+8w=;
        b=P676ZyOpN6VGXm0W43WHUz+KNrCH5kW2zPbo5+pXK1KZpGm3vB9mvpy3NXWBobawek
         Fz07mOgteFEgwnACHUgnmsOEdC2PyJtaAs/QsQrACkk5gbnfJBQLiN/i/lpGohmLjX1t
         6R0ejLZnXjiH5tB6QnyQ/N8kuzt9sgqvc8/vfQE4QgmYMF9hkW/7MuWBWpyU4QUqOUov
         WMAEaNgqAhfV3yTFqAAAepVv7u/5a1FOoD77qaNntwe7+grlnklOIJ25U4duo05xldpL
         oKGg0AqMhcjBPomV7d3mvfMOxdNyLdfwuPpf0ieuwORqGC6P1AxRYzgg8yja9gEsqMLf
         iRtg==
X-Gm-Message-State: APjAAAWwdzWVxVwSGZrkDwVBYOtGFYD+7Znzciyrr61ScWqnZkQiaJGL
        /hSHS2Z1fJo5aEtdOErWc24=
X-Google-Smtp-Source: APXvYqwSTdeo72nWTQP15eCbVuOih0vQEiHgGZ9CX9LFiHEUqO4jI/5rrzluD9ntG6EOsVKIkjVyjw==
X-Received: by 2002:adf:f244:: with SMTP id b4mr32000756wrp.88.1578330649041;
        Mon, 06 Jan 2020 09:10:49 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-21-98.as13285.net. [92.22.21.98])
        by smtp.gmail.com with ESMTPSA id b68sm23410145wme.6.2020.01.06.09.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 09:10:48 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] sequencer: comment out the 'squash!' line
To:     Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo <rappazzo@gmail.com>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
 <b262a9d099b882339e9cb930b0a09fd5fe6734b0.1578326648.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <13b47c13-7a8b-a205-0cdb-5fdcb8d42412@gmail.com>
Date:   Mon, 6 Jan 2020 17:10:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <b262a9d099b882339e9cb930b0a09fd5fe6734b0.1578326648.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael

On 06/01/2020 16:04, Michael Rappazzo via GitGitGadget wrote:
> From: Michael Rappazzo <rappazzo@gmail.com>
> 
> When performing a squash commit, the commit comments are combined into a
> single commit.  Since the subject line of the squash commit is used to
> identify the squash-to target commit, it cannot offer any useful
> contribution to the new commit message.  Therefore, the squash commit
> subject line it commented out from the combined message (much like a
> fixup commit's full comment).

I like the idea but I think it would be better to only comment out the 
subject of the commit message if it starts with squash! for fixup! 
otherwise it may well be a useful part of the message. For correctness I 
think it would be better to comment out the subject (everything before 
the first blank line as returned by `git log --pretty=%s`) rather than 
just the first line. I've actually implemented this as part of a longer 
series that I've never got round to posting to the list[1] - feel free 
to use any of that which you find useful. That commit also shows an 
alternative way to change the --autosquash tests.

[1] 
https://github.com/phillipwood/git/commit/b91b492e4aba1ac8d244859361379d5063cfc2b8

> The body of a squash commit may contain additional content to add to the
> commit message, so this part of the squash commit message is retained.
> 
> Since this change what the expected post-rebase commit comment would look
> like, related test expectations are adjusted to reflect the the new
> expectation.  A new test is added for the new expectation.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>   sequencer.c                   |  1 +
>   t/t3404-rebase-interactive.sh |  4 +---
>   t/t3415-rebase-autosquash.sh  | 36 +++++++++++++++++++++++++++--------
>   t/t3900-i18n-commit.sh        |  4 ----
>   4 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 763ccbbc45..e5602686d7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1756,6 +1756,7 @@ static int update_squash_messages(struct repository *r,
>   		strbuf_addf(&buf, _("This is the commit message #%d:"),
>   			    ++opts->current_fixup_count + 1);
>   		strbuf_addstr(&buf, "\n\n");
> +		strbuf_addf(&buf, "%c ", comment_line_char);
>   		strbuf_addstr(&buf, body);
>   	} else if (command == TODO_FIXUP) {
>   		strbuf_addf(&buf, "\n%c ", comment_line_char);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ae6e55ce79..57d178d431 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -513,8 +513,6 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
>   	cat >expect-squash-fixup <<-\EOF &&
>   	B
>   
> -	D
> -
>   	ONCE
>   	EOF
>   	git checkout -b squash-fixup E &&
> @@ -1325,7 +1323,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
>   	test_cmp_rev HEAD F &&
>   	rm file6 &&
>   	git rebase --continue &&
> -	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
> +	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
>   	git reset --hard original-branch2
>   '
>   
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 22d218698e..51c5a94aea 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -59,7 +59,6 @@ test_auto_squash () {
>   	git add -u &&
>   	test_tick &&
>   	git commit -m "squash! first" &&
> -
>   	git tag $1 &&
>   	test_tick &&
>   	git rebase $2 -i HEAD^^^ &&
> @@ -67,7 +66,7 @@ test_auto_squash () {
>   	test_line_count = 3 actual &&
>   	git diff --exit-code $1 &&
>   	test 1 = "$(git cat-file blob HEAD^:file1)" &&
> -	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
> +	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
>   }
>   
>   test_expect_success 'auto squash (option)' '
> @@ -82,6 +81,27 @@ test_expect_success 'auto squash (config)' '
>   	test_must_fail test_auto_squash final-squash-config-false
>   '
>   
> +test_expect_success 'auto squash includes squash body but not squash directive' '
> +	git reset --hard base &&
> +	echo 1 >file1 &&
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "squash! first
> +
> +Additional Body" &&
git commit --squash=first -m "Additional Body"
would avoid the multi line argument

> +	git tag squash-with-body &&
> +	test_tick &&
> +	git rebase --autosquash -i HEAD^^^ &&
> +	git log --oneline >actual &&
> +	git log --oneline --format="%s%n%b" >actual-full &&

git log --format=%B ?

> +	test_line_count = 3 actual &&
> +	git diff --exit-code squash-with-body &&
> +	test 1 = "$(git cat-file blob HEAD^:file1)" &&
> +	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l) &&
> +	test 0 = $(grep squash actual-full | wc -l) &&

grep -v squash actual-full
is simpler I think

Best Wishes

Phillip

> +	test 1 = $(grep Additional actual-full | wc -l)
> +'
> +
>   test_expect_success 'misspelled auto squash' '
>   	git reset --hard base &&
>   	echo 1 >file1 &&
> @@ -114,7 +134,7 @@ test_expect_success 'auto squash that matches 2 commits' '
>   	test_line_count = 4 actual &&
>   	git diff --exit-code final-multisquash &&
>   	test 1 = "$(git cat-file blob HEAD^^:file1)" &&
> -	test 2 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
> +	test 1 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
>   	test 1 = $(git cat-file commit HEAD | grep first | wc -l)
>   '
>   
> @@ -152,7 +172,7 @@ test_expect_success 'auto squash that matches a sha1' '
>   	test_line_count = 3 actual &&
>   	git diff --exit-code final-shasquash &&
>   	test 1 = "$(git cat-file blob HEAD^:file1)" &&
> -	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> +	test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
>   '
>   
>   test_expect_success 'auto squash that matches longer sha1' '
> @@ -168,7 +188,7 @@ test_expect_success 'auto squash that matches longer sha1' '
>   	test_line_count = 3 actual &&
>   	git diff --exit-code final-longshasquash &&
>   	test 1 = "$(git cat-file blob HEAD^:file1)" &&
> -	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> +	test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
>   '
>   
>   test_auto_commit_flags () {
> @@ -192,7 +212,7 @@ test_expect_success 'use commit --fixup' '
>   '
>   
>   test_expect_success 'use commit --squash' '
> -	test_auto_commit_flags squash 2
> +	test_auto_commit_flags squash 1
>   '
>   
>   test_auto_fixup_fixup () {
> @@ -228,7 +248,7 @@ test_auto_fixup_fixup () {
>   		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
>   	elif test "$1" = "squash"
>   	then
> -		test 3 = $(git cat-file commit HEAD^ | grep first | wc -l)
> +		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
>   	else
>   		false
>   	fi
> @@ -268,7 +288,7 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
>   	test_line_count = 3 actual &&
>   	git diff --exit-code final-squash-instFmt &&
>   	test 1 = "$(git cat-file blob HEAD^:file1)" &&
> -	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> +	test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
>   '
>   
>   test_expect_success 'autosquash with empty custom instructionFormat' '
> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index d277a9f4b7..bfab245eb3 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -226,10 +226,6 @@ test_commit_autosquash_multi_encoding () {
>   		git rev-list HEAD >actual &&
>   		test_line_count = 3 actual &&
>   		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
> -		if test $flag = squash; then
> -			subject="$(head -1 expect)" &&
> -			printf "\nsquash! %s\n" "$subject" >>expect
> -		fi &&
>   		git cat-file commit HEAD^ >raw &&
>   		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
>   		test_cmp expect actual
> 
