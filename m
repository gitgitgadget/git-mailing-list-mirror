From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 16:14:31 -0700
Message-ID: <7vr4h7al9k.fsf@alter.siamese.dyndns.org>
References: <5193efe6.c42ab60a.0319.5f2c@mx.google.com>
	<7vzjvvanro.fsf@alter.siamese.dyndns.org>
	<CAMP44s1kWkNgFMAvThczCvTZppWGca0YvGv=CQ15GtViA1zy_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 01:14:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucku8-0003ig-1o
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 01:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab3EOXOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 19:14:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677Ab3EOXOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 19:14:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00FB01F1D2;
	Wed, 15 May 2013 23:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6LDJEbbOofZYwDMhHxHM90Dclr8=; b=F7Vmgn
	ki0dxJeHTEQUrWppZwQBTmZrpE8Mp3zXtYQJ9pALtj/PTaaM2/dxkmOH4nW1IA9m
	mcjEW6PmkRFU6eHrhuNd8lAt4E3L2Y/Tl3jTDPWZ68SVXmbLGbk0dpvwV+Ns4T62
	2RhXpl3Zbg+PDcDj73M9iFZsqAoRzx2ck/Vfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oT22JnDel8FPWlXqsYGgRjAei8g/y5cs
	/R+luh+Res6rswCHfFVehbCAMwTahftePlhOFS7COeyqNRTLIk7pDH99MF1sDN8F
	mqyO4YgoZcw19M8iqLdnMq9ZQ3AH4+vGmnC7gBLNCVtr3f2hHIZDnZb1RfPeH2LE
	8PMYRuQVUwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED2AA1F1D1;
	Wed, 15 May 2013 23:14:33 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EE501F1CD;
	Wed, 15 May 2013 23:14:33 +0000 (UTC)
In-Reply-To: <CAMP44s1kWkNgFMAvThczCvTZppWGca0YvGv=CQ15GtViA1zy_Q@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 15 May 2013 17:56:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 340E818A-BDB5-11E2-A216-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224455>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Exactly the same as 'git pull' does right now.

You set

	[branch 'foobar']
        	base = refs/heads/master

then 'git pull [--rebase]' will go to 'origin' due to the default,
but then what branch from the 'origin' are you integrating with?

Do you mean you are also setting both remote and upstream, perhaps
like this, for all of your branches?

	[remote "origin"]
		url = github.com:maintainer/hisproject
                fetch = +refs/heads/*:refs/remotes/origin/*

	[remote "github"]
        	url = github.com:felipec/myproject
                fetch = +refs/heads/*:refs/remotes/github/*

	[branch 'foobar']
        	base = refs/heads/master
		remote = github ;# or is it origin???
                upstream = refs/heads/foobar

Then your 'git pull' will fetch from remote 'origin' and integrate
with its 'foobar' and 'push' may go to update 'foobar' at 'github'.

Perhaps that is what you meant.

> 'base' has absolutely nothing to do with pulling or pushing.

I agree it shouldn't have anything to do with pushing, but given
that 'git pull [--rebase]' is a way to do a 'merge' or 'rebase' with
what you 'git fetch', introducing something that 'merge' or 'rebase'
pays attention to that does not have anything to do with 'pull'
sounds like it breaks existing end user expectation.

But that does not mean it is a bad idea. The behaviour changes only
when you have branch.$name.base, so I suspect that we do not need to
worry about "what if the user has both?" case you mentioned in your
first message.

I think I misunderstood what you meant.  If it is the norm to have
both base and upstream/remote in branch.$name (as opposed to "have
only branch.$name.base and not branch.$name.remote to force fetch to
go to the default 'origin'), then 'git pull' will not break and I
can see how many things would work naturally (admittedly I can only
say 'many things', not 'everything', at this point, as I haven't
thought things through).
