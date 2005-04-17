From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] update-cache --refresh cache entry leak
Date: Sat, 16 Apr 2005 20:35:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504162033250.7211@ppc970.osdl.org>
References: <7v8y3i5o8t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 05:30:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN0Td-0001ft-5w
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 05:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVDQDdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 23:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDQDdS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 23:33:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:52367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261244AbVDQDdP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 23:33:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3H3X9s4002889
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 20:33:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3H3X90F005497;
	Sat, 16 Apr 2005 20:33:09 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y3i5o8t.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Junio C Hamano wrote:
>
> When update-cache --refresh replaces an existing cache entry
> with a new one, it forgets to free the original.

I've seen this patch now three times, and it's been wrong every single 
time. Maybe we should add a comment?

That active-cache entry you free()'d was not necessarily allocated with 
malloc(). Most cache-entries are just mmap'ed directly from the index 
file.

Leaking is ok. We cannot leak too much.

		Linus
