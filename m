From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-add: make the entry stat-clean after re-adding the
 same contents
Date: Fri, 9 Nov 2007 18:43:07 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711091840120.15101@woody.linux-foundation.org>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
 <Pine.LNX.4.64.0711091702190.4362@racer.site> <7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
 <7vzlxmq1oj.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 03:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqgK4-0007xQ-Iw
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 03:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbXKJCnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 21:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbXKJCnd
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 21:43:33 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52369 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752258AbXKJCnd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 21:43:33 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA2hAVn006035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 18:43:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA2h707012966;
	Fri, 9 Nov 2007 18:43:09 -0800
In-Reply-To: <7vzlxmq1oj.fsf_-_@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.738 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64301>



On Fri, 9 Nov 2007, Junio C Hamano wrote:
>  
> -int run_diff_files(struct rev_info *revs, int silent_on_removed)
> +int run_diff_files(struct rev_info *revs, int option)

Wouldn't it be much better to now 
 - make it "unsigned int flags"
 - create a few enums or #define's to make the usage be more readable?

Because this:

>-       run_diff_files(&rev, 0);
>+       run_diff_files(&rev, 2);
> -	    !ie_modified(istate, istate->cache[pos], &st, 1)) {
> +	    !ie_match_stat(istate, istate->cache[pos], &st, 3)) {

just went from subtle to "incredibly non-obvious".

I realize that 3 is "silent + assume_racy" and 2 is just "assume_racy", 
but I may realize that now, and in a month? I'd need to look it up.

		Linus
