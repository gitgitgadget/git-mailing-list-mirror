From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 09:11:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806230908500.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:13:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAofQ-0006xn-MP
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 18:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760192AbYFWQM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 12:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760186AbYFWQM1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 12:12:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60992 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760180AbYFWQMY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 12:12:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NGBobt012426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 09:11:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NGBocW004540;
	Mon, 23 Jun 2008 09:11:50 -0700
In-Reply-To: <20080623082223.GA12130@artemis.madism.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85879>



On Mon, 23 Jun 2008, Pierre Habouzit wrote:
> 
> You can't, mainly because of option aggregation: if the parser1 knows
> about -a and -b, parser2 about -c, then, this kind of things is
> problematic: -acb because you need to go to the parser '2' to know about
> -c, and you can't filter the arguments and keep -c and give -b to
> parser1 again, *BECAUSE* 'b' could also be -c argument.

Sure you can. You just rewrite the arguments themselves.

That said, anybody who doesn't use parse_options() right now won't be 
accepting something like "-abc" *anyway*, and people currently need to use 
"-a -b -c".

> int (*parse_opt_unknown_cb)(int shortopt, const char *longopt,
>                             const char *value, void *priv);

This doesn't really change anything. It just makes it harder to write a 
simple partial parser. Just passing in "IGNORE_UNKNOWN" (and probably 
"STOP_AT_UNKNOWN") is the simplest way to have multiple passes.

		Linus
