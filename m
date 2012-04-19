From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Thu, 19 Apr 2012 08:58:01 +0200
Message-ID: <4F8FB779.60004@viscovery.net>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl> <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki> <4F8C3E0F.2040300@in.waw.pl> <20120416174230.GA19226@sigill.intra.peff.net> <20120416224424.GA10314@ecki> <20120419060326.GA13982@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpl?= =?UTF-8?B?d3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 08:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKlJq-0000MD-J4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 08:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab2DSG6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 02:58:11 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14311 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2DSG6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 02:58:10 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SKlJv-0006MF-0z; Thu, 19 Apr 2012 08:58:27 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 375921660F;
	Thu, 19 Apr 2012 08:58:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20120419060326.GA13982@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195928>

Am 4/19/2012 8:03, schrieb Jeff King:
> mkfifo fd
> yes >fd &
> pid=$!
> {
>         read line
>         echo $line
>         cat <fd &
> } <fd
> sleep 1
> kill $pid
> wait $pid
> rm -f fd
...
> Hmm. Yeah, if you strace the cat, it gets an immediate EOF. And even
> weirder, I notice this in the strace output:
> 
>   clone(...)
>   close(0)                                = 0
>   open("/dev/null", O_RDONLY)             = 0
>   ...
>   execve("/bin/cat", ["cat"], [/* 50 vars */]) = 0
> 
> What? The shell is literally redirecting the cat process's stdin from
> /dev/null. I'm totally confused.

You don't have to be; it's mandated by POSIX:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_03_02

-- Hannes
