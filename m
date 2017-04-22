Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360EA1FE90
	for <e@80x24.org>; Sat, 22 Apr 2017 17:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425814AbdDVRzX (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 13:55:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36638 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425780AbdDVRzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 13:55:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so10171210wmu.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpIzElnNOniYe4ZRPpZbkdCE2qRtfaR8N+MmhiJdzaw=;
        b=jseQbGVq2jkqYK53OY+MFoH5edButyLy+dBT3d7/4NvCENsR5SIpDhYgF5ab0hxH+o
         UlCJtAWVtaDOh9hUp07o2CZruxAckmIsX3CzYGM2GGKlhhFqPckOxyexKlyxJ5jZks2c
         dDfIzzO3/LK3S7GettmQJGsQjyHqyfx7ipWlYuixU8BA9RoxrwDEe9I2uWLezhKD8dxz
         grgbXHrrpE8S9XwHmPQx4UzgMww9dm6fD3jOocMfnQkhot5WmvZTu/eOFdQC0NLarbi2
         XKxCGd86SBxXd93UWpk0iMcZ8wM7WD47Jm/j45NNF3SnMKh/MshoNCyHdOoELKO7Js9Z
         b6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpIzElnNOniYe4ZRPpZbkdCE2qRtfaR8N+MmhiJdzaw=;
        b=sqUE1C6uXM2ihW2W86GzsRrMiBney2dS0xhCi2SGHoQptDsNT2w5+jX5FZaOdZCk1Y
         GMTS52zHbxIR0xFRdvhO8MJlAYFQ02Zt4ej0MMAHWorx0ilPhxZOHlZKaw/YDkElq3ke
         eKW5YeXKJ7RJu/EL8SXnquCcCRvI0tpepvtiqKhPsOHiIg1NixQExiH7U9ij2pKXOAad
         3/W9g14lv0IHvcut5LLEzbyyKLPqKYOzWseEEeb9Ia8CShmPMInmjc1/lI0ajx6NzQLB
         FEAmr/MjFuseF3zq7ptPW1L1KbU8VZUbuwCvoHf4uKYzTeZJXweglLs6TpjLG+y/Zqko
         d8Sg==
X-Gm-Message-State: AN3rC/612gwHftIaggNlGrmXxGtzpiJUYUcDtQnhA42Oz/Pf/aTXvead
        9bCMVHhWdjQipg==
X-Received: by 10.28.185.10 with SMTP id j10mr3581391wmf.57.1492883720130;
        Sat, 22 Apr 2017 10:55:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 43sm16066478wry.31.2017.04.22.10.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Apr 2017 10:55:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jay Soffian <jaysoffian@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] completion: expand "push --delete <remote> <ref>" for refs on that <remote>
Date:   Sat, 22 Apr 2017 17:55:04 +0000
Message-Id: <20170422175504.19999-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170421122832.24617-1-szeder.dev@gmail.com>
References: <20170421122832.24617-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the completion of "push --delete <remote> <ref>" to complete
refs on that <remote>, not all refs.

Before this cloning git.git and doing "git push --delete origin
p<TAB>" will complete nothing, since a fresh clone of git.git will
have no "pu" branch, whereas origin/p<TAB> will uselessly complete
origin/pu, but fully qualified references aren't accepted by
"--delete".

Now p<TAB> will complete as "pu". The completion of giving --delete
later, e.g. "git push origin --delete p<TAB>" remains unchanged, this
is a bug, but is a general existing limitation of the bash completion,
and not how git-push is documented, so I'm not fixing that case, but
adding a failing TODO test for it.

The testing code was supplied by SZEDER Gábor in
<20170421122832.24617-1-szeder.dev@gmail.com> with minor setup
modifications on my part.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
Test-code-by: SZEDER Gábor <szeder.dev@gmail.com>
---

