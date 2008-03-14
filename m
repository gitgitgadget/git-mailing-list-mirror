From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault in git read-tree
Date: Thu, 13 Mar 2008 21:48:56 -0700
Message-ID: <7vejadvrk7.fsf@gitster.siamese.dyndns.org>
References: <200803132359.06745.lenb@kernel.org>
 <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803132136080.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Len Brown <lenb@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1rc-0000wx-NB
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbYCNEtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYCNEtL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:49:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYCNEtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 00:49:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A49E62E55;
	Fri, 14 Mar 2008 00:49:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BDAF32E53; Fri, 14 Mar 2008 00:49:03 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803132136080.3557@woody.linux-foundation.org>
 (Linus Torvalds's message of "Thu, 13 Mar 2008 21:37:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77173>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 13 Mar 2008, Linus Torvalds wrote:
>> 
>> Ok, I can reproduce this, I'm on it like a maggot on a two-week-dead baby 
>> donkey.
>
> Ok, that was embarrassing.
>
> This should fix it. Spot the stupid stack corruption..
>
> 		Linus

> diff --git a/unpack-trees.c b/unpack-trees.c
> index be89d52..b62b054 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -8,6 +8,8 @@
>  #include "progress.h"
>  #include "refs.h"
>  
> +#define MAX_UNPACK_TREES 4

Somehow this reminds me of a9ab200 (Clean-up read-tree error condition.,
Aug 16, 2007) and f34f2b0 (Fix read-tree merging more than 3 trees using
3-way merge, Aug 15, 2007).
