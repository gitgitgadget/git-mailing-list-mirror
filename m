From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 2/3] rev-list: Introduce --no-output to avoid /dev/null redirects
Date: Thu, 08 Nov 2007 23:32:01 -0800
Message-ID: <7vejezx4b2.fsf@gitster.siamese.dyndns.org>
References: <20071108080052.GB16690@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 08:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqOM6-0005A7-4K
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 08:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbXKIHcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 02:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXKIHcH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 02:32:07 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47795 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXKIHcG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 02:32:06 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 45BB22F2;
	Fri,  9 Nov 2007 02:32:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CF76E91CB3;
	Fri,  9 Nov 2007 02:32:24 -0500 (EST)
In-Reply-To: <20071108080052.GB16690@spearce.org> (Shawn O. Pearce's message
	of "Thu, 8 Nov 2007 03:00:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64135>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> @@ -640,7 +656,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	traverse_commit_list(&revs, show_commit, show_object);
> +	traverse_commit_list(&revs,
> +		nooutput ? noshow_commit : show_commit,
> +		nooutput ? noshow_object : show_object);
>  
>  	return 0;
>  }

The function names noshow_xxx() looked a bit funny, but I do not
offhand have better alternatives to offer.

This allows "--bisect-vars --no-output" and "--bisect-all
--bisect-vars --no-output" but makes them behave differently.  I
do not think --no-output is useful with bisection anyway but
maybe it makes sense to forbid the combination?
