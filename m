From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 23:36:46 -0800
Message-ID: <7vejco4xv5.fsf@gitster.siamese.dyndns.org>
References: <874pdmhxha.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0801101204120.31053@racer.site>
	<87myrdhnn5.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0801101234580.31053@racer.site>
	<87hchlhm3k.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:37:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDESE-0007Cv-UL
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbYAKHg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYAKHg4
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:36:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbYAKHgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:36:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ABE9E4CEE;
	Fri, 11 Jan 2008 02:36:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C4234CED;
	Fri, 11 Jan 2008 02:36:47 -0500 (EST)
In-Reply-To: <87hchlhm3k.fsf@rho.meyering.net> (Jim Meyering's message of
	"Thu, 10 Jan 2008 14:00:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70130>

Jim Meyering <jim@meyering.net> writes:

> On the other hand, if that write failure is truly ignorable,
> a mindless minimalist :-) might argue that it's best just to
> omit the syscall.

Usually the contents of .keep file is a small one-line comment
that describes who decided that the pack needs to be kept and
why, so the answer is no.

In this case, a failure while closing that small .keep file is
highly unlikely, and if we ever mange to trigger such a highly
unlikely failure, I think we would rather want to *know* about
it, as it is likely there is something more seriously wrong
going on.

So let's keep that check on close().
