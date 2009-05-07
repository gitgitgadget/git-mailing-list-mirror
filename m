From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 07 May 2009 15:15:15 +0200
Message-ID: <4A02DEE3.1080006@viscovery.net>
References: <4A02D288.6040804@googlemail.com> <4A02D70B.6090305@op5.se> <EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, jdl@jdl.com
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 07 15:15:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M23Rh-0008LR-6H
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 15:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbZEGNPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 09:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbZEGNPU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 09:15:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33736 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZEGNPT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 09:15:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M23RT-0006zk-QB; Thu, 07 May 2009 15:15:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 87CE554D; Thu,  7 May 2009 15:15:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118474>

Benjamin Kramer schrieb:
> git daemon has a feature called interpolated paths
> 
> If git daemon is started like this:
>     git daemon --interpolated-path=%IP/%D
> (the machine has two IPs: 123.123.123.123 (v4) and 2001:db8::1 (v6))
> and someone clones a repository:
>     git clone git://123.123.123.123/frotz
> git daemon will look for the repository in the directory
> `123.123.123.123/frotz'
> 
> But if git daemon listens on the IPv6 interface and someone clones a
> repository:
>     git clone git://2001:db8::1/frotz
> Then git daemon will look for the repository in `0.0.0.0/frotz'
> 
> My patch makes it converting IPv6 addresses properly and if you the clone
> in my previous example it'll now look in `2001:db8::1/frotz' (with
> colons in the
> directory name)

I don't particularly care about git-daemon on Windows at this time because
we don't build it anyway. But others have already had limited success, and
they might care since getnameinfo() is not available. If we did have IPv6
support on Windows, we would indeed have troubles with those path names.

But even on non-Windows, a directory name with colons does not look kosher
to me. Don't they look like PATH values? Or like remote addresses? Are
IPv6 addresses used in this way by other software?

Moreover, I think that since IPv6 addresses can have at most one '::'
abbreviation, but not in an unambiguous way, users of path-interpolation
of IPv6 addresses are at the mercy of whether and how getnameinfo() makes
use of '::'.

-- Hannes
