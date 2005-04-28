From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Built-in diff driver shows Index: line.
Date: Thu, 28 Apr 2005 13:05:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281236090.18901@ppc970.osdl.org>
References: <7vy8b27lyf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 21:59:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRF9o-0001dl-St
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 21:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVD1UDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVD1UDm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 16:03:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:48100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262255AbVD1UDb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 16:03:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SK3Rs4003670
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 13:03:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SK3QfE005873;
	Thu, 28 Apr 2005 13:03:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8b27lyf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Junio C Hamano wrote:
>
> As suggested by Linus as a workaround to unconfuse diffstat,
> this patch adds Index: line before the diff output the built-in
> driver produces.

Actually, I do dislike the Index: line, and think this is a pretty
intrusive work-around for a problem with diffstat.

There are other work-arounds for diffstat. In particular, diffstat has 
various heuristics for finding the filename from the +++/--- files, and 
the main one is

	"*** %[^\t]\t%[^ ] %[^ ] %d %d:%d:%d %d"

(where "***" can be either +++ or ---). If if you match that one, diffstat
will pick up the name (first match) on its own.

Oh, actually maybe the better pattern to use is the one that GNU diff 
itself ends up matching:

	"*** %[^\t ]%[\t ]%d%c%d%c%d %d:%d:%d"

where the "%c" has to be either '-' or '/' (ie it ends up matching as 
"numeric date" + "numeric time").

You can put the "mode" thing at the end, and diffstat won't care about it.

		Linus
