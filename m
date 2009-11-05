From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit -c/-C/--amend: reset timestamp and authorship
 to committer with --reset-author
Date: Wed, 04 Nov 2009 21:40:13 -0800
Message-ID: <7vws25a5s2.fsf@alter.siamese.dyndns.org>
References: <1257304811-26812-1-git-send-email-erick.mattos@gmail.com>
 <7vpr7ykbh8.fsf@alter.siamese.dyndns.org>
 <20091105123456.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 06:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5v5F-0001DK-TS
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 06:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbZKEFkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 00:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbZKEFkT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 00:40:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZKEFkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 00:40:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E83742D4;
	Thu,  5 Nov 2009 00:40:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BoRsvvFVz/baMoCDesFJWAa95Kc=; b=CLY4Zz
	ibezcP+PQ5Ntmn436N7/X6ZO6JvlkgPQpHynKF6G5C+Sjy00icKt38JDlOfTvokz
	sv2XzAvshuF9WxvzJ2enoD6lUXX47yVBxeNwMFZ9D5Nn0z7M8M74toKnu43OG/r8
	qMLjt+6h/nNTfTF/NxVitEpg09zZFRnYMrr2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P2O8/ALyGXI/XFZhWePo0/qye8Rsh5fo
	PuTgiBjd9GFwXkPf0NXzY7yVfdoMQHni4b/JQo+K8yEvePlEaMUaOP7en/pT1nlB
	lCZSuh4xo2oVOxxcYSWZQr0fNHpFnfSOJfsD07VPWuiFMwc4oXzJDMyQaLx5jYQU
	eWvmTduYY0s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18317742D3;
	Thu,  5 Nov 2009 00:40:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14670742D1; Thu,  5 Nov
 2009 00:40:14 -0500 (EST)
In-Reply-To: <20091105123456.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu\, 05 Nov 2009 12\:34\:56 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B474B914-C9CD-11DE-B940-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132199>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> It may be wise to forbid a combination of options if it 
> encourages mistakes or a wrong workflow, but I don't think 
> using --author and --reset-author with 'git commit --amend' 
> is such a case.
>
> Imagine somebody other than you (eg. me) were the maintainer, 
> and a message by Szeder was sent with a good commit log message.
>
>  http://article.gmane.org/gmane.comp.version-control.git/132029
>
> Then you sent a replacement patch that solves the same problem 
> in a more elegant way, but without anything that is usable as the 
> commit log message.
>
>  http://article.gmane.org/gmane.comp.version-control.git/132041
>
> If I were the maintainer, I would find it very convenient if I can 
> work like this:
>
>  % git am -s 132029   --- first I apply Szeder's version
>
> Then I see your message. Replace the code change but use Szeder's
> log message.
>
>  % git reset --hard HEAD^
>  % git am 132041   --- your version with no usable log message
>  % git commit --amend -s -c @{2} --author='Junio C Hamano <...>'

Thanks.

So you commit Szeder's and then commit mine (make them independent), and
amend the log message of the latter using the message from the former, and
assign the authorship of the latter to the resulting commit?

That is a much more understandable argument than just claiming "--author
should be usable with --reset-author" without clearly stating why that
would help.  I think you forgot to add --reset-author to the last command
line, though.

But I think it is showing that --reset-author is actually suboptimal way
to solve your scenario.  In the last command in your sequence, you don't
want to add "--reset-author --author=X" but want "--reuse-only-message"
option.

And I think it makes much more sense than the alternative semantics we
came up with during this discussion.  --mine (or --reset-author) to
declare that "I am the author" was not what we wanted after all(yes, I am
guilty for suggesting it).  What we want is "I am using -C/-c/--amend and
I want to borrow only the message part from the named commit (obviously
"amend" names the HEAD commit implicitly).  Determine the authorship
information (including author timestamp) as if I didn't use that option."
