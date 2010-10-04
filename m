From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] do not depend on undefined signed integer overflow
Date: Mon, 4 Oct 2010 15:48:48 -0500
Message-ID: <20101004204848.GI6466@burratino>
References: <1286221388-4908-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2s1B-0001wS-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723Ab0JDUwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:52:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42270 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514Ab0JDUwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:52:07 -0400
Received: by ewy23 with SMTP id 23so2238411ewy.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3hMDhKDJPCflw5OmTYuzpDT6A5+fKJVUUdUKbWYAJRA=;
        b=C3iq7hKEZeDTlZCFob3IYcqx/EhFf+uDMolRTUTk0WLhGdtp6rlYWjnyPbcnu3dbs5
         RJHJqV3YZxt9KVuS3CCj5D8v8q8iMkPBHF2H33jWvo+iR/WB/Q4/CHdYLJviAurD8hIL
         gQsMO1a0wSrx33NBzbHyxmOu3prQmLlgeuUOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ls9ELHBWhoGBkbR7KPtjyVYVKuiWHmEJ0rwWriJqIauK4dNsPJ5+O+7CANqqxo1PFs
         H8VthlgG6QrOYtpfDGoc0iaUvUzedlKPzC1cyd4a34d3mZjQ/otqRd9ULYOrWxXsrGFG
         /p1tHnKKcj8oji6TB6pldANQnZfMdIACgdPs8=
Received: by 10.223.119.82 with SMTP id y18mr3049218faq.65.1286225525935;
        Mon, 04 Oct 2010 13:52:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r8sm2496127faq.10.2010.10.04.13.52.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 13:52:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286221388-4908-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158113>

Erik Faye-Lund wrote:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -28,6 +28,15 @@
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>  #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
>  
> +/*
> + * Signed integer overflow is undefined in C and some compilers take
> + * advantage of this when optimizing
[...]
> + */
> +#define signed_add_overflows(a, b) \
> +    ((b) > ((INTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a))) - (a)))

Clever.  I like it.
