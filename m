From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Introducing different handling for small/large transactions
Date: Fri, 16 Jan 2015 11:23:22 -0800
Message-ID: <CAGZ79kYc97xa6YRJ_KTUj7z2_aNa4uTDSEAA0+DiLuMPE8WuBw@mail.gmail.com>
References: <1421361371-30221-1-git-send-email-sbeller@google.com>
	<20150115224605.GD19021@peff.net>
	<CAGZ79kbXYm66StsAwHFdTovkYeDVHWV2PdCK0abVXwWiD7sAAg@mail.gmail.com>
	<20150115235310.GA25120@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:23:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCUS-0007fX-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbbAPTXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:23:24 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:51046 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbAPTXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:23:23 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so4877480igj.4
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 11:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hxdVzrsOzadvWSFOuQf0nr0REhUqkhwKY7kZvZmnG9g=;
        b=k1nv4QS1L2azw074OgIhV0YfGcvQv/Q/RjTjiMeBhHh3TNvMEWcSLEAYgghBL0GB2Z
         XIF09Y2ZApr/GWVDlb8rCLiTtY/3b8R/RgyWs2V+qcluzaSmigyTMfkyJAiDz18FstTw
         7w+Sahf7QwzWsP3sNfwIbQAZr6JHMIBjQFhxLKe88sfocb6mIdE6LnvH6AImBJG7k2xP
         YaOiZGv1PccOBmtw4HBp3QtMjYAOtDi8mYV5PETy18y6YLdB85qE64GonW5FEH48o6Vk
         0Sp2F6C2tG2fUQZ3xxRuDD0WNuWrqnbDjacBUaXOjZ7CwFopuNcpYTCC7XB6y0qLW60c
         DfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hxdVzrsOzadvWSFOuQf0nr0REhUqkhwKY7kZvZmnG9g=;
        b=DK/63JmXyMdQx0R+MwM4bi+08g+cvYtKYNN/5V16y1oAcPQ7crdNI3aVnaj2ui2JsR
         ivgrpdBB+byz40MzlcYzZPV/BraCTBKnZ2QX0jvW3e12swLDqNbJ0EuD3QNzKzprvDio
         4nw+p623CtO7c14ciDQRZ/zg46x5MAPGDqY1/Yz0WdQQ/dE9+pDRwZHZ4Ut0zDGuL9FA
         mjDPrFyj5Qd+XxiVUF6yXMzzyGgIAKWtVBhoRP3TIXm5Gr+0/iz/VtD+XXKB+FH542Xo
         ACJ9p9Ov/kkIrNOjmz6ySnbbTMTy5U+bmm2KJpNTQ3WfWYgR41K6ikEz/Otmcc9JRwMx
         fRuA==
X-Gm-Message-State: ALoCoQkp7WUDdc9bvlxZlLR8k4fnqBORg3msoAhSmhlot+RnFFJU8Z6nOt6CESNSAJmYIVHzMjhG
X-Received: by 10.42.207.129 with SMTP id fy1mr15996765icb.17.1421436202438;
 Fri, 16 Jan 2015 11:23:22 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 16 Jan 2015 11:23:22 -0800 (PST)
In-Reply-To: <20150115235310.GA25120@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262562>

