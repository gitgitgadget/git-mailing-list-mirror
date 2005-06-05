From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git full diff output issues..
Date: Sun, 5 Jun 2005 08:11:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506050806400.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
 <Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org> <7v64x5bt9n.fsf@assigned-by-dhcp.cox.net>
 <7vu0kd42dm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 17:07:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dewi0-0002R6-T6
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 17:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFEPJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFEPJs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 11:09:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:4026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261588AbVFEPJH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 11:09:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j55F8wjA028981
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 08:08:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j55F8v5r010347;
	Sun, 5 Jun 2005 08:08:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0kd42dm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 5 Jun 2005, Junio C Hamano wrote:
> 
> The case you mentioned (i.e. /dev/null) is fine but rename/copy
> is "broken" according to the definition by git-apply.

No problem, the renames always get the names from the "rename" line, not 
the header. Same goes for copies.

It's only modified files that keep the same name _and_ the same content 
that don't have the name uniquely on a line somewhere.

> What do you want the diff-patch format to say for this one?
> 
>     :100644 100644 SHA1-OLD SHA1-NEW R frotz.c nitfol.c
> 
> Currently I am saying:
> 
>     diff --git a/frotz.c b/nitfol.c
>     similarity index 89%
>     rename old frotz.c
>     rename new nitfol.c
>     --- a/frotz.c
>     +++ b/nitfol.c

This finds the old names unambiguously in _two_ places: in the "--- " line 
(no question about where it begins: it's -p1, or where it ends - at the 
newline) _and_ on the "rename old xxxx" line.

The only case that was special was literally the "same name, no content 
changes, new mode" case, which looked like

	diff --git a/oldname.c b/oldname.c
	new mode 100755
	old mode 100644

and thus _only_ had the name in the (normally ambiguous wrt whitepsace)  
header line.

But by having the requirement that the format of the header line for that
case is "-p1" together with both names being the same, it's not ambigious 
any more.

		Linus
