Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3965CC64EC4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCGAPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCGAPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:15:07 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C0305FD
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:15:06 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h1-20020a62de01000000b005d943b97706so6223906pfg.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678148105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sek6RHVYkjWMoh+ldEy+TX1nrHTjZmI/E1qBcV9ZNSY=;
        b=fZAby0sUhY7d+gM8GYV4WkcRVXrfZ/ljmHxOo5FLuv0zP86e5s2Ii17jV9k2kuECMG
         D2SX+H+/3bAAVtzLHkIK2En8uWN6BZ1UAncyOKDeJcWEglRIpksQTj/pEh9Hi2bjwPj2
         Vq7rf/X3y/GHpdjl1KB5Pe6L530xq8OOcVdt1fE3J4p6O2Sj9zhAJoAt3alzCkAG2z50
         uEuYUiQX0yHqZ9I2fNycRGbhZRzcjL7K6Y+9komgr9aqufR28UUOAW0I01k/gNJ/pSpW
         m1F/RQuFIKe/JDiNTbCn2FsEA4A8EN6A2+rf0k4DiTVAKe78R5sV5Zcid8fYEYBZyxHy
         WY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678148105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sek6RHVYkjWMoh+ldEy+TX1nrHTjZmI/E1qBcV9ZNSY=;
        b=mpBZe/XfmywDvwxQF9UheP6IQc9tAO8QH5K1IlSm1Nep3CCTKF6djGgg4+jcTe6+IS
         f7E+rUFhNGp6h5/yJfRyiAbsxuPZeLUGWrX5kEOBDArwfTEZdQjxwC1eHszHpo82+Jhs
         HBaNaVMtiQADBm9TB6WozBmCa901tnvbBaYGZ7+8qVtxOt6eK+05ef+zyqb8dAAmg7HP
         fZnI0VXAW+SdxpExZ8wMRisTvAK89EuQW+6SyRn7k815Qi0UlB2ogJVZ6GGeSoVyj71V
         bmzZmlHp/1vkWbDA8c1y+JZDTv/MuONgJ/76nVMblUg+xgSNGsY5PjwEb6WvfcZVxNuQ
         E47Q==
X-Gm-Message-State: AO0yUKUcMZy7BvJJI+12r09XuywpXKEu8MGyEv6IHTk1V1n7zmOSUbI7
        JDYQuGcKttqNiMuEq/UuMtqGeQvbP74I8A==
X-Google-Smtp-Source: AK7set+G3MznYWe7n1BjJLbvm6goUJ0UDCsOjj4HcfbeZdfA+rpFr3oXNOoYQYNYGc1sWZ5ZK3thSYYZT8K4MA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a62:834b:0:b0:5e2:c313:a660 with SMTP id
 h72-20020a62834b000000b005e2c313a660mr5422333pfe.6.1678148105718; Mon, 06 Mar
 2023 16:15:05 -0800 (PST)
Date:   Mon, 06 Mar 2023 16:15:04 -0800
In-Reply-To: <20230228185642.2357806-4-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com> <20230228185642.2357806-4-calvinwan@google.com>
Message-ID: <kl6lpm9lifhz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 4/6] tests: use `git submodule add` and fix expected status
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> @@ -122,25 +123,30 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
>  '
>  
>  test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
> +	git branch pristine-gitmodules &&
>  	git config diff.ignoreSubmodules dirty &&
>  	git diff HEAD >actual &&
>  	test_must_be_empty actual &&
>  	git config --add -f .gitmodules submodule.subname.ignore none &&
>  	git config --add -f .gitmodules submodule.subname.path sub &&
> +	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
>  	test_cmp expect.body actual.body &&
>  	git config -f .gitmodules submodule.subname.ignore all &&
>  	git config -f .gitmodules submodule.subname.path sub &&
> +	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual2 &&
>  	test_must_be_empty actual2 &&
>  	git config -f .gitmodules submodule.subname.ignore untracked &&
> +	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual3 &&
>  	sed -e "1,/^@@/d" actual3 >actual3.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
>  	test_cmp expect.body actual3.body &&
>  	git config -f .gitmodules submodule.subname.ignore dirty &&
> +	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual4 &&
>  	test_must_be_empty actual4 &&
>  	git config submodule.subname.ignore none &&
> @@ -152,7 +158,7 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
>  	git config --remove-section submodule.subname &&
>  	git config --remove-section -f .gitmodules submodule.subname &&
>  	git config --unset diff.ignoreSubmodules &&
> -	rm .gitmodules
> +	git reset --hard pristine-gitmodules
>  '

