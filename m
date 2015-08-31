From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 07:36:42 -0700
Message-ID: <xmqqzj17y16t.fsf@gitster.mtv.corp.google.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3-Y4T=dQmBVfRR1DEuuRZLSrUvQid8m1YttOnJc5Fj8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 16:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWQCX-0007HV-Fd
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 16:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbbHaOgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 10:36:46 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36349 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbHaOgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 10:36:45 -0400
Received: by pabpg12 with SMTP id pg12so8772513pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=S36d8Lhli3N7RYuq76jxrwwSEqWFuDIC2XF1TnbNeG8=;
        b=QTLubwSo3Stdb1GfQJf1JpeV+jSSu9jTbe/mL3+YxjKHSVHopKINecsWRnQ5TIqbEK
         rcLzJhJJ1ndAsbbrJZSuNpRhYVfbOnWjub3ETOlYUrHx1sJ5A8BoZzusXW1ok+ShgwM1
         eGKfgTtOFaDHibQo1PbITVnaK/To2AkjJen0xQOacLLdojCg8q5Ty6W3INGepZ1Dhb07
         IUjDmmAqwtV7qvNMhAE+H4+KirYkipWOqTtUeGRMMbqV3iiv896Ylv1dqXQz5WyR+ZTI
         qgA0FqvEIi6/+gADUiVQjExnrkHMRJdfTk/gCk4cyLCUomjJD6qsODxPllj17zXban5q
         v8jQ==
X-Received: by 10.68.178.1 with SMTP id cu1mr38349004pbc.1.1441031804725;
        Mon, 31 Aug 2015 07:36:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id s17sm14869129pdl.2.2015.08.31.07.36.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 07:36:44 -0700 (PDT)
In-Reply-To: <CAP8UFD3-Y4T=dQmBVfRR1DEuuRZLSrUvQid8m1YttOnJc5Fj8w@mail.gmail.com>
	(Christian Couder's message of "Sat, 29 Aug 2015 06:15:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276879>

Christian Couder <christian.couder@gmail.com> writes:

>> * dt/refs-bisection (2015-08-28) 5 commits
>>  - bisect: make bisection refs per-worktree
>>  - refs: make refs/worktree/* per-worktree
>>  - SQUASH???
>>  - path: optimize common dir checking
>>  - refs: clean up common_list
>>
>>  Move the refs used during a "git bisect" session to per-worktree
>>  hierarchy refs/worktree/* so that independent bisect sessions can
>>  be done in different worktrees.
>>
>>  Will merge to 'next' after squashing the update in.
>
> Sorry if I am missing something or repeating what myself or someone
> else like Michael already said, but in the current doc there is:
>
>        Eventually there will be no more revisions left to bisect, and
> you will have been left with the first bad kernel revision in
>        "refs/bisect/bad".
>
> If we now just use "refs/worktree/bisect/bad" instead of
> "refs/bisect/bad", it might break scripts that rely using
> "refs/bisect/bad".

Christian, thanks for raising this one.

I do recall the thread and I might be the somebody like Michael you
remember, e.g. $gmane/275105---which did mention that "git bisect"
would not need changing if we kept refs/bisect/.

What was the reason why we chose to move to refs/worktree/ again?  I
do not think there was an issue that we cannot keep refs/* in
general shared while having one (or more) subhierarchy of it per
worktree (otherwise we would not be using refs/worktree/*, but using
something outside refs/, like $GIT_DIR/worktree-refs/).  Was there an
objection to refs/bisect being private from aesthetics point of view
(i.e. forcing everything per-worktree in refs/worktree/ would prevent
proliferation of refs/this and refs/that that need to be private
case by case), ignoring the practical issue of compatibility issues
around existing tools?

I think one example of script, "gitk --bisect", does want to show
the DAG limited by bisect refs, but it does so using plumbing
without having to say refs/bisect/bad itself.  Perhaps the thinking
(or lack of enough of it) went that no other uses by scripts need to
peek directly into refs/bisect/ hierarchy?
