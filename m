From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] push: change push to fail if short ref name does not exist
Date: Sun, 28 Oct 2007 00:28:53 -0700
Message-ID: <7vabq3wvd6.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2aB-0006YK-KC
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbXJ1H27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXJ1H26
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:28:58 -0400
Received: from rune.pobox.com ([208.210.124.79]:46220 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbXJ1H25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:28:57 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A8BFA14F201;
	Sun, 28 Oct 2007 03:29:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1CC8A14F200;
	Sun, 28 Oct 2007 03:29:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62533>

Steffen Prohaska <prohaska@zib.de> writes:

> You can use a branch's shortname to push it. Push used to create
> the branch on the remote side if it did not yet exist. If you
> specified the wrong branch accidentally it was created. A safety
> valve that pushes only existing branches may help to avoid
> errors.

I do not agree with this change.

If you misspelled the branch name (by the way, it is not a
"shortname", but what follows refs/heads/ is _the_ name of the
branch) "frotz" as "frtoz", and if a branch with the misspelled
name did _not_ exist locally, it would fail, with or without
this change, which is a good thing.

But if you named "nitfol" that exists locally when you meant to
push "frotz" out, if "nitfol" remotely existed, we will push
that anyway by mistake, even with this change.  It will prevent
the push only when "nitfol" did not happen to exist at the
remote side.

Earlier there was a discussion to introduce an optional
configuration that makes "git push" without any parameter to
push only the current branch out, in order to help people who
work with shared remote central repository.  That might be a
better alternative to avoid pushing out wrong branch by
mistake.  That approach would also make your 8/8 unnecessary.
