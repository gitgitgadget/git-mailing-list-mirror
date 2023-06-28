Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C6AEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 08:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjF1IeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:34:15 -0400
Received: from giraff.fripost.org ([193.234.15.44]:58560 "EHLO
        outgoing.fripost.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjF1Ib7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 04:31:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id 216F32AB23FA;
        Wed, 28 Jun 2023 09:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:message-id
        :user-agent:references:in-reply-to:subject:subject:from:from
        :date:date:mime-version; s=9df9cdc7e101629b5003b587945afa70; t=
        1687936371; x=1689750772; bh=r+/jPn1PUadqyNa8nt4uNiyPxodwj1YFbVm
        lukQ87qY=; b=M647j2YPLTqloDbazRX8Fr4UrUHpr3vZ1eUvSS8tEn9mJx465tl
        Za+7cSlWj/I5PyYR+V+jRxGJCnVLI3UNRS/AfT5R452xJxYEAs2g/4dp86oYMwju
        vGG2NIyaoo+qBgzWY4+QzaVftWYyT7mzUaq4x2u9MJc9cAc1+RkiAweg0DjzNrLn
        391URrrIX1+06Tq1vioc+ySjVE8qojSbGXl2S4EzMHGphEh9U5FUFNiBi0iaaS4L
        g89POTOMIuOwD7QoQLMT8hQAe7gpAfHnhcygc+pQmK0BPPyCt/L8FeczSk3b/gOE
        ZI1Qw8xp1u6VrymUVcbQCuPUK6QGgEOPxXg==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id n8Bmqzw5I7Ly; Wed, 28 Jun 2023 09:12:51 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id F06AB2AB23F5;
        Wed, 28 Jun 2023 09:12:50 +0200 (CEST)
Received: from mail.fripost.org (unknown [172.16.0.4])
        by smtp.fripost.org (Postfix) with ESMTPA id D81B896129E1;
        Wed, 28 Jun 2023 09:12:50 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 28 Jun 2023 09:12:50 +0200
From:   =?UTF-8?Q?Jens_Lidestr=C3=B6m?= <jens@lidestrom.se>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org
Subject: Re: [PATCH 6/9] gitk: add keyboard bind for create and remove branch
In-Reply-To: <7c73cc47-302d-8706-dd7f-fd034ef8d945@kdbg.org>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <661f098d882e64391ff76647e3764d58c6cbb50a.1687876885.git.gitgitgadget@gmail.com>
 <7c73cc47-302d-8706-dd7f-fd034ef8d945@kdbg.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <36b3ce90d4ecc9eb9fa5174aba0cf9d4@lidestrom.se>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +[mc "<%s-C>		Create branch on selected commit" $M1T]
> 
> ... "C"? Which one is it?

"C" is a mistake. Good catch, thanks!

I choose Ctrl-B to avoid a conflict with Ctrl-C for copying text.

> The key binding to remove a branch does not make sense to me. It does
> happen that I have more than one branch on a commit, but there is no 
> way
> to select which one to remove via the keyboard. I have to use the
> context menu. This needs more thought IMHO.

My intention is to always remove the first branch head that is displayed 
for a single commit in the GUI. This caters to the common use case, with 
only one branch for a single commit. If there are multiple branch heads 
on a commit and the users don't want to remove the first one then they 
need to use the mouse context menu to choose which one to delete.

I could change the implementation to display a dialog that lets the user 
choose in case of multiple branch heads.

In that case, should I do that as part of this PR, or as a follow up? I 
would prefer to finish this one first.

> At a minimum, separate it out into its own commit.

I'll do so.

/Jens

On 2023-06-28 07:59, Johannes Sixt wrote:
> Am 27.06.23 um 16:41 schrieb Jens Lidestrom via GitGitGadget:
>> From: Jens Lidestrom <jens@lidestrom.se>
>> 
>> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
>> ---
>>  gitk-git/gitk | 25 ++++++++++++++++---------
>>  1 file changed, 16 insertions(+), 9 deletions(-)
>> 
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> index 596977abe89..0d83a72a424 100755
>> --- a/gitk-git/gitk
>> +++ b/gitk-git/gitk
>> @@ -2692,6 +2692,8 @@ proc makewindow {} {
>>      bind $ctext <<Selection>> rehighlight_search_results
>>      bind . <$M1B-t> {resethead [selected_line_id]}
>>      bind . <$M1B-o> {checkout [selected_line_head] 
>> [selected_line_id]}
>> +    bind . <$M1B-m> {rmbranch [selected_line_head] [selected_line_id] 
>> 1}
>> +    bind . <$M1B-b> {mkbranch [selected_line_id]}
> 
> "b" vs...
> 
>>      for {set i 1} {$i < 10} {incr i} {
>>          bind . <$M1B-Key-$i> [list go_to_parent $i]
>>      }
>> @@ -2735,7 +2737,7 @@ proc makewindow {} {
>>      makemenu $headctxmenu {
>>          {mc "Check out this branch" command {checkout $headmenuhead 
>> $headmenuid}}
>>          {mc "Rename this branch" command mvbranch}
>> -        {mc "Remove this branch" command rmbranch}
>> +        {mc "Remove this branch" command {rmbranch $headmenuhead 
>> $headmenuid 0}}
>>          {mc "Copy branch name" command {clipboard clear; clipboard 
>> append $headmenuhead}}
>>      }
>>      $headctxmenu configure -tearoff 0
>> @@ -3185,6 +3187,8 @@ proc keys {} {
>>  [mc "<F5>		Update"]
>>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
>>  [mc "<%s-O>		Check out selected commit" $M1T]
>> +[mc "<%s-C>		Create branch on selected commit" $M1T]
> 
> ... "C"? Which one is it?
> 
>> +[mc "<%s-M>		Remove selected branch" $M1T]
>>  " \
>>              -justify left -bg $bgcolor -border 2 -relief groove
>>      pack $w.m -side top -fill both -padx 2 -pady 2
>> @@ -9576,13 +9580,13 @@ proc wrcomcan {} {
>>      unset wrcomtop
>>  }
>> 
>> -proc mkbranch {} {
>> -    global NS rowmenuid
>> +proc mkbranch {id} {
>> +    global NS
>> 
>>      set top .branchdialog
>> 
>>      set val(name) ""
>> -    set val(id) $rowmenuid
>> +    set val(id) $id
>>      set val(command) [list mkbrgo $top]
>> 
>>      set ui(title) [mc "Create branch"]
>> @@ -10054,13 +10058,14 @@ proc readcheckoutstat {fd newhead newheadref 
>> newheadid} {
>>      }
>>  }
>> 
>> -proc rmbranch {} {
>> -    global headmenuid headmenuhead mainhead
>> +proc rmbranch {head id shouldComfirm} {
>> +    global mainhead
>>      global idheads
>> -
>> -    set head $headmenuhead
>> -    set id $headmenuid
>>      # this check shouldn't be needed any more...
>> +    if {$head eq ""} {
>> +        error_popup [mc "Cannot delete a detached head"]
>> +        return
>> +    }
>>      if {$head eq $mainhead} {
>>          error_popup [mc "Cannot delete the currently checked-out 
>> branch"]
>>          return
>> @@ -10070,6 +10075,8 @@ proc rmbranch {} {
>>          # the stuff on this branch isn't on any other branch
>>          if {![confirm_popup [mc "The commits on branch %s aren't on 
>> any other\
>>                          branch.\nReally delete branch %s?" $head 
>> $head]]} return
>> +    } elseif {$shouldComfirm} {
>> +        if {![confirm_popup [mc "Really delete branch %s?" $head]]} 
>> return
>>      }
>>      nowbusy rmbranch
>>      update
> 
> The key binding to remove a branch does not make sense to me. It does
> happen that I have more than one branch on a commit, but there is no 
> way
> to select which one to remove via the keyboard. I have to use the
> context menu. This needs more thought IMHO. At a minimum, separate it
> out into its own commit.
> 
> -- Hannes
