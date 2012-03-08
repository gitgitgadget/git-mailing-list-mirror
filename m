From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Removing useless merge commit with "filter-branch"
Date: Thu, 08 Mar 2012 15:30:12 -0800
Message-ID: <7v62eebri3.fsf@alter.siamese.dyndns.org>
References: <CAOMFOmWMsXgepY0-ZWFymd9uHSUmbOk66r75qa-Kv5TWx_U=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 00:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5mms-0004cG-97
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 00:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759062Ab2CHXaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 18:30:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab2CHXaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 18:30:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 633887463;
	Thu,  8 Mar 2012 18:30:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HzKCeWpwrYGgsbyT+gx6TH/of5g=; b=CH/ZDZ
	IYmTdXl1mqPq7zRJUZApjxpWezaY4xiSlLfHlYQetS9LfFPCVMPuQ/blsNytWgzj
	paHeFKbBAngeK8BS7e1x9glMxu3eaHB/xEEupaPa7mYhLerbRH1nxCOCJDRUAxgg
	uDBP7M5LR1CSgVbuPem+7j5CDAZtRNm7fM7Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZeXnkW/gk5SpzAQNNuUQ+OAbsu9D4xP
	rJ/DUTyugpTdYv95uRnDBuvu3/PV5SNAVem46VSLUqHkD60ITwUhJDS7a3KH3ops
	XXGV9twd0dzu1S3TfIOITwkwrZ7oobzGLR3rfewx74tsli/nQnVh3/j/Xl34fTKM
	7yHVG+z+lVo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A5A47462;
	Thu,  8 Mar 2012 18:30:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD26C7461; Thu,  8 Mar 2012
 18:30:13 -0500 (EST)
In-Reply-To: <CAOMFOmWMsXgepY0-ZWFymd9uHSUmbOk66r75qa-Kv5TWx_U=EA@mail.gmail.com> (Anatol
 Pomozov's message of "Thu, 8 Mar 2012 15:21:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7B479A8-6976-11E1-8347-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192664>

Anatol Pomozov <anatol.pomozov@gmail.com> writes:

> |
> o      - merge commit that previously merged feature X
> |\
> | \
> |  \
> o  |   - real commit
> |   |
> |  /
> |/
> |

It is unclear how many commits are drawn in the above picture and
what "feature X" is about in the above picture.  Care to redraw the
commit DAG to explain what you are trying to do a bit better?

The way I read it is that you start from a history like this (note
that when we draw an ascii art history we often write it sideways,
time flows from left to right):

    ---A-----B-----M---
        \         /
         C-------D

where a side branch to implement "feature X" that has C and D forked
at A, and it was merged at M after somebody else committed B on the
mainline.  When you filtered out some parts of the tree, it turns
out that C and D are totally unintereseting because their changes
touch parts outside of your interest, i.e. the history is:

    ---A-----B-----M---
        \         /
         o-------o

where 'o' are now no-op.

Is that what you are talking about?

I think "log --simplify-merges A..M -- path" may already has logic
that deals with this, so it may help if you study what it does and
how it does what it does.
