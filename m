From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Sat, 22 Nov 2014 10:04:57 -0800
Message-ID: <6b21dd7a53200ab413c67bb4667e8bc@74d39fa044aa309eaea14b9f57fe79c>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com> <20140919093910.GA15891@peff.net> <CALKQrgc4nZdaXM-Ooh1pP4x4nZRLexJzLyaBmrgn+qVaQGCg+g@mail.gmail.com> <xmqqoaubmpvh.fsf@gitster.dls.corp.google.com>
Cc: Johan Herland <johan@herland.net>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 22 19:05:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsF3Y-0002D4-UL
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 19:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaKVSFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 13:05:06 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:53010 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbaKVSFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 13:05:05 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so7021496pab.0
        for <git@vger.kernel.org>; Sat, 22 Nov 2014 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3FlaibWEr4kLzXi+SV6vpfYeXOp8cn+0VmTG0vg9GM=;
        b=eWg5a80Rm8iPE+gq234ZsVNCLMxjFVsu7kxVdREVHvzmMvTItcOhHnlKotylB2BwH/
         eGby9Cs23pS9lv3i5kccVidQOQX7SJtbSxU+FCEdxx+uYT0SvWlQek9xdNe5HQIim33v
         ewC59L0shtRbiGcmnYbH+ndDgy9hH5plQB6YHcKImlf5qmyInqrQo+IKoBAFSaISR7x4
         y3jRL7KJ/zEI/KQ8gEg01H78/kEtvO717esp6PjJDYE+Pw6HA7/3Fvb6/IwlCIbym0QX
         RE1dY53A1fgJosslu7wFHuwBVL6Ym5RPy8t2nLuod3nVkBNNDLwsgs66Mzr9OluIqHa4
         ap2Q==
X-Received: by 10.66.97.39 with SMTP id dx7mr18307934pab.65.1416679503776;
        Sat, 22 Nov 2014 10:05:03 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id lm3sm8059537pab.34.2014.11.22.10.05.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 22 Nov 2014 10:05:03 -0800 (PST)
In-Reply-To: <xmqqoaubmpvh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260072>

I see this patch has not been picked up.

I would like to lobby for inclusion of this patch.

On Sep 19, 2014, at 11:22, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
>
>> On Fri, Sep 19, 2014 at 11:39 AM, Jeff King <peff@peff.net> wrote:
>>> On Fri, Sep 19, 2014 at 09:39:45AM +0200, Scott Chacon wrote:
>>>> This patch changes the expand_notes_ref function to check for  
>>>> simply a
>>>> leading refs/ instead of refs/notes to check if we're being  
>>>> passed an
>>>> expanded notes reference.
>>>
>>> I think this change affects not just "git notes merge", but all of  
>>> the
>>> notes lookups (including just "git notes show")....
>> ...
>
> Is it our future direction to set up refs/remote-notes/<remote>/
> namespace?

