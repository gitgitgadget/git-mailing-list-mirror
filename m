From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t/t9001-send-email.sh: fix '&&' chain in some tests
Date: Mon, 22 Nov 2010 11:00:40 -0600
Message-ID: <20101122170040.GA2084@burratino>
References: <1290429109-2318-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Mon Nov 22 18:00:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKZl9-0006Hl-Um
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 18:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab0KVRAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 12:00:48 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:36606 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab0KVRAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 12:00:47 -0500
Received: by pxi15 with SMTP id 15so1518370pxi.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 09:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=flTECGg08COO1BxfKAa1L4/8gJMeKj6Vo3165R+4nmA=;
        b=pkmd9KPDXmlNrKWgZC92BrHiDDW80YCXuGTol3PIgKxjQxwsHB7PipWqDLly19UH6x
         xNO+yY3xlWQKZOty7NTxweXXcq4vJC6TEJfqAThIkjCnI+7lCkwQyj6Z40qSEJ5Y74Di
         Gi3xowdt/iMUxJY4wp/o6w8xgbYKap8QPWC1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a/R9V1e87c1I6H3U/+UlmL7NSzVLDEUwGodEMbdN75QXCDJdWDDiHW6Ng7FRoCRSEc
         M4fGVj8VfiYBPwD9G26aW9cnn7viaYeEsZvjshCvH6VD4ZZ9lv5gWHN+rS/oiTPIylaZ
         pEuoeaR7XtKA4MICEGXPdiceMA17zt/xNqTyI=
Received: by 10.229.99.84 with SMTP id t20mr5213839qcn.120.1290445246307;
        Mon, 22 Nov 2010 09:00:46 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id l14sm2976905qck.29.2010.11.22.09.00.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 09:00:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290429109-2318-1-git-send-email-ospite@studenti.unina.it>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161901>

Hi,

Antonio Ospite wrote:

> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -261,10 +262,10 @@ test_expect_success $PREREQ 'Author From: in message body' '
> test_expect_success $PREREQ 'Author From: in message body' '
> 	clean_fake_sendmail &&
> 	git send-email \
> 		--from="Example <nobody@example.com>" \
>  		--to=nobody@example.com \
>  		--smtp-server="$(pwd)/fake.sendmail" \
>  		$patches &&
> -	sed "1,/^\$/d" < msgtxt1 > msgbody1
> +	sed "1,/^\$/d" < msgtxt1 > msgbody1 &&
>  	grep "From: A <author@example.com>" msgbody1
>  '
[...]
>  		$patches &&
> -	sed "1,/^\$/d" < msgtxt1 > msgbody1
> +	sed "1,/^\$/d" < msgtxt1 > msgbody1 &&
[...]
> @@ -300,5 +300,5 @@ test_expect_success $PREREQ 'Invalid In-Reply-To' '
>  		$patches \
> -		2>errors
> +		2>errors &&

Good.

> @@ -574,7 +574,7 @@ EOF
>  "
>  
>  test_expect_success $PREREQ '--suppress-cc=sob' '
> -	git config --unset sendemail.cccmd
> +	git config --unset sendemail.cccmd &&

This one needs a test_might_fail in front, since "git config --unset"
would fail if some future change causes the configuration item not to
be set in the first place.

Thanks.
