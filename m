From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t2017: redo physical reflog existance check
Date: Thu, 22 Jul 2010 10:35:35 -0700
Message-ID: <7vlj93h120.fsf@alter.siamese.dyndns.org>
References: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 19:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObzgU-0000IK-2b
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 19:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291Ab0GVRfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 13:35:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab0GVRfn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 13:35:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DA5C66B9;
	Thu, 22 Jul 2010 13:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U0f3WGWRoF4Esmb+nzgNTR62aIQ=; b=kDPl8d
	LD08zWkv8LPytOCHjletPK7Axsi+8yVXx6rG0E8rN6zlQTLS/qx8CQbChmDmP9Qv
	maiCje1DPLru1SeXR655CpjlcsYktCvIlwLbJyCfr5AwM1KReGuo160vZaRreVA/
	uQtO/jsg7+7wJqHZ/xm1mwtNuUtdM5O3nTwV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XNDmVs5BzVgMfKfGirQqC8EZaPIIXzph
	d/oPQJWeFxkVnR9dyOaw/su65HAOQzpHY3yXZ/zRgghMe0gC+Fvapymr1wOqaIYb
	13ZqFecSZmzxRizBg6A7U9IUimetcG906HxTLSJFJm38IUEihQIsK/AceBKnQtjg
	4tgXwufDW0s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D79C66B8;
	Thu, 22 Jul 2010 13:35:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D22DC66B7; Thu, 22 Jul
 2010 13:35:36 -0400 (EDT)
In-Reply-To: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com>
 (Erick Mattos's message of "Wed\, 21 Jul 2010 22\:46\:30 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8BBEA5AA-95B7-11DF-A054-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151464>

Erick Mattos <erick.mattos@gmail.com> writes:

> Although this is not a problem to all the other changes, it is laming to
> the tenth test.  The implementation of the correspondent problem creates
> a "touch" reflog that must be wiped out if not used by committing the
> new branch.

I thought about it a bit when I sent out my patch, but I do not think that
is necessary.

The things you care about, after running "-l --orphan eta", are:

 - If you make a commit, you get eta@{...} reflog that records it; and

 - If you leave the still-to-be-born eta branch without making a commit,
   you do not leave eta@{...} reflog behind.

Your zeta@{...} test is about the former, and your eta@{...} test is about
the latter.  I think they already check what they want to see happen.

I also am afraid that the "test -f" check would expose the implementation
detail more than necessary.  We may want to come up with a different
implementation of this behaviour later that may not create an empty file
there.
