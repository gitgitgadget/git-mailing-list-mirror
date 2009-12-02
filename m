From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Document date formats accepted by parse_date()
Date: Wed, 02 Dec 2009 14:54:40 -0800
Message-ID: <7v638p9ebz.fsf@alter.siamese.dyndns.org>
References: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org> <831fc8f48429d5a21e29d04760b46b2ddfcb7d80.1259791789.git.vmiklos@frugalware.org> <20091203073313.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFy68-0002C7-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbZLBWyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbZLBWyt
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:54:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbZLBWys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:54:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB1ADA39FA;
	Wed,  2 Dec 2009 17:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oEmWuXokgZC1r0muysL4suVj+UY=; b=ekfsVw
	xDPjyDQNFuVJOkC6ApnSzv57YW/4lJRpHrUTaGKRbi5mtJ0hl7wETjgz+em8+PAS
	3OKZE9g8s5AXPEg5RUcakAiPtXzW1mArXdzqiXasjaa1FW3Lkqco08UzzYDqrK3R
	vjwbfqyf0KsI3ToBOxEE7EvYohPgIS2Ga9g/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2PA6lo00QzRQ75Y+Krnl/7fMMRTP4Vt
	UzNcNBM9Y2tQdgkISo9pE0++3Kod/A/anY/e7dAbHUxv75k1JDQDFGgyxVi0CE3j
	u0BCQzu23Inv0nu+pVHhk00t+cyendWcBpcrJanD28o3YgFVJrMrxwVtdDCHZz9z
	yeYddi9HaI0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CBB7A39F9;
	Wed,  2 Dec 2009 17:54:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 73AB3A39F8; Wed,  2 Dec 2009
 17:54:42 -0500 (EST)
In-Reply-To: <20091203073313.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu\, 03 Dec 2009 07\:33\:13 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1CF0A1A-DF95-11DE-864B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134415>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Is there something wrong with 'show'?
>
>   nana.git% ./test-date show '2005-04-07T22:13:13'
>   2005-04-07T22:13:13 -> 40 years ago

Heh, you fooled me, and Peff is right.  "test-date show" does not
interpret its input any way other than as seconds-since-epoch.

I agree with the "native->internal" part of the suggestion.  What see by
default in "git show" output is merely the ctime(3) format followed by
timezone.  I don't mind if we call that "git native", even though I
suspect we do _not have to_ invent new word for that.

Also "test-date parse" seems to accept things like these:

    '2009.04.07 20:21:22 -0000'
    '04/07/2009 20:21:22 -0000'
    '07.04.2009 20:21:22 -0000'
