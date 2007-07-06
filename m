From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Fri, 6 Jul 2007 10:59:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
 <7vejjnhpap.fsf@assigned-by-dhcp.cox.net> <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
 <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051223520.9789@racer.site>
 <7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:59:38 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6s5g-0005jg-VS
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 19:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761176AbXGFR7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 13:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759801AbXGFR7e
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 13:59:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54555 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757827AbXGFR7d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 13:59:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66HxP2q001546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2007 10:59:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66HxKC0011297;
	Fri, 6 Jul 2007 10:59:20 -0700
In-Reply-To: <7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-4.64 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51778>



On Fri, 6 Jul 2007, Junio C Hamano wrote:
>
> This makes"diff -p" hunk headers customizable via gitattributes mechanism.
> It is based on Johannes's earlier patch that allowed to define a single
> regexp to be used for everything.

Ok, I think this is really nice, but I do wonder a bit about the syntax.

In particular, the "funcname" thing is really a pretty ugly special-case 
approach.

Wouldn't it be nicer to consider the "funcname=java" to be less of a 
"special case for the built-in diff", and instead think of it as a more 
generic issue of "how do we want to generate diffs for java files?"

IOW, wouldn't this be much nicer to be thought about as a "custon diff 
driver" issue?

So I like your patches, but dislike the config syntax, and would suggest 
something like

In .gitattributes:

	*.java diff=java
	*.perl diff=perl
	*.doc diff=doc

In .git/config

	[diff "java"]
		command = internal
		funcname = ... # ugly and complicated regexp to override the built-in one.

	[diff "perl"]
		command = internal
		funcname = ...

	[diff "doc"]
		command = ms-doc-diff

Doesn't this make more sense and mesh much better with the already 
existing custom diff driver?

(And yeah, maybe we could instead of "command=internal" just have the rule 
that "internal" is the default, and you'd not have a command at all when 
you want to run the internal diff.

Just an idea. I don't have any code.

			Linus
