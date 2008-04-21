From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 18:21:33 -0700
Message-ID: <7vk5isatpe.fsf@gitster.siamese.dyndns.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
 <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
 <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com>
 <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org>
 <20080420215700.GA18626@bit.office.eurotux.com>
 <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 03:22:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnkjp-0007nT-1X
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 03:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbYDUBVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 21:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbYDUBVq
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 21:21:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbYDUBVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 21:21:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4922F6578;
	Sun, 20 Apr 2008 21:21:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A06D96576; Sun, 20 Apr 2008 21:21:38 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 20 Apr 2008 16:07:35 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80009>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio, what was the logic for that whole "has_symlink_leading_path()" 
> thing?

If you have a tracked path a/b/c/d/e, and you changed your work tree to
make a/b to a symlink that points at a random directory, potentially
even outside work tree, that has c/d/e in it, we should not be fooled by
the fact that lstat("a/b/c/d/e") says "yup, the file exists".  As far as
git is concerned, that path does _not_ exist, as "a/b" is a symlink now.
