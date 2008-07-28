From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/9] Makefile: Do not install a copy of 'git' in $(gitexecdir)
Date: Mon, 28 Jul 2008 19:13:00 -0400
Message-ID: <488E527C.4000901@gmail.com>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at> <488D104F.8080005@gmail.com> <7vabg2v83o.fsf@gitster.siamese.dyndns.org> <7v63qqv7ex.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNbuo-0006q5-Vh
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbYG1XNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYG1XNF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:13:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:50608 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYG1XND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:13:03 -0400
Received: by qw-out-2122.google.com with SMTP id 3so351637qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=m28HAK+Y7PPtACHOjezGx5ITP24KY1B54Zo2lfAp29A=;
        b=vGh3c5rJkW52Hxj+7rd5E6VuhfocbkRgoYw3lCZv/Q3TeJ+T0c8+scp8/OjmBmfq1D
         LBijD66n9AoROTaKSW4WacnIsdBWU04+d/zNX1aGRvc4jjoi4MJV9++k+vGd10vBltvW
         k0+6rL9Oy+vJ5L+x9oyGOj4mVP/1x58dhSnWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=Va1Jc+isHzf4TpHNB4i4k/c3MiL0duXGcMCHPyW5zYUXK49DvtRPwVVINtrKJTY5JB
         9SpcwyMtLkKzVwCR/7jqJ5ZhbsUygzQBTTiaLmsb1XODf2jKQPBMycPA6tnSqTfdoAEn
         0id5milCLe9mJ9szZGfP5OZkOzi/XcoK2BMd4=
Received: by 10.214.116.16 with SMTP id o16mr691195qac.46.1217286782520;
        Mon, 28 Jul 2008 16:13:02 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 6sm11449734yxg.6.2008.07.28.16.13.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 16:13:01 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7v63qqv7ex.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90519>

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

Tested by: A Large Angry SCM <gitzilla@gmail.com>
