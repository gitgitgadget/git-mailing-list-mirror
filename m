Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C975A1FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 11:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbcLaLEK (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 06:04:10 -0500
Received: from ozlabs.org ([103.22.144.67]:57629 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754101AbcLaLEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 06:04:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3trL7P2Mhpz9t2C; Sat, 31 Dec 2016 22:04:01 +1100 (AEDT)
Date:   Sat, 31 Dec 2016 19:53:59 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Pierre Dumuid <pmdumuid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] Add ability to follow a remote branch with a dialog
Message-ID: <20161231085358.GB21019@fergus.ozlabs.ibm.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
 <20161215112847.14719-2-pmdumuid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215112847.14719-2-pmdumuid@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 09:58:43PM +1030, Pierre Dumuid wrote:
> A suggested name is provided when creating a new "following" branch.
> 
> Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
> ---
>  gitk | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 50d1ef4..36cba49 100755
> --- a/gitk
> +++ b/gitk
> @@ -2673,6 +2673,7 @@ proc makewindow {} {
>  	{mc "Rename this branch" command mvbranch}
>  	{mc "Remove this branch" command rmbranch}
>  	{mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
> +	{mc "Follow this branch"  command follow_remote_branch_dialog}
>      }
>      $headctxmenu configure -tearoff 0
>  
> @@ -9947,23 +9948,100 @@ proc headmenu {x y id head} {
>      stopfinding
>      set headmenuid $id
>      set headmenuhead $head
> -    array set state {0 normal 1 normal 2 normal}
> +    array set state {0 normal 1 normal 2 normal 3 normal}
>      if {[string match "remotes/*" $head]} {
>  	set localhead [string range $head [expr [string last / $head] + 1] end]
>  	if {[info exists headids($localhead)]} {
>  	    set state(0) disabled
>  	}
> -	array set state {1 disabled 2 disabled}
> +	array set state {1 disabled 2 disabled 3 normal}

You set array(3) to "normal" just above, no need to do it again.

>      }
>      if {$head eq $mainhead} {
> -	array set state {0 disabled 2 disabled}
> +	array set state {0 disabled 2 disabled 3 disabled}
> +    } else {
> +	set state(3) disabled
>      }

As far as I can see, this will always end up with state(3) set to
"disabled", won't it?  Is that really what you want?

Paul.
