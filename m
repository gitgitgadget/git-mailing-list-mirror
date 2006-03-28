From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cherry-pick particular object
Date: Tue, 28 Mar 2006 14:44:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603281435410.15714@g5.osdl.org>
References: <20060328113107.20ab4c21.sebastien@xprima.com>
 <BAYC1-PASMTP02B05019F52DE48793CB39AED30@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?S=E9bastien_Pierre?= <sebastien@xprima.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 00:44:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOMv5-0006uh-O6
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 00:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWC1WoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 17:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWC1WoI
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 17:44:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932472AbWC1WoG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 17:44:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2SMi3Co029123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Mar 2006 14:44:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2SMi2bi029361;
	Tue, 28 Mar 2006 14:44:03 -0800
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP02B05019F52DE48793CB39AED30@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18133>



On Tue, 28 Mar 2006, sean wrote:
> 
> $ git cat-file -t 78132af2643

Side note: when using git-ls-tree, the "blob"ness information is already 
in the tree output itself and you shouldn't even need to check the type 
with "-t". So what is perhaps somewhat more interesting is actually the 
mode of the file, since that determines whether the blob should be 
interpreted as regular file content or as a symlink.

Ie you can have a tree like this:

	100644 blob f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f    abc
	120000 blob f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f    file

where the first one is a regular file called "abc" (which contains the 
string "abc"), and the second is the _symlink_ that points to "abc".

They share the exact same blob, and what distinguishes them is the 
filemode info from git-read-tree.

Of course, the symlink case isn't very common and likely not very 
interesting in this case, but the fact that "git ls-files" is set up so 
that you can just cut-and-paste the "blob <sha1-of-blob" part and feed it 
to git-cat-file was definitely not just coincidence.

(A number of the early stuff was set up so that I could do things by hand 
by just doing cut-and-paste of the output of the previous command. Git has 
come a long way in the last 12 months ;)

		Linus
