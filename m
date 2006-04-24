From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 15:23:15 -0400
Message-ID: <0C184231-78A3-4517-89B2-2AE5C2CC9752@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <Pine.LNX.4.64.0604221333470.23166@alien.or.mcafeemobile.com> <20060423023144.GA17704@adacore.com> <Pine.LNX.4.64.0604241155000.18685@alien.or.mcafeemobile.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 21:23:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY6eX-00011b-N7
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 21:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWDXTXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWDXTXT
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 15:23:19 -0400
Received: from nile.gnat.com ([205.232.38.5]:32194 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1751150AbWDXTXS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 15:23:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id EA5CD48CDF4;
	Mon, 24 Apr 2006 15:23:17 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 14527-01-9; Mon, 24 Apr 2006 15:23:17 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id C540E48CE3C;
	Mon, 24 Apr 2006 15:23:17 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604241155000.18685@alien.or.mcafeemobile.com>
To: Davide Libenzi <davidel@xmailserver.org>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19104>


On Apr 24, 2006, at 15:10, Davide Libenzi wrote:
> Right, but you are looking at highest equal-probability  
> distribution over your hash buckets ;)
> Anyway, thanks for bringing Rabin's polynomial fingerprint up from  
> the forgotten lands. Performance and delta size are quite amazing,  
> and I decided to add Rabin's delta to libxdiff.
> I hacked some code (attached) to generate T/U tables. Since  
> libxdiff must be portable everywhere, even on system w/out 64 bits  
> support, I use xrabin to create both 64 bits tables (poly degree  
> 61) and 32 bits tables (poly degree 31), and store them in a .c  
> file letting the build environment to pick the correct one for the  
> platform.

It might actually make sense to use the 32-bit code for GIT
as well, since it turns out that on the typical small source files
with few differences, the full 64-bit Rabin is a problem for
performance.

When diffing large files (my main interest), this is more than
offset by the better hash quality. For tiny files with few changes
it appears to be overkill...

   -Geert
