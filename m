From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: problem with file mode
Date: Mon, 08 Jun 2009 16:50:06 +0200
Message-ID: <4A2D251E.9030305@viscovery.net>
References: <18e14dc30906080209m9eceb6ft81c77ea0345b30e3@mail.gmail.com> <20090608123006.GF13775@coredump.intra.peff.net> <18e14dc30906080649y2efa7facv1109fcd797614d27@mail.gmail.com> <20090608135709.GC28101@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Romanenco <andrew@romanenco.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDgBF-0003E7-I6
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 16:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbZFHOuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 10:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbZFHOuH
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 10:50:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40757 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbZFHOuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 10:50:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MDgAp-0004J1-94; Mon, 08 Jun 2009 16:50:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 06452FCD2; Mon,  8 Jun 2009 16:50:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090608135709.GC28101@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121079>

Jeff King schrieb:
> On Mon, Jun 08, 2009 at 04:49:44PM +0300, Andrew Romanenco wrote:
>> true - B is Fat
> 
> Then you probably want to:
> 
>   git config core.filemode false
> 
> on B. Though I thought we automagically tested whether the filesystem
> supported executable bits when creating the repository.

We do. Our test basically:

   lstat()
   chmod(st_mode ^ S_IXUSR)
   lstat()

but Linux (Andrew said he's on Ubuntu) keeps the mode bits that user-space
requested with chmod() in the cache long enough that the subsequent
lstat() call sees what it just requested. So, our test doesn't notice that
the x-bit is not written to the filesystem.

:-(

-- Hannes
