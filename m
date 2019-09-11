Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAFE31F463
	for <e@80x24.org>; Wed, 11 Sep 2019 20:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfIKUzo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 16:55:44 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39223 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfIKUzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 16:55:43 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 225FEFF804;
        Wed, 11 Sep 2019 20:55:40 +0000 (UTC)
Date:   Thu, 12 Sep 2019 02:25:39 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
Message-ID: <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Birger,

Please ignore the two emails I sent about basing your work on top of 
Bert's. I see that you have already done so (or maybe Bert did it, I 
don't know), and I was reading an older version of the patch.

On 05/09/19 10:09PM, Bert Wesarg wrote:
> From: Birger Skogeng Pedersen <birger.sp@gmail.com>
> 
> Selecting whether to "Amend Last Commit" or not does not have a hotkey.
> 
> With this patch, the user may toggle between the two options with
> CTRL/CMD+e.
> 
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Rebased-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 80a07d5..8b776dd 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2640,6 +2640,12 @@ proc show_less_context {} {
>  	}
>  }
>  
> +proc toggle_commit_type {} {
> +	global commit_type_is_amend
> +	set commit_type_is_amend [expr !$commit_type_is_amend]
> +	do_select_commit_type
> +}

Ah! So we had almost exactly the same thought process. This is pretty 
much what I suggested in my other email ;)

> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -2830,6 +2836,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>  	if {![is_enabled nocommit]} {
>  		.mbar.commit add checkbutton \
>  			-label [mc "Amend Last Commit"] \
> +			-accelerator $M1T-E \
>  			-variable commit_type_is_amend \
>  			-command do_select_commit_type
>  		lappend disable_on_lock \
> @@ -3825,6 +3832,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
>  bind .   <$M1B-Key-plus> {show_more_context;break}
>  bind .   <$M1B-Key-KP_Add> {show_more_context;break}
>  bind .   <$M1B-Key-Return> do_commit
> +bind .   <$M1B-Key-e> toggle_commit_type

Nitpick: Please move this up with the binds for other letters (u, j, 
etc)

Also, I notice that the bindings for other letters have the same 
function bound for both small and capital letters (IOW, same behavior 
with shift held and released).

I don't necessarily think that is a great idea. It is a pretty common 
pattern to have, say Ctrl+a, do something, and Ctrl+Shift+a, do 
something else. Just want to pick your brain on whether you think we 
should do the same thing for both Ctrl+e and for Ctrl+E (aka 
Ctrl+Shift+e), or just bind it to Ctrl+e, and leave Ctrl+E for something 
else.

>  foreach i [list $ui_index $ui_workdir] {
>  	bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
>  	bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }

Overall, the patch LGTM apart from a couple of nitpicks above. Thanks.

-- 
Regards,
Pratyush Yadav
