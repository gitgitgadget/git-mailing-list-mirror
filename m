From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 08:54:08 +0100
Message-ID: <20130819075408.GT2337@serenity.lan>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de>
 <1376894300-28929-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 19 09:54:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBKIK-0007I6-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 09:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750Ab3HSHy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 03:54:29 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34066 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3HSHy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 03:54:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0490BCDA57D;
	Mon, 19 Aug 2013 08:54:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Own+yD1Et0RW; Mon, 19 Aug 2013 08:54:20 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E5E91CDA570;
	Mon, 19 Aug 2013 08:54:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1376894300-28929-1-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232531>

On Mon, Aug 19, 2013 at 08:38:20AM +0200, Steffen Prohaska wrote:
> diff --git a/Makefile b/Makefile
> index 3588ca1..0f69e24 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -69,6 +69,9 @@ all::
>  # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
>  # doesn't support GNU extensions like --check and --statistics
>  #
> +# Define NEEDS_CLIPPED_READ if your read(2) cannot read more than
> +# INT_MAX bytes at once (e.g. MacOS X).
> +#
>  # Define NEEDS_CLIPPED_WRITE if your write(2) cannot write more than
>  # INT_MAX bytes at once (e.g. MacOS X).
>  #
> @@ -1493,6 +1496,11 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
>  	MSGFMT += --check --statistics
>  endif
>  
> +ifdef NEEDS_CLIPPED_READ
> +	BASIC_CFLAGS += -DNEEDS_CLIPPED_READ
> +	COMPAT_OBJS += compat/clipped-read.o

You've created compat/clipped-write.c, but...

>  Makefile              |  8 ++++++++
>  builtin/var.c         |  1 +
>  config.mak.uname      |  1 +
>  git-compat-util.h     |  5 +++++
>  streaming.c           |  1 +
>  t/t0021-conversion.sh | 14 ++++++++++++++
>  6 files changed, 30 insertions(+)

... it's not included here.  Did you forget to "git add"?
