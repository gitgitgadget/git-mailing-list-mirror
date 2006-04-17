From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fixes for option parsing
Date: Sun, 16 Apr 2006 19:42:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161938070.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 04:42:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVJhX-0002oq-AW
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 04:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWDQCmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 22:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWDQCmf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 22:42:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbWDQCmf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 22:42:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3H2gUtH023489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 19:42:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3H2gUVJ024173;
	Sun, 16 Apr 2006 19:42:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18812>



On Sun, 16 Apr 2006, Junio C Hamano wrote:
> 
> In the mid-term, I am hoping we can drop the generate_header()
> callchain _and_ the custom code that formats commit log in-core,
> found in cmd_log_wc().

Maybe. I'm not convinced, though. The reason? cmd_log_wc needs to generate 
it regardless, for the "always" case.

Also, I think the "---" printing should be removed, and moved into the 
"diffstat" flushing code. Right now it does the wrong thing entirely if no 
diff exists, but we have always_show_header: it will print the "---" for 
no good reason. 

> I wish this "diff-tree SHA1 (from ANOTHERSHA1)" format can be
> dropped and replaced with "commit SHA1" format like "git log"
> does uniformly, but it might be already depended upon by
> Porcelains.

I think it might be worth just trying. A lot of the formats were pretty 
ad-hoc, and since everybody had their own routines, there was no reason to 
even try to keep them similar. Now, we'd be better off trying to make them 
look as close to each other as possible, and I suspect there's not a lot 
of porcelain that cares deeply about that format..

		Linus
