From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Tue, 29 Apr 2008 08:17:27 +0200
Message-ID: <4816BD77.1060709@op5.se>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:18:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqjAU-0002gd-1S
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbYD2GRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbYD2GRa
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:17:30 -0400
Received: from mail.op5.se ([193.201.96.20]:48331 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbYD2GRa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:17:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1DCF11F0807D;
	Tue, 29 Apr 2008 08:17:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UeymMJYRZH51; Tue, 29 Apr 2008 08:17:31 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 4266F1F08063;
	Tue, 29 Apr 2008 08:17:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <20080428182917.GA4794@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80650>

Mike Hommey wrote:
> On Mon, Apr 28, 2008 at 08:21:14PM +0200, Miklos Vajna wrote:
>> On Mon, Apr 28, 2008 at 07:08:50PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>>> With rotating logs, there is a problem when the syslog is opened only 
>>>>> once (in the beginning).  So open the log everytime we write 
>>>>> something, and close it directly after writing.
>>>> Gaah, this is ugly.
>>>>
>>>> Is this something all the daemons need to deal with?
>>> I have no idea, but it seems to fix a real issue.
>> logrotate supports sending a signal (typically SIGHUP) to the process
>> after it rotated the log. Couldn't we just re-open the log on SIGHUP?
> 
> Isn't the problem that git-daemon loses its connection to the syslog
> daemon when logrotate sighups syslog?
> 

It really shouldn't. The connection to the syslog daemon is just a
unix socket (/dev/log) which is used to send whatever passes for
UDP packets on unix domain sockets. Since the socket isn't re-created
by syslogd (well, a sane syslogd anyways), but rather just open()'ed
for reading, no program should ever need to reconnect.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
