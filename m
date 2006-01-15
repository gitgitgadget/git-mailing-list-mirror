From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: what exactly is git-tag looking for when you try to sign a tag?
Date: Sun, 15 Jan 2006 12:02:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601151155520.13339@g5.osdl.org>
References: <200601151932.05342.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 21:02:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyE5F-0004wP-Sq
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 21:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWAOUCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 15:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWAOUCe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 15:02:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932128AbWAOUCe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 15:02:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0FK2SDZ016040
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Jan 2006 12:02:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0FK2Rd8021503;
	Sun, 15 Jan 2006 12:02:27 -0800
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200601151932.05342.alan@chandlerfamily.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14706>



On Sun, 15 Jan 2006, Alan Chandler wrote:
> 
> git-tag -s v1.0
> 
> and it complained that I don't have any secret key available.
> 
> What exactly is the process of making one available?

Do 

	gpg --list-secret-keys

to check what keys you have available to sign with.

Then, use

	git tag -u "key user name" v1.0

because what has _probably_ happened is that if you just use "-s" it will 
pick your "committer name" as the key identifier, and you probably made 
your keys using your real email or other identifier.

So "-u <username>" means the same thing as "-s", but with additionally 
specifying _which_ key it should use.

Alternatively, you should be able to just use "gpg --edit-key <keyname>" 
and then using "adduid" to add your git committer ID as a user of the key. 
At which point "git tag -s <tagname>" should just work, since gpg will be 
able to match up the keys automatically.

		Linus