This looks like the perfect use case for test_when_finished :)

> @@ -190,12 +196,15 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>  test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
>  	git config --add -f .gitmodules submodule.subname.ignore all &&
>  	git config --add -f .gitmodules submodule.subname.path sub &&
> +	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual2 &&
>  	test_must_be_empty actual2 &&
>  	git config -f .gitmodules submodule.subname.ignore untracked &&
> +	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual3 &&
>  	test_must_be_empty actual3 &&
>  	git config -f .gitmodules submodule.subname.ignore dirty &&
> +	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual4 &&
>  	test_must_be_empty actual4 &&
>  	git config submodule.subname.ignore none &&

Like the previous patch, I wonder a little whether we should be diffing
with :!.gitmodules, but at least here we are focused on diffing with
submodules in general (and not the specific "git diff --submodule="
behavior), so I thnk this is okay to keep.

> @@ -206,7 +215,7 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)
>  	test_cmp expect.body actual.body &&
>  	git config --remove-section submodule.subname &&
>  	git config --remove-section -f .gitmodules submodule.subname &&
> -	rm .gitmodules
> +	git reset --hard pristine-gitmodules

Ditto about test_when_finished.

>  '
>  
>  test_expect_success 'git diff between submodule commits' '
> @@ -243,7 +252,7 @@ test_expect_success 'git diff between submodule commits [.gitmodules]' '
>  	expect_from_to >expect.body $subtip $subprev &&
>  	git config --remove-section submodule.subname &&
>  	git config --remove-section -f .gitmodules submodule.subname &&
> -	rm .gitmodules
> +	git reset --hard pristine-gitmodules
>  '
>  

Ditto

> @@ -1152,8 +1156,37 @@ test_expect_success '.gitmodules ignore=untracked suppresses submodules with unt
>  	test_cmp expect output &&
>  	git config --add -f .gitmodules submodule.subname.ignore untracked &&
>  	git config --add -f .gitmodules submodule.subname.path sm &&
> +	cat > expect-modified-gitmodules << EOF &&
> +On branch main
> +Your branch and '\''upstream'\'' have diverged,
> +and have 2 and 2 different commits each, respectively.
> +  (use "git pull" to merge the remote branch into yours)
> +
> +Changes to be committed:
> +  (use "git restore --staged <file>..." to unstage)
> +	modified:   sm
> +
> +Changes not staged for commit:
> +  (use "git add <file>..." to update what will be committed)
> +  (use "git restore <file>..." to discard changes in working directory)
> +	modified:   .gitmodules
> +	modified:   dir1/modified
> +
> +Submodule changes to be committed:
> +
> +* sm $head...$new_head (1):
> +  > Add bar
> +
> +Untracked files:
> +  (use "git add <file>..." to include in what will be committed)
> +	dir1/untracked
> +	dir2/modified
> +	dir2/untracked
> +	untracked
> +
> +EOF
>  	git status >output &&
> -	test_cmp expect output &&
> +	test_cmp expect-modified-gitmodules output &&
>  	git config -f .gitmodules  --remove-section submodule.subname
>  '

That another giant snapshot makes me a bit wary, since it's harder to
tell whether the "modifed .gitmodules" and "unmodified .gitmodules" are
really checking the same things, but there might not be a way around it.
The following tests check various combinations of values (dirty,
untracked, etc) and sources "--ignore-submodules", ".git/config ignore="
and ".gitmodules ignore=". For the .gitmodules tests, we really do have
to modify .gitmodules to test that it gives us the behavior we want.

As a hack, we could preemptively modify .gitmodules, so that it's
modified in all of the snapshots we're diffing. That feels too hacky to
me, but maybe others think it's fine.

(Side note: I recall a previous conversation with Junio about how we
shouldn't be changing behavior based on .gitmodules. If we had that, we
wouldn't need to worry about this right now.)

