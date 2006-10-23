From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 11:45:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231134450.3962@g5.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <200610232021.55625.jnareb@gmail.com>
 <1161628001.27312.8.camel@charis.lan.vernstok.nl> <200610232031.12399.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jelmer Vernooij <jelmer@samba.org>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:47:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4oj-0006ev-IC
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWJWSqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWJWSqX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:46:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965023AbWJWSqW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 14:46:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NIjHaX030682
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 11:45:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NIjDFk001439;
	Mon, 23 Oct 2006 11:45:14 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610232031.12399.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.477 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29859>



On Mon, 23 Oct 2006, Jakub Narebski wrote:
> 
> The place for timestamp and commiter info is in the revision metadata
> (in commit object in git). Not in revision id. Unless you think that
> "accidentally the same" doesn't happen...

Well, git and bzr really do share the same "stable" revision naming, 
although in git it's more indirect, and thus "covers" more.

In git, the revision name indirectly includes the commit comments too (and 
git obviously also distinguishes between "committer" and "author", and 
those end up being indirectly credited in the name of the commit too). But 
in a very real sense, the bzr stable ("real") revision name does 
effectively contain the same things as a git ID: it's just that it's a 
small subset (only committer+date+random number) of what git includes in 
its names.

So you could more easily _fake_ a commit name in bzr, and depending on how 
things are done it might be more open to malicious attacks for that reason 
(or unintentionally - if two people apply the exact same patch from an 
email, and take the author/date info from the email like hit does, you 
might have clashes. But with a 64-bit random number, that's probably 
unlikely, unless you also hit some other bad luck like having the 
pseudo-random sequence seeded by "time()", and people just _happen_ to 
apply the email at the exact same second).

The git use of hashes and parenthood information make any accidental 
clashes like that a non-issue: if you have exactly the same information, 
it really _is_ the same commit, since the hash includes the parenthood 
too. So you're left with just malicious attacks, and those currently look 
practically impossible too, of course.

So I don't think bzr and git differ in this respect. I think you can 
_trust_ stable git names a lot more, but that's a separate issue.

			Linus
