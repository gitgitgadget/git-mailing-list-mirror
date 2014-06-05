From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal for pruning tags
Date: Thu, 05 Jun 2014 13:50:58 -0700
Message-ID: <xmqqoay7rsgd.fsf@gitster.dls.corp.google.com>
References: <CAHd499BLX3q2FHLfFpq_14w2mmosywfRqMHVjkke0BRhAAjx7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 22:51:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsed2-0002hP-NB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 22:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbaFEUvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 16:51:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64602 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbaFEUvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 16:51:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA0721DCB2;
	Thu,  5 Jun 2014 16:51:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FoDPYje2wRMGkvMeZJNJk/85398=; b=yQKwIN
	uHw0O7IoRUQeCpiX21voa9Lz6y5Td0I1UfYIiR7xB3+VsKQeaKkP1MGtVcdWUxhg
	23YKvAZtDWHcYmG58AII75yzPvSZ4eo9B8ljP3AYS1y0z6nsT4VE6Z9ERU0dDWpA
	7BuAlzr2acIN9BRR4ZSHOiDa3633/gD+v93QE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GiIeh8Xaay5BvrB+0La5Hzz4DmF9yoj/
	kGpxNMfNEmZlYdoJSTWV/pB8r4h57eTv1/LwHLMh+1zd/2AqARtbaks5upO62+Gv
	jQdsmh6/tSJUE0iQFrLRxFreU+JI+f/v+FMok5tvxKghxq/O4DJLhWa1/UF42Oo0
	e7PI3KYUSyo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEC211DCB1;
	Thu,  5 Jun 2014 16:51:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B5B091DCAD;
	Thu,  5 Jun 2014 16:51:00 -0400 (EDT)
In-Reply-To: <CAHd499BLX3q2FHLfFpq_14w2mmosywfRqMHVjkke0BRhAAjx7g@mail.gmail.com>
	(Robert Dailey's message of "Thu, 5 Jun 2014 09:51:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 19EF3664-ECF3-11E3-A70E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250862>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> I've never contributed to the Git project before. I'm a Windows user,
> so I use msysgit, but I'd be happy to install linux just so I can help
> implement this feature if everyone feels it would be useful.
>
> Right now AFAIK, there is no way to prune tags through Git. The way I
> currently do it is like so:
>
> $ git tag -l | xargs git tag -d
> $ git fetch --all

I think you need to explain what you mean by "prune" a lot better
than what you are doing in your message to be understood by others.

After seeing the above two commands, my *guess* of what you want to
do is to remove any of your local tag that is *not* present in the
repository you usually fetch from (aka "origin"), but that directly
contradicts with what you said you wish, i.e.

> This is not only wasteful, but dangerous. I might accidentally delete
> a local tag I haven't pushed yet...

which only shows that your definition of "prune" is different from
"remove what I do not have at 'origin'".

But it does not say *how* that is different.  How should "prune"
behave differently from the two commands above?  How does your
"prune" decide a tag needs to be removed locally when it is not at
your "origin" [*1*]?

There is *nothing* in git that lets you look at a local tag that is
missing from the other side and determine if that is something you
did not want to push (hence it is missing there) of if that is
something you forgot to push (hence it is missing there but you
would rather have pushed if you did not forget).  So you must have
some new mechanism to record and/or infer that distinction in mind,
but it is not clear what it is from your message.

So until that is clarified, there is not much more to say if your
"feature" has any merit---as there is no way to tell what that
"feature" exactly is, at least not yet ;-)


[Footnote]

*1* By the way, removing and then refetching would be a silly way to
    do this kind of thing anyway.  After removing but before you
    have a chance to fetch, your ISP may severe your network
    connection and then what happens?

    Whatever your definition of "prune" is, I would think it would
    be built around "ls-remote --tags" output, to see what tags the
    other repository (or other repositories, by looping over the
    remotes you interact with) have, compare that set with the tags
    you locally have in order to decide which subset of tags you
    locally have to remove.
