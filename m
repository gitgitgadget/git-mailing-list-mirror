From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] Bugfix for AIX tmpfile creation
Date: Mon, 23 Jun 2008 15:55:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231552510.2926@woody.linux-foundation.org>
References: <1214256821-3169-1-git-send-email-patrick.higgins@cexp.com> <7vy74vg4zq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Patrick Higgins <patrick.higgins@cexp.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:56:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuxy-0005Vc-5A
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbYFWWz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYFWWz6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:55:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37830 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbYFWWz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 18:55:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NMtpuT013705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 15:55:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NMtoau020418;
	Mon, 23 Jun 2008 15:55:50 -0700
In-Reply-To: <7vy74vg4zq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.844 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85949>



On Mon, 23 Jun 2008, Junio C Hamano wrote:
>
> Hmm, we have quite a few calls to mkstemp(), so adding the workaround to
> this specific call site does not scale well as a fix, I am afraid.

All other callers of mkstemp() always rewrite the _entire_ path and don't 
care about the result after failure (since it failed)

The new 'create_tmpfile()' usage was/is special in that it re-uses the 
path without recreating it all, just the final part.

So I think Patrick's patch is fine and sufficient. Maybe I missed some in 
my quick grep, but it does look ok, and the create_tmpfile() usage really 
was pretty special.

		Linus