On Fri, Apr 21, 2017 at 2:28 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>
> On Tue, Apr 18, 2017 at 3:31 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> Change the completion of "push --delete <remote> <ref>" to complete
>> refs on that <remote>, not all refs.
>
> Good.
>
>> Before this e.g. cloning git.git
>> and doing "git push --delete origin p<TAB>" will complete nothing,
>
> Well, it will complete all local branches starting with 'p', but
> perhaps you don't happen to have any.
>
>> whereas origin/p<TAB> will uselessly complete origin/pu.
>>
>> Now p<TAB> will complete as "pu". The completion of giving --delete
>> later, e.g. "git push origin --delete p<TAB>" remains unchanged, this
>> is a bug, but is a general existing limitation of the bash completion,
>> and not how git-push is documented, so I'm not fixing that case.
>>
>> I looked over t9902-completion.sh but couldn't quickly find out how to
>> add a test for this,
>
> Yeah, this helper function has to look at the whole command line to do
> its thing, and we don't have other unit test-like tests doing
> something like that.
>
> One option would be something like this:
>
> @@ -1162,6 +1162,19 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
>         test_cmp expected out
>  '
>
> +test_expect_success '__git_complete_remote_or_refspec - push -d' '
> +       sed -e "s/Z$//" >expected <<-EOF &&
> +       master-in-other Z
> +       EOF
> +       (
> +               words=(git push -d other ma) &&
> +               cword=${#words[@]} cur=${words[cword-1]} &&
> +               __git_complete_remote_or_refspec &&
> +               print_comp
> +       ) &&
> +       test_cmp expected out
> +'
> +
>  test_expect_success 'teardown after ref completion' '
>         git branch -d matching-branch &&
>         git tag -d matching-tag &&
>
> This is chatty, no question about that, but it only excercises
> __git_complete_remote_or_refspec() (and __git_refs() behind its back),
> and thus fits right in there with other refs completion tests.
>
>
> The other option would be something like this:
>
> @@ -1348,6 +1361,10 @@ test_expect_success 'complete tree filename with metacharacters' '
>         EOF
>  '
>
> +test_expect_success 'complete remote refs for git push -d' '
> +       test_completion "git push -d other ma" "master-in-other "
> +'
> +
>  test_expect_success 'send-email' '
>         test_completion "git send-email --cov" "--cover-letter " &&
>         test_completion "git send-email ma" "master "
>
> While this is much more compact, it does excercise the whole shebang,
> therefore it has to go to the integration tests.  However, at that
> point in the test script there aren't any remote refs in the
> repository (and, consequently this test will fail as it is), so you
> would need to add a few, which in turn would most likely require
> adjustments in other tests.
>
> I'm partial to the former, even if it's more lines of code, because if
> it were to fail, then it already narrowed down the scope where we'd
> need to look for the cause of the failure.
>
> Take your pick :)
>
>> but all the existing tests pass, and all my
>> manual testing of "git push --delete <remote> ..." does the right
>> thing now.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 1150164d5c..2e5b3ed776 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -701,7 +701,7 @@ __git_complete_revlist ()
>>  __git_complete_remote_or_refspec ()
>>  {
>>       local cur_="$cur" cmd="${words[1]}"
>> -     local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
>> +     local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0 delete=0
>>       if [ "$cmd" = "remote" ]; then
>>               ((c++))
>>       fi
>> @@ -709,6 +709,7 @@ __git_complete_remote_or_refspec ()
>>               i="${words[c]}"
>>               case "$i" in
>>               --mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
>> +             --delete) delete=1 ;;
>
> I noticed the two identical __git_complete_refs() calls in the hunk
> below.  How about:
>
>   -d|--delete) [ "$cmd" = "push" ] && lhs=0 ;;
>
> First, it recognizes the short option, too.
> Second, with 'push -d' any ref is interpreted as the right hand side
> of a refspec whose left hand side is empty (i.e. '-d pu' means ':pu').
> That 'lhs=0' tells the rest of the function to complete the right hand
> side of a refspec, i.e. in case of 'push' to list remote refs, which
> is exactly what you want.  And you won't need the extra if branch in
> the hunk below, or the new local variable.
> In this case, however, we should check that the command is 'push' as
> well, just in case the other commands whose completion is driven by
> this helper function get these options in the future.

Thanks a lot. I changed all of this as you suggested & integrated your
testing code, now also with a TODO test for "git push origin
--delete".

>>               --all)
>>                       case "$cmd" in
>>                       push) no_complete_refspec=1 ;;
>> @@ -761,7 +762,9 @@ __git_complete_remote_or_refspec ()
>>               fi
>>               ;;
>>       push)
>> -             if [ $lhs = 1 ]; then
>> +             if [ $delete = 1 ]; then
>> +                     __git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
>> +             elif [ $lhs = 1 ]; then
>>                       __git_complete_refs --pfx="$pfx" --cur="$cur_"
>>               else
>>                       __git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
>> --
>> 2.11.0

 contrib/completion/git-completion.bash |  1 +
 t/t9902-completion.sh                  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164d5c..b617019075 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -709,6 +709,7 @@ __git_complete_remote_or_refspec ()
 		i="${words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
+		-d|--delete) [ "$cmd" = "push" ] && lhs=0 ;;
 		--all)
 			case "$cmd" in
 			push) no_complete_refspec=1 ;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5ed28135be..2cb999ecfa 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1457,4 +1457,38 @@ test_expect_failure 'complete with tilde expansion' '
 	test_completion "git add ~/tmp/" "~/tmp/file"
 '
 
+test_expect_success 'setup other remote for remote reference completion' '
+	git remote add other otherrepo &&
+	git fetch other
+'
+
+for flag in -d --delete
+do
+	test_expect_success "__git_complete_remote_or_refspec - push $flag other" '
+		sed -e "s/Z$//" >expected <<-EOF &&
+		master-in-other Z
+		EOF
+		(
+			words=(git push '$flag' other ma) &&
+			cword=${#words[@]} cur=${words[cword-1]} &&
+			__git_complete_remote_or_refspec &&
+			print_comp
+		) &&
+		test_cmp expected out
+	'
+
+	test_expect_failure "__git_complete_remote_or_refspec - push other $flag" '
+		sed -e "s/Z$//" >expected <<-EOF &&
+		master-in-other Z
+		EOF
+		(
+			words=(git push other '$flag' ma) &&
+			cword=${#words[@]} cur=${words[cword-1]} &&
+			__git_complete_remote_or_refspec &&
+			print_comp
+		) &&
+		test_cmp expected out
+	'
+done
+
 test_done
-- 
2.11.0

