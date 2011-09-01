From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funnies with "git fetch"
Date: Thu, 01 Sep 2011 15:42:46 -0700
Message-ID: <7vpqjjnau1.fsf@alter.siamese.dyndns.org>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 00:43:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzFyL-0000OP-VK
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 00:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab1IAWmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 18:42:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554Ab1IAWmt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 18:42:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB2F05228;
	Thu,  1 Sep 2011 18:42:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=No/kj5Styc4pwbBQQUVZzAVQt6Y=; b=BCf2ww
	/MtsYH7EHQ6CIn2opFFeEZ/+aa6uEaJKcEnGDyt98JGC0EmVvxrSgMu9THNg01Kg
	P/w3F3u5Bl8fYygL07wbiRvJQJJ/aS/zQjFXPSYZ4RejNI5dTgFoK75LY5PvuyDr
	g/g+LhepeylReDnaBKmxVyfGs004Jf2H7n/8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbApLw2xu03SfpARpSXM+5i6Lhl6vq1X
	8xfEmPRBr6uoOPM/OWBBLXA5pmgS9A6oNWA1OVd0+JqYKcgXjdWflH1oYw2XOoK4
	iyWbYkRxcKUARwD1dMdc+N0uL3LRT8yiSGHf5xmVsfiwbnwjdGlyLMQ/PH8KApY1
	l4NgFDBtnQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2D5A5227;
	Thu,  1 Sep 2011 18:42:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49FA95226; Thu,  1 Sep 2011
 18:42:48 -0400 (EDT)
In-Reply-To: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 01 Sep 2011 10:53:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B78F2EA6-D4EB-11E0-A126-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180577>

Junio C Hamano <gitster@pobox.com> writes:

> I think the breakages are:
>
>  - The sending side does not give any indication that it _wanted_ to send
>    ce0136 but couldn't, and ended up sending another object;
>
>  - The pack data sent over the wire was self consistent (no breakage here)
>    and sent three well-formed objects, but it was inconsistent with
>    respect to what history was being transferred (breakage is here);
>
>  - The receiving end did not notice the inconsistency.
>
> The first one is of the lower priority, as the client side should be able
> to notice an upstream with corruption in any case. Perhaps after asking
> for objects between "have" and "want", "git fetch" should verify that it
> can fully walk the subhistory that was supposed to be transferred down to
> the blob level?

So I have a series to fix the latter "more important" half I'll be sending
out in this thread.
