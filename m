From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Fri, 14 Feb 2014 16:16:26 -0800
Message-ID: <xmqqppmpfcx1.fsf@gitster.dls.corp.google.com>
References: <xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
	<xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
	<20140214.224133.484636406629780362.chriscool@tuxfamily.org>
	<xmqqtxc1fdsk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 01:16:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WESvs-0007uF-HY
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 01:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbaBOAQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 19:16:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaBOAQc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 19:16:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A20B86C6E3;
	Fri, 14 Feb 2014 19:16:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3dvYxoqvZDxMtmSfvpkyTTVGG2w=; b=ilV7Cp
	CoFkpK8RyJO77i9PnTnT8eLh3JvZcF9oQUwYLbcgx/C4CCHz9rrktkmjr9L8sQyJ
	WXvev07WWHBkM+TljOg9ZB2imuIgbDuOEJFKXvtMIgCuW2y7ZlUWovbpZHZkPI8m
	c64yxK7drorJDil3DGkhH24H1Gt15PBB2zj6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d24WVpEiTyjqb2U6OhFpymQpdthp0gJd
	f7U3WvV+iCtl/ZovdJc0XER10wIqX5Rym32tssX20K68UxsMPhM5bQv3xXRNrZgu
	V+ZQX09lbBfTsuS34ybumMIxjuFX2yM74elmxUHp67eGnIlqxPuEZI3oK2h0DSzr
	XEh+WJ90L3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 763556C6E2;
	Fri, 14 Feb 2014 19:16:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97EB56C6E1;
	Fri, 14 Feb 2014 19:16:29 -0500 (EST)
In-Reply-To: <xmqqtxc1fdsk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 14 Feb 2014 15:57:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6AB55BC4-95D6-11E3-B9B5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242165>

Junio C Hamano <gitster@pobox.com> writes:

> That is, you are saying with the above
>
>      if_exists = add_if_different AND ignore_if_same
>
> So you already have to support more than one actions depending on
> the condition, ...
> of conditions, I think.  Which is essentially the same as saying
> that you need this:
>
>>     action = do_Y_if_X_and_Z AND do_U_if_V
>
> Again, unless all the U's are limited to "ignore", that is.

Oh by the way, don't get me wrong.  I am not saying that the last
one is necessarily better or worse.  I am only saying that the
semantics proposed seems to be hard to explain and we need to do
find a way to do better.

If you have these existing ones:

	Sob: A
        Sob: B
        Sob: C
        Sob: D

and you have "Sob: B" at hand, "Sob.if-missing" would not fire
(because if-exists/if-missing is only about keys) ans
"Sob.if-exists" will.  What happens is now up to the action part
(i.e. what follows "if_exists =", e.g. "add_if_different").

The conditional part of "add_if_different" action is explainable as
a conditon on the value (as opposed to condition on keys, which is
the left-hand-side).  But what does a condition with "neighbour" in
its name really mean?  It is not a condition about the value, but
also is a condition about the order of the existing records.

What is the right mental model the end-user needs to form when
understanding these?  Conditions on keys go on the left, and any
other random conditions can come as a modifier after action
e.g. add_if_same_value_is_not_at_the_end?
