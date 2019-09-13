Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031411F463
	for <e@80x24.org>; Fri, 13 Sep 2019 18:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbfIMSxP (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 14:53:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33623 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389927AbfIMSxP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 14:53:15 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F3F73C0008;
        Fri, 13 Sep 2019 18:53:11 +0000 (UTC)
Date:   Sat, 14 Sep 2019 00:23:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: Re: [PATCH] git-gui: add horizontal scrollbar to commit buffer
Message-ID: <20190913185309.m766nxjo6wby47hf@yadavpratyush.com>
References: <f9bf70bfae825228a7afee705babc1915b579072.1568315704.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bf70bfae825228a7afee705babc1915b579072.1568315704.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can you please add a version number when you send re-rolls the next time 
around. Something like "[PATCH v2] subject...". Makes it easier for me 
to keep track of things when there are multiple re-rolls of multiple 
patches.

You can do this by passing "-v2" (or "-v3", "-v4", etc) to 
git-send-email or git-format-patch.

You missed two quick questions I had in the last version. I'll ask them 
again below. Other than those two, LGTM. Thanks.

On 12/09/19 09:20PM, Bert Wesarg wrote:
> While the commit message widget has a configurable fixed width, it
> nevertheless allowed to write commit messages which exceeded this limit.
> Though there is no visual clue, that there is scrolling going on. Now
> there is a horizontal scrollbar.

Looks much better!
 
> There seems to be a bug in at least Tcl/Tk up to version 8.6.8, which
> does not update the horizontal scrollbar if one removes the whole
> content at once.
> 
> Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..032ebd6 100755
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

If I remove this change, the behavior does not seem to change, and the 
commit message buffer still expands. So what exactly does this change 
do?

>  pack .vpane.lower.commarea.buffer.header -side top -fill x
> -pack .vpane.lower.commarea.buffer.frame -side left -fill y
> +pack .vpane.lower.commarea.buffer.frame -side bottom -fill both -expand 1

I'm not too familiar with pack, but why change the side from left to 
bottom? I tested by changing it back to left and it doesn't seem to make 
a difference.

>  pack .vpane.lower.commarea.buffer -side left -fill y
>  
>  # -- Commit Message Buffer Context Menu
> -- 
> 2.21.0.789.ga095d9d866
> 

-- 
Regards,
Pratyush Yadav
