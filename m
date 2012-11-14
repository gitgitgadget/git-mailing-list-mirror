From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: push branch descriptions
Date: Wed, 14 Nov 2012 15:51:01 +0100
Message-ID: <CAB9Jk9BN6vTnpPa8rv1Yumn2Os=XU=tEn3=j2QJJK1GpajY=VQ@mail.gmail.com>
References: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com>
	<7vr4nwb832.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 15:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYeJB-0008OS-Ja
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 15:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab2KNOvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 09:51:03 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:55306 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2KNOvB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 09:51:01 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so216834dak.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 06:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rgfVir1nRpQnz5hE1l6ne8lv092fSLrZfBx9lfVo4sM=;
        b=Cf7ip7JxPkfR9ZoYQzQ51/SJH+oSwLibDCAQ96N+qWJVTtOYxHK3jZ4tNHKUHIiCJG
         WfYn97JvH7p8cB28PbK2CaqmxNxRiVqT50lv7wCJOo2UWrIM3N2R5vHsr5MPJqjDF9oh
         fZJpQdo4qLnuk1f7hJBXFb8/eiODFeC7cG44TkTHRgpd4YRQ0u7At3XFSbdta+3l7puy
         ATpAJy54wV0MHDh1RqssffK+lMa1QEUea69zXo9ljZhvAm8/cIsoWqXp5jNK9tVWPWw/
         F9RVM1oOZvyDxXOVr6LievEabicw80Mi6WVmxnz5h9EGUOluAsMxneiqBN7HrtbbhNhQ
         osWw==
Received: by 10.66.90.101 with SMTP id bv5mr7117936pab.42.1352904661404; Wed,
 14 Nov 2012 06:51:01 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Wed, 14 Nov 2012 06:51:01 -0800 (PST)
In-Reply-To: <7vr4nwb832.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209721>

Hi Junio,

> It would conceptually be a lot cleaner to treat updating of remote
> Ibranch description as a separate "repository management" class of
> Ioperation, similar to setting the repository description stored in
> I$GIT_DIR/description.

I agree, it should be a distinct operation. I was thinking that when
you have a remote bare repository, the normal way of adding contents
to it is to push to it, and thus also adding a description should be
done with some sort of pushing. Creating branches is also normally
done with a push (think how difficult it is to create a branch in a
bare repository when the HEAD is not set ...).

-Angelo

On 14 November 2012 14:57, Junio C Hamano <gitster@pobox.com> wrote:
> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
>> currently, there is no means to push a branch description to a remote
>> repository. It is possible to create a branch, but not to set its
>> description.
>
> Correct.  You have to go to the remote repository and run "git
> branch --edit-description" there; there is currently no way to do
> this remotely, which may be an issue, but...
>
>> Would not be more correct to push also branch descriptions when
>> branches are pushed?
>
> ... I do not think "git push" is the best place to do so, given the
> inherently local nature of branches and branch descriptions.
>
> Imagine the project creates a branch "magic" to enhance its system
> with magic words.  The description for the "magic" branch in the
> project may say "support magic words" or something.
>
> You and your friend are tasked to add a handful of magic words,
> e.g. "xyzzy", "frotz" and "nitfol".  You may start your work like so
> on your "magic-xyzzy" branch:
>
>     $ git clone git://example.com/zork.git/
>     $ git checkout -b magic-xyzzy -t origin/magic
>
> And you say something like "add xyzzy magic" in its branch
> description.
>
>     $ git branch --edit-description magic-xyzzy
>
> After finishing your work, you may push it
>
>     $ git push origin magic-xyzzy:magic
>
> Should the description of the subtask "add xyzzy magic" overwrite
> the purpose of the project wide "magic" branch "support magic words"?
> Most likely not.
>
> The local nature of the description becomes even more clear if you
> imagine the case where the push at the last stage gets rejected due
> to non-fast-forward error (in other words, your friend has already
> pushed her support of the "frotz" magic to the "magic" branch.
>
> In fact, you would normally not directly push your magic-xyzzy
> branch to the magic branch, but you would do something like this
> once you are done:
>
>     $ git checkout -b magic -t origin/magic
>     $ git pull origin ;# to update with her work
>     $ git merge magic-xyzzy
>     $ git push origin magic
>
> And the last "merge" is where the description for your magic-xyzzy
> is used to fill the commit log template for you to explain your
> merge (that is, you are merging a branch whose description is "add
> xyzzy magic").  There is no reason to propagate the description of
> your magic-xyzzy topic to the description of shared magic branch
> when you push, as this merge commit already records what the branch
> that was merged was about.
>
> So you could modify "git push" to set the branch description when
> you push to create a branch remotely, but in general, "git push"
> should not be updating the branch description with the description
> of your local branch.  This comes as a consequence of the fact that
> the purpose of the branch in the remote central repository is, more
> often than not, different from the purpose of the corresponding
> branch in your repository.
>
> It would conceptually be a lot cleaner to treat updating of remote
> branch description as a separate "repository management" class of
> operation, similar to setting the repository description stored in
> $GIT_DIR/description.
