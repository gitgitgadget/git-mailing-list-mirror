From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 20:48:41 -0800
Message-ID: <7v63z4bjrq.fsf@gitster.siamese.dyndns.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	<alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	<4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
	<alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
	<7vprxcdhis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 05:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2JXS-0006Th-D5
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 05:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbXLLEtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 23:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbXLLEtU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 23:49:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbXLLEtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 23:49:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 68449593D;
	Tue, 11 Dec 2007 23:49:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F399593A;
	Tue, 11 Dec 2007 23:49:06 -0500 (EST)
In-Reply-To: <7vprxcdhis.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 11 Dec 2007 13:54:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67991>

Junio C Hamano <gitster@pobox.com> writes:

> While this should be safe (because the user of blob lazily re-fetches),
> it feels a bit too aggressive, especially when -C or other "retry and
> try harder to assign blame elsewhere" option is used.
>
> Instead, how about discarding after we are done with each origin, like
> this?

It's been a while for me to look at the blame engine, and it hit me that
it would be interesting to run assign_blame() loop on multi-core machine
in parallel threads.
