From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Do not use zlib 1.1.3 with git packs!
Date: Sat, 29 Apr 2006 03:47:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604290341380.22696@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604290245510.30565@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 29 03:47:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZeYd-0008Fg-8V
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 03:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWD2Br3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 21:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWD2Br3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 21:47:29 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44964 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751465AbWD2Br2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 21:47:28 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 607801C79
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 03:47:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 546E31C85
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 03:47:27 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 380A81C62
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 03:47:27 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0604290245510.30565@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19290>

Hi,

On Sat, 29 Apr 2006, Johannes Schindelin wrote:

> Upgrading to zlib 1.2.3 helped.

Apparently I was too enthusiastic to have a working system again.

The problem showed again, but with a different repository.

This time, though, I have an idea what could be the culprit.

In create_delta(), there might be illegal accesses. The function adler32() 
is called for BLK_SIZE bytes (which is 16 bytes at the moment), starting 
from data, which is initially trg_buf, and is incremented until it is 
(trg_buf + trg_size).

I gather that close to the end, adler32() tries to read 15 bytes after the 
end of the allocated target buffer.

Am I wrong?

Ciao,
Dscho
