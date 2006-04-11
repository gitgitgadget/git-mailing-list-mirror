From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 11 Apr 2006 06:50:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604110645060.3722@g5.osdl.org>
References: <7v3bgk7mhy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 15:50:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTJGB-0004Bl-SY
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 15:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWDKNuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 09:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWDKNuV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 09:50:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750967AbWDKNuT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 09:50:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3BDoFtH017152
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Apr 2006 06:50:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3BDoEYn025557;
	Tue, 11 Apr 2006 06:50:15 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bgk7mhy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18611>



On Mon, 10 Apr 2006, Junio C Hamano wrote:
>
>       Retire git-log.sh
>       Retire git-log.sh (take#2)

I think you need a (take#3).

This creates "git-log" as a link to "git", but does so at _build_ time, 
not install time.

Which means that when it actually gets installed, it gets installed as a 
copy of that link, and you get two different executables instead of one 
single executable that is just linked to two names:

  [torvalds@g5 git]$ ls -li /home/torvalds/bin/git ~/bin/git-log
  67272830 -rwxr-xr-x 1 torvalds torvalds 333613 Apr 11 06:45 /home/torvalds/bin/git
  67272781 -rwxr-xr-x 1 torvalds torvalds 333613 Apr 11 06:45 /home/torvalds/bin/git-log

so it _works_, but it wastes 300kB+ for each "builtin". Which was kind of 
against the whole point.

I think the builtins should be a install-time only issue. 

		Linus
