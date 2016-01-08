From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] object name: introduce '^{/!-<negativepattern>}' notation
Date: Fri, 08 Jan 2016 10:21:48 -0800
Message-ID: <xmqq37u82apv.fsf@gitster.mtv.corp.google.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
	<1433550295-15098-3-git-send-email-wmpalmer@gmail.com>
	<xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
	<loom.20160108T065547-969@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 19:22:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHbgg-0005iw-4D
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 19:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440AbcAHSWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 13:22:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756323AbcAHSVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 13:21:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4012C39539;
	Fri,  8 Jan 2016 13:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YmmrGumztINxN0YAw6x0JWzuLQs=; b=eqTNBp
	kf2rpL4fwKj9z1ALfZhsyzQYgabxDjbTlnujGT6XlQ97jgAO42WLYQSSON16EZwg
	owFFz5I5J8+Xjd4i4RpQsPg7ZEwO9WDA2lTxgojgGB1g08nrd+RJ4R9GvlVW4c3R
	icO/QLOKfgD5mgr9j3R3uCJmcSwF2CBvHUKxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IeCuLrs6X7r66vuEawbwIBsSP4dsw9jS
	TUJduDR3Ar9uvrT3+Zv1Vj/ydmkGeSnqeb0pcTrMGO9rPAZW7kClRBJQM/HVOOj/
	z/VpOo2cYQ2/TbqyHqCxRie7vHLt17kKymkbelny5mJgrnQXBg8mcXjwKkuRM/S2
	LOGIx69/Exw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3757A39537;
	Fri,  8 Jan 2016 13:21:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D6333952A;
	Fri,  8 Jan 2016 13:21:49 -0500 (EST)
In-Reply-To: <loom.20160108T065547-969@post.gmane.org> (Stephen Smith's
	message of "Fri, 8 Jan 2016 06:04:34 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AF143B20-B634-11E5-8697-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283573>

Stephen Smith <ischis2@cox.net> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>> >  	echo modified >>a-blob &&
>> >  	git add -u &&
>> >  	git commit -m Modified &&
>> > +	git branch modref &&
>> 
>> This probably belongs to the previous step, no?
>> 
> What did you mean by this comment?  I looked at the original patch and at 
> Will's response to your comment and am not quite sure what was meant.

Notice that the title is [2/2], so there is [1/2], which turns out
to be http://article.gmane.org/gmane.comp.version-control.git/270898

That patch updates the preparatory steps of the test script so that
[2/2] have more commits and refs to work with to perform more tests.

Marking the result of that "Modified" commit so that it can be
referenced later with a short name 'modref' is something that should
have done in [1/2], which added that new invocation of "git commit"
to record that "Modified" commit, not in [2/2] as an afterthought
"Oh I created Modified commit in 1/2 so that I can use it in the
test in 2/2, but I forgot to give it a name, so I am adding a new
invocation of 'git branch' in this step".

>
>> > +test_expect_success 'ref^{/!-}' '
>> > +	test_must_fail git rev-parse master^{/!-}
>> > +'
>> 
> I plan on leaving this in.
>
>> > +test_expect_success 'ref^{/!-.}' '
>> > +	test_must_fail git rev-parse master^{/!-.}
>> > +'
>> 
> I plan on leaving this in.
