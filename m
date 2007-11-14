From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bisect visualize: use "for-each-ref" to list all good refs.
Date: Wed, 14 Nov 2007 00:11:47 -0800
Message-ID: <7voddxkzzw.fsf@gitster.siamese.dyndns.org>
References: <20071114055036.2c5ae793.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 09:12:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsDMA-0005mW-Fw
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 09:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbXKNIL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 03:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXKNIL6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 03:11:58 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43901 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbXKNIL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 03:11:57 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E885B2F0;
	Wed, 14 Nov 2007 03:12:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 862C994257;
	Wed, 14 Nov 2007 03:12:16 -0500 (EST)
In-Reply-To: <20071114055036.2c5ae793.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 14 Nov 2007 05:50:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64959>

Christian Couder <chriscool@tuxfamily.org> writes:

> In bisect_visualize, "cd $GIT_DIR/refs && echo bisect/good-*" was
> still used instead of "git for-each-ref". This patch fix it.

Heh, it still uses

	echo "$rev" >"$GIT_DIR/refs/bisect/$tag"

So we are still _very_ much tied to refs on the filesystem not
in packed-refs.

Even worse is that bisect_clean_state uses

	rm -fr "$GIT_DIR/refs/bisect"

so if you ever pack your refs in the middle of bisection and
then clean the state, you will still carry the old good set of
commits that are somewhat hard to cull.
