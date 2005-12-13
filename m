From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: qgit reports errors in the git repository
Date: Mon, 12 Dec 2005 17:06:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512121700010.15597@g5.osdl.org>
References: <1134433440.3798.27.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Tue Dec 13 02:08:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elyd9-0004GN-2c
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVLMBG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVLMBGz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:06:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932318AbVLMBGy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 20:06:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBD16nDZ012433
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 17:06:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBD16liv027728;
	Mon, 12 Dec 2005 17:06:48 -0800
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1134433440.3798.27.camel@dv>
X-Spam-Status: No, hits=0.16 required=5 tests=HTML_MESSAGE
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13553>



On Mon, 12 Dec 2005, Pavel Roskin wrote:
>
> Git says:
> fatal: git-cat-file 23ea3e201cea0deea909569e08e950a9ec2345f7: bad file
> 
> I believe qgit runs "git-cat-file -t tag" on in, but it's a commit.  If
> I change the git-cat-file invocation in  src/git_startup.cpp to use
> "commit" instead of "tag", qgit complains about
> 0918385dbd9656cab0d1d81ba7453d49bbc16250.
> 
> Maybe qgit should check the type of the object first?  Or maybe there
> should another type for git-cat-file that would match both tag and
> commit?

Using "git-cat-file commit <object>" already works for both real commits 
and for tags that point to commits.

However, the "0918385dbd9656cab0d1d81ba7453d49bbc16250" object is a tag 
that points to a blob (Junios public gpg key), so you can't use that.

Basically, qgit should do either:

 - check the type of the object by hand first (using "git-cat-file -t" and 
   then follow any tags it finds by hand)

_or_ 

 - just use "git-cat-file commit" and if an error occurs, just silently 
   ignore that ref since it doesn't understand them.

which one is the right strategy depends on usage.

		Linus
