From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v2] autocrlf: Make it work also for un-normalized
 repositories
Date: Wed, 12 May 2010 10:16:47 +0400
Message-ID: <20100512061646.GL14069@dpotapov.dyndns.org>
References: <20100511223757.GB16974@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed May 12 08:16:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC5Fb-0007ZD-9p
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 08:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab0ELGQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 02:16:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:56284 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab0ELGQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 02:16:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1729306fgg.1
        for <git@vger.kernel.org>; Tue, 11 May 2010 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IeKJBALwApoczP1Q1qUznjCTw50ito0kkD0EZ5VYdfw=;
        b=eMwg2qbEWmrcjpA+7IFUGJWRnXQ2kobf+kp5qOq9iDxIgTH+EFfd/4Bw3RjUw3864+
         VvAepJWk8ZC1EQOXuripnDhEYtN/Vl2e7NTX+J1si3+AONmLy7RXGG6Q9NwFY3zXg6i9
         TdWnojLVFPpk/XmEQW9ZhqnhK9b76S1ZAk3L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V5ZFX6RBvjV3gKzuEHLQiEb1JHgoxNi69ul4TvYz58k9ZEuRM7s2qKVIBmeVFfvQI9
         AoO6pUACKGk5WW3kpnBn+Un7HZEGrpM3oQb0M207gIIS90zVzIj4Vw74KNjaRwxco+8b
         OsIo4p8LujFqL+uUDPrxFGcw19CpLLUDztN6U=
Received: by 10.103.205.23 with SMTP id h23mr4116132muq.88.1273645010846;
        Tue, 11 May 2010 23:16:50 -0700 (PDT)
Received: from localhost (ppp85-141-232-209.pppoe.mtu-net.ru [85.141.232.209])
        by mx.google.com with ESMTPS id 7sm28182192mup.13.2010.05.11.23.16.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 23:16:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100511223757.GB16974@pvv.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146922>

On Wed, May 12, 2010 at 12:37:57AM +0200, Finn Arne Gangstad wrote:
> @@ -203,6 +247,11 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
>  		return 0;
>  
>  	if (action == CRLF_GUESS) {
> +		/* If we have any CR or CRLF line endings, we do not touch it */
> +		/* This is the new safer autocrlf-handling */
> +		if (stats.cr > 0 || stats.crlf > 0)
> +			return 0;
> +		
>  		/* If we have any bare CR characters, we're not going to touch it */
>  		if (stats.cr != stats.crlf)
>  			return 0;

If there is no CR then there is no CRLF and certainly no bare CR
characters. So, all above checks can be replaced with one:

		if (stats.cr > 0)
			return 0;

Other than that, I really like your patch.


Thanks,
Dmitry
