From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Removing redundant packs
Date: Sat, 08 Dec 2007 13:37:44 -0800
Message-ID: <7vsl2cvpef.fsf@gitster.siamese.dyndns.org>
References: <20071208125050.GA17478@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Dec 08 22:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J17NM-0000vT-PR
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 22:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbXLHVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 16:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXLHVh4
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 16:37:56 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:55487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXLHVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 16:37:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E4B404F4C;
	Sat,  8 Dec 2007 16:37:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A3EA24F4B;
	Sat,  8 Dec 2007 16:37:46 -0500 (EST)
In-Reply-To: <20071208125050.GA17478@machine.or.cz> (Petr Baudis's message of
	"Sat, 8 Dec 2007 13:50:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67572>

Petr Baudis <pasky@ucw.cz> writes:

> At the same time, I have to be careful not to prune all unreferenced
> objects since they can be referenced in forks.

How about...

 (1) In each repository, run "repack -a -d".  That would ensure that
     everybody has the necessary objects that they themselves need.  By
     doing this for a repository that borrows from another makes sure
     pruning the latter would not break the former, so you start from
     leaves and move on to the repositories they borrow from.

 (2) In each repository, run "repack -a -l -d".  By doing this for a
     repository that borrows from another repacks the former without
     objects it borrows from the latter, so the former repository will
     retain what it needs but will borrow what are common from the
     latter, so you start from the repository that does not borrow from
     anybody else, and move on to the repositories that borrow from the
     one you already run this step.
