From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 19:01:35 +0200
Message-ID: <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de> <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 19:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN6bY-0001c2-RP
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603Ab1ESRBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:01:39 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:13590 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933550Ab1ESRBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 13:01:38 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id C670D1D21DF;
	Thu, 19 May 2011 19:01:36 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.403
X-Spam-Level: 
X-Spam-Status: No, score=-3.403 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=-0.503, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rUxoLOBD8+Wu; Thu, 19 May 2011 19:01:35 +0200 (CEST)
Received: from dhcp208-43.rz.uni-freiburg.de (dhcp208-43.rz.uni-freiburg.de [132.230.208.43])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id A44C61D2034;
	Thu, 19 May 2011 19:01:34 +0200 (CEST)
In-Reply-To: <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173967>


Am 19.05.2011 um 14:17 schrieb Erik Faye-Lund:

> But I can't help to think that this implementation of getpass looks a
> bit heavy, especially since we already have our own getpass
> implementation in compat/mingw.c.

> Do we really need two implementations? Wouldn't it be better to factor
> out the mingw-version to a separate source file, and then improve it?

Yes, I agree very much that it would be nicer to have a common version.


> Windows doesn't have /dev/tty, but the logic in this version handles
> that by using stdin/stderr instead. The signal-stuff has a comment
> that indicates it might not even be correct. tcgetattr/tcsetattr isn't
> supported on Windows, but it's not needed if we use getch (as the
> version in compat/mingw.c does). POSIX/curses getch respects the
> echo-setting, while Windows getch never echo.

Sadly, there is no curses.h on Android. So as my goal is compiling on Android, it wouldn't help much to create another dependency on curses.h.

So we would still need the /dev/tty opening and the tcgetattr/tcsetattr stuff, which would result in a very cluttered code if combined with getpass from compat/mingw.c. So I think, it will be easier to keep the two separated.

I do share your concern about the license and the heavyness of the code, so I switched to the getpass.c from uClibc and prepared a new patch. It is LGPL-v2.1 licensed, which seems like it has to be added anyway. I also tried to remove unused code from the new version as good possible.
