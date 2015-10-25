From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] blame: allow blame --reverse --first-parent when it makes sense
Date: Sun, 25 Oct 2015 09:52:53 -0700
Message-ID: <xmqqk2qalwka.fsf@gitster.mtv.corp.google.com>
References: <1445485872-21453-1-git-send-email-max@max630.net>
	<1445485872-21453-3-git-send-email-max@max630.net>
	<xmqqfv13ttq6.fsf@gitster.mtv.corp.google.com>
	<20151022145606.GD5722@wheezy.local>
	<xmqqvb9yra5g.fsf@gitster.mtv.corp.google.com>
	<20151025124338.GA27615@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Oct 25 17:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqOXc-0004fM-3B
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 17:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbJYQxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 12:53:03 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751717AbbJYQxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 12:53:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C54D24287;
	Sun, 25 Oct 2015 12:52:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=mP/yVHttesscAIaMfzaT33PpfhY=; b=iox8F6z4yH0C+zachQmc
	gc7xZG4wYt3fdhg2Fi3aWza5qzzdDP5j8B9hZhokJotA0pZNMPzv/M3V8Y/DiFN1
	D2tnTajYtzVeUdqyfsVnSPxUrpNHFjFQV39GCuXEyoPOIp66Px3RR/OB4MifFJXH
	VD3+4hHtuEyyHABP8wPQM4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nc4Dz9x8xiOEoCp+AceCteEYFOsh2I47x1kpYKJW909FQK
	UT6ZhIl74DOGRSJdHPbTBeuZWu3cBjd5z4UeD6fDKssFPAGgfmvIsFzFl96pgrkR
	YXnsvTYeDYVkQ8/yAPT0UE1Ctjwfl4aSVUwlj/bWHpp9aDdtmMallCkv7m/Z8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52F6B24284;
	Sun, 25 Oct 2015 12:52:55 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C696724283;
	Sun, 25 Oct 2015 12:52:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D64ABEB2-7B38-11E5-A83F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280159>

Max Kirillov <max@max630.net> writes:

> This additionally forbids having several end commits
> (git blame --reverse --first-parent ^A B C ...), but
> this does not seem to have much practical use.

Even if there were practical uses for a request with multiple end
points, a solution that

 (1) guarantees that "blame --reverse --first-parent" is the only
     thing that is affected; and

 (2) errors out if "blame --reverse --first-parent" cannot give a
     sensible answer.

is a strict improvement over "we don't know how to produce a
sensible answer in all cases, so we just forbid".  Somebody who
needs multiple end points badly can build on top with the same
principle, just widening the definition of what is "a sensible
answer" in the criteria (2) above.  Until then, defining the
sensible answer to be "an answer that consists of commits on the
first parent chain (but in reverse)" is perfectly fine [*1*].

As you added your patch after "-- <EOL>", my MUA refuses to quote it
in this response, but that's OK, as this message is not about the
patch itself ;-)


[Footnote]

*1* I haven't read the patch text to see if that is what the updated
    code is computing, though.  That's for a weekday ;-).
