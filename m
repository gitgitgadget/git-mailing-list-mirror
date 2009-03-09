From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: git-grep Bus Error
Date: Sun, 8 Mar 2009 21:48:02 -0400
Message-ID: <981DB931-6FE4-484E-B101-EFCCAA5E2973@gernhardtsoftware.com>
References: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com> <20090308234141.GJ12880@zoy.org> <7vtz63ijoz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sam Hocevar <sam@zoy.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:49:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgUcd-0001QS-39
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbZCIBsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZCIBsI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:48:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59431 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbZCIBsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:48:07 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C70E01FFC3FB; Mon,  9 Mar 2009 01:47:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C5A521FFC043;
	Mon,  9 Mar 2009 01:47:53 +0000 (UTC)
In-Reply-To: <7vtz63ijoz.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112669>


On Mar 8, 2009, at 9:11 PM, Junio C Hamano wrote:

> Brian, would this patch help?
>
> grep.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index cace1c8..dcdbd5e 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -490,9 +490,9 @@ static void show_line(struct grep_opt *opt, char  
> *bol, char *eol,
> 		*eol = '\0';
> 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
> 			printf("%.*s%s%.*s%s",
> -			       match.rm_so, bol,
> +			       (int) match.rm_so, bol,
> 			       opt->color_match,
> -			       match.rm_eo - match.rm_so, bol + match.rm_so,
> +			       (int)(match.rm_eo - match.rm_so), bol + match.rm_so,
> 			       GIT_COLOR_RESET);
> 			bol += match.rm_eo;
> 			rest -= match.rm_eo;

Apparently so.  Despite the fact that match.rm_so is 0 at times,  
"%.*s" works properly so the other half of the patch isn't needed.  Odd.

~~ B
