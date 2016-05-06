From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Fri, 06 May 2016 09:34:07 -0700
Message-ID: <xmqqh9eb5eo0.fsf@gitster.mtv.corp.google.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
	<xmqqr3dhhcd7.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605061658580.2963@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 06 18:34:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayihl-0006xv-0k
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247AbcEFQeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:34:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751695AbcEFQeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 12:34:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0DE318A91;
	Fri,  6 May 2016 12:34:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=44DEoF0voXXhJX6JeAyRPjFiU/o=; b=k9thnC
	J9XkteiklZnu62tHBZwFLgYO4e/60VU3VV1+LUFUi1spVVEIY9t9OqOKqRzWS8b2
	L7JHCOAClTGUXVt5J00886WQVxgxuRoUak9cTPXgwiMQTd55rZmpNaJiF/ZMo5ha
	MRDAe4f/XwScqunw4a3GeBZ3w1mvF3IfC98O0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5qkxITGKBuztbgVFg7vZBG8fWrC4YmY
	GmZMploef5T2fttkvuyNtK9BgFchcVllACbutMVl6Swbbn3qN8fR+QYKG9M9qQN+
	+iuoUUD5XoRT2YANSoIdWs65xxT/jLi+QXl2JM9yyth8QSA6VpuYaSIPgJK5INaq
	jNfZ/cZDbNg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7E9318A90;
	Fri,  6 May 2016 12:34:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 369F318A8F;
	Fri,  6 May 2016 12:34:09 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605061658580.2963@virtualbox> (Johannes
	Schindelin's message of "Fri, 6 May 2016 17:19:23 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B86CF5A-13A8-11E6-BF89-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293830>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I agree with the goal of the change, but I am having a hard time
>> justifying this addition.  Primarily because I do not understand the
>> need for this.
>> 
>> In order to be prepared to handle HIDE_DOTFILES_TRUE case,
>> mingw_mkdir() needs to be taught about needs_hiding() and
>> make_hidden() already.  Why isn't it sufficient to teach
>> needs_hiding() to check with !strcmp(basename(path, ".git"))
>> under HIDE_DOTFILES_DOTGITONLY?
>
> The reason was that I wanted to avoid to compare a name unnecessarily when
> I already had a code path that knew perfectly well that a given directory
> is the .git/ directory.
>
> I made the change. It was more painful than I expected, as two bugs were
> uncovered, both introduced after the original patch by Erik.
> ...
> It worries me slightly that the new code is so different from the code
> that was tried and tested through all those years (although admittedly it
> is unlikely anybody ever ran with core.hideDotFiles = true, given above
> findings). But I guess that cannot be helped. Not unless we reintroduce
> those two bugs.

I have a huge preference for a code that has been production for
years over a new code that would cook at most two weeks in 'next'.
As I said, the part regarding the mark_as_git_dir() in the message
you are responding to was me asking you to explain, not me objecting
to the code.

> I had a look in the mail archives, and it looks as if I wanted to support
> `git clone -c core.hideDotFiles...`. I introduced a new regression test
> and verified that we no longer need to write that config setting
> explicitly.

If you are sure we do not need that, that is one less reason we
would be better off without mark_as_git_dir().  It was another way
how a $GIT_DIR creation codepath behaved differently from other
mingw_mkdir() codepath in the patch.

Having said that, I actually was leaning towards an opinion that it
might actually be better to have mark_as_git_dir() there.  Platforms
may need to do other things in their implementation of the function
to tweak things inside $GIT_DIR, just like you had to have a place
to add configuration variables and mark_as_git_dir() was the perfect
place for it.

But mark_as_git_dir() is not a generic enough name to express its
purpose.  It wasn't even when all it did was to see the
HIDE_DOTFILES configuration and hide it (you are not marking it, in
the sense that after you return, you cannot tell which directories
are "marked" as "git_dir" by only looking at the resulting
filesystem entities), and as an all-purpose place to hook platform
specific tweaks, it is even less about "marking it as a $GIT_DIR".

A name that hints the fact that it is a place to do a platform
specific extra preparation of $GIT_DIR would be more appropriate.

So given the knowledge that

 - I am not fundamentally opposed to having an extra call there;
 - in fact, I suspect it may even be a good thing to have one;
 - I am not entirely happy with the name mark_as_git_dir; and
 - the rewrite to lose that call was more painful than anticipated.

would you still choose to lose the extra call and go with
!stricmp(basename(path), ".git")?  The best approach for v2 might be
to

 - Keep the two bugfixes that was uncovered during this exercise;
 - keep the change to init_db() to add a call to mark_as_git_dir();
 - optionally, come up with a better name for that function; and
 - drop the setting of configuration varaibles that was unnecessary.

That is what I think, with the new knowledge I learned from your
message.
