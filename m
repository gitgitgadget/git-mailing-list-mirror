From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Fix quadratic performance in rewrite_one.
Date: Sat, 12 Jul 2008 15:55:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807121550320.2959@woody.linux-foundation.org>
References: <200807122200.58187.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Alexander N. Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 00:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHo18-0005v0-HX
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 00:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbYGLWzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 18:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbYGLWzk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 18:55:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33957 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089AbYGLWzk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2008 18:55:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6CMtSLO016908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jul 2008 15:55:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6CMtRBI025496;
	Sat, 12 Jul 2008 15:55:27 -0700
In-Reply-To: <200807122200.58187.angavrilov@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.896 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88274>



On Sat, 12 Jul 2008, Alexander N. Gavrilov wrote:
>
> Parent commits are usually older than their children. Thus,
> on each iteration of the loop in rewrite_one, add_parents_to_list
> traverses all commits previously processed by the loop.
> It performs very poorly in case of very long rewrite chains.

Good call, but you don't seem to invalidate the cache when we remove 
things from the list.

The top of the limit_list() loop does that "get top entry from list, an 
free it", and I'm not seeing you invalidating the cache if that entry that 
just got free'd happened to be the cache entry?

Or did I miss some reason why that couldn't happen? 

		Linus
