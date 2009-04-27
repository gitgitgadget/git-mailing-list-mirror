From: Junio C Hamano <gitster@pobox.com>
Subject: Re: compiling on netbsd
Date: Mon, 27 Apr 2009 09:59:31 -0700
Message-ID: <7vocui3udo.fsf@gitster.siamese.dyndns.org>
References: <20090426134900.GB454@quartz.inf.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Welche <prlw1@cam.ac.uk>
X-From: git-owner@vger.kernel.org Mon Apr 27 18:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyUBG-0001jL-LH
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334AbZD0Q7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZD0Q7k
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:59:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbZD0Q7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 12:59:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E0D0FAE9D4;
	Mon, 27 Apr 2009 12:59:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8FA6AE9D3; Mon,
 27 Apr 2009 12:59:35 -0400 (EDT)
In-Reply-To: <20090426134900.GB454@quartz.inf.phy.cam.ac.uk> (Patrick
 Welche's message of "Sun, 26 Apr 2009 14:49:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CB4BDBF8-334C-11DE-96C7-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117693>

Patrick Welche <prlw1@cam.ac.uk> writes:

> I found I needed to add the following patch in order to compile today's
> git source under NetBSD-current (5.99.11)

Thanks; USE_ST_TIMESPEC part is a nice companion patch to 9140804
(Makefile: turn on USE_ST_TIMESPEC for FreeBSD, 2009-03-22).

I cannot tell if "#define _NETBSD_SOURCE 1" has a potential to regress
things to existing NetBSD users with releases different from yours, so I
need to ask some help here.

Any objection from people who runs older NetBSD?

-- >8 --
From: Patrick Welche <prlw1@cam.ac.uk>
Date: Sun, 26 Apr 2009 14:49:00 +0100
Subject: [PATCH] NetBSD compilation fix

Similar to other BSD variants, it needs USE_ST_TIMESPEC.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile          |    1 +
 git-compat-util.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index f006d2c..bb15c6b 100644
--- a/Makefile
+++ b/Makefile
@@ -764,6 +764,7 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	THREADED_DELTA_SEARCH = YesPlease
+	USE_ST_TIMESPEC = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 785aa31..1ac16bd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -46,6 +46,7 @@
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
+#define _NETBSD_SOURCE 1
 
 #include <unistd.h>
 #include <stdio.h>
-- 
1.6.3.rc3
