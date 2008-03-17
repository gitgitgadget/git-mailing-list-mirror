From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible Solaris problem in 'checkout_entry()'
Date: Mon, 17 Mar 2008 08:37:09 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803170832280.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803170756390.3020@woody.linux-foundation.org> <118833cc0803170823q1e1e29a9p18b9a41f6975e268@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 16:39:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbHQZ-0001Ac-B8
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbYCQPiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYCQPiY
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:38:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51384 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751167AbYCQPiY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2008 11:38:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HFcJAX016670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2008 08:38:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2HFb9iv018749;
	Mon, 17 Mar 2008 08:37:10 -0700
In-Reply-To: <118833cc0803170823q1e1e29a9p18b9a41f6975e268@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-103.3 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77441>



On Mon, 17 Mar 2008, Morten Welinder wrote:
>
> >                 unlink(path);
> 
> And checking the result from unlink might not hurt either.

Well, that part is actually intentional. We simply don't care. If the 
unlink succeeds, we're happy, if it fails, we're happy. No reason to test, 
really.

(Well, it's not that we're "happy" if the unlink fails, but we actually 
_expect_ it to fail for directories, and regardless of that we're really 
doing the _real_ error handling later when we actually create the new 
entry that will replace the old one, so we don't much care at unlink 
time).

IOW, the real "checking" is taking place in "create_file()", so if the 
unlinking failed (due to a read-only directory or something), that's where 
we'll do the proper error reporting.

		Linus
