From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] merge: honor prepare-commit-msg hook
Date: Wed, 21 Jul 2010 17:14:44 -0700
Message-ID: <7vsk3cgyob.fsf@alter.siamese.dyndns.org>
References: <1279600144-89629-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 02:15:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObjRK-0005Q9-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 02:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab0GVAOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 20:14:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0GVAOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 20:14:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11806773;
	Wed, 21 Jul 2010 20:14:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zV32AXjcWjk8eQctwBiV8WiByDI=; b=kTYpla
	9h5J9WKVgPsFiPcwVG6qCS+5t2YVDqJ+dV567eMF4/JHCzRzGdayLwAyEGVmnYrf
	JGGnQMoW6+9rbHb+ytEStRHrBNBsLQOsldEkQAH1TLMKgeeb8GNRwD+L9yYIFO7a
	OQ7ZF8OHqTkht+2KNMxyOoaolLFd7JFY/l6cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=maDu158M2nR+RNjCj+cqxBQjdYgsiSQ9
	CIJpN9HcpYU+NmzzfNZbk9D6ym+dQpowChieadHaOan5QNq0ENe2ha308OmQgkhN
	0ZS9nDPJQ8Rp12Ue4ULlfP9AJtGvj5A7ScJe/lQrofPSEzxswTul1e94oBlydC0w
	6/YlTJgL0R8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4AC2761;
	Wed, 21 Jul 2010 20:14:48 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BBAC758; Wed, 21 Jul
 2010 20:14:45 -0400 (EDT)
In-Reply-To: <1279600144-89629-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue\, 20 Jul 2010 00\:29\:04 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 23E2ED74-9526-11DF-8DE5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151435>

Jay Soffian <jaysoffian@gmail.com> writes:

> ---
> I couldn't figure out why my prepare-commit-msg wasn't being honored
> by git merge.

It has been that way from day one, it appears.

The bypassing of pre-commit hook was and remains to be a conscious design
decision.  When you are pulling from your contributors who may have
objectionable contents that you have to merge, the damage is already
done; you _could_ yell at them to fix their branch and re-pull in theory,
but that wouldn't work very well in practice.

On the other hand, I think letting people use prepare-commit-msg for
merges might  make sense.  Indeed, "git commit" is prepared to call
prepare-commit-msg telling the hook that it is concluding a merge, when
your "git merge" stopped due to a conflict (or you stopped it from making
a new commit with --no-commit).

I don't know about the other hooks "git commit" normally calls.  Both
"commit-msg" and "post-commit" may make sense, but I don't care too deeply
either way---I don't care too deeply for pre-commit either ;-).
