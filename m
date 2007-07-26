From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: index-pack died on pread
Date: Thu, 26 Jul 2007 14:42:30 +0200
Message-ID: <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
	 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
	 <200707260115.13234.robin.rosenberg.lists@dewire.com>
	 <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Michal Rokos" <michal.rokos@gmail.com>, GIT <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 14:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE2fv-0003Hc-UO
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 14:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759018AbXGZMmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 08:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758446AbXGZMmd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 08:42:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:14357 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558AbXGZMmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 08:42:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so525542ugf
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 05:42:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eM9X5bX6KRQzFB7pe+uXKUaQyPC8sDIZYSm6a+4jAP3amq+a4D+TXgwSb8EwBWgzbRzoHXto4peEdPMYBTCceZ5u9z2Qh5I8desHkTUvt7Ln6exBmMcP9J+hUGP9zrypKQna3Pmpe6xZNi2RNjmACCwdMRAiHi1j5h1IJD2utWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IvCg3TSL4nvcVucjDTS9HDI/+7G850a5VTnallpDo7RxRuJnSKCxphNlJIIWqlMB0cFt6I8IZwsGyLEddixYiIph+kJmw06aNif3Xp0/SAi6CF49t8WXPRg9TtMqRaifmSIxng43n/WoDmEqT6FF5NybhsHohtPF8xbIHDyg41s=
Received: by 10.78.140.17 with SMTP id n17mr423732hud.1185453750898;
        Thu, 26 Jul 2007 05:42:30 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 26 Jul 2007 05:42:30 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53826>

On 7/26/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 26 Jul 2007, Robin Rosenberg wrote:
> >
> > Does cygwin have the same pread problem then.. ? after make NO_PREAD=1 with 1.5.2.4
> > clone works.
>
> Interesting.
>
> It's true that pread() is used much less than normal reads, and maybe the
> cygwin pread() is indeed broken. But it's intriguing how apparently both
> HP-UX and Cygwin are showing the same breakage.

Maybe because neither _has_ POSIX pread? This is cygwin's pread, I believe:

http://cygwin.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_disk_file.cc?rev=1.225&content-type=text/x-cvsweb-markup&cvsroot=src

Windows has means to implement it natively, but the interface is so ugly
(see OVERLAPPED, if interested), that it is no wonder Cygwin chose to
just use lseek.
