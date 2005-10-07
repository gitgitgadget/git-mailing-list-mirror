From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Show original and resulting blob object info in diff
 output.
Date: Thu, 6 Oct 2005 21:47:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510062139560.31407@g5.osdl.org>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510042155090.31407@g5.osdl.org> <7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510050725510.31407@g5.osdl.org> <7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
 <m1mzln9zi1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
 <m1y8575i9y.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0510060731560.31407@g5.osdl.org>
 <m1wtkqk89a.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0510060756060.31407@g5.osdl.org>
 <7vachm5a4w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 06:50:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENk9P-0005Ru-3U
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 06:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVJGEsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 00:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVJGEsE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 00:48:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932116AbVJGEsC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 00:48:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j974lv4s013420
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Oct 2005 21:47:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j974lu7q005845;
	Thu, 6 Oct 2005 21:47:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vachm5a4w.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9795>



On Thu, 6 Oct 2005, Junio C Hamano wrote:
> 
>     diff --git a/apply.c b/apply.c
>     old index 7be50413538868412a87c847f8fa184cadd0fa2a 100644
>     new index 83660822fcbb9edac523634999e30d65c2790cae 100644

Hmm.. It strikes me that if we don't have the SHA1 object, then the SHA1 
is largely useless except as a verification of the thing (ie we can still 
_calculate_ the blob sha of whatever the current file is).

And if we _do_ have the SHA1, then we don't actually need all of it.

So the above is just very ugly, but it would be equally useful if it just 
had a partial SHA1 - still plenty good to identify the thing.

IO, why not make it shorter ans prettier and just make it be

	index 7be50413538868412a87..83660822fcbb9edac523

which is basically the first 20 hex digits of each SHA1.

Still plenty good to look up the object if we have it, and _certainly_ 
good enough as a quick verification. And much less "imposing".

The thing is, I actually tend to look at diffs when I send stuff out or 
receive them, and your one is just very ugly:

> applies-to: 8cf0bb652ffde36e57bca5d6f33287305a61bb74
> 2c48a811a36ee6e12aeb044b3d1ff459b8d958c2
> diff --git a/apply.c b/apply.c
> old index 7be50413538868412a87c847f8fa184cadd0fa2a 100644
> new index ed2eac2c67dd003c8a0eaa7325e1543d1472777d 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -14,6 +14,7 @@

That's a _lot_ of very "solid" unreadable stuff. It makes my eyes water. 
I'd really like to minimize it.

If you want the "applies-to" etc, then _all_ of it could be just crammed 
onto just one line (just cut each SHA1 down to 10 hex characters: 40 bits 
is still _way_ enough to indicate a unique version of a particular file if 
we have it, even if it's "just" a quarter of the full name. It's not 
like this is meant to be cryptographic. In fact, I bet 20 bits would be 
plenty).

		Linus
