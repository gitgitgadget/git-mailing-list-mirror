From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 08:03:04 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com>  <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>  <877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain> 
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net>  <7vbphaquwl.fsf@alter.siamese.dyndns.org> <20100104064408.GA7785@coredump.intra.peff.net>  <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:03:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpOp-0003Lh-2Y
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0ADQDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464Ab0ADQDQ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:03:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53091 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753463Ab0ADQDP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 11:03:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04G34xu004873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jan 2010 08:03:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04G34UM003425;
	Mon, 4 Jan 2010 08:03:04 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.447 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136121>



On Tue, 5 Jan 2010, Miles Bader wrote:

> On Tue, Jan 5, 2010 at 12:54 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > And "perf record" followed by "perf report" on the internal one shows
> > that it's not even regexec() - we use strstr() for the trivial case:
> 
> Does strstr use e.g. boyer-moore?  I imagine grep does...

It doesn't matter. Since we do the line-by-line thing, the input is always 
so short that DFA vs NFA vs BM vs other-clever-search doesn't matter. 
There is no scaling - the grep buffer tends to be too small for the 
algorithm to matter.

And the reason we do things line-by-line is that we need to then output 
things line-per-line.

			Linus
