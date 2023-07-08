Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06ECEB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 12:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGHMJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGHMJo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 08:09:44 -0400
Received: from outgoing.fripost.org (giraff.fripost.org [193.234.15.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509E1BD2
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 05:09:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id 7E6252ACD886;
        Sat,  8 Jul 2023 14:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :content-language:references:subject:subject:from:from
        :user-agent:mime-version:date:date:message-id; s=
        9df9cdc7e101629b5003b587945afa70; t=1688818179; x=1690632580;
         bh=sqqbQtR+1uQ0GfO0cCJ/2Pf0ygUU15bgB7kmxzVvhmU=; b=XoX7Kx31e0qN
        ogpmu2xj15e8m8wX8qgprU/6pgl/cabLQtlH03g3Acw7/lbiS1l8VLDlWlezQF8f
        Rpe+yCCldhwuktErm3v6on76BXPOZqOSCT2hwFRtdFKH61tV3Why+EA3v3TX7e+G
        Vrwswr4km1HTWz2AjT3bV5lwCdGkfJDfHt0ddfqRkVlGnZbJTJNImctSCAlCVF3X
        Gmd6+vOWu/7vx3HIjoMtQt5RPGplwFGkO8qqKHddL3+r7gOv3CjMu+Fa6bcZmPBm
        CUKRQvoD1npv7m7ph9/tik3y2wI/0PsKp6/ngSCrJi+0MpIoyqBFxDEBuAuSFnCs
        xMZA8OOLcw==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id BmF4mOgbiehn; Sat,  8 Jul 2023 14:09:39 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id 5F9DA2ACD881;
        Sat,  8 Jul 2023 14:09:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        by smtp.fripost.org (Postfix) with ESMTPSA id 3DC5D965C261;
        Sat,  8 Jul 2023 14:09:39 +0200 (CEST)
Message-ID: <b70d1804-7f6a-d688-028b-abd8f9307240@lidestrom.se>
Date:   Sat, 8 Jul 2023 14:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>
Subject: Re: [PATCH v2 07/10] gitk: add keyboard bind for cherry-pick command
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
 <54afa8fe9e831f5381d045bc24464ff2d6246118.1688409958.git.gitgitgadget@gmail.com>
 <3d3dd74a-aed3-b2cf-1be3-8a14129e3f4a@kdbg.org>
Content-Language: en-GB
In-Reply-To: <3d3dd74a-aed3-b2cf-1be3-8a14129e3f4a@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +        {mc "Create new branch" command {mkbranch $rowmenuid}}
>> +        {mc "Cherry-pick this commit" command {cherrypick $rowmenuid}}
> 
> The change regarding Create new branch is not related to this commit's
> topic and should be elsewhere.

Sorry, sloppy mistake, will fix, thanks.

>> +    if {! [info exists headids($mainhead)]} {
>> +        error_popup [mc "Cannot cherry-pick to a detached head"]
>> +        return
>> +    }
> 
> Why is it necessary to forbid this now? It was not forbidden before.

Oh, I had no idea you can actually cherry-pick to a detached head! When a added this check I though I fixed an existing bug, which only manifested if the user had checked out a detached head using the terminal and then used cherry-pick in gitk. I now see that it is not an error.

I have mixed feelings about allowing this, but it's probably best to not invent artificial limitations in gitk, so I'll remove the check.

/Jens

On 2023-07-05 22:07, Johannes Sixt wrote:
> Am 03.07.23 um 20:45 schrieb Jens Lidestrom via GitGitGadget:
>> From: Jens Lidestrom <jens@lidestrom.se>
>>
>> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
>> ---
>>  gitk-git/gitk | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> index 65ca11becca..351b88f10c0 100755
>> --- a/gitk-git/gitk
>> +++ b/gitk-git/gitk
>> @@ -2690,6 +2690,7 @@ proc makewindow {} {
>>      bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
>>      bind $ctext <Button-1> {focus %W}
>>      bind $ctext <<Selection>> rehighlight_search_results
>> +    bind . <$M1B-p> {cherrypick [selected_line_id]}
>>      bind . <$M1B-t> {resethead [selected_line_id]}
>>      bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
>>      bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
>> @@ -2710,8 +2711,8 @@ proc makewindow {} {
>>          {mc "Create tag" command mktag}
>>          {mc "Copy commit reference" command copyreference}
>>          {mc "Write commit to file" command writecommit}
>> -        {mc "Create new branch" command mkbranch}
>> -        {mc "Cherry-pick this commit" command cherrypick}
>> +        {mc "Create new branch" command {mkbranch $rowmenuid}}
>> +        {mc "Cherry-pick this commit" command {cherrypick $rowmenuid}}
> 
> The change regarding Create new branch is not related to this commit's
> topic and should be elsewhere.
> 
>>          {mc "Reset current branch to here" command {resethead $rowmenuid}}
>>          {mc "Mark this commit" command markhere}
>>          {mc "Return to mark" command gotomark}
>> @@ -3186,6 +3187,7 @@ proc keys {} {
>>  [mc "<%s-minus>	Decrease font size" $M1T]
>>  [mc "<F5>		Update"]
>>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
>> +[mc "<%s-P>		Cherry-pick selected commit to current branch" $M1T]
>>  [mc "<%s-O>		Check out selected commit" $M1T]
>>  [mc "<%s-B>		Create branch on selected commit" $M1T]
>>  [mc "<%s-M>		Remove selected branch" $M1T]
>> @@ -9758,24 +9760,29 @@ proc exec_citool {tool_args {baseid {}}} {
>>      array set env $save_env
>>  }
>>  
>> -proc cherrypick {} {
>> -    global rowmenuid curview
>> +proc cherrypick {id} {
>> +    global curview headids
>>      global mainhead mainheadid
>>      global gitdir
>>  
>> +    if {! [info exists headids($mainhead)]} {
>> +        error_popup [mc "Cannot cherry-pick to a detached head"]
>> +        return
>> +    }
> 
> Why is it necessary to forbid this now? It was not forbidden before.
> 
>> +
>>      set oldhead [exec git rev-parse HEAD]
>> -    set dheads [descheads $rowmenuid]
>> +    set dheads [descheads $id]
>>      if {$dheads ne {} && [lsearch -exact $dheads $oldhead] >= 0} {
>>          set ok [confirm_popup [mc "Commit %s is already\
>>                  included in branch %s -- really re-apply it?" \
>> -                                   [string range $rowmenuid 0 7] $mainhead]]
>> +                                   [string range $id 0 7] $mainhead]]
>>          if {!$ok} return
>>      }
>>      nowbusy cherrypick [mc "Cherry-picking"]
>>      update
>>      # Unfortunately git-cherry-pick writes stuff to stderr even when
>>      # no error occurs, and exec takes that as an indication of error...
>> -    if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
>> +    if {[catch {exec sh -c "git cherry-pick -r $id 2>&1"} err]} {
>>          notbusy cherrypick
>>          if {[regexp -line \
>>                   {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
>> @@ -9791,7 +9798,7 @@ proc cherrypick {} {
>>                          resolve it?"]]} {
>>                  # Force citool to read MERGE_MSG
>>                  file delete [file join $gitdir "GITGUI_MSG"]
>> -                exec_citool {} $rowmenuid
>> +                exec_citool {} $id
>>              }
>>          } else {
>>              error_popup $err
> 


