From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Thu, 23 Jan 2014 16:16:06 -0800
Message-ID: <xmqqob32s08p.fsf@gitster.dls.corp.google.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093716.GE15720@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 01:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6URa-00074U-6M
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbaAXAQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:16:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbaAXAQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 19:16:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E44066148;
	Thu, 23 Jan 2014 19:16:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lQl46GBNxY65asdX6f8lQrXAedo=; b=IppU+i
	JagVz9PEcR9f1zMXOawZE57fWVXydyY/3F0W1IgvRdY3dW17hRJgRt9EhwuFKueJ
	5nS8qa4hyhkaqzWfxdLXkV/IyATS5yDDQ8WabVQoK1I4dN2b7ayp9mlqCi/kBrJY
	H2Q3IXyGJa++H+s6Rd4gDfZCYphK1U5vqA1fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ELnUTGtPwKzu5VuEUmoYMRagCU9tjF7c
	WnFMn8AbQSN3CNHQFrQnnOYEDoXGBW3pNunfqNv7sk7PHof7IfsuWDS5ChO0jjk4
	l0eO9ov4oIIAkd/IBoujmBA7ybKTjDbu0jUj/kiUueYgqXwPEIVOeJBoQ3eGcag3
	nS0P7+5exUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1711F66147;
	Thu, 23 Jan 2014 19:16:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2108266146;
	Thu, 23 Jan 2014 19:16:14 -0500 (EST)
In-Reply-To: <20140108093716.GE15720@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jan 2014 04:37:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BCF0C5BE-848C-11E3-AAF7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240981>

Jeff King <peff@peff.net> writes:

> In a triangular workflow, you may have a distinct
> @{upstream} that you pull changes from, but publish by
> default (if you typed "git push") to a different remote (or
> a different branch on the remote). It may sometimes be
> useful to be able to quickly refer to that publishing point
> (e.g., to see which changes you have that have not yet been
> published).
>
> This patch introduces the <branch>@{publish} shorthand (or
> "@{pu}" to be even shorter). It refers to the tracking
> branch of the remote branch to which you would push if you
> were to push the named branch. That's a mouthful to explain,
> so here's an example:
>
>   $ git checkout -b foo origin/master
>   $ git config remote.pushdefault github
>   $ git push
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

As there is no @{pu} in publish_mark() as far as I can see, and also
I found it is a bit unclear what the example in the last paragraph
wants to illustrate, I'll reword the above as the following before
merging it to 'next'.

    This patch introduces the <branch>@{publish} shorthand that
    refers to the tracking branch of the remote branch to which
    you would push if you were to push the named branch.
    
    That's a mouthful to explain, so here's an example:
    
      $ git checkout -b foo origin/master
      $ git config remote.pushdefault github
      $ git push
    
    With this, foo@{upstream} and foo@{publish} would be origin/master
    and github/foo, respectively (assuming that "git fetch github" is
    configured to use refs/remotes/github/* remote-tracking branches).

> The implementation feels weird, like the "where do we push to" code
> should be factored out from somewhere else. I think what we're doing
> here is not _wrong_, but I don't like repeating what "git push" is doing
> elsewhere. And I just punt on "simple" as a result. :)

I think we can polish that in-tree.

Thanks.
