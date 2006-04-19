From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 21:14:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604182108070.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
 <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181836400.3701@g5.osdl.org>
 <7v8xq2ciws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 06:14:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW44x-0000X7-MZ
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 06:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWDSEOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 00:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWDSEOI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 00:14:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWDSEOG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 00:14:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J4E2tH002247
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 21:14:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J4E1NY008375;
	Tue, 18 Apr 2006 21:14:02 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xq2ciws.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18906>



On Tue, 18 Apr 2006, Junio C Hamano wrote:
> 
> A small fry in the ointment.  What should the parts that are
> output with --name-only say for such a diff?

I have no idea, I have to say ;)

> Blob references like v0.99.6:git-commit-script are resolved by
> the extended SHA1 interpreter, and all what the caller of
> setup_revisions() can see and feed the diff machinery with has
> are their object names.

Actually, the names are there. The object list has the "->name" field 
(used to do the name-based sorting), and we actually even fill it in for 
the stuff we pass in as arguments. See the "add_pending_object()" calls 
in setup_revisions().

We just don't use them right now. We _could_.

> Something like this is a possibility, but is ugly.
> 
>         diff --git a/a2455b0... b/01c73bd...
>         index a2455b0..01c73bd 100644
>         --- a/a2455b0...
>         +++ b/01c73bd...

Yes. But if you look at the object list name (in the "pending_object" 
thing), you _could_ actually get this to be something like

	diff --git v0.99.6:git-commit-script git-commit.sh
	index a2455b0..01c73bd 100644
	--- v0.99.6:git-commit-script
	+++ git-commit.sh

which would be much prettier, although I'm not saying it's necessarily 
worth it. I'm just saying that it's _possible_ with the cmd line parsing 
infrastructure we have now.

		Linus
