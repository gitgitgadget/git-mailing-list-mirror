From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:24:37 -0700
Message-ID: <xmqqa9kd8uga.fsf@gitster.dls.corp.google.com>
References: <1376900499-662-1-git-send-email-prohaska@zib.de>
	<1376926879-30846-1-git-send-email-prohaska@zib.de>
	<CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
	<61B1EB04-497F-4398-8C52-CCE3A1A81B10@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 19 19:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBTCA-0005Xu-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 19:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165Ab3HSRYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 13:24:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab3HSRYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 13:24:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33B6E392F6;
	Mon, 19 Aug 2013 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nhBfJs3Xbsn7RXr8dMG7fYY0fyE=; b=unIq4s
	0QYrxpjRgtKeJvQP+ox9XWJWnLeSt2nO7ogjMsEts8mzgbISjnhtx91jjWpL8FTs
	mcvBedxqds7veUnKdeQUz1RfGmmX/E3RNkNak5/stOgJKJ4szkTBrJiqc/RSwl5+
	R0myChctZNakxcr/ueLlnnz3MbtIsP6AJ2GAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u4XkNEbZAkdDvV+ezUbxS31MuHRsaRQ+
	sf6DYQkOXuetw+ZPypssPgogTdsVfJRLk7vlXFal3XxX/O+QkQpCgiqdTY0aPel4
	pPcp+7G6DT/fUyCOPjcuaca863Q92Hf4UnB9c/cAEuV+8Gwpcx5/QCdT3xhtX4Ra
	4HG/F3wuSLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B07392F5;
	Mon, 19 Aug 2013 17:24:41 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72A90392F4;
	Mon, 19 Aug 2013 17:24:40 +0000 (UTC)
In-Reply-To: <61B1EB04-497F-4398-8C52-CCE3A1A81B10@zib.de> (Steffen Prohaska's
	message of "Mon, 19 Aug 2013 18:37:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3AF836F0-08F4-11E3-92F7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232555>

Steffen Prohaska <prohaska@zib.de> writes:

> I'm happy to rework it again towards your suggestion.  I would also remove
> the compat wrapper for write().  But I got a bit tired.  I'd appreciate if
> I received more indication whether a version without compat wrappers would
> be accepted.

I think it is a reasonable way forward to remove the writer side
wrapper and doing large IO in reasonably big (but small enough not to
trigger MacOS X limitations) chunks in both read/write direction.

Linus, thanks for a dose of sanity.
