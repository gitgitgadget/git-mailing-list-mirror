From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] submodule config lookup API
Date: Thu, 21 May 2015 11:40:44 -0700
Message-ID: <xmqqy4khixjn.fsf@gitster.dls.corp.google.com>
References: <20150521170616.GA22979@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu May 21 20:40:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVOl-0004rh-8h
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbbEUSks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:40:48 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34654 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbbEUSkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:40:46 -0400
Received: by ieczm2 with SMTP id zm2so15069556iec.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VQPL8AbIMr4cpJ4DHXyFWYyfRUzSfr8vG/6mf4bfsJk=;
        b=UlAssfUX559PPTJII73J8UFSP1eeORC/JGS463iHA0VmDPWsk0IF5pSEQX9XfYbuWL
         8pVRPaJ4Ml0FrLUB5rooDvETLlwgk8k8aTc2Q2GWl3B9ow16VQj1AcDz7belcCzZm3Zw
         YQlx7rM0WvWlwVlTrhLsC+SD5D5ahLPzFV/YUP1nJ0qSzKocUoH03v88/biPWEGn+/1u
         uhbXgEDN+jZJsotZHn8jQiSPM3CuvZUSpbDRbdobthVdVJua9LavdeLoKtUdXTH2mInX
         q9XMFWvDrfBRjwGaslGcS6fA8w/Xo5mbdqiaGZ55Fsu10lSeUyLKXoiB0zrhg5RBSpKz
         wZbA==
X-Received: by 10.50.61.229 with SMTP id t5mr137603igr.34.1432233646123;
        Thu, 21 May 2015 11:40:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id p8sm1761973iga.13.2015.05.21.11.40.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 11:40:45 -0700 (PDT)
In-Reply-To: <20150521170616.GA22979@book.hvoigt.net> (Heiko Voigt's message
	of "Thu, 21 May 2015 19:06:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269643>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This is finally the next iteration of the submodule config api. The last
> iteration can be found here:
>
> http://article.gmane.org/gmane.comp.version-control.git/252601
>
> This iteration fixes the lookup of submodules by name
> (submodule_from_name()) where one needed to pass in the gitmodule sha1
> by mistake. To keep it simple for the user and behave as documented we
> should take the commit sha1 which is now fixed here. We now also test
> the lookup by name in the api tests.
>
> This should be ready for inclusion.
>
> Cheers Heiko
>
> Here is the interdiff to the last iteration:
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 96623ad..177767d 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -25,6 +25,11 @@ struct submodule_entry {
>  	struct submodule *config;
>  };
>  
> +enum lookup_type {
> +	lookup_name,
> +	lookup_path,
> +};

Please lose the comma after the last element in enum.  Some
compilers do not like it, I was told.

> +	switch (lookup_type) {
> +		case lookup_name:
> +			submodule = cache_lookup_name(cache, sha1, key);
> +			break;
> +		case lookup_path:
> +			submodule = cache_lookup_path(cache, sha1, key);
> +			break;

Is this too deeply indented?
