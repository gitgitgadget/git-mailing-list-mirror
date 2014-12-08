From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 15/23] expire_reflog(): pass flags through to
 expire_reflog_ent()
Date: Mon, 8 Dec 2014 14:55:17 -0800
Message-ID: <20141208225517.GG25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-16-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:55:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy7DA-00051C-PW
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbaLHWzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:55:21 -0500
Received: from mail-ig0-f202.google.com ([209.85.213.202]:57998 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbaLHWzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:55:19 -0500
Received: by mail-ig0-f202.google.com with SMTP id hn18so475700igb.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=b5ej1TTban4B+NXKJbFYdx5AaMeFE0blkKXihaD0QBA=;
        b=UL+GGhnar1UI48++v6/KNd7Lh9Iz5g2e8JCk523TZpCwcfFPO8S8A08/5+QUrdRx/c
         xh8Y0IrznXvNRWHI7Hw0AEeZaUDV1YYpF1I9vMnKXRtuGNjvX25kan/vxaZWAbVMCzLY
         yFLSWLpBhaKmQru1ThuFL0/NtfX0TYG/H+c52H4ozS4BWku0W1LAXNT6oqgLgwx/1kI/
         vqTQpQuv5o1lIHRbZAmjHkViROcibXIM+s63Bumx7Kds2mk7+tA8bh7VQBACacVYeKex
         WiECXFpqQsrXaer4derCAlwIu09JiEBsJ6/VjNsUppLpYQlwQSgbt34lkYvtxoLiZUBD
         ZaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=b5ej1TTban4B+NXKJbFYdx5AaMeFE0blkKXihaD0QBA=;
        b=esvn3nw8CpFRHKfivnfz2+Mdj+wT3Uadc5GwPMkjNrFjGcGwzXLryCvPxHo79+wyhd
         6pe1oK271rMggQKEGZJm9R8CC1gvV0UqkmkIrP4i846hV0qNchdqsMV8DpydMGdjG7Fj
         dQzNMtqNnAi+rvc5TxQsn6oAh6RRz0Qeh9LBoipyrEE2aF/jYQmHf1eMemLRDn03BgFp
         M5U+5F8NIUyBpLeBoFKXn0hkTX/5Khavyl76U2PP7oV0kqENqxZniSL68IwKiRQ2nD9C
         uJTo0Z4XdEMVTA44DTYzcU16uvFboikBKSf4VzhnBfU7vSe+9LicMZyPf4RfRaNLfZuT
         Ii4w==
X-Gm-Message-State: ALoCoQlTGPbWsMXVlkPsPqbndKd09gGzX450cCC00COPyFUIapOLEoovysAOM/syRFP3kaGYsJbI
X-Received: by 10.182.121.170 with SMTP id ll10mr31273094obb.12.1418079318493;
        Mon, 08 Dec 2014 14:55:18 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 26si1107053yhj.7.2014.12.08.14.55.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:55:18 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id Gh2GaSGt.1; Mon, 08 Dec 2014 14:55:18 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 838C2140BBD; Mon,  8 Dec 2014 14:55:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-16-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261092>

On Fri, Dec 05, 2014 at 12:08:27AM +0100, Michael Haggerty wrote:
> Add a flags field to "struct expire_reflog_cb", and pass the flags
> argument through to expire_reflog_ent(). In a moment we will start
> using it to pass through flags that expire_reflog_ent() needs.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: <sbeller@google.com>

> ---
>  builtin/reflog.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 5dfa53a..1512b67 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -46,6 +46,7 @@ struct expire_reflog_policy_cb {
>  };
>  
>  struct expire_reflog_cb {
> +	unsigned int flags;
>  	void *policy_cb;
>  };
>  
> @@ -437,6 +438,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  
>  	memset(&cb, 0, sizeof(cb));
>  	memset(&policy_cb, 0, sizeof(policy_cb));
> +	cb.flags = flags;
>  	cb.policy_cb = &policy_cb;
>  
>  	/*
> -- 
> 2.1.3
> 
