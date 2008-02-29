From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pretty format now configurable
Date: Fri, 29 Feb 2008 12:00:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802291155550.17889@woody.linux-foundation.org>
References: <1204314263-8072-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 21:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVBRA-0001kW-3i
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 21:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbYB2UBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 15:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbYB2UBz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 15:01:55 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:39488 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880AbYB2UBy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 15:01:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1TK0lCS005406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Feb 2008 12:00:48 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1TK0lqK018254;
	Fri, 29 Feb 2008 12:00:47 -0800
In-Reply-To: <1204314263-8072-1-git-send-email-crquan@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.119 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75554>



On Sat, 1 Mar 2008, Denis Cheng wrote:
>  
>  	rev->abbrev = DEFAULT_ABBREV;
> -	rev->commit_format = CMIT_FMT_DEFAULT;
> +	if (fmt_pretty)
> +		rev->commit_format = get_commit_format(fmt_pretty);

Umm. Now it looks like commit_format isn't initialized at all if 
fmt_pretty hasn't been set.

Now, it looks like it will have been initialized properly in 
"init_revisions()", but your commit log doesn't mention that, so it was 
harder to review this patch than necessary.

Also, can you describe what the background for this is? The reason I ask 
is that if anybody ever sets that default commit format to anythign else, 
it will now *seriously* confuse not just users but potentially other git 
tools too (at least gitk uses "--pretty=raw", but who knows what other 
tools/scripts are around that just expected the default format).

		Linus
