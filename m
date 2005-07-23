From: Junio C Hamano <junio@twinsun.com>
Subject: Re: [PATCH] Deb Packaging fixes: Build against Mozilla libs for
 Debian, conflict with "git"
Date: Sat, 23 Jul 2005 02:11:16 -0700
Message-ID: <7vd5p9horr.fsf@totally-fudged-out-message-id>
References: <20050723073707.GA3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 11:11:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwG2a-0007mA-Js
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 11:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVGWJLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 05:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVGWJLY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 05:11:24 -0400
Received: from alcor.twinsun.com ([198.147.65.9]:59970 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id S261640AbVGWJLY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 05:11:24 -0400
Received: from sic.twinsun.com ([192.54.239.17])
	by alcor.twinsun.com (8.12.9/8.12.9) with ESMTP id j6N9BG3x013845;
	Sat, 23 Jul 2005 02:11:16 -0700 (PDT)
Received: from pete.twinsun.com (pete.twinsun.com [192.54.239.43])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j6N9BGY12018;
	Sat, 23 Jul 2005 02:11:16 -0700 (PDT)
Received: from sic.twinsun.com ([192.54.239.17])
 by pete.twinsun.com (SMSSMTP 4.1.0.19) with SMTP id M2005072302111626161
 ; Sat, 23 Jul 2005 02:11:16 -0700
Received: from arte (arte.twinsun.com [192.54.239.5])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j6N9BGY12014;
	Sat, 23 Jul 2005 02:11:16 -0700 (PDT)
Received: by arte (sSMTP sendmail emulation); Sat, 23 Jul 2005 02:11:16 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050723073707.GA3255@mythryan2.michonline.com> (Ryan
 Anderson's message of "Sat, 23 Jul 2005 03:37:07 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> --- a/debian/changelog
> +++ b/debian/changelog
> ...
> +  * Minor tweaks to the Build-Depends.

This is a nit and not the reason for NACK, but I do not see any
change to Build-Depends.

> -Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
> +Depends: ${misc:Depends}, patch, diff, rsync, rcs, wget, rsh-client

This is primarily my fault, but this new Depends line is already
obsolete.  Darrin Thompson removed the last remaining use of
wget and it is my understanding that we do not depend on wget
anymore; instead we now depend on curl executable.

I do not offhand remember where we use rsh-client.  The
rsh-client I know of is this one, which claims to offer rsh, rcp
and rlogin but I do not think we use any of them.  Did you mean
"ssh" package?

    Package: rsh-client
    Priority: extra
    Section: net
    Maintainer: Alberto Gonzalez Iniesta <agi@inittab.org>
    Source: netkit-rsh
    Version: 0.17-13
    Description: rsh clients.
     This package contains rsh, rcp and rlogin.

Perhaps (I am not sure about the rsh-client vs ssh):

> +Depends: ${misc:Depends}, patch, diff, rsync, rcs, curl, ssh

Both the use of mozilla SHA1 library and conflicting with the
other GIT, which are the primary points of this patch, sound
sensible, relative to the Debian poli(cies|tics), but as long as
we are touching the Depends: line, let's make sure we get it
right (the current one is obviously obsolete).
