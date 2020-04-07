Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7CC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BE72063A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+gsacAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDGSQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:16:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGSQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:16:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so5022680wrl.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S/tF6MMPMbC5qffeVKSqhG6g+LlJM8D3tBiOZEAD/y0=;
        b=A+gsacAB3GezFFD5qzvVeWg7ABDDNWlq+NPy+zTuXOQQwYuk4P9Q+JiVyDw35YVXZy
         e3aw3M8ar2wv0K3TneqIc2+cjucU4FO8h2L8p6KkLV+kw1UHmRjhCGQvIcg/rhw0SzOP
         C3AgcMSY7c4A1WDYc0lIKx4Q6vijHFwthr3oh1dV1FM5FFcr/dzYzxT9DDgIsuBHb3Ut
         LZIYfG/ObnQVs7bcK+5YPFAMJgvoe4IpXy9FyiCadVBnbihVaI/54Jrhyb6SoOV0LFcf
         BtUMdj/kjKqC0CkTMHqKANTf6avodfg8T7CctNreIQboFbhaUX2OgHf95ZPO3/WAIBqM
         dRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S/tF6MMPMbC5qffeVKSqhG6g+LlJM8D3tBiOZEAD/y0=;
        b=lCtHL/rfzzTF0cpJYaz9GGHAmmo5XE9L4kCrd621S26spOeKvcnaD5QtfFAxxGeV0Z
         T5TJIRw0bcyoK5WD2ZlJ2MIx2QiospSYKXsZUUygRMsB2XgtfIEtg+92ddg3DrX70xSs
         B256StoYndK62cWGcix2Zz7xd4eiVYPUnrttuAsK3WidhpBfEk1vcrQPtdwN/uwKfjo/
         BGpHG78czlOFnQoTIASTlc6YmH8fGRkoLGjvb1X4eOTzFrAuczSRCbscL+TPTlmcLnf0
         T9FyyHsgYVpw5whil3qNyHjDYCltvd5IA23LRuRjBiv+YtRJ2B+mIbH+J2AKQ/u/jq+j
         3WJQ==
X-Gm-Message-State: AGi0PuYHVAq/TBTzWqAnKOJkEBz4oQzR6NezZuPZC/2f26k72MstXnuf
        ZYC4kK1jYN61i6Kbdq0wYp8=
X-Google-Smtp-Source: APiQypJOSjkxOJWwkg0W76hlEwcdUgcZtcJYmJx+9t5mVVtD+X+TOVWRB9bRK5D/5KjcbUe4nwiaWA==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr4027558wrr.122.1586283378658;
        Tue, 07 Apr 2020 11:16:18 -0700 (PDT)
Received: from [192.168.1.201] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.googlemail.com with ESMTPSA id c11sm6778143wrt.24.2020.04.07.11.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 11:16:17 -0700 (PDT)
Subject: Re: [PATCH 6/6] t3433: improve coverage
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200407141125.30872-7-phillip.wood123@gmail.com>
 <CABPp-BFZknddcEcAz02T7Uej0jNWtKAUW8hwS6CdMfAa5BhGgA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1094f0a2-91b8-4106-1db6-7bb49dadd267@gmail.com>
Date:   Tue, 7 Apr 2020 19:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFZknddcEcAz02T7Uej0jNWtKAUW8hwS6CdMfAa5BhGgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 07/04/2020 16:13, Elijah Newren wrote:
> On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Add tests to check --ignore-whitespace and --ignore-date are remembered
>> when running `rebase --continue` and to check
>> --committer-date-is-author-date with --ignore-date gives the expected
>> result.
> 
> Thanks for adding these.
> 
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  t/t3433-rebase-options-compatibility.sh | 55 +++++++++++++++++++++++++
> 
> t3433 is taken by t3433-rebase-across-mode-change.sh in upstream.
> When you revert the reversion of Rohit's changes, perhaps you need to
> rename his t3433 to some other file?

