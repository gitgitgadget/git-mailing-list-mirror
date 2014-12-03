From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] reflog.c: use a reflog transaction when writing
 during expire
Date: Tue, 2 Dec 2014 19:18:26 -0800
Message-ID: <20141203031826.GG6527@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
 <1417506402-24257-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:18:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw0SY-00058D-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 04:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbaLCDSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 22:18:31 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45400 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaLCDSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 22:18:30 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so13074976ier.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=chw5unl8snlfCL8w7a0Z9q1Cxg1hBgEnErF7hPgnaTM=;
        b=I8FYVdtbDKQbuugSkwEMrnRG+frXR8Mrc1l2WJO6iWI0+m1BQLsExsEv9XsHhfxLCx
         Z0h19Fuk0JNYlp8iKj4rLz2f2aAEdzMy6PELh8fPipA0hMiLTh3Bock+CrS34tXgejXS
         fi/hq/Iuqjo9mYiMDmZAuNWQ5Z/HaYoISD0KsAH/S9hx6nbdDogdT4nFRWrLamPE9bQl
         M3ah6VmY+8EQ6WeeGW9htzYZV6g9iBlHgDuPd9pdXW8N7rbhktmM0AIGLUkSzogAs4Sw
         32gcT8WIbl70yecb06AeulsFeTT+hcgLpUf1V8ZLlislg9QGNi8gMCj2uSYnIhNLieXd
         Y3ag==
X-Received: by 10.51.17.66 with SMTP id gc2mr11552355igd.27.1417576710233;
        Tue, 02 Dec 2014 19:18:30 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id w6sm17920964igp.15.2014.12.02.19.18.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 19:18:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417506402-24257-5-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260620>

Stefan Beller wrote:

> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
[...]
> @@ -290,7 +291,7 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
>  
>  static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  		const char *email, unsigned long timestamp, int tz,
> -		const char *message, void *cb_data)
> +		const char *message, void *cb_data, struct strbuf *err)

This doesn't match the signature of each_reflog_ent_fn.  Would putting
err in the cb_data struct work?

Curious,
Jonathan
