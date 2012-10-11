From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] "git commit" after "cherry-pick -n" conflict clobbers
 .git/COMMIT_EDITMSG
Date: Thu, 11 Oct 2012 10:00:53 -0700
Message-ID: <7vzk3t6j0a.fsf@alter.siamese.dyndns.org>
References: <20121011113352.006efa25@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMM8B-0004q7-Js
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758853Ab2JKRA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:00:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757733Ab2JKRA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 13:00:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0708C97C2;
	Thu, 11 Oct 2012 13:00:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CXFgk0NBWUQkfDpWIAqXJtYvK6A=; b=pLbnTa
	IFoq8j7xIrllMEnuuUQF1eCgKLlqsN8Z044fExudzCmLcjZmhGs6trGvhOh2yCg9
	n+S8Do453LuPdt+2DfklpnV44OUd0s5uglJcealQuuINrad5pxPVqQaDJIEH3Q6b
	yPwNns+WDB6GsySgClKFWqrMUET+XIaM3ptw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kqSwYtPPwSHAb90i3oGGbs3qQUwq4HWX
	kGs28fLO1cjaClmxaXtB+S/a19RtU7ZNh9uOav86dUr0YKbQMUykUvbFuVKro4qU
	d4tygIlJ1T1xsn+wUpMMErt0vahyy4ITjSCjLqJj+azLT3ZvGeORJtBxNwEcfaZg
	VX/zmrorvIY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E255E97C1;
	Thu, 11 Oct 2012 13:00:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B12497B9; Thu, 11 Oct 2012
 13:00:55 -0400 (EDT)
In-Reply-To: <20121011113352.006efa25@chalon.bertin.fr> (Yann Dirson's
 message of "Thu, 11 Oct 2012 11:33:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 389D6ED6-13C5-11E2-A50E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207488>

Yann Dirson <dirson@bertin.fr> writes:

> (only tested with 1.7.10.x for now)
>
> ~/softs/linux$ echo foo > .git/COMMIT_EDITMSG

Why are you mucking with such an internal implementation detail in
the first place?

> ~/softs/linux$ git cherry-pick -n b55f3d92cd
> error: could not apply b55f3d9... Linux 2.6.32.26
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> ~/softs/linux$ cat .git/COMMIT_EDITMSG
> foo
>
> So far, so good.  But then "git commit" brings me the message from the
> cherry-picked commit plus the list of conflicted files, and I can verify that
> it is now the contents of .git/COMMIT_EDITMSG.

You verified that "what" is now in .git/COMMIT_EDITMSG?  The commit
log message for you to edit to record the result of the cherry-pick?

If that is the case, what is the problem?

If anything you had in .git/COMMIT_EDITMSG before you started
"'cherry-pick -n', edit further to adjust, and then 'commit'"
sequence were to appear in the editor to edit the commit log,
it would be a bug, I would think.
