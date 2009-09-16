From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Correctly initialize nonfastforward in do_push.
Date: Wed, 16 Sep 2009 10:13:57 -0700
Message-ID: <7vpr9q24oa.fsf@alter.siamese.dyndns.org>
References: <1253119020-26547-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 16 19:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mny59-0008Cx-Ln
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 19:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759704AbZIPROG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 13:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759628AbZIPROE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 13:14:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbZIPROD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 13:14:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B0BA3455C;
	Wed, 16 Sep 2009 13:14:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZEYCzotksyrC72otOp3iLXKdtas=; b=iO7bUc
	zOUWOyw1IoQf2ES5+YZeutwzYQxXz4N1LkT1hQmV6KITIPLFTSgg+NXb+3zFfaMi
	eciWJHmVWghxM8tdGp8zDIvEoLVGr7Q3I8p1elFYtXovIbmNyKJDYFMV46FwlYiE
	kNSj+XaJaSUb0xjNLzReyR/jfjB2JVjOI6zcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iu121pmC9lyWohAt6ovZttxWp8CTQl6R
	/FIBpbd6I7BgzYX7SliLUGBPey99VUuHo/1T+KZX++FeT5NaWPioViUkYporFpLN
	dBuo/F36NQeWJlyZSigC8yvLNNxchqJ6A2Kdxh99RhQkmyVUguAYbyroRUnz+FaT
	nATe6Y7IB1E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E6B23455B;
	Wed, 16 Sep 2009 13:14:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 980D73455A; Wed, 16 Sep
 2009 13:13:58 -0400 (EDT)
In-Reply-To: <1253119020-26547-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed\, 16 Sep 2009 18\:37\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53E69000-A2E4-11DE-A961-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128666>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The variable is assigned unconditionally in print_push_status, but
> print_push_status is not reached by all codepaths. In particular, this
> fixes a bug where "git push ... nonexisting-branch" was complaining about
> non-fast forward.

Hmm, the patch looks correct but I am scratching my head to see how this
is triggered.  "git push ... nonexisting-branch" seems to get:

	error: src refspec nonexisting-branch does not match any.
        error: failed to push some refs to '...'
