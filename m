From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 00/16] worktree: use "git reset --hard" to populate worktree
Date: Tue, 14 Jul 2015 11:53:32 +0200
Message-ID: <55A4DC1C.90908@drmicha.warpmail.net>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com> <xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 12:03:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEx3H-0006Cl-L3
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 12:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbbGNKC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 06:02:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41691 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753919AbbGNKC5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2015 06:02:57 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2015 06:02:57 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0D1CE20334
	for <git@vger.kernel.org>; Tue, 14 Jul 2015 05:53:34 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 14 Jul 2015 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=W7jS6cQZoJa0t4FiDVE2PBTbRHU=; b=Au/eQl
	iPM5wsQPWmwS/4Be3qj6p74uWNol8ksNg3MNaMiXpM73NZ6StwoU1/odWmNc6LeY
	Km73Kk0b4usnka3ySuKbDe9oeOJfChlhv8tc5QcTZh95lR9GRcP+JW8b2iOa/KiB
	Q0jXKyksf4kF7MtC9oG82LlaJo786GFTIm/O8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=W7jS6cQZoJa0t4F
	iDVE2PBTbRHU=; b=ZulivlRp/ZjQ2JFxqdw3+k1Z9QxB5q+wrrBjkb+wUlU2HqK
	06A2by+b3OEMIuA5fWUozXKI5EJDYZgi5cfMtDRAFdOI6NJwD4ZoSlPLSzC3MHdc
	CFmoaYwAB22YLhGhUEexUr366gbzunNEGejy+4nYpy15s+IRYeG7kYVcoOi8=
X-Sasl-enc: fdDdItvNP3m09TqIZePP7XyUcwS+wDnxJ0ZH1dZp0Mbt 1436867613
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 18894680120;
	Tue, 14 Jul 2015 05:53:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273945>

Junio C Hamano venit, vidit, dixit 13.07.2015 20:36:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> This is a follow-on series to [1], which migrated "git checkout --to"
>> functionality to "git worktree add". That series continued using "git
>> checkout" for the initial population of the new worktree, which required
>> git-checkout to have too intimate knowledge that it was operating in a
>> newly created worktree.
>>
>> This series eliminates git-checkout from the picture by instead
>> employing "git reset --hard"[2] to populate the new worktree initially.
>>
>> It is built atop 1eb07d8 (worktree: add: auto-vivify new branch when
>> <branch> is omitted, 2015-07-06), currently in 'next', which is
>> es/worktree-add except for the final patch (which retires
>> --ignore-other-worktrees) since the intention[3] was to drop that patch.
> 
> A few comments on things I noticed while reading (mostly coming from
> the original before this patch series):
> 
>  - What does this comment apply to?
> 
>         /*
>          * $GIT_COMMON_DIR/HEAD is practically outside
>          * $GIT_DIR so resolve_ref_unsafe() won't work (it
>          * uses git_path). Parse the ref ourselves.
>          */
> 
>    It appears in front of a call to check-linked-checkout, but I
>    think the comment attempts to explain why it manually decides
>    what the path should be in that function, so perhaps move it to
>    the callee from the caller?
> 
>  - check_linked_checkout() when trying to decide what branch is
>    checked out assumes HEAD is always a regular file, but I do not
>    think we have dropped the support of SYMLINK_HEAD yet.  It needs
>    to check st_mode and readlink(2), like resolve_ref_unsafe() does.
> 
>  - After a new skelton worktree is set up, the code runs a few
>    commands to finish populating it, under a different pair of
>    GIT_DIR/GIT_WORK_TREE, but the function does so with setenv(); it
>    may be cleaner to use cp.env[] for it, as the process we care
>    about using the updated environment is not "worktree add" command
>    we are running ourselves, but "update-ref/symbolic-ref" and
>    "reset" commands that run in the new worktree.
> 
> Other than that, looks nicely done.
> 
> I however have to wonder if the stress on "reset --hard" on log
> messages of various commits (and in the endgame) is somewhat
> misplaced.
> 
> The primary thing we wanted to see, which this series nicely brings
> us, is to remove "new-worktree-mode" hack from "checkout" (in other
> words, instead of "reset --hard", "checkout -f" would also have been
> a satisfactory endgame).
> 
> Thanks.
> 

Related to that, I'm interested in "worktree list", and I'm wondering
how many more worktree commands we foresee, and therefore how much
refactoring should be done: Currently, the parsing of the contents of
.../worktrees/ into worktree information is done right in prune-spcefic
functions. They will have to be refactored. The following questions come
to my mind:

- Is a simple funtion refactoring enough, or should we introduce a
worktree struct (and a list of such)?
- Should each command do its own looping, or do we want
for_each_worktree() with a callback?
- Is a fixed output format for "list"[1] enough, or do we want something
like for-each-ref or log formats (GSOC project...)?
- Finally: Who will be stepping on whose toes doing this?

Michael

[1] Something like:

* fooworktree (master)
  barworktree (HEAD detached from deadbeef)

with "*" denoting the worktree you're in (if any) and (optionally?)
adding the "on" info from "git branch" in parentheses after each
worktree (checked out branch name, or detached info). Maybe the path, too?
