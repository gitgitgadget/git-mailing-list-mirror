From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 12:19:08 -0700
Message-ID: <7vppwtid3n.fsf@alter.siamese.dyndns.org>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
	<CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
	<CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:19:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKkm-0006Qf-8y
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680Ab3ENTTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:19:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032Ab3ENTTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3E51E15E;
	Tue, 14 May 2013 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+RmyWuypQt67i8i78n5Gv0FPrAk=; b=gGwB49
	QBl83+D0R+zPgiS0dTXxYqkPiPdc5ajIN6XXfzSaZsAZMqAvrVdi0mcGtccEYXFj
	VMsVNc/vbIJnSoDUq+enccilUvO2mkeqVnAeTlnIdRrRWuaw+9HximWn1+DQYftn
	LQv7qwG6a8yVwENah1byPCjd8bgXWyN4YvPqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jnt8NQ1K1JmyyYOcNvS1znLIeRqiHOY0
	U3zqlFIKtFTtu/rj1jfN4MCdSR0HWudzjPpPNc28PzdOof91s8Sm2wZXfHTvblOf
	6Xg3c4qQh+sR8NLT6v/T9H6bn99APCcn7Q09LmT5ScoQ44IoAuBE2c7DuupwZ4vE
	JGnd1QD0TZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAFCD1E15D;
	Tue, 14 May 2013 19:19:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BC6B1E15C;
	Tue, 14 May 2013 19:19:10 +0000 (UTC)
In-Reply-To: <CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 15 May 2013 00:14:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27840DE4-BCCB-11E2-93B1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224319>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> +The S kind detects filepairs whose "result" side and "origin" side
>>> +have different number of occurrences of specified string.  While
>>> +rename detection works as usual, 'git log -S' cannot omit commits
>>
>> The "cannot omit" feels like a confusing double-negative.  How about
>> "includes" instead?
>
> Intended.  Omission is expected.

I think what makes this paragraph unnecessarily hard to read is the
"While rename works".

With that, you are implying "if you rename a file as a whole without
changing the block of text you identify with the -S parameter, then
such a change is not interesting as far as pickaxe is concerned".
while that statement is logically correct, normal people are not
that generous to read that much between your lines.

I think that is one of the reasons why "If you moved a string from
file A to file B, log -S will flag that change as worth inspecting"
does not seem to logically follow and made Phil find your
description confusing.

Finding such a change indeed is a feature [*1*]; we need to flag
such a change as worth inspecting to find where the code came from
in order to dig deeper, so at least this "cannot omit" should be
"does not omit".


[Footnote]

*1* I suspect that your confusion may stem from not understanding
    what pickaxe was invented for. It is _not_ about finding the
    final answer, but is about stopping at a commit that is worth
    investigating further.  

    It may help to read
    http://article.gmane.org/gmane.comp.version-control.git/217 and
    then its follow-up http://gitster.livejournal.com/35628.html
