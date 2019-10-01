Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C171F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 15:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbfJAPmD (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 11:42:03 -0400
Received: from smtp125.iad3b.emailsrvr.com ([146.20.161.125]:40498 "EHLO
        smtp125.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbfJAPmD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Oct 2019 11:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1569944522;
        bh=IyITJYxWvEXWy1KMoyRicv4AxYogTMh/qEBLxMXpbTQ=;
        h=Subject:To:From:Date:From;
        b=dD8rIQ9XzpR89UJZFZs2WQmLLt5G0PWkgrH1FIc5yiBmKmL3Ai0p8+OdeaP0jYxE4
         jUcUHZmyh+WoLyiJcPw9lcIFE9OSTKBHt3gzLnfh+KxbOJAquosIrgJ8slEq8Qww6t
         7kX/DbwQRSNCeomAZr/EYliiYL7Zapna4qLLLvII=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp8.relay.iad3b.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EEE8A401AB;
        Tue,  1 Oct 2019 11:42:01 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 01 Oct 2019 11:42:02 -0400
Subject: Re: [PATCH] gitk: Add horizontal scrollbar to the files list
To:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Cc:     paulus@ozlabs.org
References: <5c5803ac99b6aaf7ca39393422ca9aa17f0280ec.1569910203.git.bert.wesarg@googlemail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <650bb0ab-50e8-96a6-957a-ebf3e75efed2@xiplink.com>
Date:   Tue, 1 Oct 2019 11:42:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5c5803ac99b6aaf7ca39393422ca9aa17f0280ec.1569910203.git.bert.wesarg@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-01 6:08 a.m., Bert Wesarg wrote:
> Wrapping filenames is an unexpected experience in UX design. Disable
> wrapping and add a horizontal scrollbar to the files list to remove this.

(Thanks for working on gitk and git-gui!)

I have to say I'm mildly opposed to this change.  The reason is that 
having to scroll to see the end of the filename is extra work, and it's 
work that would have to be repeated as one navigates between commits in 
the same area of code.  Git-gui has scrollbars for its filename panes, 
and I find them more of a hassle that gitk's wrapping.  (The horizontal 
scrollbar might work better if it defaulted to scrolling all the way to 
the *right* instead of to the left.)

But I would instead prefer there to be some visual indication that the 
filename was wrapped.  Maybe indent the wrapped lines?  Or how about 
contracting the file path with an ellipsis (...), like "git diff --stat"?

		M.


> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>   gitk | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/gitk b/gitk
> index abe4805..bf2a061 100755
> --- a/gitk
> +++ b/gitk
> @@ -2477,13 +2477,16 @@ proc makewindow {} {
>   	-background $bgcolor -foreground $fgcolor \
>   	-font mainfont \
>   	-tabs [list $indent [expr {2 * $indent}]] \
> -	-yscrollcommand ".bright.sb set" \
> +	-xscrollcommand ".bright.sbx set" \
> +	-yscrollcommand ".bright.sby set" \
>   	-cursor [. cget -cursor] \
> -	-spacing1 1 -spacing3 1
> +	-spacing1 1 -spacing3 1 -wrap none
>       lappend bglist $cflist
>       lappend fglist $cflist
> -    ${NS}::scrollbar .bright.sb -command "$cflist yview"
> -    pack .bright.sb -side right -fill y
> +    ${NS}::scrollbar .bright.sbx -orient horizontal -command "$cflist xview"
> +    ${NS}::scrollbar .bright.sby -orient vertical   -command "$cflist yview"
> +    pack .bright.sbx -side bottom -fill x
> +    pack .bright.sby -side right -fill y
>       pack $cflist -side left -fill both -expand 1
>       $cflist tag configure highlight \
>   	-background [$cflist cget -selectbackground]
> 