On Thu, Jan 15, 2015 at 3:53 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 15, 2015 at 03:24:15PM -0800, Stefan Beller wrote:
>
>> I see the performance problem as well as the contention problem
>> you're pointing out. Dealing with loose refs however creates other
>> problems such as directory/file conflicts on renaming. I am trying to
>> think of a way which moves most of the failures to the transaction_update
>> phase, such that the transaction_commit is rather easy and not expected
>> to produce many errors.
>>
>> So I think dealing with a generic large transaction cannot be really solved
>> outside the packed refs file. There could be another special case for mass
>> deleting refs however. Or retries for the packed refs file. Or we first check if
>> we *really* need to lock the packed refs file (just realized we
>> already do that :/)
>
> It sounds like there are certain _types_ of transactions that trigger
> problems (and that we can handle better). E.g., renames. Which must
> involve a deletion. And we already have to touch the packed-refs file
> for a deletion. Once we know that we must do that, we might as well
> write the rest of the ref updates into it for "free", right? There is no
> extra lock contention (there is contention, but we are not making it
> worse than what is already there, and what is necessary for the on-disk
> format).
>
> Could the rule be something like:
>
>   if there are deletions in the transaction
>     /* to handle potential D/F conflicts */
>     update_type = packed
>   else if # of transactions / # of packed-refs entries > 0.8
>     /*
>      * for performance, we are better off just writing the whole file;
>      * extra lock contention probably doesn't matter because a
>      * simultaneous write would probably conflict with one of our
>      * refs anyway.
>      */
>      update_type = packed
>   else
>     /*
>      * small-ish ref update. Just write out the loose refs.
>      */
>     update_type = loose
>
> I'm not sure I'm completely comfortable with all of the "probably"'s in
> the second comment, though.
>
>> May I ask on which kinds of repository you can see packed-refs.lock contention?
>
> I'm not sure what you mean by "kinds" (i.e., how you want me to
> characterize our repos). Busy ones, certainly. :) And this is all
> server-side, where the main write operations are client pushes and
> running "git gc". And of course mainly ones that are shared between many
> users (so many users pushing to a central repo, not each one forking and
> making pull requests from their own publishing points).
>
> Some people do a lot of deletions. E.g., they may be constantly pushing
> and deleting tags from a CI process that kicks off whenever a "real"
> push happens.
>
> A lot of our contention is from the pack-refs process itself. It has to
> take a lock on each of the loose refs it prunes. It's smart enough
> (since 06839515, anyway) to avoid complaining when a real writer is
> holding the lock. But when the race goes the other way, the "real"
> writer has no idea that the process holding the lock is "weak". That is,
> if it were another push, we would not want to block and wait to acquire
> the lock. We would only find out then that the sha1 had moved, and we
> have to abort the operation. But for a weak writer like packed-refs, the
> ref value is not changing at all, and we could probably succeed if we
> retried the lock after a delay.
>
>> I want to improve git atomicity, specially for 'weird' cases as presented in my
>> previous mail[1]. Eventually I even want to have cross repository atomicty in
>> git, so an example could be:
>> (
>>     cd API-Provider &&
>>     edit files # new changes breaking the API
>>     git commit -a -m "..."
>> ) &&
>> (
>>     cd API-consumer
>>     edit files # use new and shiny API
>>     git commit -a -m "..."
>> ) &&
>> git multipush --atomic API-Provider:origin:master API-consumer:origin:master
>
> I think that's a reasonable goal, but I am not sure what packed-refs has
> to do with it. The client sees only the push interface. So you need:

I was assuming origin to be the same for both repos, which then makes
it a lot easier.
So on the server side you need to do:
* prepare the ref transaction in the first repo
* "cd second repo"
* prepare the ref transaction the second repo
* ref transaction commit.

Note that we're in the second repository when committing the ref transaction,
but we also want to commit things the first repo. So we cannot keep branch
names in memory but need to have the lockfiles already as a lockfile is pointed
to by its filename or optionally by its file descriptor, so we still
know which of
the repos we're adressing there.

>
>   1. Atomic push to each remote (which I think you have already
>      implemented).
>
>   2. Some kind of 2-phase commit on each remote. To say "take the lock,
>      tell me when you have it, but _don't_ update until I ask you to".
>      And then when you have confirmation from all remotes, send each one
>      the instruction to commit the update.
>
>      Of course that isn't foolproof if the commit step fails (lost
>      connection, write error on disk, etc), but it's basically what you
>      want (and this kind of commit is well-studied in the literature).

It is even taught in universities, so it must be at least 15 years old
already. ;)

>
> The actions that the remote takes to do (1) are not important, and
> either way it needs to take all of the locks for each ref. Using
> packed-refs here is just a quality of implementation issue (there are
> some transactions we can take as a single atomic change that we
> otherwise would not be able to).

Yeah I think it's a good goal to have atomic not shrinking the
possible set of operations,
i.e. what works without --atomic should also work with --atomic.

>
> Coincidentally, we are looking at something similar at GitHub to (2) for
> doing repository replication (where you'd want to make sure that each of
> your replicas moves in lockstep). It hasn't been written yet, but we
> imagined that the result would be way too gross and too GitHub-specific
> to make it into the upstream protocol. But maybe not.

Ronnie has written code for that and already posted it here in the mailing list
a few times, but it was lacking reviews and feedback.
Essentially he proposed the following:
* do a push to a hidden part of the git server. This hidden place is
hidden by default
and doesn't need special setup. (refs/hidden/ iirc)
* do an push which makes the previous push visible. This one doesn't need to
  wait for pack uploads, so it's fast. Hence it could lock all it wants.

>
>> When having such a goal a reliable and easy to use ref transaction API makes
>> life lots more easier. By reliable I mean that there are no sudden problems
>> as pointed out in [1], these kinds of rejections make users unhappy. And by
>> easy to use I mean there are only a few functions I need to know and no
>> proliferation of functions exposed in the API. Internally we can do all we want
>> such as special cases for delete-only transactions.
>
> Yeah, I agree with this. But I have a nagging feeling as we deal with
> these problems that the right solution is some better ref-store than the
> filesystem + packed-refs. It's a great, simple solution, but the scaling
> and transactional considerations are really making it not-simple. These
> are solved problems in the database world. Moving onto a ready-made
> solution has its own problems, and I do not think we would ever
> deprecate the filesystem + packed-refs storage format. It works very
> well for client repositories, and has no dependencies. But it would be
> nice if there was a pluggable option for busy shared server repos.

That's what Jonathan said here as well. I though about getting the files backend
improved, but you're the second who talks me into implementing a database
backend. I'll look into that.

Thanks,
Stefan
