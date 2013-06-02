From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Sun, 02 Jun 2013 11:50:14 -0700
Message-ID: <7v61xwpct5.fsf@alter.siamese.dyndns.org>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
	<51A7A5F9.2030107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 02 20:50:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjDMS-0003AK-VV
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 20:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab3FBSuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 14:50:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755401Ab3FBSuR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 14:50:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E51723DA9;
	Sun,  2 Jun 2013 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=25ejIgi+wXL8QULlp9j5hCkYx+0=; b=IlYHE1
	YnOphz32BNluI0iV3pxsb5WfqrNeD5aUj8DoNvqIIuJHS9sYfFlwZOIcqkzWEs6r
	+AWor4l9s/s+TQ4NSCIHgLlxHYfz1HVfm/pFZxwDz8EkLj2eLsHKN1PVIDSwcopT
	+BYKynwC77Bxpm1imGeEzB5SMTc/EvGhexNtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5kPu+pE+c0/EeSxKa+XbGBNxqIh5N6G
	tRJTJYM/x+KCbLdWqH+60WSLxroZ78yGvSJ53+yToo9SxRN+82B/Vo6PckB70kCa
	0AlTTrsNycBzmHyuZOWTO8AGJ/TYHTn4t3HKFEmMv8YigVxa2KVbg4m32puLFGch
	kKzAJxa/3kU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E9123DA8;
	Sun,  2 Jun 2013 18:50:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD77C23DA3;
	Sun,  2 Jun 2013 18:50:15 +0000 (UTC)
In-Reply-To: <51A7A5F9.2030107@web.de> (Jens Lehmann's message of "Thu, 30 May
	2013 21:18:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 439E6D82-CBB5-11E2-9E88-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226172>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 30.05.2013 01:58, schrieb Junio C Hamano:
>> * jl/submodule-mv (2013-04-23) 5 commits
>>   (merged to 'next' on 2013-04-23 at c04f574)
>>  + submodule.c: duplicate real_path's return value
>>   (merged to 'next' on 2013-04-19 at 45ae3c9)
>>  + rm: delete .gitmodules entry of submodules removed from the work tree
>>  + Teach mv to update the path entry in .gitmodules for moved submodules
>>  + Teach mv to move submodules using a gitfile
>>  + Teach mv to move submodules together with their work trees
>> 
>>  "git mv A B" when moving a submodule A does "the right thing",
>>  inclusing relocating its working tree and adjusting the paths in
>>  the .gitmodules file.
>
> There are only two issues I'm aware of:
>
> *) When the .gitmodules file is already modified but unchanged
>    running rm or mv on a submodule will stage those changes too.
>
> *) There is a harmless but unnecessary double invocation of strlen()
>    in the function (fixed by the diff below).
>
> I plan to fix the first issue in another patch which would also get
> rid of the second issue, as exactly that code would have to be touched
> anyways.
>
> Does that make sense?

In general I think whatever you think that makes sense in this area
would make sense ;-).

I do not feel confident that I am reading what you mean by "already
modified but unchanged" right.  Do you mean the working tree version
is different from both HEAD and the index (HEAD and the index may or
may not match and that does not change the situation)?  Assuming
that is the case, i.e. the situation you are worried about is:

    When ".gitmodules" has a local modification the user chose not
    to "add" yet.  Then the user does "git rm/mv" on a submodule
    that is unrelated to the submodule whose setting the user has
    changes for.

I am curious what the plan is to "fix" this.  An obviously safe
thing to do is to error out with a "You have local modification;
please 'git add .gitmodules' first." but if that advice/suggestion
is always the right course of action for the user, it invites "then
why doesn't Git do so for me?", which would in turn support that it
is not an issue in the first place (it deserves to be mentioned in a
warning, "adding your local modifications together with change
needed for rm/mv", though).

I think in the ideal world, you may want to apply the change needed
for rm/mv to the version in the index, and then update the working
tree version by doing a 3-way merge. We already know that eventually
we would need a merge driver that is specific to the file format
that git-config uses, possibly even taking an advantage of the
knowledge of not just the file format but also the semantics of
individual variables [*1*], so we may want to keep it in mind that a
three-way merge would be the eventual goal, while settling on an
"error out on local mod" just like "git checkout anotherbranch" used
to always stop (before we taught the "-m" option to it) when a local
change needed a 3-way merge to be carried along to the new branch.

So my gut feeling of the "fix" at this point in the evolution of the
program may be to error out with a message like "You have local
changes to .gitmodules; please stash it before moving or removing".

[Footnote]

*1* I think all the variables in .gitmodules are single-valued, so
    the original submodule.dir.path's value was "dir", the local
    modification by the user was to make it "folder", and rm wants
    to delete an unrelated submodule.mod.* altogether, we can apply
    the usual 3-way merge policy per variable basis to update
    submodule.dir.pah to "folder".

    A more general merge driver to handle git-config format files
    would have a way to be told that some variables are additive
    with the -X<driver-specific-option> mechanism.  When variable
    foo.bar is specified as a multi-valued set of variables, the
    original has a single foo.bar="xyzzy", one side adds a
    foo.bar="frotz while the other side modifies the original to
    foo.bar="nitfol", the ideal way for such a merge driver to
    operate is to leave two definitions (xyzzy will be gone and
    frotz and nitfol remain).

    But I highly suspect that would need a much larger change to the
    configuration file parser and writer that is totally out of
    scope with this change, and that is why my recommendation at
    this point is just to follow the example of pre-"-m" era of "git
    checkout anotherbranch".


> ----------8<-----------------
> diff --git a/submodule.c b/submodule.c
> index edfc23c..4670af7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -102,7 +102,7 @@ void stage_updated_gitmodules(void)
>         struct cache_entry *ce;
>         int namelen = strlen(".gitmodules");
>
> -       pos = cache_name_pos(".gitmodules", strlen(".gitmodules"));
> +       pos = cache_name_pos(".gitmodules", namelen);
>         if (pos < 0) {
>                 warning(_("could not find .gitmodules in index"));
>                 return;
