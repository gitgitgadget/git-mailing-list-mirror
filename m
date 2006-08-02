From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: [PATCH 6/10] Fix header breakage with _XOPEN_SOURCE.
Date: Wed, 2 Aug 2006 19:47:51 +0100
Message-ID: <001d01c6b664$285ff540$c47eedc1@ramsay1.demon.co.uk>
References: <7vpsfjvaul.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 02 20:48:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Lkx-0001PJ-Hq
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 20:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWHBSrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 14:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWHBSrm
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 14:47:42 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:21764 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S932143AbWHBSrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 14:47:41 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with smtp (Exim 4.42)
	id 1G8Lko-000MLO-L7; Wed, 02 Aug 2006 18:47:39 +0000
To: "Junio C Hamano" <junkio@cox.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
In-Reply-To: <7vpsfjvaul.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24666>


On Wed, 2006-08-02 at 8:46, Junio C Hamano wrote:
> 
> "Ramsay Jones" <ramsay@ramsay1.demon.co.uk> writes:
> 
> > convert-objects.c sets _XOPEN_SOURCE and _XOPEN_SOURCE_EXTENDED before
> > including <time.h>, in order to get the declaration of strptime().
> > This leads to breakage in cache.h, due to S_ISLNK and S_IFLNK no longer
> > being defined by <sys/stat.h>.  These definitions are protected by the
> > __USE_BSD symbol, which is not set when _XOPEN_SOURCE is set.  Moving
> > the #defines and #include <time.h> below all other #includes does not
> > fix the problem, however, since now _USE_XOPEN, which protects the
> > declaration of strptime(), is now not defined (don't ask!).
> 
> Wouldn't including "cache.h" and friends first and including
> <time.h> last solve the problem, then?
> 

Not for me. It may be a glibc 2.1 specific problem, of course, but 
strptime() remains undeclared.

> This kind of change tends to fix one system while potentially
> breaking another, and we would need to be careful.  Will queue
> for post 1.4.2 and have people scream if it breaks somebody, I
> guess.
> 

Yes, I had some concern about that myself. Unfortunately, you can't
make it conditional on the glibc version macros; in order to get the
macros, you have to include (one way or another) <features.h>, at which
point it is already too late ...

Ramsay
