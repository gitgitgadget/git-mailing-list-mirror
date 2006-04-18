From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 11:47:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181139150.3701@g5.osdl.org>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org> <20060418175853.GA25688@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0604181104420.3701@g5.osdl.org> <20060418182650.GB25688@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1361547916-1145386073=:3701"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 20:48:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVvF0-0006v4-5E
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWDRSrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 14:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDRSrz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:47:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbWDRSrz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 14:47:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3IIlstH013682
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 11:47:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3IIlrcT021158;
	Tue, 18 Apr 2006 11:47:53 -0700
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20060418182650.GB25688@wohnheim.fh-wedel.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18871>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1361547916-1145386073=:3701
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 18 Apr 2006, Jörn Engel wrote:
> 
> But it appears as if I could "cp -lr" the git tree and work with that.

That should work. I just personally fear cowlinks, because some things 
will edit the files in place, and then you're screwed.

I _think_ it should be ok for the .git subdirectory, but quite frankly, 
I'm not going to guarantee it. Also, you will break the cow-linking when 
you ever re-pack either the source or the destination, so you'd actually 
be _better_ off with something that does

	# clone the git directories by hand, no checkout (-n).
	git clone -l -s -n src dst

	# cow-link the checked-out state
	(cd src ; git ls-files | cpio -pudml dst)

	# make sure to refresh the index
	git update-index --refresh

or something like that.

TOTALLY UNTESTED!!  (And you need to have made "dst" be an absolute path, 
of course, since we want it to work even after we've done the "cd src" 
thing).

		Linus
--21872808-1361547916-1145386073=:3701--
