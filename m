From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 00:40:27 -0700
Message-ID: <7vochlkvtg.fsf@alter.siamese.dyndns.org>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 09:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Jgm-0008Qi-5p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 09:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab0DOHkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 03:40:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab0DOHke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 03:40:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1711AAB8DB;
	Thu, 15 Apr 2010 03:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1WgykNJYUcJK+iA3afOfcLEAmhs=; b=Z7urzc
	8w9cMEddx3Au+5jFxuMiwApBz/7h5own7RjaDTr4Y19SIEq/2xZKIUoTlLgbMSaf
	NiMbhdbXP0sB2D/6sv5XzUkrWnYlx6kbg3+2tz1vQStAsdKkMTYeEck3KMo2xCFV
	VRY5DXdBMIdOrsuhG92v2YunvJz5dh1bHoS0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBMvsdYIxVkvcFIgBGoZD0iEKdKfDydi
	vi45sazUMtuWrCgFSNV0Asq6Yl3xPl/B6cAoJ+/DHEQRh1OMcF6G6KuZX6R6gHqC
	8Usf97Iworq7+k9gD5p5W+4jh0BOd7vzDtNHqOgdtX92rJAEeN5znpM9m81vAlDw
	AgDni5d+DQo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4523AB8DA;
	Thu, 15 Apr 2010 03:40:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5979BAB8D9; Thu, 15 Apr
 2010 03:40:28 -0400 (EDT)
In-Reply-To: <4BC6B5FF.6030406@viscovery.net> (Johannes Sixt's message of
 "Thu\, 15 Apr 2010 08\:45\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2AF47A76-4862-11DF-AB5A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144960>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Does not help what? What is the problem?

You will lose the record from HEAD reflog that records the fact that you
were at the tip of "next" less than "reflogexpire" but more than
"reflogexpireunreachable" time ago, if you run "gc" while on "master".

Such a pruning does not have much to do with the real reason why
expireunreachable would be a useful thing (namely, to prune failed
histories that have been rewound away faster than the history that
survived from reflog of individual branches).
