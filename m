From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] status: always show tracking branch even no change
Date: Fri, 09 Aug 2013 14:18:48 -0700
Message-ID: <7vob964l6v.fsf@alter.siamese.dyndns.org>
References: <cover.1375972599.git.worldhello.net@gmail.com>
	<0affa278c225273a2d3fdcf8f55b61e26d322f1e.1375972599.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:18:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7u5H-0006Ej-I4
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031185Ab3HIVSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:18:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031152Ab3HIVSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:18:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FD6138844;
	Fri,  9 Aug 2013 21:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQkl4AOshxgcG9PB9M9R5CgmivU=; b=QzitO7
	vdmzESkzq0csTpMNXufMVHqXRmczgsWwAvs9app2m32ZYps2CpABMPfTDlX016ls
	h1gZoI1ed/skURFgkgYTf4GBx1yIcK+TXhFy/ohPIOKxn4evq4WA/D40SaC6sOva
	5GFh5ku1UAScG8g5no9gbOYtkaHasZ4hK7QG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cb8hBF0ZeLqKzaKBbfuYreJVHLEGrXdO
	HJt81fssLL7f5TLJW/2lSRtjgW/c7iurgaNY3jUtIx6DBJWK5IE/blb8XEBOjxM2
	UcfeLZy73T6MEDPA8juS3L5yX9TqJXo+qTvIhsa8tQ1FgjhzSd/9rKA+9/wr0GmX
	n2075J7bzKY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33A3C38843;
	Fri,  9 Aug 2013 21:18:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79DC838842;
	Fri,  9 Aug 2013 21:18:49 +0000 (UTC)
In-Reply-To: <0affa278c225273a2d3fdcf8f55b61e26d322f1e.1375972599.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 8 Aug 2013 22:49:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48A9EC52-0139-11E3-A5E4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232031>

Jiang Xin <worldhello.net@gmail.com> writes:

> If the current branch has an upstream branch, and there are changes
> between the current branch and its upstream, some commands (such as
> "git status", "git status -bs", and "git checkout") will report their
> relationship. E.g.
>
>     $ git status
>     # On branch master
>     # Your branch is ahead of 'origin/master' by 1 commit.
>     #   (use "git push" to publish your local commits)
>     #
>     ...
>
>     $ git status -bs
>     ## master...origin/master [ahead 1]
>     ...
>
>     $ git checkout master
>     Already on 'master'
>     Your branch is ahead of 'origin/master' by 1 commit.
>       (use "git push" to publish your local commits)
>
> But if there is no difference between the current branch and its
> upstream, the relationship will not be reported, and it's hard to
> tell whether the current branch has a tracking branch or not. And
> what's worse, when the 'push.default' config variable is set to
> `matching`, it's hard to tell whether the current branch has already
> been pushed out or not at all [1].

That description of the problem you are trying to solve makes (sort
of) sense.

> So always show the remote tracking branch in the output of "git status"
> and other commands will help users to see where the current branch
> will push to and pull from. E.g.
>
>     $ git status
>     # On branch master
>     # Your branch is identical to 'origin/master'.
>     #
>     ...
>
>     $ git status -bs
>     ## master...origin/master
>     ...

Hmmph.

I do not know if this will help any case you described above, even
though this might help some other cases.  The added output is to
always show the current branch and its upstream, but the thing is,
the original issue in $gmane/198703 was *not* that the current
branch was pushed and up to date.  It was that there was no current
branch to be pushed.  The same thing would happen if you are on a
local branch that is not set to be pushed to the other side
(e.g. the configuration is set to "matching" and there is no such
branch on the other end).

"Your branch is identical to" will be given only if your branch is
set to be pushed out, no?  For the user to tell what is going on,
the user has to notice the lack of this extra line in the output,
and noticing the lack of anything is much unlikely.