Thanks for point that out I'll rename it

> Also, the name "rebase-options-compatibility" suggest to me that it's
> just checking whether certain options can be used together.  Perhaps
> the --ignore-whitespace and --ignore-date tests you add should go
> somewhere else?

I think this file is so named because it tests that the merge backend is
compatible with the apply backend for the new options (i.e. they both
give the same results) - I'll try and think of a better name

>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
>> index 8247d01442..a13c341301 100755
>> --- a/t/t3433-rebase-options-compatibility.sh
>> +++ b/t/t3433-rebase-options-compatibility.sh
>> @@ -7,6 +7,8 @@ test_description='tests to ensure compatibility between am and interactive backe
>>
>>  . ./test-lib.sh
>>
>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>> +
>>  GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
>>  export GIT_AUTHOR_DATE
>>
>> @@ -70,6 +72,22 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
>>         test_cmp expect file
>>  '
>>
>> +test_expect_success '--ignore-whitespace is remembered when continuing' '
>> +       cat >expect <<-\EOF &&
>> +       line 1
>> +       new line 2
>> +       line 3
>> +       EOF
>> +       (
>> +               set_fake_editor &&
>> +               FAKE_LINES="break 1" &&
>> +               export FAKE_LINES &&
>> +               git rebase -i --ignore-whitespace main side
>> +       ) &&
>> +       git rebase --continue &&
>> +       test_cmp expect file
>> +'
>> +
>>  test_expect_success '--committer-date-is-author-date works with am backend' '
>>         GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>>         git rebase --committer-date-is-author-date HEAD^ &&
>> @@ -135,6 +153,16 @@ test_expect_success '--ignore-date works with interactive backend' '
>>         grep "+0000" authortime
>>  '
>>
>> +test_expect_success '--ignore-date works after conflict resolution' '
>> +       test_must_fail git rebase --ignore-date -i \
>> +               --onto commit2^^ commit2^ commit2 &&
> 
> I don't see any todo list here; is there a reason you are using -i
> instead of say -m?  (Similar question applies for the subsequent tests
> you add below too?)

Habit. (also these were originally based on an older commit and I wasn't
sure if that had your 'rebase -m' changes in it.) I'll update them to use -m

Best Wishes

Phillip

>> +       echo resolved >foo &&
>> +       git add foo &&
>> +       git rebase --continue &&
>> +       git log --pretty=%ai >authortime &&
>> +       grep +0000 authortime
>> +'
>> +
>>  test_expect_success '--ignore-date works with rebase -r' '
>>         git checkout side &&
>>         git merge --no-ff commit3 &&
>> @@ -143,4 +171,31 @@ test_expect_success '--ignore-date works with rebase -r' '
>>         ! grep -v "+0000" authortime
>>  '
>>
>> +test_expect_success '--ignore-date with --committer-date-is-author-date works' '
>> +       test_must_fail git rebase -i --committer-date-is-author-date \
>> +               --ignore-date --onto commit2^^ commit2^ commit3 &&
>> +       git checkout --theirs foo &&
>> +       git add foo &&
>> +       git rebase --continue &&
>> +       git log -2 --pretty=%ai >authortime &&
>> +       git log -2 --pretty=%ci >committertime &&
>> +       test_cmp authortime committertime &&
>> +       ! grep -v "+0000" authortime
>> +'
>> +
>> +test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
>> +       GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
>> +               git rebase -i --strategy=resolve --ignore-date \
>> +               --committer-date-is-author-date side side &&
>> +       git log -1 --pretty=%ai >authortime &&
>> +       git log -1 --pretty=%ci >committertime &&
>> +       test_cmp authortime committertime &&
>> +       grep "+0000" authortime
>> + '
>> +
>> +# This must be the last test in this file
>> +test_expect_success '$EDITOR and friends are unchanged' '
>> +       test_editor_unchanged
>> +'
>> +
>>  test_done
>> --
>> 2.26.0
>>

