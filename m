From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2 - RFH/WIP] xdiff-merge: optionally show conflicts in
 "diff3 -m" style
Date: Thu, 28 Aug 2008 17:34:36 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org>
References: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org> <7vsksobrn9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYry2-0003Ct-0t
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbYH2Aex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYH2Aex
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:34:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45042 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753305AbYH2Aew (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 20:34:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7T0Yagq002230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 17:34:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7T0YakW022503;
	Thu, 28 Aug 2008 17:34:36 -0700
In-Reply-To: <7vsksobrn9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.933 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94236>



On Thu, 28 Aug 2008, Junio C Hamano wrote:
> 
> Some poeple find it easier to be able to understand what is going on when
> they can view the common ancestor's version, which is used by "diff3 -m",
> which shows:
> 
>  <<<<<<<
>  postimage from one side;
>  |||||||
>  shared preimage;
>  =======
>  postimage of the other side; and
>  >>>>>>>
> 
> This is an initial step to bring that as an optional feature to git.
> Only "git merge-file" has been converted, with "--diff3" option.

If you have the common ancestor, why would you ever want this format, and 
not a nice conflict entry in the index?

Anyway, that's irrelevant for my real question, which is:

>  /*
> - * level == 0: mark all overlapping changes as conflict
> - * level == 1: mark overlapping changes as conflict only if not identical
> - * level == 2: analyze non-identical changes for minimal conflict set
> - * level == 3: analyze non-identical changes for minimal conflict set, but
> - *             treat hunks not containing any letter or number as conflicting
> + * "Level" parameter can be:
> + *
> + * (MINIMAL):
> + * Mark all overlapping changes as conflict
> + *
> + * (EAGER):
> + * Mark overlapping changes as conflict only if not identical
> + *
> + * (DIFF3):
> + * Same as EAGER but show the shared preimage in the output as well
> + *
> + * (ZEALOUS):
> + * Analyze non-identical changes for minimal conflict set
> + *
> + * (ZEALOUS_ALNUM):
> + * Analyze non-identical changes for minimal conflict set, but
> + * treat hunks not containing any letter or number as conflicting
>   *

Wouldn't it be much nicer to make this a bitflag, than an enumeration of 
different models?

In particular, why would it be wrong to want to be ZEALOUS (possibly 
_ALNUM) and still want DIFF3 output?

IOW, I don't think these are at all disjoint sets. In fact, I think DIFF3 
sounds not at all like a "level" to me, but like an output format thing, 
so it's in a totally different "address space".

Hmm?

		Linus
