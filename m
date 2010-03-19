From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 07:32:05 -0700
Message-ID: <20100319143205.GB16211@spearce.org>
References: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsdFH-0004kG-V5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab0CSOcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:32:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:15483 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab0CSOcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 10:32:08 -0400
Received: by qw-out-2122.google.com with SMTP id 8so587775qwh.37
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:32:08 -0700 (PDT)
Received: by 10.224.115.145 with SMTP id i17mr1237788qaq.103.1269009128121;
        Fri, 19 Mar 2010 07:32:08 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm268893qyk.8.2010.03.19.07.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 07:32:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142603>

Scott Chacon <schacon@gmail.com> wrote:
> @@ -815,7 +815,18 @@ static int http_request(const char *url, void
> *result, int target, int options)
>  			ret = HTTP_OK;
>  		else if (missing_target(&results))
>  			ret = HTTP_MISSING_TARGET;
> -		else
> +		else if (results.http_code == 401) {
> +			if (user_name) {
> +				ret = HTTP_NOAUTH;
> +			} else {
> +				// it is neccesary to use getpass here because
> +				// there appears to be no other clean way to
> +				// read/write stdout/stdin
> +				user_name = xstrdup(getpass("Username: "));

No, getpass is needed here because its very likely stdin/stdout are
pipes to our parent process.  So we instead need to use /dev/tty,
but that is non-portable.  Using getpass() can at least be stubbed
on other platforms with a different implementation if/when necessary.

-- 
Shawn.
