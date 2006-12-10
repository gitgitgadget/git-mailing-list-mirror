X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Sun, 10 Dec 2006 16:25:52 +0000
Message-ID: <b0943d9e0612100825h3ef2fa77kd5d9fd5022cbb3f9@mail.gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 16:26:12 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IzcRNYPEQeXCHKHb9mZ/lO8Lj/X8irb1Cv5Bdk8XtW14/OM+fdJWYS7Sy5j9mzhz1kGZGg68z3sj/BXPoy6yvhlC7zjY765hmpvtI3MnCIfZTVNwk3ljZkZqsDbFrcXMuU8gqZwskoER3+GFthd6oHwCES2uS9eiON3ZLaSkMsw=
In-Reply-To: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33898>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtRV2-00071H-1P for gcvg-git@gmane.org; Sun, 10 Dec
 2006 17:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762247AbWLJQZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 11:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762176AbWLJQZ4
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 11:25:56 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:16452 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1762247AbWLJQZz (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 11:25:55 -0500
Received: by nz-out-0102.google.com with SMTP id s1so683992nze for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 08:25:53 -0800 (PST)
Received: by 10.65.219.11 with SMTP id w11mr2345706qbq.1165767952919; Sun, 10
 Dec 2006 08:25:52 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Sun, 10 Dec 2006 08:25:52 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On 08/12/06, Yann Dirson <ydirson@altern.org> wrote:
> Here is the remaining of my queue of stgit issues and ideas noted
> in the last months.  A number of items in the "wishlist" section is
> really here to spawn discussion.  Maybe some of them should end up
> in the TODO list.

Since this list gets changed pretty often, I would rather add TODO
Bugs wiki pages on http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT
(maybe I should create a page on one of the open-source hosting sites
and get some bug-tracking support). I keep the TODO file mainly for
what I plan to implement and, while I agree with many of the issues
you point below, I don't guarantee I have time to fix/implement.

From your list below, I removed those which I don't have any comments
for (I agree with you).

> - "stg import" leaves empty patch on the stack after failed patch application

That's a feature in the sense that it creates the empty patch with the
description and author information. It also leaves a
.stgit-failed.patch which you can manually apply.

> - "push --undo" should restore series order

Yes, but it requires some work to store the old series information

> - "stg fold" usage does not tell what <file> is used for

I think "stg help fold" is somewhat clear in this respect but, well,
it could be improved.

> - "patches -d" may be confused by files added then removed (below,
> file added to platform-v0, removed in rm-junk, problem encountered on
> 2006-08-14, probably on 0.10):

Is this still the case now? I fixed a similar issue a few months ago
(commit a57bd72016d3cf3ee8e8fd7ae2c12e047999b602; GIT considers a file
name to be revision name if the file isn't found on disk; easily
fixable by adding the "--" separator).

Only the push and pick comands take renames into account at the moment
(by using git-merge-recursive). It's not hard to modify the other
commands to deal better with renames, only that I didn't have time to
do it. There might be some performance impact on some commands. There
is also the case that I want to be able to send patches in a standard
GNU diff format for people not using GIT.

> - "refresh" should display .git/conflicts if any ?

stg status -c does this but I don't have anything against refresh
showing it as well (can be made more general by modifying the
check_conflicts function).

> - patches/*/*.log branches could be better named as patchlogs/*/*
> (easier to filter reliably)

It was easier to implement this way because the Patch objects have the
directory where they store the commits. I also didn't want to polute
the refs directory with yet another directory.

> - "stg show" should catch inexistant patch instead of saying "Unknown
> revision: that-patch^{commit}"

This command works for commit ids as well as patches. If the patch
isn't found, it considers the name to be a commit id.

> - "clean" should give enough info for the user to locate any problem
> (eg. conflict with files removed from revision control), eg. with a
> "popping to ..." message

Clean only removes empty patches and there shouldn't be any conflicts
caused by this operation (unless there is a bug).

> - "stg fold" should allow to pass -C<n> to git-apply: context mismatch
> currently makes folding unnecessarily hard

My solution was to leave a .stgit-failed.patch file which I apply
manually (I prefer to see what I apply rather than reducing the
context information). Indeed, an option to fold would be nice.

> - "stg goto <current>" causes IndexError exception

I thought it was fixed recently.

> - "sink" or "burry" as opposite to "float" (possibly with a target
> patch)

But how deep to burry it?

> - lacks "pick --patch=XXX" to pick by name

I don't understand this.

> - interactive merge tools could only be called automatically after
> failed merge, instead of requiring not-so-intuitive "resolved -i"

You can set the stgit.merger config option for this (diff3 followed by
xxdiff or emacs). I even have a .py file for doing this, I can add it
to the contrib dir. The other option would be to set this in the
config file and move the handling of this operation to a common file
(it can be used by all the operations involving a three-way merge)

> - needs a config example to call ediff via gnuserv (possibly sending
> several merges at a time, making use of the session registry)

Don't know how to do it.

> - shortcuts (st -> status, etc.), possibly making use of the git alias
> system ?

This could be easily implemented in the main.py file by finding a
single command match from the command list based on the first letters.
If more than one is found, just report the usual unknown command.

> - "stg fold" should allow to run a merge (insert conflict markers, or
> even just output a .rej patch somewhere)

It just calls git-apply. If this can do it, StGIT would use it.

> - support for atomicity of complex transactions (stg begin/snapshot,
> rollback, commit/finish - possibly with a transaction name so nesting would
> just work)

Would be nice but probably not that easy.

> - mark patches as deactivated (float above all unapplied ones), so
> even "push -a" would not push them

This would be good indeed.

> - "stg patches" should be able to report on unapplied patches

It invokes GIT to find out the commits modifying the give file. An
unapplied patch doesn't modify any local file.

-- 
