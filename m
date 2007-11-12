From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] push: use same rules as git-rev-parse to resolve refspecs
Date: Mon, 12 Nov 2007 11:51:39 -0800
Message-ID: <7v1wav44z8.fsf@gitster.siamese.dyndns.org>
References: <1194789708646-git-send-email-prohaska@zib.de>
	<11947897083381-git-send-email-prohaska@zib.de>
	<11947897081278-git-send-email-prohaska@zib.de>
	<11947897083159-git-send-email-prohaska@zib.de>
	<11947897083265-git-send-email-prohaska@zib.de>
	<1194789709671-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfKE-00020V-9r
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbXKLTvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 14:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbXKLTvr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:51:47 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50457 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbXKLTvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 14:51:46 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 966492F0;
	Mon, 12 Nov 2007 14:52:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 118DF94FC7;
	Mon, 12 Nov 2007 14:52:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64692>

Steffen Prohaska <prohaska@zib.de> writes:

> diff --git a/remote.c b/remote.c
> index bec2ba1..28d8eb7 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -519,10 +519,7 @@ static int count_refspec_match(const char *pattern,
>  		char *name = refs->name;
>  		int namelen = strlen(name);
>  
> -		if (namelen < patlen ||
> -		    memcmp(name + namelen - patlen, pattern, patlen))
> -			continue;
> -		if (namelen != patlen && name[namelen - patlen - 1] != '/')
> +		if (!ref_abbrev_matches_full_with_rules(pattern, name, ref_rev_parse_rules))
>  			continue;

I vaguely recall that in the old round this check used to be
without negation '!' in the front.  I think this version is
correct.
