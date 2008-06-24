From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/7] parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
Date: Tue, 24 Jun 2008 10:18:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806241015390.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org>
 <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <1214298732-6247-7-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBCCo-0005nu-49
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761584AbYFXRU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760410AbYFXRUZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:20:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45514 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758460AbYFXRUW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 13:20:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OHIvcx019139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 10:18:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OHIu8Y029791;
	Tue, 24 Jun 2008 10:18:56 -0700
In-Reply-To: <1214298732-6247-7-git-send-email-madcoder@debian.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.851 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86093>



On Tue, 24 Jun 2008, Pierre Habouzit wrote:
>
> This way, argv[0] isn't clobbered, to the cost of maybe not having a
> resulting NULL terminated argv array.

Umm. I think it's much easier to do by always having

	ctx->out  = argv;

and then just initializing cpix to 0 or 1:

	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);

because now parse_options_end() doesn't need to play games any more. It 
doesn't need to care about PARSE_OPT_KEEP_ARGV0, it can just do exactly 
what it always used to do, because "ctx->cpidx + ctx->argc" automatically 
does the right thing (it is both the return value _and_ the index that you 
should fill with NULL.
	
Hmm?

		Linus
