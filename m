From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -f --autosquash
Date: Sat, 26 May 2012 23:44:52 -0700
Message-ID: <7vobpap1gb.fsf@alter.siamese.dyndns.org>
References: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com>
 <1336820755.3002.11.camel@centaur.lab.cmartin.tk>
 <7vipfyiuv6.fsf@alter.siamese.dyndns.org>
 <33DF11B90FEF4CB6B4103BE0AAF9B256@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Andy Kitchen <kitchen.andy@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 08:45:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYXEW-0001ts-PY
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 08:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab2E0Go4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 02:44:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab2E0Goz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 02:44:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82E074489;
	Sun, 27 May 2012 02:44:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YzJM+tXLPAeoqG0ou8yMobaln3A=; b=D8Qy8c
	Fl63ukOWMfcl4e2FZBUBjhFiHCuVaor4z0Y1ig0hHUzn3/DBozsBVqhHIsgwZAyu
	qQIai1bqSywHDKyrorRL/alfTl9pr8hXhCsLHoMY8tuL0hleJ7xvlEa7cO+QOIte
	hobRvGQxhm8+P6/6RIRjprkKhZJOHBeHra/2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cz5OYoNALp8TTHdVWaTipxh/+xz4TJ72
	ebVoGfFZiN1IOX8gZ47QcxLO6R7R3YlTc6ZplUqhSb1lNZtMGr6L3gKIhJlsq71q
	5B5dWLMheBT/s0jnIJjQ0AP8iEB39Y7F/1TsRQsAhjj/nJKq941VQXby+uPlmsjk
	kqMcL5Ti1gQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79CFF4488;
	Sun, 27 May 2012 02:44:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4520447E; Sun, 27 May 2012
 02:44:53 -0400 (EDT)
In-Reply-To: <33DF11B90FEF4CB6B4103BE0AAF9B256@gmail.com> (Andy Kitchen's
 message of "Sat, 26 May 2012 17:30:21 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 773F5F92-A7C7-11E1-A457-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198579>

Andy Kitchen <kitchen.andy@gmail.com> writes:

> 1a)
>
> $ git rebase -f --autosquash <base>
> is made to be effectively equivalent to:
> $ EDITOR=: git rebase -i --autosquash <base>

I am not sure how you do the above without breaking the existing users and
other people's use cases, given that giving --force option to rebase has
totally different meaning from the above (i.e. "do not refuse to rebase
even though the current branch is up to date with respect to <base>").
Such an option overloading, especially for an option "force", feels adding
confusion without much merit---it is unclear what kind of "forcing" is it
calling for.

> 1b)
>
> $ git rebase --autosquash <base>
> (i.e. -f is implicit) is made to be effectively equivalent to:
> $ EDITOR=: git rebase -i --autosquash <base>

I do not think this would work.  

The --autosquash option is merely a way to help reordering by moving the
"fixup!" commits in the history around without manual action You may have
commits created with "fix" but _other_ commits in the history that you
want to manually reorder in the insn sheet.

> 3) A new command is created, for example one of:
>
> $ git fix
> $ git squash
> $ git autosquash

All of these names are so broad and generic---I am not sure if any of them
will "click" with your single narrow use case, which as far as I can see
is "I want rebase with --autosquash but I am not going to do any other
editing."  None of the above three words hints the new command is about
rebasing.

Even though I find the "I want rebase with --autosquash but I am not going
to do any other editing." is a workflow element that often appears in the
real life, I do not think it deserves its own command that is separate
from "rebase".  It is merely a slightly different way to drive "rebase",
after all.

And that "I want rebase with --autosquash but I am not going to do any
other editing" is where my suggestion to use "--no-edit" comes from.
