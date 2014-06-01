From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4 1/2] refs.c: optimize check_refname_component()
Date: Sun, 01 Jun 2014 09:17:20 +0200
Message-ID: <m2k391drpb.fsf@linux-m68k.org>
References: <1401599865-14117-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 09:18:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr01v-0004Nb-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 09:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaFAHRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 03:17:31 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52169 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaFAHRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 03:17:30 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gh9nf3RB2z3hhZ3;
	Sun,  1 Jun 2014 09:17:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gh9nd4sb9zbcMK;
	Sun,  1 Jun 2014 09:17:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id hYIFbmnICj0R; Sun,  1 Jun 2014 09:17:24 +0200 (CEST)
X-Auth-Info: gEZM/JMLgergUtJ/Q9bBUWy9hMKHiRsTIAg1jzR90Js=
Received: from linux.local (ppp-188-174-150-140.dynamic.mnet-online.de [188.174.150.140])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  1 Jun 2014 09:17:24 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id C4D691E570D; Sun,  1 Jun 2014 09:17:20 +0200 (CEST)
X-Yow: It's the land of DONNY AND MARIE as promised in TV GUIDE!
In-Reply-To: <1401599865-14117-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Sun, 1 Jun 2014 01:17:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250522>

David Turner <dturner@twopensource.com> writes:

> +static unsigned char refname_disposition[] = {
> +	1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +	9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +	9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 2, 1,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 9,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 9, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 9, 9
> +};

> +		unsigned char ch = (unsigned char) *cp;
> +		char disp = refname_disposition[ch];

Undefined behaviour.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
