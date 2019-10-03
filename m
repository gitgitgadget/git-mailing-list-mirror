Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_DBL_ABUSE_PHISH shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85ED51F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfJCUCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:02:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:64716 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731089AbfJCUCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:02:52 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iG7JG-0001rE-Ca; Thu, 03 Oct 2019 21:02:47 +0100
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
To:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
 <f1477ba53a03484a0440202065a5293c8795d3b7.1569443729.git.bert.wesarg@googlemail.com>
 <20190929150406.s57pmb3dggfbcqhr@yadavpratyush.com>
 <CAKPyHN3nOL6qy4RhwwHrh2m3EJuJ1-rt-8+0+=z2oJi96Nigpw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <dc210bf0-eef3-ed58-f596-0999fd9d9a98@iee.email>
Date:   Thu, 3 Oct 2019 21:02:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKPyHN3nOL6qy4RhwwHrh2m3EJuJ1-rt-8+0+=z2oJi96Nigpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/2019 13:17, Bert Wesarg wrote:
> Pratyush,
>
> On Sun, Sep 29, 2019 at 5:04 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>> Hi Philip, Bert,
>>
>> Is there any way I can test this change? Philip, I ran the rebase you
>> mention in the GitHub issue [0], and I get that '9c8cba6862abe5ac821' is
>> an unknown revision.
>>
>> Is there any quick way I can reproduce this (maybe on a sample repo)?
> The easiest way to produce a merge conflict, is to change the same
> line differently in two branches and try to merge them. I added a
> fast-import file to demonstrate this for you.
>
> $ git init foo
> $ cd foo
> $ git fast-import <../conflict-merge.fi
> $ git reset --hard master
> $ git merge branch
>
> this gets you into the conflict, probably the usual style. Which looks
> in liek this on the terminal:
>
> @@@ -2,7 -2,7 +2,11 @@@ Lorem ipsum dolor sit amet, consectetu
>    Sed feugiat nisl eget efficitur ultrices.
>    Nunc cursus metus rutrum, mollis lorem vitae, hendrerit mi.
>    Aenean vestibulum ante ac libero venenatis, non hendrerit orci pharetra.
> ++<<<<<<< HEAD
>   +Proin bibendum purus ut est tristique, non pharetra dui consectetur.
> ++=======
> + Proin placerat leo malesuada lacinia lobortis.
> ++>>>>>>> branch
>    Pellentesque aliquam libero et nisi scelerisque commodo.
>    Quisque id velit sed magna molestie porttitor.
>    Vivamus sed urna in risus molestie ultricies.
>
> and this in git gui: https://kgab.selfhost.eu/s/gHHaQqowGp7mXEb

