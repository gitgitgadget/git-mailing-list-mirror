From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/2] Command preparation cleanup in "connect.c" (was: [PATCH] Fix memory leak in "connect.c".)
Date: Mon, 11 Sep 2006 06:43:12 +0200
Message-ID: <200609110643.13486.chriscool@tuxfamily.org>
References: <20060907055952.dafffe2b.chriscool@tuxfamily.org> <7vwt8g48rt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 06:37:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMdYE-0007AY-Qo
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 06:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWIKEhV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 11 Sep 2006 00:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWIKEhV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 00:37:21 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:5514 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751134AbWIKEhT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 00:37:19 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5E83310598;
	Mon, 11 Sep 2006 06:37:18 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vwt8g48rt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26834>

Le jeudi 7 septembre 2006 06:09, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > sq_quote allocates some memory that should be freed.
>
> That's technically correct, but the code you are touching is
> immediately before exec() or die() so I chose to be sloppy and
> short ;-).
>
> With sq_quote_buf() (which was introduced with 77d604 Oct 10
> 2005), you should be able to directly write into the command[]
> buffer, I think.  The code you touched predates that function
> (b10d0e July 8 2005).

The following two patches clean "connect.c" up using "add_to_string"=20
from "rsh.c". The code is still longer, but there is no leak and it may=
 be=20
better to die with an error message than to truncate a too long command=
=2E

Shortlog:
	[PATCH 1/2] Move add_to_string to "quote.c" and make it extern.
	[PATCH 2/2] Fix a memory leak in "connect.c" and die if command too
long.

Diffstat:
 connect.c |   17 ++++++++++++++---
 quote.c   |   29 +++++++++++++++++++++++++++++
 quote.h   |    6 ++++++
 rsh.c     |   29 -----------------------------
 4 files changed, 49 insertions(+), 32 deletions(-)

Christian.
