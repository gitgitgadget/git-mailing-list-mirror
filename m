Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6905D1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 10:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbeFRKZQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 06:25:16 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:9843 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeFRKZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 06:25:15 -0400
Received: from [192.168.2.201] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id UrLVfSEhvVlGZUrLVfRy9h; Mon, 18 Jun 2018 11:25:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529317514;
        bh=grSKOgpfleshc6oniVTZL0pj+h99oxYLAk33c5yLxns=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GzZdFE6H4AEXmNFoi0pT2yvNpiV+c+RamdYGBZW/7n9s3mIUpuZcnCK2xZAHoinZQ
         +83vSPpdAQJ7t3q/5zGF23ODUaBSdnUNuyfAG8ywrBw4/hno0hsPWLPFI+WEIyXiBl
         mkvSwqSC1QNM1BnqoQXfYVCnSNfGGT/YEQt3APys=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=AeNu9FI7EVE57UVfWwgA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] rebase --root: demonstrate a bug while amending
 rootcommit messages
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>
References: <pull.3.git.gitgitgadget@gmail.com>
 <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <484fe825-0726-a027-1187-de00df6406d5@talktalk.net>
Date:   Mon, 18 Jun 2018 11:25:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJjadb6geEgPDsUrjWC8Ss0r0g1Gp0oeQhyoF3KwRC5mb4wc+1QwC78y93blZa8qy6wSZ3ewSuCpuOyHvaRv+jsXxa2SGNrwBQyn9AmpXnhAx/7gtACl
 PfCO2brehH8Q8CMBLrE0UjAL8AwhPrlS9LJ8pj8caoHZ9+QAUJ8xHcZsSxLoPsV2G6k45sNuuXYToMUhSFgmFwvo2qVbUccOGMf78d1SmGfiwD5olrqWDrWj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd/Johannes

On 15/06/18 05:31, Johannes Schindelin via GitGitGadget wrote:
> 
> From: Todd Zullinger <tmz@pobox.com>
> 
> When splitting a repository, running `git rebase -i --root` to reword
> the initial commit, Git dies with
> 
> 	BUG: sequencer.c:795: root commit without message.
> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3404-rebase-interactive.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c65826dda..ca94c688d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -971,6 +971,15 @@ test_expect_success 'rebase -i --root fixup root commit' '
>  	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
>  '
>  
> +test_expect_failure 'rebase -i --root reword root commit' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	git checkout -b reword-root-branch master &&
> +	set_fake_editor &&
> +	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
> +	git rebase -i --root &&
> +	git show HEAD^ | grep "A changed"

I wonder if it should also check that HEAD^ is the root commit, to make
sure that the squash-onto commit that's created and then amended has
been squashed onto.

Best Wishes

Phillip

> +'
> +
>  test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
>  	git reset --hard &&
>  	git checkout conflict-branch &&
> 

