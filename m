From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD state while preserving its staged state
Date: Mon, 06 May 2013 07:52:46 -0700
Message-ID: <7vbo8otb29.fsf@alter.siamese.dyndns.org>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	<87obcryvcw.fsf@hexa.v.cablecom.net>
	<7va9oawmbp.fsf@alter.siamese.dyndns.org>
	<7v61yywm49.fsf@alter.siamese.dyndns.org>
	<CADeMBopBvCmb4cz8p8vf-jXaOhfzP3GZKF94Efgsh-NOBs+d3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Thomas Rast <trast@inf.ethz.ch>
To: Dimitar Bonev <dsbonev@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 16:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZMmc-0003tP-1K
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 16:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab3EFOwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 10:52:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab3EFOws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 10:52:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 587BA1B186;
	Mon,  6 May 2013 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JPB7HDMfARtZ3PLtM7efHg3VlZY=; b=tJ4drhifDi7w3Igom19G
	7swI+slBNir69DmPbDQhBbeepeqtIVE3oDZzMIByFan7VJhhqkszHn04+QUeeGMm
	Xq1t9vEf87r2lAlAOVGxCFnJN6KpFp9xO60B8jqVwxDYzXpEeBDA9LMyhD1mhzg4
	b5o+O4jydMKKrKSu52v0/u4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BRfNRcmi7TTpQ3EQ/9mDs2NtL+Qk4+3YzITDRDd6b/YXui
	5SXuLnWZDHjJBcXzXGawqycps/7KqJkJc+S4pRIHz1pvlbQ+LJVrU3CRqCqkruC3
	WAX4SV49O+VPJzZZWMMxL0M5jYDNI8f3mJdwFIphJ5aW8k0JyM2VL5Xrasfgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FB691B185;
	Mon,  6 May 2013 14:52:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A32BF1B183;
	Mon,  6 May 2013 14:52:47 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DE4647C-B65C-11E2-8358-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223456>

Dimitar Bonev <dsbonev@gmail.com> writes:

[administrivia: please do not drop people out of Cc list]

> Actually this is not the case as I tried to explain with the 'git
> commit' followed by 'git checkout HEAD~1 -- targetfile' followed by
> 'git commit --amend' example. The index and the working dir states are
> very well related.

That invites another question: if it is very well related, why isn't
it an option to start from the state you have in the working tree
(i.e. doing nothing), or in the index (i.e. "git checkout
controller")?

But the answer does not matter that much in the end.

> Lets imagine that I am adding an MVC feature X - it
> could be implemented with 3 or more files. If I stage the files and
> came up with an idea that requires a major rewrite of one of these
> files - lets say the controller one - then it is more convenient to
> checkout the file's HEAD state and build on top of it - I had been
> doing just that right before staging

So you have satisfactory changes for view and model in the index,
and changes to the controller that maybe is OK but you think it
could be improved, and you want to go back to the clean slate to
rethink the approach only for the controller part?

I think the story is essentially the same.  Let's say you did

    git diff HEAD controller | git apply -R
    edit controller

to get rid of the changes in the working tree, further worked on the
controller part, and came up with a different implementation.  Then
you would presumably do

    git add controller

but at that point you would lose the "maybe OK" version you had in
the index.  What if you think the version in the working tree might
end up being better than "maybe OK" but can still be improved
further?  You never "git add" until the working tree version gets
into truly a better shape?

What happens fairly often is that you end up having more than _one_
versions that are both better than the version from the HEAD but
cannot immediately say one is clearly better than the others in all
counts, and at some point, you would need more than one intermediate
states (while the index can have only one), to keep these competing
versions. The next thing you would want to do is to take a deep
breath and pick better parts from these good versions to come up
with the single final version. Keeping one good version in the index
does not let you do so.

> ... commits - I treat them as finished work.

I think people should learn to take the biggest advantage of using a
distributed source control system, which is that commits do not have
to be "finished work", until you choose to declare they are done and
push them out for others to see.

Fear of commitment is a disease we do not have to suffer once we
graduated centralized systems ;-).
