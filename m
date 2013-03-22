From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Fri, 22 Mar 2013 14:21:59 -0700
Message-ID: <20130322212159.GJ12223@google.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9Q1-0003Cp-6z
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423307Ab3CVVWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:22:06 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34863 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423294Ab3CVVWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:22:04 -0400
Received: by mail-pd0-f181.google.com with SMTP id q10so1787396pdj.12
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=t2cJuBNfU2b0iDWTXe/VVDhJiuGMAnARfMaB+/c7n54=;
        b=i7NoTqpma25kXQSgEX15vkbF1KlRS8kpVTvrkkkQoaUnU2HbyT1VPJVmI7R7Y06onY
         9rem2sXhlgfkzF9MaPHfWam0Sk01rgxAeTx9O/U1PIOd2M1C4aU32uDEKPw7319m/dd9
         28uxRLm1GbqbY2cVyo7dPvJ02lIu78bB52Q22gVuGOpFEMlaNTpVEw3Dn6WA0B4DACgC
         F+KWu3yU5elXdzcgIo5U8wqFKGzgwKcWQ89aC1sM/wsU3RusZ9n2vG/wO2hdIGeUPTQ5
         AHAEC8E0x2yVDy39quXHViH7DWWEDXFhyPOken4F8hAMKC6NZsm8iyk9uEAJ7LXCskec
         hb1w==
X-Received: by 10.66.253.74 with SMTP id zy10mr5483978pac.122.1363987324166;
        Fri, 22 Mar 2013 14:22:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id zv3sm4347519pab.0.2013.03.22.14.22.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 14:22:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363938756-13722-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218848>

Ramkumar Ramachandra wrote:

>                            This patch has no visible impact, but
> serves to enable future patches to introduce configuration variables
> to set pushremote_name.  For example, you can now do the following in
> handle_config():
>
>     if (!strcmp(key, "remote.pushdefault"))
>        git_config_string(&pushremote_name, key, value);

Thanks.

[...]
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -322,7 +322,7 @@ static int push_with_options(struct transport *transport, int flags)
>  static int do_push(const char *repo, int flags)
>  {
>  	int i, errs;
> -	struct remote *remote = remote_get(repo);
> +	struct remote *remote = pushremote_get(repo);

"struct remote" has url and pushurl fields.  What do they mean in the
context of these two accessors?  /me is confused.

Is the idea that now I should not use pushurl any more, and that I
should use pushremote_get and use url instead?

Hope that helps,
Jonathan
