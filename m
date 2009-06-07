From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends strerror(errno)  to die()
Date: Sun, 07 Jun 2009 09:57:04 -0700
Message-ID: <7vzlck9e3j.fsf@alter.siamese.dyndns.org>
References: <200906061509.15870.trast@student.ethz.ch>
	<cover.1244299302.git.trast@student.ethz.ch>
	<3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
	<20090606221320.GB30064@coredump.intra.peff.net>
	<2325a7950906070412k3a440558h35db7511cc390e4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Petr Baudis <pasky@suse.cz>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLgN-0001fP-9Z
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 18:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbZFGQ5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 12:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbZFGQ5O
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 12:57:14 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36917 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZFGQ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 12:57:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090607165705.RGCH2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jun 2009 12:57:05 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 14x41c0034aMwMQ034x4Kq; Sun, 07 Jun 2009 12:57:04 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=w3hDlop6rIQA:10 a=MeH_iaCVfCUA:10
 a=pGLkceISAAAA:8 a=XQy3nXNo7oIaQB6D1BoA:9 a=50QyqcwOxed0uwXxgyH9-DKUDnsA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120984>

Alexander Potashev <aspotashev@gmail.com> writes:

> This breaks theoretical usage of custom format string in custom die
> routines:
>         1. A custom die routine might not support %s.
>         2. If the die routine adds a custom format specifier, vsnprintf
>                 will fail.

I do not think that flies even as a theory.  The "custom" 39a3f5ea talks
about is more about "Instead of sending it to stderr, let's pop up an info
window and give the message there" kind of customization.

Existing die() that prints errno does so by giving strerror() to "%s", so
no matter how custom your die routine is, you must support '%s' for its
output to make sense to humans.  If you "not support %s", then you will
ignore (or choke at) such strerror() result without this patch anyway.
