From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting
	GIT_EXIT_OK to GIT_EXIT_CODE
Date: Sat, 10 Oct 2009 14:01:21 +0200
Message-ID: <20091010120121.GA16336@localhost>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Oct 10 14:04:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwagF-0007fw-Ce
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 14:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251AbZJJMB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 08:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756893AbZJJMB6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 08:01:58 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:37822 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650AbZJJMB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 08:01:57 -0400
Received: by fxm27 with SMTP id 27so7129925fxm.17
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=slKteA7y9v82H5ai31f3diOZP55bRKWg7VU5UofWk6A=;
        b=ljYp7mo4Qwb2KRSMug+vb6i9PNz9o4dWDToXApYC/uqM82bFau+pCfOwAeuFdCwM2a
         vSIpix/s43+cpADu31J20wBIpi6dI14BWdcyK22Z906o1gf17+OYQuY3sYzHQAuAmK2w
         ZxG5gFaRTQbxVzs+SaBiAXK4A9WaTzUul29DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=tL7CgI6tgexDI6cBR9IG+aJEqK0N/8AeoctLymzCS0PN9MGgcAtqpoLqxmLiS5tPCa
         cvSeyLhIyhvN+nYyj4TqDovxysMdaMrIZzLF2hI1iZvbLH6Nnyr1WezOnsw4mr6ymFu/
         Atl6wQoGGDr6Ily26EWVubMZQNeQ11yoJXSJo=
Received: by 10.103.81.12 with SMTP id i12mr1557006mul.37.1255176077961;
        Sat, 10 Oct 2009 05:01:17 -0700 (PDT)
Received: from darc.lan (p549A5742.dip.t-dialin.net [84.154.87.66])
        by mx.google.com with ESMTPS id g1sm2451256muf.5.2009.10.10.05.01.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 05:01:17 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MwadV-0004sj-GI; Sat, 10 Oct 2009 14:01:21 +0200
Content-Disposition: inline
In-Reply-To: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129879>

Hi,

On Fri, Oct 09, 2009 at 01:39:56PM -0500, Brandon Casey wrote:

> For the Korn shell, $? has the value of the last executed statement
> _before_ the call to exit.

I just installed ksh/stable (version 93s+ 2008-01-31) on Debian and it
behaves correctly. Maybe you need to upgrade? This really looks like a bug
in your shell to me.

>  die () {
>  	code=$?
> -	if test -n "$GIT_EXIT_OK"
> +	if test -n "$GIT_EXIT_CODE"
>  	then
> -		exit $code
> +		exit $GIT_EXIT_CODE
>  	else
>  		echo >&5 "FATAL: Unexpected exit with code $code"
>  		exit 1
>  	fi
>  }

So in your shell an unexpected exit will always output this?

 FATAL: Unexpected exit with code <some command>

If we can't rely on the value of $?, we should not use it.

Clemens
