From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a notice that only certain functions can print color
 escape codes
Date: Thu, 26 Nov 2009 23:30:48 -0800
Message-ID: <7vzl68v2zb.fsf@alter.siamese.dyndns.org>
References: <cover.1259248243.git.git@drmicha.warpmail.net>
 <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net> <4B0EA06A.1050101@viscovery.net> <7vy6lt6rh3.fsf@alter.siamese.dyndns.org> <4B0F78F1.4040101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 08:31:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDvII-0004sx-Vl
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 08:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbZK0Hay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 02:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbZK0Hay
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 02:30:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbZK0Hax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 02:30:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CB4E83F02;
	Fri, 27 Nov 2009 02:30:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RweTpVADiCy1hUD9DtzeWKhjUCY=; b=CbuuHg
	e2KTN33ZLv7ReoadkEWtSzUSx1Yz47gAJZXqEusJTdzA56ehCGhr/0XTo0LCLmCN
	ppKGQnjow1KpR3hHrN9Orz4f37UddbqMuJgSd+UVUb/umDLxSAKaZCI2qmbZ/zdY
	iskoSjDS/Jm7nkExR+40MBfgz6sM0pRXrDyxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WITGAJWwMV5lCbFwsiiHZv5cCvFdY1i/
	C45DNdA7/WdNP6ApiQbuK73MhEKQsgUm5/k6mNe+iGeaGMf1yAQ+8dnZ0iuB8O3s
	OGYydeNUQRLna64gkA06D3ni9q0vDTogJjcU/fD2La7KErrbMQl/3Y28ulAVF5y8
	ASv36r72YFQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1947C83F01;
	Fri, 27 Nov 2009 02:30:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38DF783EFF; Fri, 27 Nov
 2009 02:30:50 -0500 (EST)
In-Reply-To: <4B0F78F1.4040101@viscovery.net> (Johannes Sixt's message of
 "Fri\, 27 Nov 2009 08\:00\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC4FEBD4-DB26-11DE-89A0-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133870>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Like this?

Yeah, and in addition to "puts", "write(2)" is also not supported, right?

>  color.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/color.h b/color.h
> index 7d8da6f..edeaa3e 100644
> --- a/color.h
> +++ b/color.h
> @@ -4,6 +4,11 @@
>  /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
>  #define COLOR_MAXLEN 24
>
> +/*
> + * IMPORTANT: Due to the way these color codes are emulated on Windows,
> + * write them only using printf, fprintf, and fputs. In particular,
> + * do not use puts.
> + */
>  #define GIT_COLOR_NORMAL	""
>  #define GIT_COLOR_RESET		"\033[m"
>  #define GIT_COLOR_BOLD		"\033[1m"
> -- 
> 1.6.6.rc0.43.g50037
