From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-annotate - leaking hundrets of megabytes
Date: Tue, 23 Oct 2007 11:14:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231108150.30120@woody.linux-foundation.org>
References: <471E28B2.7020508@imendio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Herzberg <sven@imendio.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 20:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkOHR-0004Px-7j
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 20:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbXJWSOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbXJWSOy
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 14:14:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57698 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752145AbXJWSOx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 14:14:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NIEgs3030687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 11:14:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NIEfRR032308;
	Tue, 23 Oct 2007 11:14:42 -0700
In-Reply-To: <471E28B2.7020508@imendio.com>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62144>



On Tue, 23 Oct 2007, Sven Herzberg wrote:
> 
> In my example, it used up to 450MB:
> http://people.imendio.com/~sven/massif.18740.png
> 
> Reproduce:
> 1. git clone git://git.webkit.org/WebKit.git
> 2. cd WebKit/WebCore
> 3. git-annotate --incremental ChangeLog

Hmm. I'm not seeing this at all. I do

	/usr/bin/time git-annotate --incremental ChangeLog > /dev/null

in WebCore, and it returns

	0.16user 0.01system 0:00.18elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+8365minor)pagefaults 0swaps

where that minor pagefault count is a good estimate of total memory used. 
8365 minor page faults implies it only ever got 32MB of memory total.

What git version do you have, or did you perhaps mean some other file or 
other config that causes this?

(It does end up using lots more memory if you ask for "-C" to see if there 
are copies from other sources, but even then I'm not seeing anything 
close to 450MB!)

			Linus
