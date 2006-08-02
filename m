From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/10] Fix header breakage with _XOPEN_SOURCE.
Date: Wed, 02 Aug 2006 00:46:26 -0700
Message-ID: <7vpsfjvaul.fsf@assigned-by-dhcp.cox.net>
References: <00b601c6b5cf$7d54b940$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 09:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8BRB-0000kv-BP
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 09:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWHBHq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 03:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHBHq2
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 03:46:28 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54687 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751355AbWHBHq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 03:46:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802074626.FQZV25430.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 03:46:26 -0400
To: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24637>

"Ramsay Jones" <ramsay@ramsay1.demon.co.uk> writes:

> convert-objects.c sets _XOPEN_SOURCE and _XOPEN_SOURCE_EXTENDED before
> including <time.h>, in order to get the declaration of strptime().
> This leads to breakage in cache.h, due to S_ISLNK and S_IFLNK no longer
> being defined by <sys/stat.h>.  These definitions are protected by the
> __USE_BSD symbol, which is not set when _XOPEN_SOURCE is set.  Moving
> the #defines and #include <time.h> below all other #includes does not
> fix the problem, however, since now _USE_XOPEN, which protects the
> declaration of strptime(), is now not defined (don't ask!).

Wouldn't including "cache.h" and friends first and including
<time.h> last solve the problem, then?

This kind of change tends to fix one system while potentially
breaking another, and we would need to be careful.  Will queue
for post 1.4.2 and have people scream if it breaks somebody, I
guess.
