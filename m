From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch name in remote.<remote>.push is not updated after "git
 branch -m"
Date: Tue, 22 Jan 2013 08:59:23 -0800
Message-ID: <7v622pb1ck.fsf@alter.siamese.dyndns.org>
References: <20130122164306.3dc8b757@opensuse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 17:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxhCP-0008SD-39
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 17:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab3AVQ71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 11:59:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622Ab3AVQ70 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 11:59:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4449CC206;
	Tue, 22 Jan 2013 11:59:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ON+8PwMQ/sjat+O4JEX1U3Leqt0=; b=L48XKr
	xIwD+bsLZUAvEClKluSVtQqOK8YgtEcg6vJQhJ6PA0zu+UB2xtby9q1gaLHJCsdS
	Eu+Aq5hE+70V/bZpZPXhF3sU1joIPwflI+K7alPqxbC0VEGz3dAUSQWWpOiLsGMa
	jTkq2OLRMxtQi0yPmyFB+5zZk3x8qfCWhpmA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wrFeExyMTQA8inOxG00gk6mEOdwBvHmh
	KX6TYdgku7rJK7OLfi8nQ0wIkW9P/WpphaKH/mz4evWt3bTYd5q1Z/7W2yRqQkO+
	mm4Bd6dWHEO5u7S3huOfwnx+usW/wIqZ8EKI46r1rS4+srjgnDF69K69dk5gw/hC
	jJVFLw9v6wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36F03C205;
	Tue, 22 Jan 2013 11:59:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BDF5C200; Tue, 22 Jan 2013
 11:59:25 -0500 (EST)
In-Reply-To: <20130122164306.3dc8b757@opensuse.site> (Andrey Borzenkov's
 message of "Tue, 22 Jan 2013 16:43:06 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13A271F8-64B5-11E2-92F1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214238>

Andrey Borzenkov <arvidjaar@gmail.com> writes:

> I renamed branches and noticed that branch name was not changed in
> remote push config. I.e. after
>
> bor@opensuse:~/src/bootinfoscript> git branch -m github master
>
> I still have
>
> [remote "github"]
>         push = github:master
>         url = git://github.com/arvidjaar/bootinfoscript.git
>         pushurl = git@github.com:arvidjaar/bootinfoscript.git
>         fetch = +refs/heads/*:refs/remotes/github/*
>
> Is it expected behavior or possibly already fixed?

Isn't that line added manually by you?

If the line were written in a canonical and an explicit way
(i.e. "push = refs/heads/github:refs/heads/master"), it might be
nicer if "git branch -m" noticed it and adjusted the LHS of the
refspec, but even that is dubious.

The move of the old github to master by the user may well have been
because the user realized that he added something that is not ready
to be pushed out to the branch, and the next move by the end user
could be to create a github branch anew that points at an earlier
part of the history that is ready to be pushed, while keeping the
invariant "my local github branch is what I will publish".

So, in short, it is expected, and no, I do not think changing it to
"push = master:master" is necessarily an improvement.
