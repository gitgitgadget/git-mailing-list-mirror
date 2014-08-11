From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2 02/23] rebase -i: allow squashing empty commits without
 complaints
Date: Mon, 11 Aug 2014 09:01:48 +0200
Message-ID: <53E86A5C.2050202@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1407368621.git.bafain@gmail.com>	<16751a4402233b6c2925bf00d7ecebdccedd0eef.1407368621.git.bafain@gmail.com> <CAPig+cSvLwcwZ_8R0nRYst9V9mfRqc-HMDhyrCoU6cxE254Agg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Phil Hord <phil.hord@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 09:02:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGjcC-0007eJ-EB
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 09:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbaHKHBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 03:01:52 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47860 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbaHKHBv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 03:01:51 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so5050028wiw.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cx92EgcHPL7hLaPDCtuUzlmL04p07C30JcSyMhQMyP8=;
        b=Wf2OdUA8yGm7Fr1bH9waQdfBzWBbcmyB9/E2Ou7VDxI93MLfzAHd/dgouKO523Fz74
         GC4XLPINYa/4dHGKHPrhaS3GMkKWeTPqpPUWo9uWjvXAMzr+Wpd7IgRDavz01JmZyNeS
         LxvsAV3AhX79rhtdl+4fHuDPlOSx9+TasdudCmlOLp2oyvt4g6MgiXumMsvNzUoXSwA9
         a2L8hm9RTAI42iQndbkEQksXgMTMjCHyqeBpUcnaSsb8mHpnO9WUrh0U+WvTqPYn9bVE
         Pn/yBqwAgeCOLa4+CBFqaRgpG4M5FhtDrKZ0ZwKilJDGBmgahJbq76r+qmnoUrKLiubT
         tA8w==
X-Received: by 10.194.8.35 with SMTP id o3mr51476829wja.3.1407740510314;
        Mon, 11 Aug 2014 00:01:50 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id xw9sm9143872wjc.32.2014.08.11.00.01.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 00:01:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cSvLwcwZ_8R0nRYst9V9mfRqc-HMDhyrCoU6cxE254Agg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255117>

Hi Eric,

Eric Sunshine writes:
> On Wed, Aug 6, 2014 at 7:59 PM, Fabian Ruch <bafain@gmail.com> wrote:
>> The to-do list commands `squash` and `fixup` apply the changes
>> introduced by the named commit to the tree but instead of creating
>> a new commit on top of the current head it replaces the previous
>> commit with a new commit that records the updated tree. If the
>> result is an empty commit git-rebase stops with the error message
>>
>>    You asked to amend the most recent commit, but doing so would make
>>    it empty. You can repeat your command with --allow-empty, or you can
>>    remove the commit entirely with "git reset HEAD^".
>>
>> This message is not very helpful because neither does git-rebase
>> support an option `--allow-empty` nor does the messages say how to
>> resume the rebase. Firstly, change the error message to
>>
>>    The squash result is empty and --keep-empty was not specified.
>>
>>    You can remove the squash commit now with
>>
>>      git reset HEAD^
>>
>>    Once you are down, run
> 
> I guess you meant: s/down/done
> 
> Same issue with the actually message in the code (below).

Fixed.

>>      git rebase --continue
>>
>> If the user wishes to squash a sequence of commits into one
>> commit, f. i.
>>
>>    pick A
>>    squash Revert "A"
>>    squash A'
>>
>> , it does not matter for the end result that the first squash
>> result, or any sub-sequence in general, is going to be empty. The
>> squash message is not affected at all by which commits are created
>> and only the commit created by the last line in the sequence will
>> end up in the final history. Secondly, print the error message
>> only if the whole squash sequence produced an empty commit.
>>
>> Lastly, since an empty squash commit is not a failure to rewrite
>> the history as planned, issue the message above as a mere warning
>> and interrupt the rebase with the return value zero. The
>> interruption should be considered as a notification with the
>> chance to undo it on the spot. Specifying the `--keep-empty`
>> option tells git-rebase to keep empty squash commits in the
>> rebased history without notification.
>>
>> Add tests.
>>
>> Reported-by: Peter Krefting <peter@softwolves.pp.se>
>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>> ---
>> Hi,
>>
>> Peter Krefting is cc'd as the author of the bug report "Confusing
>> error message in rebase when commit becomes empty" discussed on the
>> mailing list in June. Phil Hord and Jeff King both participated in
>> the problem discussion which ended with two proposals by Jeff.
>>
>> Jeff King writes:
>>>   1. Always keep such empty commits. A user who is surprised by them
>>>      being empty can then revisit them. Or drop them by doing another
>>>      rebase without --keep-empty.
>>>
>>>   2. Notice ourselves that the end-result of the whole squash is an
>>>      empty commit, and stop to let the user deal with it.
>>
>> This patch chooses the second alternative. Either way seems OK. The
>> crucial consensus of the discussion was to silently throw away empty
>> interim commits.
>>
>>    Fabian
>>
>>  git-rebase--interactive.sh    | 20 +++++++++++---
>>  t/t3404-rebase-interactive.sh | 62 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 79 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 3222bf6..8820eac 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -549,7 +549,7 @@ do_next () {
>>                 squash|s|fixup|f)
>>                         # This is an intermediate commit; its message will only be
>>                         # used in case of trouble.  So use the long version:
>> -                       do_with_author output git commit --allow-empty-message \
>> +                       do_with_author output git commit --allow-empty-message --allow-empty \
>>                                 --amend --no-verify -F "$squash_msg" \
>>                                 ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>>                                 die_failed_squash $sha1 "$rest"
>> @@ -558,18 +558,32 @@ do_next () {
>>                         # This is the final command of this squash/fixup group
>>                         if test -f "$fixup_msg"
>>                         then
>> -                               do_with_author git commit --allow-empty-message \
>> +                               do_with_author git commit --allow-empty-message --allow-empty \
>>                                         --amend --no-verify -F "$fixup_msg" \
>>                                         ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>>                                         die_failed_squash $sha1 "$rest"
>>                         else
>>                                 cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
>>                                 rm -f "$GIT_DIR"/MERGE_MSG
>> -                               do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
>> +                               do_with_author git commit --allow-empty --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
>>                                         ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>>                                         die_failed_squash $sha1 "$rest"
>>                         fi
>>                         rm -f "$squash_msg" "$fixup_msg"
>> +                       if test -z "$keep_empty" && is_empty_commit HEAD
>> +                       then
>> +                               echo "$sha1" >"$state_dir"/stopped-sha
>> +                               warn "The squash result is empty and --keep-empty was not specified."
>> +                               warn
>> +                               warn "You can remove the squash commit now with"
>> +                               warn
>> +                               warn "  git reset HEAD^"
>> +                               warn
>> +                               warn "Once you are down, run"
> 
> s/down/done/

Thanks for the thorough reading.

   Fabian
