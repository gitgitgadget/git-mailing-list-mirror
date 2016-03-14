From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: drop confusing prefix parameter of die_on_unclean_work_tree()
Date: Mon, 14 Mar 2016 09:20:23 -0700
Message-ID: <xmqqfuvtav5k.fsf@gitster.mtv.corp.google.com>
References: <974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de>
	<xmqqr3fidxs3.fsf@gitster.mtv.corp.google.com>
	<xmqqk2ladx36.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1603141410590.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 17:20:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afVEO-0005Y8-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 17:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbcCNQU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 12:20:29 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbcCNQU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 12:20:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECC354B268;
	Mon, 14 Mar 2016 12:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GDHv8grgnIIgo9tqpYWjRl1z2sU=; b=j8QYHg
	wNPILVQRqm7Ap/2Wd24qFkT6uIbO6meRMjl11cQAOu5BrY75G3OMGSqUkpNG+ejG
	5lDS7zXrXBcUWI1N4L/qWUD7JpRXfFzTH51HsliYCm/4IZovYoyC5HSMhj3Ui+kU
	NTNjM8xQPKJSmY62+/lvT2Pyp0PxdyJWmXxxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C20uqWHVRfiqGxVxWHoAYnYCo3KpDKlq
	9KJlAHp82GQq0u8qjMDjoOzRuucIjiEjRL4xAcCQengYbJdzsA3y34rcZ9u7j5bc
	7yu7NTUJsA1zTZLXVqrhtnTSBHEqfeSLIB4+cWmW2aETb6g2rFSU3CAYBKGtJNZK
	QDUNfTKjGp4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAECC4B267;
	Mon, 14 Mar 2016 12:20:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D4504B263;
	Mon, 14 Mar 2016 12:20:25 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603141410590.4690@virtualbox> (Johannes
	Schindelin's message of "Mon, 14 Mar 2016 14:42:32 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A877EAC8-EA00-11E5-B7AB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288789>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Another reason why it is more sensible to keep the prefix available,
>> but not use it to limit the extent of diff, to has_*_changes()
>> functions is that it would be easier for us to change our mind later
>> to allow the users to ask for more detailed output.  Instead of
>> "Cannot pull with rebase: You have unstaged changes, period.", you
>> may be asked to list which paths are dirty in such a case, and in
>> order to present the list relative to the directory where the user
>> started the command, you would need "prefix" available to the code
>> that calls into diff machinery somehow.
>
> Let me summarize.
>
> First, you argue that the prefix is a documented way to say: "This
> function needs to be called from the top-level directory".

It tells the reader of this function that the caller has already
moved to the top-level and as a633fca0 (Call setup_git_directory()
much earlier, 2006-07-28) says, gives you the "prefix" (i.e.
pathname of $PWD relative to the project root level).  When you read
the function, hence, you know "prefix" can be used to tell where
originally the command was run from, if you want to learn it.

In other words, I didn't mean to argue anything like what you are
saying.  Either I phrased poorly, or you misread it.

For the purpose of letting "git pull --rebase" make sure that there
is no difference between the index and the working tree, we'd want a
tree-wide diff, so we do not want to limit the diff with pathspec.
Not passing "prefix" to init_revisions() _is_ the right thing.
Again, I think I said that in the message you are responding to, and
either I phrased poorly, or you misread it.

In any case, that call to init_revisions() should have imitated what
index_differs_from() and do_diff_cache() in diff-lib.c do, i.e.
pass NULL as the prefix to say "I do not want any path/subdirectory
limitation".

> P.S.: The idea that a rebasing pull might, at some stage in the future,
> want to require only part of the working directory to be clean, this idea
> also makes little sense to me.

And there is no such idea.  Again, perhaps I phrased the whole thing
poorly or you misread it under the assumption that whenever I disagree
with what you say, it is more likely what I say is incorrect.

I was talking about this sequence:

    $ edit rerere.c
    ... time passes ...
    $ cd Documentation/
    $ git pull --rebase
    error: Cannot pull with rebase: You have unstaged changes.
    ... oh, where do I have changes?
    $ git status -suno
     M ../rerere.c

which you may want to optimize the human-end-user experience by
allowing 'pull --rebase' to say "You have unstaged changes in
../rerere.c" or something along that line [*1*] so that the user
does not have to give a separate "git status" there.

And for that, the code that gives the error message needs to be able
to access the "prefix" (i.e. pathname of $PWD relative to the
project root level) to make that path relative in the output.


[Footnote]

*1* By "something along that line" I mean that you'd need to work
out the details of what to do when there are too many of them, for
example you wouldn't list everything but indicate that the list is
truncated in some way.
