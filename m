Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6790D207F8
	for <e@80x24.org>; Sat,  6 May 2017 17:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdEFROB (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 13:14:01 -0400
Received: from mout.web.de ([212.227.15.3]:50604 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbdEFRN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 13:13:59 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoHP7-1ditCh47hp-00gIUL; Sat, 06
 May 2017 19:13:43 +0200
Subject: Re: [PATCH v3 12/25] split_commit_in_progress(): fix memory leak
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <cover.1493387231.git.johannes.schindelin@gmx.de>
 <cover.1493740497.git.johannes.schindelin@gmx.de>
 <8cc59c706934134294e91a99062f7dcc0bda17db.1493740497.git.johannes.schindelin@gmx.de>
 <8a0a2230-239e-b6c8-f7c0-8192e6cec7ec@web.de>
 <alpine.DEB.2.21.1.1705041231270.4905@virtualbox>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <49fad7f1-0bad-dbd2-89ff-5476f9b5bf91@web.de>
Date:   Sat, 6 May 2017 19:13:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705041231270.4905@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SpNws+yrhUwyI/U7RXiFbukgdpfxGOKeNYJQ4jxyg9Noj/DCl01
 QWF4FRz/XDZNV1kdLuXg1lUeZ5TaDmq1zNptgf66RI1Of0X9fhOfzhneqedX+nLBy0dY0lj
 536feLkeGm5+F5lV43l3EQwhlsZ7bu34KGB1Fx29BvxB9YnSf+nZOnZXQqBaLwXKhI72Vg7
 lRMwWu+UF9Obg01etmzag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0drT+mNSRvI=:7UsSHyza5CMvf1Z+p2qkVw
 CRp1KJyPwV+j7E7wvxMIU0AUPGV28tQkB2wh9aP90PoYnKO9OZKUdBnESXhsCbaRH6+Z5ZePL
 ol3jDjK0gNxphzRcV4ZsP66iPT5YYHcC8OCqyQsp/Zj9FDQQsy3meSjm9UphXbZFBK7U9exDl
 VogZl1f7Jm/mMbDj8rtUxucSqNcm8ehxY/3FmhOAthpszcTO718/8wXdP23vmh4VskyOY+W/m
 KSl1VdNdEYnUIY+j50oSJEy0EnZn6N+mlqKg5dnx6kJPl7naVpOjrbFmLJlkMCh4wYxtTrBdI
 gDdNa5JBVRY3yWrGblZpZwWt/p/fxWtn67PKPyqeopAacAABTUOhPTj2T0GFW+zFiRg5uCyHP
 yO8HWxEcygEE+Isf4Cx+SJW1VGL/8RTEuH+Dtb1H9fm1mTtdla4MMok/pfivd+h9Q641/lkX0
 7Vhwh7xs+dmJ9RpTcHa1pROnUKR4RsA9h7Max04rbe3lp87x2ubS1y75OEfSvJeVAXkEjZVHk
 KfQn2w8YWgbtKtfyvztClYom50DOBExt9kojoezl+YxJ4bq2JMGAfyAD0O4O29McZ4jdpZHMA
 O1l7UTo/R8aWbw/+KBOUSfSMeQtnKkM9GZR5gvjLuh8kQ2wcK3vakNZfn2DbpQHLu+T5ori0Q
 DvKCJ/S0cvN2gdiHBtCLR8//xsMXODvNhQJlj8Ra3XruiEHiszp5ys5yCHBIUhtk2wdMS4a73
 +igfHa95CY0c5uUajaRuTc8+YIyH5T95N5m92YbrKMU9izMa+p1oTJwm2YXVHb8pe63kRkjWv
 xlD5od5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.05.2017 um 12:59 schrieb Johannes Schindelin:
> Hi René,
> 
> On Wed, 3 May 2017, René Scharfe wrote:
> 
>> Am 02.05.2017 um 18:02 schrieb Johannes Schindelin:
>>> Reported via Coverity.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>    wt-status.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/wt-status.c b/wt-status.c
>>> index 0a6e16dbe0f..1f3f6bcb980 100644
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -1088,8 +1088,13 @@ static int split_commit_in_progress(struct wt_status
>>> *s)
>>>     char *rebase_orig_head =
>>>     read_line_from_git_path("rebase-merge/orig-head");
>>>    
>>>    	if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
>>> -	    !s->branch || strcmp(s->branch, "HEAD"))
>>> +	    !s->branch || strcmp(s->branch, "HEAD")) {
>>> +		free(head);
>>> +		free(orig_head);
>>> +		free(rebase_amend);
>>> +		free(rebase_orig_head);
>>>    		return split_in_progress;
>>> +	}
>>>    
>>>     if (!strcmp(rebase_amend, rebase_orig_head)) {
>>>      if (strcmp(head, rebase_amend))
>>>
>>
>> The return line could be replaced by "; else" to achieve the same
>> result, without duplicating the free calls.
> 
> True. It is much harder to explain it that way, though: the context looks
> like this:
> 
> static int split_commit_in_progress(struct wt_status *s)
>   {
>          int split_in_progress = 0;
>          char *head = read_line_from_git_path("HEAD");
>          char *orig_head = read_line_from_git_path("ORIG_HEAD");
>          char *rebase_amend = read_line_from_git_path("rebase-merge/amend");
>          char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
> 
>          if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
> -           !s->branch || strcmp(s->branch, "HEAD"))
> +           !s->branch || strcmp(s->branch, "HEAD")) {
> +               free(head);
> +               free(orig_head);
> +               free(rebase_amend);
> +               free(rebase_orig_head);
>                  return split_in_progress;
> +       }
> 
>          if (!strcmp(rebase_amend, rebase_orig_head)) {
>                  if (strcmp(head, rebase_amend))
>                          split_in_progress = 1;
>          } else if (strcmp(orig_head, rebase_orig_head)) {
>                  split_in_progress = 1;
>          }
> 
>          if (!s->amend && !s->nowarn && !s->workdir_dirty)
>                  split_in_progress = 0;
> 
>          free(head);
>          free(orig_head);
>          free(rebase_amend);
>          free(rebase_orig_head);
>          return split_in_progress;
>   }
> 
> So as you see, if we make the change you suggested, the next if() is hit
> which possibly sets split_in_progress = 0.
> 
> The thing is: this variable has been initialized to 0 in the beginning! So
> this conditional assignment would be a noop, unless any of the code paths
> before this conditional modified split_in_progress.

