From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Make gitk use --early-output
Date: Sun, 4 Nov 2007 09:53:28 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711040947110.15101@woody.linux-foundation.org>
References: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
 <e5bfff550711040237s250bcec0iddf1ebdc616e0bbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 18:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IojfV-000078-Uk
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 18:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXKDRxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 12:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbXKDRxi
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 12:53:38 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54795 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037AbXKDRxi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 12:53:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA4HrTaU015382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Nov 2007 09:53:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA4HrS3D009893;
	Sun, 4 Nov 2007 09:53:28 -0800
In-Reply-To: <e5bfff550711040237s250bcec0iddf1ebdc616e0bbf@mail.gmail.com>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63422>



On Sun, 4 Nov 2007, Marco Costalba wrote:
> 
> But --early-output does not imply --topo-order, I guess...

Well, it does right now, because I imagined that the primary users would 
always want the topological sort.

However, I have to admit that --early-output *could* be used even without 
the topological sort, because it also works for other cases that require 
up-front limiter logic - things like ranges of commits also have to be 
fully evaluated before they are totally certain, so I could imagine seeing 
some visualizer some day that doesn't need the topo-order sort, but does 
want to get a "preliminary" list.

That said, it does seem unlikely. Anybody who asks for --early-output is 
pretty much invariably going to be an interactive visulizer: the whole 
notion doesn't make much sense otherwise. So I think I made the right 
choice in making --early-output imply topo-order, and if somebody ever 
wants to not get the output topologically sorted (unlikely), we could add 
a "--no-topo-order" flag.

Side note: if you want the "--date-order", you do need to specify *both* 
--early-output and --date-order, and it will do the right thing (ie both 
the preliminary output and the final one will be topologically sorted, but 
within that topo-sort it will be in date order rather than clumped by 
the "shape" of the history).

			Linus