The snapshot of the Gui looks just the thing! (I've been away).

I'm sure this would solve my immediate issue.

My only remaining bikeshed question it prompted was to check which parts 
would be committed as part of committing the whole "hunk". But haven't 
had time to look at all!

>
> Git gui removes the '++' in front of the marker lines. It therefor
> already 'changes' the 'diff'. Though git-apply cannot handle such
> 'diffs' anyway.
>
> To get the diff3 style do:
>
> $ git merge --abort
> $ git -c merge.conflictStyle=diff3 merge branch
>
> This is how it looks in the terminal now:
>
> @@@ -2,7 -2,7 +2,13 @@@ Lorem ipsum dolor sit amet, consectetu
>    Sed feugiat nisl eget efficitur ultrices.
>    Nunc cursus metus rutrum, mollis lorem vitae, hendrerit mi.
>    Aenean vestibulum ante ac libero venenatis, non hendrerit orci pharetra.
> ++<<<<<<< HEAD
>   +Proin bibendum purus ut est tristique, non pharetra dui consectetur.
> ++||||||| merged common ancestors
> ++Proin in felis eu elit suscipit rhoncus vel ut metus.
> ++=======
> + Proin placerat leo malesuada lacinia lobortis.
> ++>>>>>>> branch
>    Pellentesque aliquam libero et nisi scelerisque commodo.
>    Quisque id velit sed magna molestie porttitor.
>    Vivamus sed urna in risus molestie ultricies.
>
> As you can see, there is not the usual 'I removed this, and added
> that' experience, everything is 'added'. Thus I inverted the pre-image
> to '--'. Here is how it looks in the gui:
> https://kgab.selfhost.eu/s/5c8Tosra7WRfjwJ
>
>> [0] https://github.com/git-for-windows/git/issues/2340
>>
>> On 25/09/19 10:38PM, Bert Wesarg wrote:
>>> This adds highlight support for the diff3 conflict style.
>>>
>>> The common pre-image will be reversed to --, because it has been removed
>>> and either replaced with ours or theirs side.
>>>
>>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>> ---
>>>   git-gui.sh   |  3 +++
>>>   lib/diff.tcl | 22 ++++++++++++++++++++++
>>>   2 files changed, 25 insertions(+)
>>>
>>> diff --git a/git-gui.sh b/git-gui.sh
>>> index fd476b6..6d80f82 100755
>>> --- a/git-gui.sh
>>> +++ b/git-gui.sh
>>> @@ -3581,6 +3581,9 @@ $ui_diff tag conf d_s- \
>>>   $ui_diff tag conf d< \
>>>        -foreground orange \
>>>        -font font_diffbold
>>> +$ui_diff tag conf d| \
>>> +     -foreground orange \
>>> +     -font font_diffbold
>>>   $ui_diff tag conf d= \
>>>        -foreground orange \
>>>        -font font_diffbold
>>> diff --git a/lib/diff.tcl b/lib/diff.tcl
>>> index 0fd4600..6caf4e7 100644
>>> --- a/lib/diff.tcl
>>> +++ b/lib/diff.tcl
>>> @@ -347,6 +347,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
>>>        }
>>>
>>>        set ::current_diff_inheader 1
>>> +     set ::conflict_state {CONTEXT}
>>>        fconfigure $fd \
>>>                -blocking 0 \
>>>                -encoding [get_path_encoding $path] \
>>> @@ -450,10 +451,28 @@ proc read_diff {fd conflict_size cont_info} {
>>>                        {++} {
>>>                                set regexp [string map [list %conflict_size $conflict_size]\
>>>                                                                {^\+\+([<>=]){%conflict_size}(?: |$)}]
>>> +                             set regexp_pre_image [string map [list %conflict_size $conflict_size]\
>>> +                                                             {^\+\+\|{%conflict_size}(?: |$)}]
>>>                                if {[regexp $regexp $line _g op]} {
>>>                                        set is_conflict_diff 1
>>>                                        set line [string replace $line 0 1 {  }]
>>> +                                     set markup {}
>>>                                        set tags d$op
>>> +                                     switch -exact -- $op {
>>> +                                     < { set ::conflict_state {OURS} }
>>> +                                     = { set ::conflict_state {THEIRS} }
>>> +                                     > { set ::conflict_state {CONTEXT} }
>>> +                                     }
>>> +                             } elseif {[regexp $regexp_pre_image $line]} {
>>> +                                     set is_conflict_diff 1
>>> +                                     set line [string replace $line 0 1 {  }]
>>> +                                     set markup {}
>>> +                                     set tags d|
>>> +                                     set ::conflict_state {BASE}
>>> +                             } elseif {$::conflict_state eq {BASE}} {
>>> +                                     set line [string replace $line 0 1 {--}]
>>> +                                     set markup {}
>>> +                                     set tags d_--
>> I'm afraid I don't follow what this hunk is supposed to do.
>>
>> You set the variable ::conflict_state to the values like OURS, THEIRS,
>> CONTEXT, but I don't see those values being used anywhere. A quick
>> search for these words shows me that you only set them, never read them.
> the last elseif depends on it.
>
> I actually only need to detect the pre-image lines, which starts with
> the ||| conflict-marker and ends with the === conflict-marker, instead
> of all possible states.
>
>> Is there some extra code that you have and I don't?
>>
>> Also, this function is long and complicated already. A comment
>> explaining what this code is doing would be nice, since it is not at all
>> obvious at first read-through.
> Will re-send.
>
> Bert
>
>>>                                } else {
>>>                                        set tags d_++
>>>                                }
>>> @@ -505,6 +524,9 @@ proc read_diff {fd conflict_size cont_info} {
>>>                        }
>>>                }
>>>                set mark [$ui_diff index "end - 1 line linestart"]
>>> +             if {[llength $markup] > 0} {
>>> +                     set tags {}
>>> +             }
>>>                $ui_diff insert end $line $tags
>>>                if {[string index $line end] eq "\r"} {
>>>                        $ui_diff tag add d_cr {end - 2c}
>>> --
>>> 2.21.0.789.ga095d9d866
>>>
>> --
>> Regards,
>> Pratyush Yadav

