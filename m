From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 21:48:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112141310.17536@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
 <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
 <m1irzh74m0.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110928070.17536@g5.osdl.org>
 <m13bqk26pp.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507111810380.17536@g5.osdl.org>
 <m164vg7nqo.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507112018560.175
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 06:49:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsChQ-0000CZ-CG
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 06:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVGLEsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 00:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVGLEsr
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 00:48:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262341AbVGLEsq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 00:48:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C4mfjA022561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 21:48:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C4mewM022423;
	Mon, 11 Jul 2005 21:48:41 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1wtnw66cc.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> 
> Looking closer it appears that commit_list_insert is recursive
> and that is what I missed.

Actually, it's "pop_most_recent_commit()" that ends up being the
"recursive" part: it will pop the top-most entry, but as it is popping it 
it will push the parents of that entry onto the same list.

So basically, you can get a list of all history by first inserting the top 
entry, and then doing "pop_most_recent_commit()" until the list is empty.

Now, git-rev-list ends up being slightly more complex than that, since it
has support for multiple starting points, and marking commits (and thus
their parents) uninteresting, and two other sorting methods in addition to 
the default "by date" thing.

And then there's all the issues about tags, trees and blobs, and their
visibility as a function of the commits that are visible and the command
line arguments..

In fact, it turns out that git-rev-list is really the real heart of "git".  
Almost everything else revolves around it. Once you grok git-rev-list, you
probably really grok git.

			Linus
