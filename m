From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an
 ancestor of the bad rev
Date: Mon, 30 Jun 2008 15:44:55 -0700
Message-ID: <7v3amuv8yg.fsf@gitster.siamese.dyndns.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDS8K-0005oP-8e
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbYF3WpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbYF3WpH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:45:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177AbYF3WpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:45:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4AA4D18C7E;
	Mon, 30 Jun 2008 18:45:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6AF6818C7B; Mon, 30 Jun 2008 18:44:57 -0400 (EDT)
In-Reply-To: <20080701004211.ba9b89c9.chriscool@tuxfamily.org> (Christian
 Couder's message of "Tue, 1 Jul 2008 00:42:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2EDA1CD2-46F6-11DD-8855-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86953>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch "git bisect" doesn't really work when it is given
> some good revs that are siblings of the bad rev.
>
> For example if there is the following history:
>
> A-B-C-D
>    \E-F
>
> and we launch "git bisect start D F" then only C and D will be
> considered as possible first bad commit. This is wrong because A, B and
> E may be bad too if the bug exists everywhere except in F that fixes it.

Please don't.

bisect is about finding a single regression by partitioning the graph into
older good section and newer bad section with a *single* "first bad
commit".

For your "this could also be possible" scenario is already outside the
realm.  You are assuming A, B and F is good, and D is bad.  But if E is
bad, then that breakage cannot possibly affect the transition between B
and D from good to bad (E cannot break D), so C must *also* be bad.
