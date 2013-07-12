From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Fri, 12 Jul 2013 19:21:28 +0200
Message-ID: <51E03B18.5040502@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org> <7vzjtspwvo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 19:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh2H-0006qs-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090Ab3GLRVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:21:33 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:60597 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932650Ab3GLRVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:21:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6AB8DA7EB8;
	Fri, 12 Jul 2013 19:21:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BC74D19F616;
	Fri, 12 Jul 2013 19:21:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vzjtspwvo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230208>

Am 12.07.2013 00:14, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Again: Why not just define +refspec as the way to achieve this check?
> 
> What justification do we have to break existing people's
> configuration that says something like:
> 
> 	[remote "ko"]
> 		url = kernel.org:/pub/scm/git/git.git
>                 push = master
>                 push = next
>                 push = +pu
>                 push = maint
> 
> by adding a _new_ requirement they may not be able to satisify?
> Notice that the above is a typical "push only" publishing point,
> where you do not need any remote tracking branches.

Why would it break? When you do not specify --lockref, there is no
change whatsoever.

To achieve any safety at all for these push-only refs, you have to be
very explicit by saying --lockref=pu:$myoldpu
--lockref=master:$myoldmaster etc, and what is wrong if in this case
--lockref semantics are applied, but only pu is allowed to be no-ff?

> I am not opposed if your proposal were to introduce a new syntax
> element that calls for this new feature, e.g.
> 
> 	[remote "ko"]
> 		url = kernel.org:/pub/scm/git/git.git
>                 push = *pu
>                 fetch = +refs/heads/*:refs/remotes/ko/*
> 
> but changing what "+" means to something new will simply not fly.

I still do not see why we need two different kinds of ways to spell the
same strong kind of override (--force and +refspec) under the presence
of --lockref, and why we need a third one (--allow-no-ff) to give a
weaker kind of override (that makes sense only when --lockref was given
in the first place).

-- Hannes
