From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add a notice that only certain functions can print color
 escape codes
Date: Fri, 27 Nov 2009 10:22:12 +0100
Message-ID: <4B0F9A44.7060706@drmicha.warpmail.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net> <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net> <4B0EA06A.1050101@viscovery.net> <7vy6lt6rh3.fsf@alter.siamese.dyndns.org> <4B0F78F1.4040101@viscovery.net> <7vzl68v2zb.fsf@alter.siamese.dyndns.org> <4B0F82E1.80402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 10:23:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDx35-00080S-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 10:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbZK0JXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 04:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZK0JXR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 04:23:17 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36496 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753442AbZK0JXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 04:23:16 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 91C67C1F78;
	Fri, 27 Nov 2009 04:23:22 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 27 Nov 2009 04:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=t+CAEcAJ9NZxH1ssRYAbsc5Cqx8=; b=uaOc2OfzkgOVaBsjbvzT+sjUbXh3ZnDqOWcqjzi4ySA0HMpUmgY+V5NtIEZcr54m6uWT+tOt0bHmjjtdR9p6thqqnxE0ZavdafD28cms9ypZDHFvG5vpTjEqaQbM2qWtvEXzczWEz3oZsP3rbhD+X9Igs7fbvl16wODgXDSOoCM=
X-Sasl-enc: d6ufeITxUvEj1d3CgbNYqXkAo1xH1dngLknMYz+JYutP 1259313802
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D59073A5067;
	Fri, 27 Nov 2009 04:23:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <4B0F82E1.80402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133882>

Johannes Sixt venit, vidit, dixit 27.11.2009 08:42:
> Junio C Hamano schrieb:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Like this?
>>
>> Yeah, and in addition to "puts", "write(2)" is also not supported, right?
> 
> Correct, good catch!
> 
> --- 8< ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] Add a notice that only certain functions can print color escape codes
> 
> We emulate color escape codes on Windows by overriding printf, fprintf,
> and fputs. Warn users that these are the only functions that can be used
> to print them.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  color.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/color.h b/color.h
> index 7d8da6f..3cb4b7f 100644
> --- a/color.h
> +++ b/color.h
> @@ -4,6 +4,11 @@
>  /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
>  #define COLOR_MAXLEN 24
> 
> +/*
> + * IMPORTANT: Due to the way these color codes are emulated on Windows,
> + * write them only using printf(), fprintf(), and fputs(). In particular,
> + * do not use puts() or write().

Nor putchar nor putc... but they're part of the puts family, of course.
More worthwhile then listing those negatives could be a hint on another
positive: color_fprintf and friends which are declared at the end of
color.h.

> + */
>  #define GIT_COLOR_NORMAL	""
>  #define GIT_COLOR_RESET		"\033[m"
>  #define GIT_COLOR_BOLD		"\033[1m"