Right. It could have been used as a quick two-line fix.

> After you fully wrapped your head around this code, I am sure you agree
> that the code is unnecessarily confusing to begin with: why do we go out
> of our way to allocate and read all those strings, compare them to figure
> out whether there is a split in progress, just to look at bits in the
> wt_status struct (that we had available from the beginning) to potentially
> undo all of that.

The only function with a higher cyclomatic complexity in this file is
wt_longstatus_print(), which spans more than 100 lines.  Amazing.

> What's worse, I cannot even find a logical explanation why the code is so
> confusing, as it has been added as it is today in commit 2d1ccebae41
> (status: better advices when splitting a commit (during rebase -i),
> 2012-06-10).

Repeatedly I get the impression that defects or shortcomings tend to
cluster.  It pays to take a good look at the code surrounding a find of
an automatic checker for other possible improvements.

> So I think this function really wants to be fixed more fully (although I
> feel bad for inserting such a non-trivial fix into a patch series
> otherwise populated by trivial memory/resource leak plugs):

It could be done in two steps.  Doing it in one is probably OK as well.

> -- snipsnap --
> Subject: [PATCH] squash! split_commit_in_progress(): fix memory leak
> 
> split_commit_in_progress(): simplify & fix memory leak
> 
> This function did a whole lot of unnecessary work, such as reading in
> four files just to figure out that, oh, hey, we do not need to look at
> them after all because the HEAD is not detached.
> 
> Simplify the entire function to return early when possible, to read in
> the files only when necessary, and to release the allocated memory
> always (there was a leak, reported via Coverity, where we failed to
> release the allocated strings if the HEAD is not detached).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   wt-status.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 1f3f6bcb980..117ac8cfb01 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1082,34 +1082,29 @@ static char *read_line_from_git_path(const char *filename)
>   static int split_commit_in_progress(struct wt_status *s)
>   {
>   	int split_in_progress = 0;
> -	char *head = read_line_from_git_path("HEAD");
> -	char *orig_head = read_line_from_git_path("ORIG_HEAD");
> -	char *rebase_amend = read_line_from_git_path("rebase-merge/amend");
> -	char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
> -
> -	if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
> -	    !s->branch || strcmp(s->branch, "HEAD")) {
> -		free(head);
> -		free(orig_head);
> -		free(rebase_amend);
> -		free(rebase_orig_head);
> -		return split_in_progress;
> -	}
> -
> -	if (!strcmp(rebase_amend, rebase_orig_head)) {
> -		if (strcmp(head, rebase_amend))
> -			split_in_progress = 1;
> -	} else if (strcmp(orig_head, rebase_orig_head)) {
> -		split_in_progress = 1;
> -	}
> +	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
> +
> +	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
> +	    !s->branch || strcmp(s->branch, "HEAD"))
> +		return 0;
>   
> -	if (!s->amend && !s->nowarn && !s->workdir_dirty)
> -		split_in_progress = 0;
> +	head = read_line_from_git_path("HEAD");
> +	orig_head = read_line_from_git_path("ORIG_HEAD");
> +	rebase_amend = read_line_from_git_path("rebase-merge/amend");
> +	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");

Further improvement idea (for a later series): Use rebase_path_amend()
and rebase_path_orig_head() somehow, to build each path only once.

Accessing the files HEAD and ORIG_HEAD directly seems odd.

The second part of the function should probably be moved to sequencer.c.

> +
> +	if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
> +		; /* fall through, no split in progress */

You could set split_in_progress to zero here.  Would save a comment
without losing readability.

> +	else if (!strcmp(rebase_amend, rebase_orig_head))
> +		split_in_progress = !!strcmp(head, rebase_amend);
> +	else if (strcmp(orig_head, rebase_orig_head))
> +		split_in_progress = 1;
>   
>   	free(head);
>   	free(orig_head);
>   	free(rebase_amend);
>   	free(rebase_orig_head);
> +

Isn't the patch big enough already without rearranging the else blocks
and adding that blank line? :)

>   	return split_in_progress;
>   }
>   
> 
