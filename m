Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D9A1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 20:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfIJU23 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 16:28:29 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49441 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIJU23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 16:28:29 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 87E3E40006;
        Tue, 10 Sep 2019 20:28:26 +0000 (UTC)
Date:   Wed, 11 Sep 2019 01:58:23 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: Re: [PATCH 2/2] git-gui: add horizontal scrollbar to commit buffer
Message-ID: <20190910202823.hifl7mivwm6yaewy@yadavpratyush.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <62ef03a2938ac0d2158b1c3201c7f10e52e30ecb.1567627609.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ef03a2938ac0d2158b1c3201c7f10e52e30ecb.1567627609.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 10:10PM, Bert Wesarg wrote:
> While the commit message widget has a configurable fixed width, it
> nevertheless allows to write commit messages which exceed this limit.
> Though it does not show this content because there is not scrollbar for

Like we discussed before, it does show the content, you just have to 
scroll by keyboard, and can't scroll by mouse. So maybe reword this?

> this widget. No it is.

I pulled from your GitHub since you seem to have fixed this typo there.

> There seems to be a bug in at least up to Tcl/Tk 8.6.8, which does not
> update the horizontal scrollbar if one removes the whole content at once.
> 
> Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index a491085..fa9c0d2 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3363,14 +3363,20 @@ ttext $ui_comm -background white -foreground black \
>  	-relief sunken \
>  	-width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
>  	-font font_diff \
> +	-xscrollcommand {.vpane.lower.commarea.buffer.frame.sbx set} \
>  	-yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
> +${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sbx \
> +	-orient horizontal \
> +	-command [list $ui_comm xview]
>  ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
> +	-orient vertical \
>  	-command [list $ui_comm yview]
>  
> +pack .vpane.lower.commarea.buffer.frame.sbx -side bottom -fill x
>  pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
> -pack $ui_comm -side left -fill y
> +pack $ui_comm -side left -fill both -expand 1

Dropping this change does not seem to make a difference. The commit 
message buffer expands on resize even without it. Can you please explain 
why you did this?

>  pack .vpane.lower.commarea.buffer.header -side top -fill x
> -pack .vpane.lower.commarea.buffer.frame -side left -fill y
> +pack .vpane.lower.commarea.buffer.frame -side bottom -fill both -expand 1

I'm not too familiar with pack, but why did you change the side from 
left to bottom? I tested by changing it back to left and didn't notice 
any difference.

>  pack .vpane.lower.commarea.buffer -side left -fill y
>  
>  # -- Commit Message Buffer Context Menu

Other than these couple of minor things, the patch LGTM. Thanks.

-- 
Regards,
Pratyush Yadav
