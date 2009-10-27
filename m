From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My custom cccmd
Date: Tue, 27 Oct 2009 14:53:02 -0700
Message-ID: <7vzl7c4i81.fsf@alter.siamese.dyndns.org>
References: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
 <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
 <94a0d4530910151437s780bd96anca82d2b26ef99e0a@mail.gmail.com>
 <94a0d4530910250804w3a7da36eke10710eb1cbb03c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:53:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2tyn-0005CY-B6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 22:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbZJ0VxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 17:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbZJ0VxI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 17:53:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726AbZJ0VxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 17:53:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93CB769E1A;
	Tue, 27 Oct 2009 17:53:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=n4/eUDJ1QYQvQ6bj5rzEZXHMPKg=; b=hQThM+Dkt7r0gTWc0J/EUAx
	0m5kAMRq/3Rd74uRHuD8hogDBvzOQvmYBqT44H4kdtRSeXXCKH4Q8hfLBdLWlHpk
	7r2csDyGR3HrWfgNwaIJJIJlT5PJmCtm8/PFuIobtwR3TFYCfwUlo9y37IDQBnhm
	WNv5CMovuECe54d8TO9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=K2UDpBBanC6BF6HEP18TnCGUDa3TXmDoxDhh+7DNrHGaPATIG
	I00hfipx6Y8UPq3D6Sf3ut/3Jju4nZpgdgN8V+wda3mUSNW/Ro1QLlL16u/Yu7ZR
	TKLbJ13pPdG8lyEO1n/AGBAabyAA4cEL7Kd/B/eomX67Y1SqOMdeZteA0g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73F9E69E19;
	Tue, 27 Oct 2009 17:53:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98F0169E18; Tue, 27 Oct
 2009 17:53:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CFE3DFC-C343-11DE-B65C-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131382>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I explored this a bit more and I've come to the conclusion that we
> actually don't wand to discard the previous commits in the patch
> series. Let's think about this example:
> 0001 <- John
> 0002 <- Me overriding some changes from John
>
> In this case we want John to appear in the CC list of 0002, because we
> are changing his code.

There are two cases: your patch partially overrides his code, and your
patch completely rewrites/removes his code.

Obviously in the former case you do want to Cc, but there are parts of his
change that remain in the final result, so this case does not matter in
this discussion.  You will Cc him because of these remaining lines anyway.

In the latter case, the only contribution that remains from him is a
commit with his log message that does not help describing anything in the
end result, cluttering the history.

In such a case, I would imagine that the reviewers would want to see a
cleaned up series that does not have his patch that is irrelevant for
understanding the final result.  John might want to know about it, if only
to raise objection to the way how you arranged your series.  For that
reason, I think it makes sense to Cc him.

But it is a rather a convoluted logic, if you ask me.  You find John and
Cc him, primarily so that he can point out that you should be redoing the
series not to have his patch as an intermediate state in the series to
begin with, because his commit does not contribute to the end result.

It might make more sense if your tool told you about such a case directly,
rather than helping you find John so that he can tell you ;-).
