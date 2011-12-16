From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git help prune accuracy?
Date: Thu, 15 Dec 2011 16:04:02 -0800
Message-ID: <7vliqdl6vh.fsf@alter.siamese.dyndns.org>
References: <201112151432.09252.mfick@codeaurora.org>
 <201112151453.52157.mfick@codeaurora.org>
 <7v1us5mqc4.fsf@alter.siamese.dyndns.org>
 <201112151601.52968.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 01:04:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbLHf-0004gk-R2
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 01:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759846Ab1LPAEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 19:04:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247Ab1LPAEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 19:04:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2664C675A;
	Thu, 15 Dec 2011 19:04:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fJdF+TAV58ZKQ8EEDy+fGD1hBx0=; b=ySOCwy
	THvdn9iO9RkfPb4qff9bk7unRN1hJz4raV2+W3vZv5Gr35/V4w9jhCdbZ+kPsbNq
	o/PAqZsFd/C9TuD79ASlcKIX8qIJYpdQfKrbH1+ToGaJTynE7pOZbkl6yK/1xkwz
	yAVrNRJ3PbSUCYNgPQNYBVdQKxJSxRWo4qSv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oUIpoeRM/zAKMBZ9kpOpSfomlZJ0THmB
	HLSSXJwiTH/IPzYTuo1idSVDm6fgJAfsSBOWTXyGo+UspB2w4wYZEUm2biuUR6ti
	IiWjWiAKWKdwNVrpMBpbIniS7zpcXdht0Md8jCewXPrBT6Ghpa/H+KWbTYc/6HkO
	+5ci3gOiG4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19D2D6759;
	Thu, 15 Dec 2011 19:04:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3397D6758; Thu, 15 Dec 2011
 19:04:04 -0500 (EST)
In-Reply-To: <201112151601.52968.mfick@codeaurora.org> (Martin Fick's message
 of "Thu, 15 Dec 2011 16:01:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77337A98-2779-11E1-BEB6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187257>

Martin Fick <mfick@codeaurora.org> writes:

> ...  The summary line reads:
>
>   git-prune - Prune all unreachable objects from the object 
> database

Yea, prune itself has always been primarily about getting rid of
unreachable objects. I suspect (I didn't check) that we did not even have
a call to prune-packed in its original implementation and it was later
added as "we are doing the pruning anyway, why not do this as well while
at it".

Yeah, I just checked.  Before 51890a6 (Call prune-packed from "git prune"
as well., 2005-08-19), we didn't.  And 2396ec8 (Add "git-prune-packed"
that removes objects that exist in a pack., 2005-07-03) explains it rather
nicely:

    Add "git-prune-packed" that removes objects that exist in a pack.
    
    This, together with "git repack" can be used to clean up unpacked
    git archives.

> I don't quite have an alternative suggestion for a better 
> summary, the best I could do (but don't like) is:
>
>   git-prune - Prune loose objects (unreachable or packed)

For a one-liner description, "Remove unnecessary or redundant loose
objects" without parentheses may be better. Explaining "git prune" as
"this prunes" does not add as much information as restating it using a
different and more common verb.

The body text can clarify what we mean by "unnecessary" and "redundant".
A loose object that is old may be unreachable from any of the refs,
i.e. unused, and hence unnecessary. Or the same object as a loose one may
be found in a pack, which would make the loose one redundant.
