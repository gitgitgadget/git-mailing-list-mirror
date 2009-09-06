From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/6] status: refactor short-mode printing to its own
 function
Date: Sun, 06 Sep 2009 01:05:07 -0700
Message-ID: <7v63bwcxcc.fsf@alter.siamese.dyndns.org>
References: <20090905084809.GA13073@coredump.intra.peff.net>
 <20090905085348.GC13157@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 10:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkCkd-000397-K8
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 10:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbZIFIFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 04:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbZIFIFW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 04:05:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbZIFIFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 04:05:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C36280BF;
	Sun,  6 Sep 2009 04:05:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TN2bFu6zD7K4iz0852Vq+0s70is=; b=bx+dTOEl62gSnvu6o3d9v/8
	aCkaqSWccRrWk9njDj6TzV97A0N9rTgUeGkJIXMi9pems0MoaYUmAD253WSXuWcL
	Rd1S0D5Mycw7FJk7Syk+rW1SjX6yqcugkXzGGbS6THKWI8MknhenYBDXn8RbChwi
	WMmSt/uMnYXvYkC7QZX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MGcM8xeq/un638moOtyWIr/jfJ8ktnTHdJkgO6mOh3e+45KLR
	N7bnifpQkloVnPOjqvfJ92YvFxZzfdKFGtf1zNdXmwKDAkkzKHYA5Mbxsh+//SFR
	qFv+Ad/UfHtufv4Ub3rZWTGP1FIDnIfxaVrlvm5fKb8EHQkY/Rl1ION1Ms=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DEB85280BE;
	Sun,  6 Sep 2009 04:05:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D570280BC; Sun,  6 Sep
 2009 04:05:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02C48EE6-9ABC-11DE-AA20-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127847>

Jeff King <peff@peff.net> writes:

> I am tempted to move all of the short-printing code to its own file, and
> move "cmd_status" to its own builtin-status.c, as well. I don't know if
> that is a cleanup that makes sense to others, as well, or if it is too
> much churn for too little good.

Earlier in the series when "git commit --dry-run" and "git status" still
were the same thing, I checked if the above was feasible and then decided
against it, because they needed to share the option parsing and the index
preparation, and exporting these functions inherently internal to "git
commit" only to use them in "git status" did not make much sense.

But once "git status" does not have anything to do with "git commit", I
think such a separation would become much more sensible.
