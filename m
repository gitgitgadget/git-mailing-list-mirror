From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix and simplify "split patch" detection
Date: Sun, 02 Sep 2007 17:15:44 -0700
Message-ID: <7vmyw4ob7z.fsf@gitster.siamese.dyndns.org>
References: <200709022218.43042.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzc2-0002Tw-O6
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbXICAPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbXICAPv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:15:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbXICAPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:15:50 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C717F12D535;
	Sun,  2 Sep 2007 20:16:07 -0400 (EDT)
In-Reply-To: <200709022218.43042.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 2 Sep 2007 22:18:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57411>

Jakub Narebski <jnareb@gmail.com> writes:

> Alternate solution, which we did chose, is to check when git splits
> patches, and do not check if parsed info from current patch corresponds
> to current or next raw diff format output line.  Git splits patches
> only for 'T' (typechange) status filepair, and there always two patches
> corresponding to one raw diff line.

Not that I can think of a better way offhand than what you
already mentioned, but I have to say that I am not entirely
happy with this implementation.  A really old git showed two
patches (one creation and one deletion) for "complete rewrite",
which was corrected long time ago.  I do not think we will
change the typechange output in a similar way in the future, but
relying on that level of detail feels somewhat ugly.

As you are reading from --patch-with-raw, you already know the
order of patches that will be given to you when you finished
reading the "raw" part.  The patches will come in the same
order.  So it might be possible to keep track of patches to what
path you are expecting and decide if it is part of what you are
processing at the point you process "diff --git" line.
