From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [Linus Torvalds] Re: [RFH] index_name_exists() conversion
Date: Thu, 21 Feb 2008 20:00:48 +0100
Message-ID: <98AF5144-5FA8-4465-B128-9146FA53681B@ai.rug.nl>
References: <7v63wiuqdq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Dane Jensen <careo@fastmail.fm>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 20:01:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSGfe-0007HZ-VA
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 20:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbYBUTAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 14:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYBUTAv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 14:00:51 -0500
Received: from smtp-4.orange.nl ([193.252.22.249]:40302 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbYBUTAv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 14:00:51 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6306.orange.nl (SMTP Server) with ESMTP id 4292E700008D
	for <git@vger.kernel.org>; Thu, 21 Feb 2008 20:00:49 +0100 (CET)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6306.orange.nl (SMTP Server) with ESMTP id DE69C7000084;
	Thu, 21 Feb 2008 20:00:48 +0100 (CET)
X-ME-UUID: 20080221190048911.DE69C7000084@mwinf6306.orange.nl
In-Reply-To: <7v63wiuqdq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74642>


On Feb 21, 2008, at 7:16 PM, Junio C Hamano wrote:

> This was posted to the list.  Could you try to see if this fixes
> the issue for you?
>
> Date: Thu, 21 Feb 2008 09:00:55 -0800 (PST)
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> Ahh. I think I may have found it.
>
> See if this fixes it.
>
> +	ce->next = NULL;

Unfortunately this did not fix it (I applied this on 'next'). Below is  
the GDB output again, so Linus can see it too.

- Pieter

Vienna:Project pieter$ gdb --args git status
[...]
Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x004a2010
index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/ 
Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c:102
102			if (!(ce->ce_flags & CE_UNHASHED)) {
(gdb) print *ce
Cannot access memory at address 0x4a1fec
(gdb) bt
#0  index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/ 
Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c:102
#1  0x0006fc04 in dir_add_name (dir=0xbfffef68, pathname=0xbfffdc27  
"Data/Cache/Template/Peter_II_of_Yugoslavia.html", len=47) at dir.c:374
#2  0x00070d11 in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>,  
baselen=20, check_only=0, simplify=0x8072cc) at dir.c:642
#3  0x00070baf in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>,  
baselen=11, check_only=0, simplify=<value temporarily unavailable, due  
to optimizations>) at dir.c:627
#4  0x00070baf in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>, baselen=5,  
check_only=0, simplify=<value temporarily unavailable, due to  
optimizations>) at dir.c:627
#5  0x00070baf in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>, baselen=0,  
check_only=0, simplify=<value temporarily unavailable, due to  
optimizations>) at dir.c:627
#6  0x00070ed3 in read_directory (dir=0xbfffef68, path=0xc4470 ".",  
base=0xbb084 "", baselen=4857836, pathspec=0x0) at dir.c:715
#7  0x0009d4d6 in wt_status_print (s=0xbffff5ac) at wt-status.c:282
#8  0x000167b3 in run_status (fp=0xa015f5f8, index_file=0x500300 "/ 
Users/pieter/Documents/Studie/2007-2008/AWT/Project/.git/index",  
prefix=0x0, nowarn=4857836) at builtin-commit.c:347
#9  0x0001719f in cmd_status (argc=1, argv=0x0, prefix=0x500300 "/ 
Users/pieter/Documents/Studie/2007-2008/AWT/Project/.git/index") at  
builtin-commit.c:783
#10 0x00002250 in handle_internal_command (argc=1, argv=0xbffff7b8) at  
git.c:259
#11 0x0000245f in main (argc=1, argv=0xbffff7b8) at git.c:451