When cloning (without --mirror) Git now sets up a fetch spec like:

   +refs/heads/*:refs/remotes/origin/*

It's unfortunate that it does not preserve the notion of "heads" and  
instead set it up like this:

   +refs/heads/*:refs/remotes/origin/heads/*

In which case it would make more sense to then simply clone notes like  
so:

   +refs/notes/*:refs/remotes/origin/notes/*

That would also clear the way to always fetching all remote tags into  
refs/remotes/<remote>/tags/* by default as well even if the local refs/ 
tags/* do not end up being updated.

It seems clumsy to me to use a new remotes-notes ref namespace.  What  
happens if Git grows the ability to store some kind of (bug) tracking  
ticket in refs/tickets in the future?  Does Git then use refs/remote- 
tickets/<remote> to store the remote refs rather than simply refs/ 
remotes/<remote>/tickets?

There are a number of applications that create refs outside of refs/ 
heads/* and refs/tags/*.  GitHub uses refs/pull/*, should Git have a  
refs/remote-pull/<remote>/* namespace and for Gerrit refs/remote- 
changes/<remote>/* and also refs/remote-cache-automerge/<remote>/*  
(for refs/cache-automerge/*)?

> If so, let's not do it piecemeail in an unorganized
> guerrilla fashion by starting with a stealth enabler
>
> By "stealth enabler" I mean the removal of refs/notes/ restriction
> that was originally done as a safety measure to avoid mistakes of
> storing notes outside.  The refs/remote-notes/ future direction
> declares that it is no longer a mistake to store notes outside
> refs/notes/, but that does not necessarily have to mean that
> anywhere under refs/ is fine.  It may make more sense to be explicit
> with the code touched here to allow traditional refs/notes/ and the
> new hierarchy only.  That way, we will still keep the "avoid
> mistakes" safety and enable the new layout at the same time.

This is the part where I want to lobby for inclusion of this change.   
I do not believe it is consistent with existing Git practice to  
enforce restrictions like this (you can only display/edit/etc. notes  
under refs/notes/*).

Already that's not true if you use an ugly symbolic-ref workaround,  
but that requires polluting your ref namespace.

With all the other Git "restrictions" they are almost always strong  
guidance, not brutally enforced.

Take, for example, the "restriction" that HEAD should be either  
detached or a symbolic ref to refs/heads/<something>.

It's not absolutely enforced.  If you really want to, you can use git  
symbolic-ref and set HEAD to somewhere else (even under refs/taga) --  
and it mostly works -- `git branch` gets upset but you can commit new  
changes, view the log, etc.

How about the "guidance" that pushing does not update tags even if the  
change would be a fast-forward?  Again, not enforced, use the -f  
option or add an explicit refspec to the appropriate remote config.

What about the restriction that `git config --get user.name` cannot  
end in "."?  (It gets magically stripped off.)  That's a toughie, but  
if you really, really, really want to you can always `git cat-file  
commit HEAD > temp`, add the trailing dot and then git update-ref HEAD  
$(git hash-object -t commit -w temp)`.  Not recommended but possible.

So anyway, my point is that arbitrarily forcefully restricting the  
operation of the various notes commands to refs/notes/* does not seem  
consistent with the way everything else works.

> The most important first step for that to happen is to make sure we
> are on the same page on that future direction.  I personally think
> refs/remote-notes/<remote> that runs parallel to the remote tracking
> branch hierarchy refs/remotes/<remote> is a reasonable way to do
> this, but my words are no way final.

I'd prefer refs/remotes/<remote>/notes for the reasons stated above.   
Having a refs/remote-notes/<remote>/* hierarchy opens the door to a  
proliferation of refs/remote-<whatever>/<remote>/* items in the refs  
namespace in the future.

So in the vein of providing guidance to the user but, in the end,  
allowing the user to remain in control, I have gussied up Johan's  
suggested fix for the failing notes test into the following patch.

--Kyle

-- 8< --
Subject: [PATCH] t/t3308-notes-merge.sh: succeed with relaxed notes refs

With the recent change to allow notes refs to be located in
the refs hierarchy in locations other than refs/notes/ the
'git notes merge refs/heads/master' test started succeeding.

Previously refs/heads/master would have been expanded to
a non-existing, ref refs/notes/refs/heads/master, and the
merge would have failed (as expected).

Now, however, since refs/heads/master exists and the new,
more relaxed notes refs rules leave it unchanged, the merge
succeeds.  This has a follow-on effect which makes the
next two tests fail as well.

The refs/heads/master ref could just be replaced with
another ref name that does not exist such as refs/heads/xmaster,
but there are already several tests using non-existant refs
so instead just remove the refs/heads/master line.

Suggested-by: Johan Herland <johan@herland.net>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 t/t3308-notes-merge.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 24d82b49..f0feb64b 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -90,7 +90,6 @@ test_expect_success 'fail to merge various non-note-trees' '
 	test_must_fail git notes merge refs/notes/ &&
 	test_must_fail git notes merge refs/notes/dir &&
 	test_must_fail git notes merge refs/notes/dir/ &&
-	test_must_fail git notes merge refs/heads/master &&
 	test_must_fail git notes merge x: &&
 	test_must_fail git notes merge x:foo &&
 	test_must_fail git notes merge foo^{bar
