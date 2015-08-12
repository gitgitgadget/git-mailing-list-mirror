From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] revisions --stdin: accept CRLF line terminators
Date: Wed, 12 Aug 2015 20:24:49 +0200
Message-ID: <55CB8F71.1020402@kdbg.org>
References: <55CA594D.5020103@kdbg.org>
 <xmqqr3n9pkzc.fsf@gitster.dls.corp.google.com>
 <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 20:25:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPaht-00040d-4X
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 20:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbbHLSYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 14:24:53 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:29271 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbbHLSYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 14:24:52 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mrzw25hHwz5tl9;
	Wed, 12 Aug 2015 20:24:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id ACE4252DE;
	Wed, 12 Aug 2015 20:24:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275792>

Am 12.08.2015 um 00:14 schrieb Junio C Hamano:
> Now, I am wondering if it makes sense to do these two things:
>
>   * Teach revision.c::read_revisions_from_stdin() to use
>     strbuf_getline() instead of strbuf_getwholeline().
>
>   * Teach strbuf_getline() to remove CR at the end when stripping the
>     LF at the end, only if "term" parameter is set to LF.
>
> Doing so would solve 1. and 2., but we obviously need to audit all
> the other uses of strbuf_getline() to see if they can benefit (or if
> some of them may be broken because they _always_ need LF terminated
> lines, i.e. CRLF terminated input is illegal to them).

I can see what I can do with these. Don't hold your breath, though.

> As to 3., I think it is OK.  The code structure of 4. is too ugly
> and needs to be revamped to go one line at a time first before even
> thinking about how to proceed, I would think.

Regarding update-ref --stdin (your 4.), I notice that the input format 
is very strict, so the solution is to allow an optional CR before the 
LF. I alread have a patch, but it skips all trailing space, which is 
probably too lenient. (I only needed the patch once for a debug 
sesssion, but there is no obvious breakage without the patch.)

-- Hannes
