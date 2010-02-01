From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Problem listing GIT repository with accents
Date: Mon, 01 Feb 2010 13:48:01 +0100
Message-ID: <4B66CD81.3010005@viscovery.net>
References: <7E88665723814E46BCBA1A39E84C27A5@elrond> <20100201113213.GA22663@coredump.intra.peff.net> <20100201121933.GA9995@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RWxsacOpIENvbXB1dGluZyBP?=
	 =?UTF-8?B?cGVuIFNvdXJjZSBQcm9ncmFt?= 
	<opensource@elliecomputing.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 13:48:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbvhT-0004RZ-FQ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 13:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab0BAMsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 07:48:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11558 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab0BAMsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 07:48:07 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NbvhC-0005D1-FQ; Mon, 01 Feb 2010 13:48:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F29871660F;
	Mon,  1 Feb 2010 13:48:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100201121933.GA9995@coredump.intra.peff.net>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138607>

Jeff King schrieb:
> @@ -209,11 +209,14 @@ static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
>  	size_t len, count = 0;
>  	const char *p = name;
>  
> +	if (maxlen < 0)
> +		maxlen = strlen(name);
> +
>  	for (;;) {
>  		int ch;
>  
>  		len = next_quote_pos(p, maxlen);
> -		if (len == maxlen || !p[len])
> +		if (len == maxlen)
>  			break;
>  
>  		if (!no_dq && p == name)
> @@ -223,6 +226,7 @@ static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
>  		EMIT('\\');
>  		p += len;
>  		ch = (unsigned char)*p++;
> +		maxlen -= len + 1;

Couldn't you just write

		if (0 <= maxlen)
			maxlen -= len + 1;

to avoid the strlen(), because the rest of the loop is actually OK when
maxlen == -1, isn't it?

-- Hannes
