From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2
Date: Sat, 6 May 2006 14:51:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605061442490.16343@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
 <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
 <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE> <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
 <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE> <Pine.LNX.4.64.0605061008340.16343@g5.osdl.org>
 <7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat May 06 23:51:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcUgN-0005rt-7i
	for gcvg-git@gmane.org; Sat, 06 May 2006 23:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWEFVvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 17:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWEFVvO
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 17:51:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932081AbWEFVvO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 17:51:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k46Lp6tH030032
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 May 2006 14:51:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k46Lp5rJ007103;
	Sat, 6 May 2006 14:51:06 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19673>



On Sat, 6 May 2006, Johannes Schindelin wrote:
> 
> It was done because the very syntax of the config suggests it be a 
> user-editable file.

Yeah, I personally much prefer user-friendly config files. Any format that 
thinks that "easy parsing" is more important than "visually obvious" is 
bad. So I obviously think that XML is a horrid piece of cr*p (has anybody 
ever noticed I have strong opinions?) and totally unreadable.

I think "git repo-config" is doing a reasonable job of editing a file that 
is really designed to be user-friendly. That said, the code _is_ a bit 
scary.

It might be worthwhile to re-write config.c to read the config file into 
memory and work on it in-memory instead of doing the funky mixed usage 
(using fgetc/ftell to read it, but then switching over to mmap when 
rewriting it).

IOW, maybe that "static FILE *config_file" should be changed to something 
more like "static const char *config_buffer; unsigned int len;" instead, 
and at least make both the reading and writing use the same buffer rather 
than mixing stdio and mmap..

		Linus
