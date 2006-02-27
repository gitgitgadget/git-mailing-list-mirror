From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 09:19:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602270909500.22647@g5.osdl.org>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com> 
 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org> 
 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com> 
 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
 <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 18:20:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDm2M-000159-0Y
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 18:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWB0RTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 12:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWB0RTm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 12:19:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751510AbWB0RTl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 12:19:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1RHJbDZ029911
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 09:19:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1RHJZ5x030736;
	Mon, 27 Feb 2006 09:19:36 -0800
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16867>



On Tue, 28 Feb 2006, Aubrey wrote:
> 
> =================================================================
> aubrey@linux:/checkout/uboot/patch/work/drivers> git diff
> ----snip----
> diff --git a/drivers/sk98lin/skxmac2.c b/drivers/sk98lin/skxmac2.c
> diff --git a/drivers/sk98lin/u-boot_compat.h b/drivers/sk98lin/u-boot_compat.h

Ok, this is _definitely_ your index being out of touch with your file 
contents.

Run "git-update-index --refresh" and it should be ok.

Now the question is why the index got out-of-kilter with the file contents 
in the first place. I used to have all these debug aids to show why git 
thought a file had changed, but we've not had any bugs here for a long 
long time, so..

The final checkout of the "git clone" should have made sure that the index 
is up-to-date.

> >         git clone remote-repo localdir
> >         cd localdir
> >         vi somefile
> >         git diff
>
> Yes, exactly right.
> 
> > then you did everything right, and if it gives any diff other than your
> > changes to "somefile", something is buggy. Need more info.
> >
> > Does "git diff" and "git diff HEAD" give different results, btw?
> 
> Yes. the two commands give the same results.
> 
> I'm using git-1.2.3

What OS/filesystem? 

The way the index keeps track of files that haven't changed is by checking 
the size, the mtime and the ctime of the inode. It also checks the 
user/gid and inode number. If you use a filesystem where those might 
change (networked?), that might cause this..

		Linus
