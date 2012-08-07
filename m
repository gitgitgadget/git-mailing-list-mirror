From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable HAVE_DEV_TTY for Solaris
Date: Mon, 06 Aug 2012 20:43:02 -0700
Message-ID: <7v4nofxt89.fsf@alter.siamese.dyndns.org>
References: <20120807003541.GA18219@sigill.intra.peff.net>
 <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, rctay89@gmail.com,
	schwab@linux-m68k.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Aug 07 05:43:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syahe-0006EC-PR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 05:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782Ab2HGDnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 23:43:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34011 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932630Ab2HGDnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 23:43:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 158F38159;
	Mon,  6 Aug 2012 23:43:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JK0aCJrSMjnMaKyo9957smv+aWI=; b=N7cAWd
	ZQaYVBnqzY+MTlVshUjEc/6yxaTJLIMRRkchNj269Ca2sP0P4KS6XKuOJHZLzr5I
	EMI5Undlee+anNjRN2i6AmS1H0VXLSTfPhTpcCn7GQCcTMDqD1cgHZ8jROaaZyYC
	W1fPTpaGiM0kxN5ZM4gI27Kbpsy8l7B6M6QQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cAChmB4wyjDbQlfgsnEbeiQfHUA7gE85
	ipn7D9zqgBT3A3/OODA7K8iFXk3Lvmi5PjeFVOqYgd3GJChksaUAI1pwl28MpEdk
	Ob7yxeTPkpnWL6Fskc6KluBolAEs6EQu6bMLL+NStLrRwhrmdoyMF9TsyiYtkAJS
	CaWIUhpotNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E398158;
	Mon,  6 Aug 2012 23:43:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CC3B8156; Mon,  6 Aug 2012
 23:43:04 -0400 (EDT)
In-Reply-To: <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Mon, 6 Aug 2012 23:07:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE6D23E8-E041-11E1-A692-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203009>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Now that git_terminal_prompt can cleanly interact with /dev/tty on
> Solaris, enable HAVE_DEV_TTY so that this code path is used for
> credential reading instead of relying on the crippled getpass().
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
>
> This is a follow up to Jeff's patch that fixes git_terminal_prompt on
> Solaris.  I don't have 5.6 or 5.7 for testing but I believe this
> should be valid for both of those releases as well.

So which direction do you guys want to go?  Use the "bidirectional
stdio with fseek()" for now, with the expectation that Tay's other
series will rewrite it to fd based one?

>
>  Makefile |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 15d1319..6b0c961 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1014,6 +1014,7 @@ ifeq ($(uname_S),SunOS)
>  	NO_REGEX = YesPlease
>  	NO_FNMATCH_CASEFOLD = YesPlease
>  	NO_MSGFMT_EXTENDED_OPTIONS = YesPlease
> +	HAVE_DEV_TTY = YesPlease
>  	ifeq ($(uname_R),5.6)
>  		SOCKLEN_T = int
>  		NO_HSTRERROR = YesPlease
