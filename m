From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 08:19:06 +0200
Message-ID: <470DC05A.8020209@viscovery.net>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Thu Oct 11 08:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfrOH-0000az-I9
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 08:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbXJKGTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 02:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbXJKGTO
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 02:19:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5024 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbXJKGTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 02:19:14 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfrNr-0004kX-0D; Thu, 11 Oct 2007 08:19:02 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 778C8A33B; Thu, 11 Oct 2007 08:19:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60579>

Jonathan del Strother schrieb:
> +	cmt=`cat "$dotest/current"`

This is ok, but...

> +			prev_head="`cat \"$dotest/prev_head\"`"

... there are shells out there in the wild that will get badly confused by 
this sort of quoting and escaping. Butter use

	prev_head=$(cat "$dotest/prev_head")


> -VISUAL="$(pwd)/fake-editor.sh"
> +VISUAL="'$(pwd)/fake-editor.sh'"

Huh? This looks very wrong. What are the extra quotes needed for? If they 
are really needed, isn't this a bug in git-rebase--interactive.sh?

> -	 git-commit -F msg -m amending ."
> +	git-commit -F msg -m amending ."

You fix whitespace...

>  test_expect_success \
> -	"using message from other commit" \
> -	"git-commit -C HEAD^ ."
> +	 "using message from other commit" \
> +	 "git-commit -C HEAD^ ."

... and you break it. More of these follow. Don't do that, it makes patch 
review unnecessarily hard.

I question the usefulness of this patch. Why only fix breakage due to spaces 
in the path? What about single-quotes, double-quotes? IMHO, it's not too 
much of a burden for developers to require "sane" build directory paths.

-- Hannes
