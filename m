Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F15DEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjGETwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjGETwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:52:53 -0400
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82091FC8
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:52:23 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Qx9Kt1mZCz5tl9;
        Wed,  5 Jul 2023 21:52:17 +0200 (CEST)
Message-ID: <f3fd8ad1-fad7-575a-9057-ebe18d4a4fdb@kdbg.org>
Date:   Wed, 5 Jul 2023 21:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 09/10] gitk: improve keyboard convenience in reset
 dialog
Content-Language: en-US
To:     Jens Lidestrom <jens@lidestrom.se>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
 <a37a677036df9fd515201174897af4c16c69f45f.1688409958.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <a37a677036df9fd515201174897af4c16c69f45f.1688409958.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.23 um 20:45 schrieb Jens Lidestrom via GitGitGadget:
> From: Jens Lidestrom <jens@lidestrom.se>
> 
> Make it more convenient to use the reset dialog using keyboard.
> 
> * Set focus to the combo box.
> * Accept with Return key.
> * Auto-select combo items when navigating in menu with up/down keys.

I like it!

> 
> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
> ---
>  gitk-git/gitk | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index f559e279b7a..fafff2b1a5b 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -9902,27 +9902,40 @@ proc resethead {reset_target_id} {
>      ttk_toplevel $w
>      make_transient $w .
>      wm title $w [mc "Confirm reset"]
> +
>      ${NS}::label $w.m -text \
>          [mc "Reset branch %s to %s?" $mainhead [commit_name $reset_target_id 1]]
>      pack $w.m -side top -fill x -padx 20 -pady 20
>      ${NS}::labelframe $w.f -text [mc "Reset type:"]
> +
>      set resettype mixed
> +
>      ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
>          -text [mc "Soft: Leave working tree and index untouched"]
> +    bind $w.f.soft <Key-Up> "set resettype hard"
> +    bind $w.f.soft <Key-Down> "set resettype mixed"
>      grid $w.f.soft -sticky w
> +
>      ${NS}::radiobutton $w.f.mixed -value mixed -variable resettype \
>          -text [mc "Mixed: Leave working tree untouched, reset index"]
> +    bind $w.f.mixed <Key-Up> "set resettype soft"
> +    bind $w.f.mixed <Key-Down> "set resettype hard"
>      grid $w.f.mixed -sticky w
> +
>      ${NS}::radiobutton $w.f.hard -value hard -variable resettype \
>          -text [mc "Hard: Reset working tree and index\n(discard ALL local changes)"]
> +    bind $w.f.hard <Key-Up> "set resettype mixed"
> +    bind $w.f.hard <Key-Down> "set resettype soft"
>      grid $w.f.hard -sticky w
>      pack $w.f -side top -fill x -padx 4
> +
>      ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
> +    bind $w <Key-Return> "set confirm_ok 1; destroy $w"
>      pack $w.ok -side left -fill x -padx 20 -pady 20
>      ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
>      bind $w <Key-Escape> [list destroy $w]
>      pack $w.cancel -side right -fill x -padx 20 -pady 20
> -    bind $w <Visibility> "grab $w; focus $w"
> +    bind $w <Visibility> "grab $w; focus $w.f.mixed"
>      tkwait window $w
>      if {!$confirm_ok} return
>      if {[catch {set fd [open \

