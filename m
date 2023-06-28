Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3122EB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 08:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjF1Ixe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:53:34 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:51544 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236321AbjF1IqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 04:46:11 -0400
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4QrVvq4tsKz5trV
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 07:47:03 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4QrVvD2HCrz5tlG;
        Wed, 28 Jun 2023 07:46:32 +0200 (CEST)
Message-ID: <e74cc1b3-8459-101f-4613-17df0f5d69e3@kdbg.org>
Date:   Wed, 28 Jun 2023 07:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 9/9] gitk: default select reset hard in dialog
To:     Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom <jens@lidestrom.se>, git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <97857c3509fb4b45e1bc2d29588374a2631a7c2d.1687876885.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <97857c3509fb4b45e1bc2d29588374a2631a7c2d.1687876885.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.23 um 16:41 schrieb Jens Lidestrom via GitGitGadget:
> From: Jens Lidestrom <jens@lidestrom.se>
> 
> Reset hard is dangerous but also the most common reset type, and not
> having it pre-selected in the dialog is annoying to users.

I agree that the operation of the Reset dialog is clumsy before this
series. However, this patch together with the previous patch turns it
into a foot gun. It becomes far too easy to destroy uncommitted work.

I would prefer to keep the default at "mixed" mode, set the focus on the
radio button to make it easy to switch to "hard" mode by hitting the
Down arrow key, and then make it so that Enter triggers the OK button.

> It is also less dangerous in the GUI where there is a confirmation
> dialog. Also, dangling commits remain in the GUI and can be recovered.

The problem with "hard" mode are not the commits. The real danger is
that it blows away uncommitted changes. Besides of that, I do not
consider this UI a confirmation dialog.

-- Hannes

> 
> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
> ---
>  gitk-git/gitk | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9d93053e360..5b0a0ea46be 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -9906,7 +9906,9 @@ proc resethead {reset_target_id} {
>          [mc "Reset branch %s to %s?" $mainhead [commit_name $reset_target_id 1]]
>      pack $w.m -side top -fill x -padx 20 -pady 20
>      ${NS}::labelframe $w.f -text [mc "Reset type:"]
> -    set resettype mixed
> +    # Reset hard is dangerous but also the most common reset type, and not
> +    # having it pre-selected in the dialog is annoying to users.
> +    set resettype hard
>      ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
>          -text [mc "Soft: Leave working tree and index untouched"]
>      grid $w.f.soft -sticky w

