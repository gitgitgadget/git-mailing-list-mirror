From: Jeff King <peff@peff.net>
Subject: bsd group semantics
Date: Tue, 31 Mar 2009 07:26:38 -0400
Message-ID: <20090331112637.GA1910@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 13:28:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loc8j-0005Db-M5
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 13:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbZCaL0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 07:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbZCaL0u
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 07:26:50 -0400
Received: from peff.net ([208.65.91.99]:50953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482AbZCaL0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 07:26:49 -0400
Received: (qmail 9626 invoked by uid 107); 31 Mar 2009 11:27:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 07:27:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 07:26:38 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115250>

The recently added test t1301.17 is failing for me on FreeBSD; the
created directories don't have the GID bit set.

I traced this back to the fact that FORCE_DIR_SET_GID is a no-op on
FreeBSD due to the DIR_HAS_BSD_GROUP_SEMANTICS flag being set. I am not
sure I understand the original reasoning for this flag at all; GID seems
to work just fine on my FreeBSD 6.1 test system.

The original thread is here:

  http://article.gmane.org/gmane.comp.version-control.git/75999

It looks like Alex was having the problem on FreeBSD 4. I'm not sure if
this flag can go away with the new set_shared_perm, or if I need to just
enable on FreeBSD <= 4.

-Peff
