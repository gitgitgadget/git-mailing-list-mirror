From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Thu, 23 Jul 2009 12:58:06 -0700
Message-ID: <7veis7yxwx.fsf@alter.siamese.dyndns.org>
References: <20090723074104.GI4750@laphroaig.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU4Qr-0000sX-DP
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 21:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbZGWT6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbZGWT6S
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 15:58:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbZGWT6R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 15:58:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 021FDF301;
	Thu, 23 Jul 2009 15:58:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2BB9F2FE; Thu, 23 Jul 2009
 15:58:08 -0400 (EDT)
In-Reply-To: <20090723074104.GI4750@laphroaig.corp> (Pierre Habouzit's
 message of "Thu\, 23 Jul 2009 09\:41\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 291C7C5A-77C3-11DE-B41F-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123894>

Pierre Habouzit <madcoder@debian.org> writes:

> One of my most frequent use case for git-add -p is when I had an intense
> debug session with quite a lot of debug() traces added. I then want only
> to select the hunks corresponding to the bugfixes and throw away the debug
> ones.

I do not particularly like this change.  "add -i", "add -p" and "add" in
general are about manipulating the index.  They are never meant to touch
the work tree contents.  Which means that even if you make a mistake in
saying y/n, you won't damange the state you have in your work tree, and
also means that you can recover safely by simply restarting "add -p"
session if you really botched splitting of the patch.

I fear tempting a new user who sees "undo" to say "yeah, I added the
change in this hunk to the index by mistake, please undo", which would
lose the work.  The confusion is easier to avoid if "add" only manipulates
the index without harming the work tree, and the user used a different
command, namely "checkout from the index", to get rid of the remaining
debug cruft, once s/he added all the necessary bits to the index perhaps
after a multi-stage commit session.
