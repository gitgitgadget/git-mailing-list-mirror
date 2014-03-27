From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in master? (submodules without a "master" branch)
Date: Thu, 27 Mar 2014 10:16:52 -0700
Message-ID: <xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	"W. Trevor King" <wking@tremily.us>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 18:17:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTDvJ-0006rX-1l
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 18:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbaC0RQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 13:16:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873AbaC0RQz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 13:16:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C17E76D5C;
	Thu, 27 Mar 2014 13:16:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BIafgfgxRUuZWEbxRT9p8ONuoZ0=; b=wJiNq5
	osy1T+3WNzTXbBv+qNMQkRHTWohlR/GFUsErTDNB2IdMxawGT91B2QGjlLL7vqIo
	/UhfRPnQwc2GPImz6ZDijjDptmJqH5n+2fb25vSKwBV2EKoyZzXLFYynQc69mcOX
	8CNdU8X3mldEPNrHrZjmf3BQMgiNokWjIWoAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cewkL7OGT0UcYMLeSBKH0ETIMwQszo0F
	at2fB5pvXyERmI9vs9i+Z5lT82WMzvrJz7ODg7FntDUfO++2v398d1rg6/4zUD5M
	kLN5stVjTqmOkWKIdjiNZXuU02y8niL1c4r39JX6Np3ywpGH0nNB9O3Ofz6WiSEe
	mCSDRs1szMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC85976D5B;
	Thu, 27 Mar 2014 13:16:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50D9D76D5A;
	Thu, 27 Mar 2014 13:16:54 -0400 (EDT)
In-Reply-To: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
	(Johan Herland's message of "Thu, 27 Mar 2014 15:21:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97F4F0A0-B5D3-11E3-8525-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245295>

Johan Herland <johan@herland.net> writes:

> I just found a failure to checkout a project with submodules where
> there is no explicit submodule branch configuration, and the
> submodules happen to not have a "master" branch:
>
>   git clone git://gitorious.org/qt/qt5.git qt5
>   cd qt5
>   git submodule init qtbase
>   git submodule update
>
> In current master, the last command fails with the following output:

... and with a bug-free system, what does it do instead?  Just clone
'qtbase' and make a detached-head checkout at the commit recorded in
the superproject's tree, or something else?

>   Cloning into 'qtbase'...
>   remote: Counting objects: 267400, done.
>   remote: Compressing objects: 100% (61070/61070), done.
>   remote: Total 267400 (delta 210431), reused 258876 (delta 202642)
>   Receiving objects: 100% (267400/267400), 136.23 MiB | 6.73 MiB/s, done.
>   Resolving deltas: 100% (210431/210431), done.
>   Checking connectivity... done.
>   error: pathspec 'origin/master' did not match any file(s) known to git.
>   Unable to setup cloned submodule 'qtbase'
>
> Bisection points to 23d25e48f5ead73c9ce233986f90791abec9f1e8 (W.
> Trevor King: submodule: explicit local branch creation in
> module_clone). Looking at the patch, it seems to introduce an implicit
> assumption on the submodule origin having a "master" branch. Is this
> an intended change in behaviour?

If an existing set-up that was working in a sensible way is broken
by a change that assumes something that should not be assumed, then
that is a serious regression, I would have to say.
