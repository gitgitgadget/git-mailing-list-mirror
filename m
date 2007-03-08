From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] bundle: fix wrong check of read_header()'s return value &
 add tests
Date: Thu, 08 Mar 2007 15:43:23 -0500
Message-ID: <45F0756B.5080808@verizon.net>
References: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0703070613530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslchio4f.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703081405310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0703080558ye4cff44l88eb88d4911222a0@mail.gmail.com>
 <Pine.LNX.4.63.0703081811360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:44:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPPSy-0008S3-Ht
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 21:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933127AbXCHUnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 15:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933114AbXCHUno
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 15:43:44 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:46197 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933127AbXCHUnn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 15:43:43 -0500
Received: from [127.0.0.1] ([209.168.216.145])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JEL00GC4QW66P00@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 08 Mar 2007 14:43:21 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0703081811360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41772>

Johannes Schindelin wrote:
> IIRC there was a problem when a file was detected to be text, but 
> continued to be binary. Mark?
>
> Ciao,
> Dscho
>
>   
The problem occurs with constructs like

echo "some text stuff"  > file
echo "some binary stuff" >> file

The second write, being an append, ends up executed in a forked process 
where file was opened by the parent, and unfortunately auto-detected as 
a text file, such that the write from the child process ends up mangling 
any crlf in the stream. This occurs regardless of the defined mount type 
and other cygwin flags. It is definitely a bug, but is attributed to 
looseness in POSIX with noone claiming ownership to fix.

However, the above bug is not triggered in the construct mentioned by Junio.

Mark
