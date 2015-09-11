From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Fri, 11 Sep 2015 19:10:48 -0400
Message-ID: <CAPig+cQ4BUbS0ZQ=NoDO9JZmWYRzX0vhoi-W9ahg3yaWM+pKQw@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-3-git-send-email-rappazzo@gmail.com>
	<xmqqk2rx0w54.fsf@gitster.mtv.corp.google.com>
	<CANoM8SUGmb=fSFqF4DTuW2F5oPVaim-=SP76rqwwqtzcsNQf=g@mail.gmail.com>
	<xmqqbnd8zks9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Rappazzo <rappazzo@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 01:10:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXT4-0003eq-1i
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbbIKXKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:10:51 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34938 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbbIKXKt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 19:10:49 -0400
Received: by ykdu9 with SMTP id u9so107148793ykd.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HjVfcoNHvxo1K6fxUyWu876GkKE5MxRZlUGopNFHnZQ=;
        b=VtMFHO+zZ71AVjS5JWya7WOEqqUr2oY4cA2R5IP9JniGyKzUWz0muPH5u5lQ6VczrX
         1B1JGqKM/egXZxdQsk7LF50nkd2aOAjdtTOg8Tho92cLSwrlWeA54m5fxX737/4RuuQI
         vME/W5Ce9e13noFglSH75SOxmRI42rFmuHkaNtbRX+DcE3t5rdc+dN8DXqaHHyKojc93
         7l1tmmSt/BekGna8b82ri6yHwIEg11uSR1OkGTrMHAzyS9GTNX9EI07KmRy2YfFm/by8
         j83Sx3uOdkTgqe69xIFDMYRoXAdRRAyRQHRLxdrrFJCWvJ3KQZL6T4O+Okx0vaH4muV+
         u9qQ==
X-Received: by 10.129.70.195 with SMTP id t186mr1613210ywa.4.1442013048292;
 Fri, 11 Sep 2015 16:10:48 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Fri, 11 Sep 2015 16:10:48 -0700 (PDT)
In-Reply-To: <xmqqbnd8zks9.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: IF9hvbMLQOidrVcxS-XvupzZsJI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277707>

On Fri, Sep 11, 2015 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Rappazzo <rappazzo@gmail.com> writes:
>> On Fri, Sep 11, 2015 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Michael Rappazzo <rappazzo@gmail.com> writes:
>>>> The code formerly in branch.c was largely the basis of the
>>>> get_worktree_list implementation is now moved to worktree.c,
>>>> and the find_shared_symref implementation has been refactored
>>>> to use get_worktree_list
>>>
>>> Copying the bulk of the function in 1/3 and then removing the
>>> original here made it somewhat hard to compare what got changed in
>>> the implementation.
>>>
>>> I _think_ the code structure in the end result is more or less
>>> right, though.
>>
>> Should I squash these first two commits together in the next series?
>
> Mashing the two into one patch would not help anybody, I would
> suspect.
>
> I didn't try this myself, but if I were doing this and if I were
> aiming for perfection, then I would probably try to split it even
> finer.  Refactor the original while both the callers and the helpers
> are still inside branch.c (hence the early steps in the series will
> not benefit worktree.c at all---worktree.c may not even exist in
> them yet), move refactored helpers to worktree.[ch] (and at this
> step you may not even have get_worktree() etc. yet), and then use
> that refactored helper while writing new functions in worktree.c.

Thanks for bringing this up. I haven't found a sufficient block of
time yet to review these patches, however, I had the same thought upon
a quick initial read, and is how I was hoping to see the patch series
constructed based upon my earlier two reviews suggesting refactoring
the existing branch.c functions into a new get_worktrees(). There are
at least a couple important reasons for taking this approach.

First, it keeps the "blame" trail intact, the full context of which
can be helpful to someone trying to understand why the code is the way
it is. The current approach of having get_worktree_list() materialize
out of thin air (even though it may have been patterned after existing
code) doesn't give the same benefit.

Second, it's easier for reviewers to understand and check the code for
correctness if it mutates to the final form in small increments than
it is to have get_worktrees() come into existence fully matured.

A final minor comment: Since all three branch.c functions,
die_if_checked_out(), find_shared_symref(), and find_linked_symref(),
ought to be moved to top-level worktree.c, I'd probably have patch 1
do the relocation (with no functional changes), and subsequent patches
refactor the moved code into a general purpose get_worktrees(). The
final patch would then implement "git worktrees list".
