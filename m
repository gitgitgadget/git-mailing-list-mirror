From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin-merge: avoid run_command_v_opt() for
 recursive
Date: Mon, 11 Aug 2008 11:47:07 -0700
Message-ID: <7vhc9rxuc4.fsf@gitster.siamese.dyndns.org>
References: <cover.1218374062.git.vmiklos@frugalware.org>
 <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org> <ea5b9868df7c17c55cd091b4408f08a310bed641.1218374062.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScRf-0004nA-UC
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 20:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbYHKSrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528AbYHKSrR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 14:47:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbYHKSrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 14:47:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FCA555B59;
	Mon, 11 Aug 2008 14:47:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 19DA355B58; Mon, 11 Aug 2008 14:47:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E9FF8272-67D5-11DD-8771-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91972>

Miklos Vajna <vmiklos@frugalware.org> writes:

> The try_merge_strategy() function always ran the strategy in a separate
> process, though this is not always necessary. The recursive strategy can
> be called without a fork(). This patch adds a check, and calls recursive
> in the same process without wasting resources.

Yes, it saves a fork, but is this really worth it in the bigger picture?

Doesn't the current code structure have benefit of allowing git-merge
itself do necessary clean-up action when merge-recursive calls any of the
die() it has in many places?
