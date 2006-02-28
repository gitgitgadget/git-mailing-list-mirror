From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fatal: unexpected EOF
Date: Tue, 28 Feb 2006 07:34:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602280731210.22647@g5.osdl.org>
References: <440449D7.3010508@didntduck.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 16:36:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE6sV-0006Lc-A9
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 16:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWB1Pex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 10:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWB1Pex
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 10:34:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932249AbWB1Pew (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 10:34:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1SFYoDZ026727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Feb 2006 07:34:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1SFYnAh015708;
	Tue, 28 Feb 2006 07:34:49 -0800
To: Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <440449D7.3010508@didntduck.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16939>



On Tue, 28 Feb 2006, Brian Gerst wrote:
>
> Lately I've been receiving this error frequently from git.kernel.org:
> 
> Fetching pack (head and objects)...
> fatal: unexpected EOF
> cg-fetch: fetching pack failed
> 
> What is causing this?

Almost any error will cause the pack sending to abort, and the git:// 
protocol only opens a single socket for data, so there is no way for the 
other end to say _what_ failed.

With git.kernel.org, I suspect the reason for the failure is almost always 
the same, though: the mirroring is not complete, so it doesn't have all 
object files. The mirroring from master.kernel.org to the actual public 
machines is just a rsync script, so there's no atomicity guarantees.

That said, it might be a load issue too - I don't know what limits 
Peter & co put on the git daemons, and it might also be that it's set up 
to accept at most <n> connections and will close anything else.

		Linus
