From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase: Print name of rev when using shorthand
Date: Wed, 16 Apr 2014 12:10:31 -0700
Message-ID: <xmqqa9blgkew.fsf@gitster.dls.corp.google.com>
References: <1397419474-31999-1-git-send-email-modocache@gmail.com>
	<xmqqwqerogvr.fsf@gitster.dls.corp.google.com>
	<CAN7MxmUikP6pVAj3cpDiSbFxawScTh5zKusPUe8SpkNbH=e6Aw@mail.gmail.com>
	<xmqqk3api4yy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:10:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaVEL-0003bO-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 21:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbaDPTKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 15:10:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836AbaDPTKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 15:10:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 482DF7D4FE;
	Wed, 16 Apr 2014 15:10:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXQrblBvEp/SjfL41J3MH5W58gY=; b=AlkyPO
	LfaWdfDh/2vTcZvulut/D7Bm6H3+w0r/ZXPHO8DAf7yOCSIB1BtXrlqfAf0PgPVj
	483YjmtI4nDSIB4q/WAUQc1A4NRPsPwl7l5O9Z7AjC6/8bQ0o4Hx6HhDYXWvlfqv
	iBrAZ6P6AJMKJ53sPZsYFGOC+U6uOkVk3d8y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CluWnbqz8ZT5h/SYM7Lg9bx3Z0AyLFSh
	hgxYK9jrbS9XKy0OBWVbTkazR8x7tgzZp9NvV2poRhSl2xvklUQKdkgr5uxBFE+I
	8yYv9C92HimDUT6HKTt/jGZ5vYEBRJhaUp37IbHXW3+AmMjmtKDF0li9g/81Pt2F
	gpVWHOMrUiE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31ADE7D4FD;
	Wed, 16 Apr 2014 15:10:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6B977D4FC;
	Wed, 16 Apr 2014 15:10:32 -0400 (EDT)
In-Reply-To: <xmqqk3api4yy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Apr 2014 10:01:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C8658CB4-C59A-11E3-9C9A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246376>

Junio C Hamano <gitster@pobox.com> writes:

>> Furthermore, were we to translate "@{-1}", does that mean we
>> should also translate "@{-2}" or prior?
>
> Surely, why not.  If a user is so forgetful to need help remembering
> where s/he was immediately before, wouldn't it be more helpful to
> give "here is where you were" reminder for older ones to allow them
> to double check they specified the right thing and spot possible
> mistakes?

After re-reading the proposed log message of your v2, I notice one
thing:

    The output from a successful invocation of the shorthand command
    "git rebase -" is something like "Fast-forwarded HEAD to @{-1}",
    which includes a relative reference to a revision. Other
    commands that use the shorthand "-", such as "git checkout -",
    typically display the symbolic name of the revision.
  
While the above is not incorrect per-se, have you considered _why_
it is a good thing to show the symbolic name in the first place?

Giving the symbolic name 'master' is good because it is possible
that the user thought the previous branch was 'frotz', forgetting
that another branch was checked out tentatively in between, and the
user ended up rebasing on top of a wrong branch.  Telling what that
previous branch is is a way to help user spot such a potential
mistake.  So I am all for making "rebase -" report what concrete
branch the branch was replayed on top of, and consider it an incomplete
improvement if "rebase @{-1}" (or "rebase @{-2}") did not get the
same help---especially when I know that the underlying mechanism you
would use to translate @{-1} back to the concrete branch name is the
same for both cases anyway.

By the way, here is a happy tangent.  I was pleasantly surprised to
see what this procedure produced:

    $ git checkout -b ef/send-email-absolute-path maint
    $ git am -s3c a-patch-by-erik-on-different-topic
    $ git checkout bg/rebase-off-of-previous-branch
    $ git am -s3c your-v2-patch
    $ git checkout jch
    $ git merge --no-edit -
    $ git merge --no-edit @{-2}
    $ git log --first-parent -2 | grep "Merge branch"

Both short-hands are turned into concrete branch names, as they
should ;-)
