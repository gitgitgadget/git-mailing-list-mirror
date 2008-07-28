From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/9] Makefile: Do not install a copy of 'git' in $(gitexecdir)
Date: Mon, 28 Jul 2008 06:43:14 -0400
Message-ID: <488DA2C2.4030003@gmail.com>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at> <488D104F.8080005@gmail.com> <7vabg2v83o.fsf@gitster.siamese.dyndns.org> <7v63qqv7ex.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQDC-0007wq-2v
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 12:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbYG1KnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 06:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYG1KnS
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 06:43:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:7883 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYG1KnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 06:43:17 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4365120rvb.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KtEiUfYXIc3SvkdrQj8Ko9L9pqPbnCaJb38rszB9//A=;
        b=HM8/TfOhooQHTH1JdUMNQNLKAPhJj3Wn0uTeEZ18QDPYse5D/Q5HNzKhEtGiUfejOz
         k/dLn1mvcxsW2uqCBk/2NA5G8wZOli43rFUBuPRPeLIIuh26jC8jib4pkCpddzSb0+I5
         dRf1Jh+9wqU49/ThmlY8xfjdctg8udYYQ5Z48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=W+TlJ6c3m9SAKBtBr985e08HotSzmqbsyeli7PYulWtwKHkmAI/xQaFzG21rrwngkm
         n3G5/DIxluIoBd4FhAUZWw75WfwNuNzKWMEfj5vKMdBP/npxR6kmF0X15wUhelmoHzoG
         vjncSkY2XmF/0HoAnejMbdfQcX7d27ZMZ65ks=
Received: by 10.115.76.5 with SMTP id d5mr4678716wal.191.1217241796806;
        Mon, 28 Jul 2008 03:43:16 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 5sm14640932yxt.1.2008.07.28.03.43.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 03:43:16 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7v63qqv7ex.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90434>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> This new action needs to be in a conditional to keep it from removing
>>> the ONLY git executable when bindir and execdir are the same dir.
>> Heh, I love bug reports that come immediately after I tag the tip of
>> 'master' as -rc1.
> 
> This should do, but to be very honest, I really hate the output from the
> foreach that precedes this section.
> 
>  Makefile |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 798a2f2..92df61c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1362,7 +1362,10 @@ endif
>  		cp "$$bindir/git$X" "$$execdir/git$X"; \
>  	fi && \
>  	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git$X" "$$execdir/$p" ;) } && \
> -	$(RM) "$$execdir/git$X" && \
> +	if test "z$$bindir" != "z$$execdir"; \
> +	then \
> +		$(RM) "$$execdir/git$X"; \
> +	fi && \
>  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
>  
>  install-doc:
> 

I'll test this this evening.
