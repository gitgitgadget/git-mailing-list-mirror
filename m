From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-add + git-reset --hard = Arrrggh!
Date: Wed, 17 May 2006 07:43:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170735540.10823@g5.osdl.org>
References: <20060517094526.GA8563@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 16:43:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgNFf-0001rD-2l
	for gcvg-git@gmane.org; Wed, 17 May 2006 16:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWEQOns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 10:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWEQOns
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 10:43:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932570AbWEQOnr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 10:43:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HEhZtH024547
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 07:43:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HEhYS7015317;
	Wed, 17 May 2006 07:43:34 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060517094526.GA8563@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20203>



On Wed, 17 May 2006, Shawn Pearce wrote:
> 
> Oh, and I totally agree with that discussion about GIT not clobbering
> files the user is working on which the user can't easily recover.
> I just wish recovery from the above stupidity didn't require going
> through .git/objects looking for the newest file.  :-)

It doesn't.

Just do "git fsck-objects". It should have said

	dangling blob <sha1>

and you can just do

	git cat-file blob <sha1> > missing-file-name

and you're done.

That said, I think we should make everybody very aware of just how a 
_dangerous_ operation "git reset --hard" is. It does delete your work. On 
purpose. The fact that you can sometimes get it back doesn't change 
anything. 

(And I say "sometimes", because you'll obviously have lost all the 
modifications that are only in your working tree - both to any added files 
and to any old-time files. That's the _point_ of it, after all).

The default for "git reset" is to _not_ do any modifications in the 
working tree. And there's a reason that's a default ;)

			Linus
