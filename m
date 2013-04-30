From: Johan Herland <johan@herland.net>
Subject: Re: improvements to checks for core.notesRef / GIT_NOTES_REF / --ref
Date: Tue, 30 Apr 2013 02:32:33 +0200
Message-ID: <CALKQrgdH_Oh122tGKeD+chk5f6PwUvsisXjRp68QD_KMQt-9Bg@mail.gmail.com>
References: <20130427132118.GA25295@pacific.linksys.moosehall>
	<20130429133205.GA4672@pacific.linksys.moosehall>
	<20130429163909.GA19014@pacific.linksys.moosehall>
	<7vmwshjm4j.fsf@alter.siamese.dyndns.org>
	<20130429214051.GA1704@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 02:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWyV6-0003QN-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 02:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436Ab3D3Acm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 20:32:42 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:65015 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab3D3Ack (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 20:32:40 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UWyUp-0000Nd-1B
	for git@vger.kernel.org; Tue, 30 Apr 2013 02:32:39 +0200
Received: from mail-oa0-f49.google.com ([209.85.219.49])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UWyUn-000BEI-83
	for git@vger.kernel.org; Tue, 30 Apr 2013 02:32:37 +0200
Received: by mail-oa0-f49.google.com with SMTP id j1so6615271oag.22
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3jSLIFZI4ZNvyjVmhRmIz6qkib/qdlJRZGx4KNrIK/A=;
        b=ByTBEHMyPlSJS3md99bSH4t4h+sH0r2g0S0R3NexqPhsfCgddsgWI6U6nF8Ev1I4nV
         v8vNeWTWza5NWEtxXwFVLx0brV6/HeYVhGKPoWA2pKceez8WTPV2VVrHkbHLymhrfbix
         U9oyuNkOfjSR7x4KvEIT9qC/9/fTuEBLgZ3N1mJvCqwjDxRlIenZEQzOVh/lPgrOCAK+
         xr8vOkL/gNRIwZ8r5FTyc2XxXevnnijocRLNmRojiVSmadWcsrsKjGEK54cmvGi9EkrJ
         b7fUsYWEmLDxd078ReJiZ+BnoRazNbpw0C7UmHK/fN4URIL6YICrWOolRW1D0Tlme0tU
         3v/w==
X-Received: by 10.182.143.7 with SMTP id sa7mr5321922obb.0.1367281953863; Mon,
 29 Apr 2013 17:32:33 -0700 (PDT)
Received: by 10.182.23.12 with HTTP; Mon, 29 Apr 2013 17:32:33 -0700 (PDT)
In-Reply-To: <20130429214051.GA1704@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222889>

On Mon, Apr 29, 2013 at 11:40 PM, Adam Spiers <git@adamspiers.org> wrote:
> On Mon, Apr 29, 2013 at 10:13:32AM -0700, Junio C Hamano wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>> >     static struct notes_tree *init_notes_check(const char *subcommand)
>> >     ...
>> > Can we relax this to "refs/", to allow better isolation of namespaces
>> > for remote notes?  Also, the check is applied for GIT_NOTES_REF and
>> > core.notesRef, but not for values passed via --ref.  Therefore I would
>> > propose that init_notes_check() is not only relaxed but also moved
>> > from builtin/notes.c to notes.c, so that it can be consumed by
>> > default_notes_ref().  Thoughts?
>>
>> Such a policy decision at the application level should be done in
>> builtin/notes.c, and not notes.c, I think.  It is OK to have a
>> sharable check routine in notes.c and help different notes
>> applications to implement their own sanity checking, though.  "git
>> notes" that operates only on local notes might restrict its
>> operation to refs/notes, while "git notes-merge" may allow it to
>> read from other hierarchies but still write only into refs/notes,
>> for example.
>
> OK, makes sense.

I initially added this check with the intention of making it _really_
hard for users to accidentally mix up notes trees and "real" trees.
Obviously, it also makes it unnecessarily hard for people that want to
share notes (e.g. you). According to the Great Refs Namespace Debate,
I would probably want to limit note refs to refs/notes/* and
refs/remotes/$remote/notes/*, but since that debate I've regrettably
neglected the whole issue, and the current implementation was left as
it currently is... Re-thinking the issue now, I see how it might be
more useful to remove the check altogether, rather than
unintentionally holding it "hostage" while we wait for the remote refs
namespaces to materialize.

Otherwise, I agree with Junio's assessment that this code conceptually
belongs in builtin/notes.c and not notes.c.

>> I am not sure if it is a good idea in general to have a separate
>> remotes-notes/ hierarchy in the first place, though.  Wouldn't the
>> notes be less like branches (private view) and more like tags
>> (common world view)?
>
> I didn't have anything to do with the design, but the existence of
> certain "git notes" subcommands (in particular append, edit, and
> merge) gave me the distinct impression that users are expected to edit
> notes simultaneously, and handle any merge conflicts which may arise.
> These actions are modelled by commits to refs/notes/$GIT_NOTES_REF,
> which as a result is used as a sort of inferior 3rd-class branch.  In
> contrast, tags do not seem to be mutable (in the accumulative sense,
> at least), and have no history (not even in the reflog, AFAICS).

I definitely agree with Adam here. Notes are definitely to be
considered mutable (in the general case), and hence are more like
branches than tags. Especially when notes are shared among repos, one
must assume that they will also be edited in multiple repos, and must
therefore be merged properly (or at least have the option of doing so)
when shared from one repo to another. After all, that's the reason why
"git notes merge" exists at all...

> As stated earlier in the thread, my particular use case is to use
> notes to mark commits which should be excluded from a long list of
> commits which "git cherry" says need to be upstreamed.  In our
> project, there are many commits for which it does not make sense to
> upstream them, and even for the ones which it does, cherry-picking can
> sometimes result in a different patch-id due to changed context.  In
> both of these cases, git notes is a great mechanism for blacklisting
> these commits from the upstreaming process, and I've already written
> "git icing" which wraps "git cherry" to support that.  However, the
> substantial size of the upstreaming work means that it needs to be
> done by multiple people across multiple clones of the repository,
> hence the need for branch-like tracking of notes.
>
>> > Also, are there any plans in the future for making "git notes merge"
>> > provide an index, so that a proper 3-way merge with ancestor can be
>> > done using git mergetool?
>>
>> Are we committed that all notes leaves must be blobs (I do not
>> personally mind it)?
>
> No idea - perhaps someone else can comment on this.  Sounds reasonable
> to me too.

AFAICR, we've left that decision somewhat open. The notes code will in
general work with both notes and trees, although there are some
functions that will obviously only work with blobs:

 - Any notes command that lets you edit the note in a text editor
(add/append/edit, IINM) will obviously only produce blobs.

 - Certain notes merge strategies, such as "union" and "cat_sort_uniq"
will only work on blobs. The default "manual" strategy is also unable
to checkout non-blobs in the notes merge worktree.

 - Displaying notes as part of the log (or any other call to
notes.c:format_note()) only works on blobs.

So, although the common use case for notes is definitely blobs
(typically with text contents), we definitely allow other things to be
stored as notes, but you must be prepared to create your own scripts
to work with these, and you naturally cannot expect the text-centric
parts of the notes API to deal with them usefully.

>> I do think we need a way to call a custom low level 3-way merge
>> driver once we identify which notes blobs correspond to each other
>> with what common ancestor notes blob while merging two notes trees.
>
> Right.

All the information you need should be available in struct
notes_merge_pair passed to merge_one_change() in notes-merge.c. I
believe it should be fairly straightforward to create another notes
merge strategy that uses a mergetool directly for resolving conflicts.

>> But I do not think that "an index" that we use for the usual working
>> tree merge is necessarily a good representation for driving such a
>> ll-merge driver and recording its result.  Each side likely has a
>> note for the same object to be merged in a different fan-out layout,
>> and fan-out is merely a performance hack to spread the objects in
>> smaller trees.  As mergetools only work with the usual working tree
>> with the usual index, they may be a poor substitute for ll-merge
>> drivers to handle merging notes trees.
>
> I won't pretend to have fully understood that ;-) I'm certainly not
> religious about how such a merge workflow would be implemented.  I
> just wanted to point out that the current mechanism doesn't readily
> expose the common ancestor in a way which makes the merge convenient.

That common ancestor (if exists) is the "base" member of the struct
notes_merge_pair mentioned above.

> IMHO the more similar the merge's user experience is to a standard
> merge, the better, since that would minimise the number of merging
> workflows the user needs to learn.
>
> On this theme, I think ideally rebase should be supported too, and

IMHO the general discussion about rebase vs. merge is mostly about the
shape of the resulting history. When it comes to notes, I have yet to
see a use case where anybody really cares about the shape of the notes
history, and hence I don't yet see how rebase would be useful for
notes. In fact, it rather seems some people are more interested in
storing their notes trees without any history at all (ISTR a
discussion regarding the notes-cache feature, where we did NOT want to
keep earlier versions of the cache alive).

> that does make me wonder if there's a good reason why notes shouldn't
> be stored in real branches, or at least something which looks more
> like a branch (even if "git branch" doesn't list it).  In particular,
> applying the concept of remote tracking branches to notes would be
> most useful.  Currently my "git rnotes" wrapper is faking remote
> tracking branches via refs/notes/$remote/$GIT_NOTES_REF, but that
> means that if I want to push a set of notes to a remote repository,
> it's not sufficient to do the following:
>
>     git push $remote refs/notes/$GIT_NOTES_REF:refs/notes/$GIT_NOTES_REF
>
> I also have to manually update the fake tracking "branch":
>
>     git update-ref refs/notes/$remote/$GIT_NOTES_REF refs/notes/$GIT_NOTES_REF
>
>     # or if I want to make really sure this only happens if the push worked
>     git fetch $remote refs/notes/$GIT_NOTES_REF:refs/notes/$remote/$GIT_NOTES_REF
>
> That's pretty ugly.  Couldn't we instead just reuse the existing
> mechanisms?
>
>     remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
>     remote.origin.fetch=+refs/notes/*:refs/note-remotes/origin/*

The remote refs namespace idea aims to solve this by providing refspecs like

    remote.origin.fetch=+refs/heads/*:refs/remotes/origin/heads/*
    remote.origin.fetch=+refs/tags/*:refs/remotes/origin/tags/*
    remote.origin.fetch=+refs/notes/*:refs/remotes/origin/notes/*
    remote.origin.fetch=+refs/replace/*:refs/remotes/origin/replace/*
    etc.

I'm currently working on some patches to make git work well in repos
with those kinds of refspecs. I see that as the first step on the way
to properly supporting remote ref namespaces.

>     branch.notes/commits.remote=origin
>     branch.notes/commits.merge=refs/notes/commits

This looks like an natural extension of the branch upstream mechanism
for notes. Personally, I'd rather have it look more like this:

  [notes "commits"]
        remote = origin
        merge = refs/notes/commits

or, in your notation:

    notes.commits.remote=origin
    notes.commits.merge=refs/notes/commits

> Just an idea ...
>
> Adam

Thanks for your interest and insight. It's enlightening to see how
others approach and work with notes and notes sharing.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
