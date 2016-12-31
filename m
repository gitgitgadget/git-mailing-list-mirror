Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41AB71FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 11:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbcLaLEG (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 06:04:06 -0500
Received: from ozlabs.org ([103.22.144.67]:35147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752181AbcLaLEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 06:04:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3trL7P2gDwz9t1P; Sat, 31 Dec 2016 22:04:01 +1100 (AEDT)
Date:   Sat, 31 Dec 2016 19:30:51 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Pierre Dumuid <pmdumuid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] Enable ability to visualise the results of git
 cherry C1 C2
Message-ID: <20161231083051.GA21019@fergus.ozlabs.ibm.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215112847.14719-1-pmdumuid@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 09:58:42PM +1030, Pierre Dumuid wrote:
> It's a bit clunky but it works!!
> 
> Usage:
>  - mark commit one (e.g. v45)
>  - Select commit two.
>  - Switch the gdttype to the option, "git-cherry between marked commit and:"

This needs a better description.  "Git-cherry between marked commit
and" is a description of an implementation not a description of what's
being achieved.  Having read the git cherry man page, it seems like
it's (Find commit) included in marked commit but not in this commit
(or the other way around?).  We would need a terser description that
that, though.

[...]

> +proc update_gitcherrylist {} {
> +    global gitcherryids
> +    global markedid
> +    global findstring
> +    global fstring
> +    global currentid
> +    global iddrawn
> +
> +    unset -nocomplain gitcherryids
> +    set fs $findstring
> +
> +    if {$findstring eq {}} {
> +	$fstring delete 0 end
> +	$fstring insert 0 $currentid
> +    }
> +
> +    if {![info exists markedid]} {
> +	error_popup [mc "Please mark a git commit before using this find method!"]
> +	return
> +    }
> +
> +    #puts [join [list "Running cherry between: `" $markedid "` and `" $findstring "`"] ""]
> +
> +    if {[catch {set cherryOutput [exec git cherry $markedid $findstring]}]} {

How long could the git cherry take to run?  If it's more than a
fraction of a second, then we would need to handle its output
asynchronously like we do in [do_file_hl].

Paul.
