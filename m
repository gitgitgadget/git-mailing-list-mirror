From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] git-imap-send: Add method to convert from LF to
 CRLF
Date: Tue, 9 Feb 2010 09:24:51 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1002090918180.3829@localhost.localdomain>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org> <1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:26:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Netr0-0005GH-23
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab0BIR0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 12:26:10 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41036 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755372Ab0BIR0I (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 12:26:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o19HOpLj017685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Feb 2010 09:24:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o19HOpgH023529;
	Tue, 9 Feb 2010 09:24:51 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.947 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139420>



On Tue, 9 Feb 2010, Hitoshi Mitake wrote:
>
> Some strict IMAP servers (e.g. Cyrus) don't
> allow "bare newlines ('\n')" in messages.
> So I added new boolean option "lf-to-crlf" to imap section.
> If this option enabled, git-imap-send converts LF to CRLF("\r\n").
> 
> If you want to use it, add line:
> 	lf-to-crlf
> to [imap] section of your .gitconfig .

Hmm. Should this even be an option? Maybe we should _always_ do CRLF. That 
does seem to be the technically correct thing to do for SMTP and IMAP.

rfc2822 (smtp) is pretty clear that CRLF is the line ending, and neither 
CR nor LF must ever be sent individually. That's true both for headers and 
the body of the email. The same goes for rfc3501 (imap).

So I suspect that CRLF should be unconditional.

		Linus
