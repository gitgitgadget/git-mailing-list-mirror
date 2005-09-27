From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 08:34:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509270821590.3308@g5.osdl.org>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
 <20050926212536.GF26340@pasky.or.cz> <4338F3F6.8040401@michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 17:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKHTX-0008RJ-Iy
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 17:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVI0Ped (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVI0Ped
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 11:34:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964973AbVI0Pec (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 11:34:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8RFYN4s023249
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Sep 2005 08:34:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8RFYM62017284;
	Tue, 27 Sep 2005 08:34:23 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <4338F3F6.8040401@michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9399>



On Tue, 27 Sep 2005, Ryan Anderson wrote:
> 
> git-rev-parse $tagname^0

You need "--verify". Otherwise git-rev-parse will think that you just have 
a strange filename or other random thing:

	prompt$ git-rev-parse 000^0
	000^0

	prompt$ git-rev-parse --verify 000^0
	fatal: Needed a single revision

Now, if the tag doesn't point to a commit, then the "^0" thing will fail. 
What you could use instead is

	git-rev-list --max-count=1 "$tag"

since git-rev-list will actually follow the tag. Of course, whether it 
does so correctly or not if the tagged object doesn't exist, I dunno. 
Testing needed.

Finally, you might just do it by hand

	type=$(git-cat-file -t "$obj") || exit
	if [ "$type" == "$tag" ]; then
		tagged=$(git-cat-file tag "$obj" |
			sed 's/object // ; q')
		git-rev-parse --verify "$tagged"
	fi

untested, of course.

		Linus
