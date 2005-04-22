From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on ia64 linux tree
Date: Fri, 22 Apr 2005 15:34:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221521260.2344@ppc970.osdl.org>
References: <200504222203.j3MM3fV17003@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 23 00:28:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6cy-0000dF-BE
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVDVWch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVDVWch
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:32:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261247AbVDVWcf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:32:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MMWXs4011223
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 15:32:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MMWWOS016771;
	Fri, 22 Apr 2005 15:32:33 -0700
To: tony.luck@intel.com, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <200504222203.j3MM3fV17003@unix-os.sc.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Apr 2005 tony.luck@intel.com wrote:
> 
> "git log" seems to have problems interpreting the dates ... looking at the
> commit entries, the time is right ... but it appears that git log applies
> the timezone correction twice, so the changes I just applied at 14:46 PDT
> look like I made them at quarter to five tomorrow morning (+14 hours from
> when I did).

Looks like you are right.

The seconds are already in UTC format, so I think "git log" is wrong to 
pass the UTC seconds in to "date", and then tell date that it was done in 
the original timezone.

I think it would be nice to use the TZ data to show the thing in the 
timezone of the committer, though. Dunno how to do that, maybe something 
like

	TZ=$tz date -d "1970-01-01 + $sec sec"

or whatever. Sadly, it looks like "date" doesn't understand timezone 
syntax like that - looks like TZ has to be in the long machine-unreadable 
format like "US/Pacific" etc. Stupid (either TZ or me - maybe I just 
don't know what the right format is).

		Linus
