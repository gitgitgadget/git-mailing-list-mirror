From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git tonight
Date: 06 Nov 2005 04:33:07 -0800
Message-ID: <86u0eqrm64.fsf@blue.stonehenge.com>
References: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net>
	<86acgiujuk.fsf@blue.stonehenge.com>
	<87y8427zvn.fsf@briny.internal.ondioline.org>
	<868xw2t1vg.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:34:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYji6-0005G6-0T
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 13:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVKFMdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 07:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVKFMdJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 07:33:09 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:57523 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750720AbVKFMdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 07:33:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 6E5ED8FA3D;
	Sun,  6 Nov 2005 04:33:08 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 12887-01-19; Sun,  6 Nov 2005 04:33:08 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0692D8FA3E; Sun,  6 Nov 2005 04:33:08 -0800 (PST)
To: Paul Collins <paul@briny.ondioline.org>
x-mayan-date: Long count = 12.19.12.13.18; tzolkin = 2 Etznab; haab = 16 Zac
In-Reply-To: <868xw2t1vg.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11210>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> As a separate problem, why make git depend on expat if the only part
Randal> of this is for DAV pushing?  Can http-push simply refuse DAV URLs if
Randal> built without expat?

Ignore that.  Yes, defining "NO_EXPAT" is enough.  Didn't notice that there.

And, I've confirmed that this patch does the trick, and will probably
defer any other issues with "optional" packages in the future:

diff --git a/Makefile b/Makefile
index 6f9b0d1..f89e0bd 100644
--- a/Makefile
+++ b/Makefile
@@ -185,6 +185,10 @@ uname_O := $(shell sh -c 'uname -o 2>/de
 ifeq ($(uname_S),Darwin)
        NEEDS_SSL_WITH_CRYPTO = YesPlease
        NEEDS_LIBICONV = YesPlease
+       ## fink
+       ALL_CFLAGS += -I/sw/include -L/sw/lib
+       ## darwinports
+       ALL_CFLAGS += -I/opt/local/include -L/opt/local/lib
 endif
 ifeq ($(uname_S),SunOS)
        NEEDS_SOCKET = YesPlease

Note that whitespace may have been eaten... this was a cut-n-paste.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
