From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v6 00/11] Add interpret-trailers builtin
Date: Thu, 06 Mar 2014 01:18:18 +0000
Message-ID: <5317CCDA.40402@ramsay1.demon.co.uk>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 02:24:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLN36-0008KI-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 02:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996AbaCFBYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 20:24:32 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:45355 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756643AbaCFBYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 20:24:31 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2014 20:24:31 EST
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id D054DA644BE
	for <git@vger.kernel.org>; Thu,  6 Mar 2014 00:18:16 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D4729384083;
	Thu,  6 Mar 2014 01:16:39 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 96508384080;
	Thu,  6 Mar 2014 01:16:39 +0000 (GMT)
Received: from [192.168.254.8] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu,  6 Mar 2014 01:16:37 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140304193250.14249.56949.chriscool@tuxfamily.org>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243496>

On 04/03/14 19:47, Christian Couder wrote:
> This patch series implements a new command:
> 
>         git interpret-trailers
> 

[snip]

Minor problem: this series causes sparse to complain, thus:

    trailer.c:642:6: warning: symbol 'process_trailers' was not \
        declared. Should it be static?

The following patch, on top of the 'pu' branch, fixes it:

--- >8 ---
Subject: [PATCH] trailer.c: suppress sparse warning

Check that the public interface, as declared in the trailer.h header
file, is consistent with the actual implementation. Add an #include
of the header file into the implementation file.

Noticed by sparse ("'process_trailers'  was not declared. Should it
be static?").

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 trailer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trailer.c b/trailer.c
index b5de616..95d5874 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "argv-array.h"
+#include "trailer.h"
 /*
  * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
  */
-- 
1.9.0
--- 8< ---

However, for this to work, in addition to squashing the above patch into
your patch #6, you would need to move the creation of the trailer.h header
file from patch 07/11 ("trailer: add interpret-trailers command") to patch
06/11 ("trailer: put all the processing together and print"), where it should
have been anyway! :-D 

HTH

ATB,
Ramsay Jones

> Christian Couder (11):
>   Add data structures and basic functions for commit trailers
>   trailer: process trailers from stdin and arguments
>   trailer: read and process config information
>   trailer: process command line trailer arguments
>   trailer: parse trailers from stdin
>   trailer: put all the processing together and print
>   trailer: add interpret-trailers command
>   trailer: add tests for "git interpret-trailers"
>   trailer: execute command from 'trailer.<name>.command'
>   trailer: add tests for commands in config file
>   Documentation: add documentation for 'git interpret-trailers'
> 
>  .gitignore                               |   1 +
>  Documentation/git-interpret-trailers.txt | 123 ++++++
>  Makefile                                 |   2 +
>  builtin.h                                |   1 +
>  builtin/interpret-trailers.c             |  33 ++
>  git.c                                    |   1 +
>  t/t7513-interpret-trailers.sh            | 261 ++++++++++++
>  trailer.c                                | 661 +++++++++++++++++++++++++++++++
>  trailer.h                                |   6 +
>  9 files changed, 1089 insertions(+)
>  create mode 100644 Documentation/git-interpret-trailers.txt
>  create mode 100644 builtin/interpret-trailers.c
>  create mode 100755 t/t7513-interpret-trailers.sh
>  create mode 100644 trailer.c
>  create mode 100644 trailer.h
> 
