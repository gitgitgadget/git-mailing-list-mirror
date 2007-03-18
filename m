From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 16:18:54 +0000
Organization: Mandriva
Message-ID: <20070318161854.5a6a34e0@home.brethil>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	<20070316104715.483df0d5@localhost>
	<20070316140855.GE4489@pasky.or.cz>
	<20070316153822.5c842e69@localhost>
	<20070316231646.GB4508@spearce.org>
	<20070317195832.2af87c06@home.brethil>
	<20070318052332.GC15885@spearce.org>
	<7vzm6bp07f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 17:16:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSy3G-0004SS-Nw
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 17:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbXCRQQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 12:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbXCRQQI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 12:16:08 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:59835 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbXCRQQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 12:16:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 2292A2AE7A;
	Sun, 18 Mar 2007 13:16:04 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id wFPL5ECfIV3q; Sun, 18 Mar 2007 13:15:59 -0300 (BRT)
Received: from home.brethil (unknown [189.4.51.23])
	by perninha.conectiva.com.br (Postfix) with ESMTP id BD0052AE78;
	Sun, 18 Mar 2007 13:15:58 -0300 (BRT)
In-Reply-To: <7vzm6bp07f.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42504>

On Sat, 17 Mar 2007 22:52:52 -0700
Junio C Hamano <junkio@cox.net> wrote:

| "Shawn O. Pearce" <spearce@spearce.org> writes:
| 
| > Take a look at sha1_file.c, open_packed_git_1:
| >
| > ...
| >     if (!pack_version_ok(hdr.hdr_version))
| >         return error("packfile %s is version %u and not supported"
| >             " (try upgrading GIT to a newer version)",
| >             p->pack_name, ntohl(hdr.hdr_version));
| > ...
| >
| > Here we are supplying a lot more than just a simple error code
| > that can be mapped to a static string.
| >
| > Of course that code is currently feeding it to the error function,
| > which today calls the error_routine (see usage.c).  We could buffer
| > the strings sent to error()/warn() and let the caller obtain all
| > strings that occurred during the last API call.
| 
| Actually, since we are talking about the error path,
| 
|  (1) we do not care performance of what happens there that much, but
|  (2) we *do* care about not doing extra allocation.
| 
| So it might make sense to have a preallocated "error string"
| buffer, sprintf the error message in there and return error
| codes.

 Other possibility is to let the caller do the job.

 I mean, if the information needed to print the error message (packfile
name and version in this example) is available to the caller, or the
caller can get it someway, then the caller could check which error
he got and build the message himself.

 That seems simpler to me, considering the caller has the needed
info, of course...


-- 
Luiz Fernando N. Capitulino
