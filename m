From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Sat, 31 Mar 2012 00:55:20 -0500
Message-ID: <20120331055520.GA7939@burratino>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, j.sixt@viscovery.net, gitster@pobox.com,
	git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Mar 31 07:55:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDrHk-0008Vp-IR
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 07:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab2CaFzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 01:55:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56213 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab2CaFz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 01:55:29 -0400
Received: by iagz16 with SMTP id z16so1873497iag.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 22:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=//nsdt4uoEV48YWemfHOS6JubQZV+OaPfqNvqDMwyUo=;
        b=X0aQ+i09XTe2/UEdkS558S7itj0UYq2e9YOqyFx/6DkVVWI0w7VWgNCIWmy6ZAx7XN
         gJ7fMrjwSjFtNQRGMgqkgRAWH51lwomzFn3LzAqfm/iJ5NV0QB1q/OWHFUzPeBD/0W08
         VzuXzTWWoMBXY9ao6yJz1WtYpcldhTKl/tISC8EheiyOldisiKzuKOj8yH05Iq1fVr00
         FywRPmu2m63OnEJNdX4jIMirjKOG7I1Yf4/GQAKi3AHDZyXEgeNP7kVKZgeZmYaGxUlS
         2z4nK4eJsgdwkM2YTMXDMVR3ilYhFSHM8QQrIR+LPn98wEwZYrwZ9A6f6h4BJ1wef1PJ
         UkGg==
Received: by 10.50.89.200 with SMTP id bq8mr639597igb.45.1333173328944;
        Fri, 30 Mar 2012 22:55:28 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id mk10sm3316530igc.4.2012.03.30.22.55.26
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 22:55:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194435>

Ben Walton wrote:

> --- a/Makefile
> +++ b/Makefile
> @@ -1913,6 +1913,8 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
>  	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
>  	'-DGIT_INFO_PATH="$(infodir_SQ)"'
>  
> +run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH_SQ)"'

Sorry I forgot to send this before.  Quick tweaks:

 - let assembler listings (from "make run-command.s") and sparse checks
   reflect the SHELL_PATH setting, too

 - the entire -DFOO="bar" argument is surrounded with single quotes
   in other EXTRA_CPPFLAGS settings, so let this one follow that
   pattern to avoid standing out

diff --git i/Makefile w/Makefile
index dea1f157..a3791139 100644
--- i/Makefile
+++ w/Makefile
@@ -1913,7 +1913,8 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
-run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH_SQ)"'
+run-command.sp run-command.s run-command.o: EXTRA_CPPFLAGS = \
+	'-DSHELL_PATH="$(SHELL_PATH_SQ)"'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
