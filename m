From: Junio C Hamano <gitster@pobox.com>
Subject: Re: When a merge turns into a conflict
Date: Wed, 05 Dec 2007 21:51:59 -0800
Message-ID: <7v7ijsid4w.fsf@gitster.siamese.dyndns.org>
References: <pan.2007.12.06.04.49.25@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:52:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J09eu-0006aA-6e
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbXLFFwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXLFFwG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:52:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58165 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbXLFFwF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:52:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 204F72EF;
	Thu,  6 Dec 2007 00:52:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A242D98747;
	Thu,  6 Dec 2007 00:52:22 -0500 (EST)
In-Reply-To: <pan.2007.12.06.04.49.25@progsoc.org> (Anand Kumria's message of
	"Thu, 6 Dec 2007 04:49:27 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67247>

Anand Kumria <wildfire@progsoc.org> writes:

> However when my colleague came to merge my patches in; git complained 
> that the file had conflict because:
>
> 	a. it found the ========= AsciiDoc header line

Perhaps .git/hooks/pre-commit hook is enabled for the person who needed
to merge, fix conflicts and make a commit.

We ship the hook _disabled_ by default, but that hook inspects the
change (relative to the HEAD, which means "difference this merge brings
in relative to the state before I started the merge") and complains if
it finds lines that:

 * have trailing whitespaces,

 * have a SP immediately before HT in the indentation, or

 * matches 7 or more <, >, or = at the beginning (i.e. <<<<<<<, =======,
   or >>>>>>>, typically are conflict markers).

And the last heuristics does trigger on an AsciiDoc text.

The easiest (and standard) workaround in such a case is, after
inspecting the change yourself to make sure you are bitten by false
positive, to commit with --no-verify option:

	git commit --no-verify

This bypasses the pre-commit hook.
