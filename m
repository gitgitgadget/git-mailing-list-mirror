From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 16:35:59 -0800
Message-ID: <7vsjj20yog.fsf@alter.siamese.dyndns.org>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
 <20120126230054.GC12855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:36:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqZnV-0004kh-EJ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab2A0AgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 19:36:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab2A0AgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:36:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1E596027;
	Thu, 26 Jan 2012 19:36:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2c0qp771rFn/zNxuYtfEf7NBe+A=; b=jZdZYF
	/96ZDqibWHWSRSDZ6qAxs/VkkCYApfHV0LKDxQSRda/zx3FUjgBWqjtMZFdFloe5
	Ii8R9WP/SN+9fJQ3qHfz51rWdfmQPRxghwxRan+XM7MhTA95hhDtFEYaNDrv/rgv
	0QkmV5ZlitK4XaGtHXdm6SZn56u5O0HyPDV/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CaIgSpRMadRU7Sh7gm+MiU1TnGk0NZk4
	bWIyOTFEctsPBVOQCNVYY9IYxfifcUKlS6gG5//m5vF7Dw4y2G0mCgmd3ErRx7wE
	+0H8MK1DcZlPUmuS/XY37KyK4ayuyfqPFguFcuH4oYJEqacZbTZky2D9tXz8Abhx
	a55PJ5ru3l0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B65D76026;
	Thu, 26 Jan 2012 19:36:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AE6C6025; Thu, 26 Jan 2012
 19:36:00 -0500 (EST)
In-Reply-To: <20120126230054.GC12855@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jan 2012 18:00:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E31CA8BC-487E-11E1-9AD0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189179>

Jeff King <peff@peff.net> writes:

> So yeah, if you are just going to copy it once, or even periodically, it
> is not that big an advantage. And the example I gave using "git tag" did
> just that. But I also wanted to allow more complex things, like this:
>
>   # clone and inspect
>   git clone git://example.com/project.git
>   cd project
>   git show origin:devtools/std_gitconfig
>
>   # well, that looks pretty good. But I'd like to tweak something.
>   git checkout -b config origin
>   $EDITOR devtools/std_gitconfig
>   git commit -a -m "drop the foo option, which I hate"
>
>   # OK, let's use it now.
>   git config include.ref config:devtools/std_gitconfig
>
>   # Weeks pass. Somebody else updates the std_gitconfig.
>   git fetch
>   # let's inspect the changes
>   git checkout config
>   git diff @{u} -- devtools/std_gitconfig
>   # looks good, let's merge (not copy!) them in
>   git merge @{u}
>
> This is obviously an advanced thing to be doing.

The "which *I* hate" in the log message makes it sound as if it is a
personal preference, but in fact this is more about maintaining the
recommended configuration among participants, no?  And if you have the
source of the configuration on a branch so that people can work on it
among themselves, then "config.path = ../devtools/std_gitconfig" should be
sufficient, no?

The pros-and-cons between the volume of the change to read include from
blobs and the benefit illustrated in the use case did not look too good to
me, at least from the messages in this thread so far.
