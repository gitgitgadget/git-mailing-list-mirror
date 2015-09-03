From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 24/43] refs.h: document make refname_is_safe and add it
 to header
Date: Wed, 02 Sep 2015 22:06:16 -0400
Organization: Twitter
Message-ID: <1441245976.25570.24.camel@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	 <1441245313-11907-25-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 04:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJvB-00048K-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 04:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbbICCGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 22:06:18 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36372 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbbICCGS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 22:06:18 -0400
Received: by qgx61 with SMTP id 61so18777929qgx.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 19:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=lzc1bGp7NEwIaBhaNJlBszOwlT2sxOO7NJA8Tfwfvp0=;
        b=CLIu7FRJs7GWA9sUQQdAkKafXxhk32SqWyvU6bYK4hAMc6qcGDhlvx6DI/QegBMRPJ
         5TnuJ/OUGwuX1yUHEMv2p/i16Nfu29fxL2z1g3uRZqI4PoxwWCIqypKH4FC0Yl9tmTdt
         X98g9+gAe4tJSniCUi8wuvpid2tXEPCuzAEgmUiV2DbeMfDOM41f3pc8d5yNVNJsB5nM
         IeT3wWYWhULl9JYIuEaDzNcv6fnENJDBWxCalqzPAznFiJ354N0brQQgOWMnQtmP5rni
         OoHLJ8gdtTaAW+5dnsBr/f9hjtN+QUiLinXoWPnvoyXkqpvX8bxCb50wcX8tUGJJZSng
         GYuw==
X-Gm-Message-State: ALoCoQkGKII01j/pdpgam7aXjbPMAuFcWr+9X9DGagQH9wgv98WG1ld0t3FT83s1dSK6uAC5Z1vM
X-Received: by 10.140.237.73 with SMTP id i70mr65836440qhc.37.1441245977566;
        Wed, 02 Sep 2015 19:06:17 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f10sm13918005qhc.12.2015.09.02.19.06.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2015 19:06:17 -0700 (PDT)
In-Reply-To: <1441245313-11907-25-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277180>

And, of course, as soon as I send these, I notice the bad signoff on
about half of them, including this one :(  Those probably got screwed up
when I ended up losing my entire repo once when a test went wrong.

Anyway, I went ahead and fixed them in my local version, so next rev
they'll be fine.

On Wed, 2015-09-02 at 21:54 -0400, David Turner wrote:
> This function might be used by other refs backends
> 
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  refs.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/refs.h b/refs.h
> index 5542587..359e166 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -259,6 +259,17 @@ int verify_refname_available(const char *newname, struct string_list *extra,
>  			     struct string_list *skip, struct strbuf *err);
>  
>  /*
> + * Check if a refname is safe.
> + * For refs that start with "refs/" we consider it safe as long they do
> + * not try to resolve to outside of refs/.
> + *
> + * For all other refs we only consider them safe iff they only contain
> + * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
> + * "config").
> + */
> +int refname_is_safe(const char *refname);
> +
> +/*
>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>   * REF_NODEREF: act on the ref directly, instead of dereferencing
>   *              symbolic references.
