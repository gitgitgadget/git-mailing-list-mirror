From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: remove Message-Id/timestamp before comparing
 patches
Date: Mon, 19 Sep 2011 10:08:11 -0700
Message-ID: <7v4o08bguc.fsf@alter.siamese.dyndns.org>
References: <6b2cb6ebec907342a02d56a36ddc58715efabc00.1316414731.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pang Yan Han <pangyanhan@gmail.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 19 19:08:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5hKQ-0001HI-4y
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 19:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab1ISRIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 13:08:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246Ab1ISRIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 13:08:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67B3754AA;
	Mon, 19 Sep 2011 13:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BIdXKiSIl61fdXiklZcaZ77WnSc=; b=qHk7jw
	BbJC1Vz/R6JUFCFzCGaNQq0RSwAhdPVvNecD1HHPhdhtfRaNNR+VTzSm2iB03KDS
	JbVjPdaZMQNmvD9gLzjeQOI+LPiJe7Cqv7pX/yDuxGOsA4w9lGxZysH8oQlddzIn
	tLHKr0P0Dv2fC241nLJZ6b0JHeeE9a8nVNml8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yt8gpfHnLczvHS1C8IWkhz7j6MnMV95l
	BX3t7IAzwrsv7PULYCjdSLqGVPRuZnCOnoFBAUQ6U0YdZdRBO0WDM+QifBuiq+MG
	3aKicoPNmPwmk8i3tJOSAqqBCODCRcQFsvf7VCDmGVNhaJmFuHf0tf3CCqzdrBq6
	FKDR3pEy4bk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3C954A8;
	Mon, 19 Sep 2011 13:08:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECB3054A7; Mon, 19 Sep 2011
 13:08:12 -0400 (EDT)
In-Reply-To: <6b2cb6ebec907342a02d56a36ddc58715efabc00.1316414731.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 19 Sep 2011 08:45:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F52A0B60-E2E1-11E0-A89F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181684>

Thomas Rast <trast@student.ethz.ch> writes:

> +strip_msgid () {
> +	sed 's#\(Message-Id: *\)<[^>]*>#\1<MESSAGE@ID>#' "$1" >"$1+" &&
> +	mv "$1+" "$1"
> +}
> +

As this is munging the contents of the line, if future versions of
format-patch start coloring the message ID values for some mistake, the
test using strip_msgid won't catch them anyway, so I'll amend the
stripping to actually strip the message id, like this:

	sed '/^Message-Id: /d' <"$1" >"$1+"

before applying.

Thanks.
