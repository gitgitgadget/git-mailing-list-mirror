From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] push: introduce new push.default mode "simple"
Date: Tue, 24 Apr 2012 18:53:14 -0700
Message-ID: <xmqqd36weewk.fsf@junio.mtv.corp.google.com>
References: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335253806-9059-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 25 04:14:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMrkg-0001dp-1k
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 04:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757941Ab2DYCOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 22:14:37 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:60316 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757805Ab2DYCOg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 22:14:36 -0400
Received: by qcsp5 with SMTP id p5so162827qcs.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:references:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=zb3LuSO6MMzu+xHmpWxnfowLA1iGfTHuWGLvP9gR/iU=;
        b=i8R3W2tsTs7M7wkAwX0CVewBL6GVnw0tHqd1Uao2ygvdC7lTFOqB5DeKt6Uo36wnFu
         kxRP9ikAdij8rGkd0yrps0G8t0Tjs/VBaejx7GzfFcPNwRDxFryXhFOci2NYyd2ftRej
         YsqjQgnQFGQRN8VCYhw+tQKXCFaFiAQuAgcUTNM+k/fTaetk71+abwy0iQQkLzrJ8lg+
         auv0cKguTxf8E5YupBJq+//KqEFl32TG0hTQaFkYcMD3gvAW4N9hmLR/xXSVSFta/o2k
         ins1ZFrRjuFcsEEsYdpyV+W3O8DrpLp69/r6LM8hMyUgAITES0AIlIw1+3YsFZ0OfxVv
         mYFQ==
Received: by 10.100.245.28 with SMTP id s28mr377414anh.6.1335320075717;
        Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
Received: by 10.100.245.28 with SMTP id s28mr377395anh.6.1335320075571;
        Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j51si20066428yhi.1.2012.04.24.19.14.35
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 76A3010005D;
	Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 2A1F7E1756; Tue, 24 Apr 2012 19:14:35 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnwEh9nHn8duupK5rcCXXmX+IYqOOMT/gcaeSYXT4e5ydNx6Ox7qoLaBcHFU/M8yQl/DZRO2mqTzwNEjHh7ivirAbMGXuQgUKYwTz63yI4LZD3d2TD/Z+VY09iGzDCB5QDcKdGDAobHX9ypx45LBL3P1NqU+FgatwcnkD46CWeR30hYc1Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196296>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/builtin/push.c b/builtin/push.c
> index 6936713..8e663db 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -76,7 +76,43 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
>  	return remote->url_nr;
>  }
>  
> -static void setup_push_upstream(struct remote *remote)
> +static NORETURN int die_push_simple(struct branch *branch, struct remote *remote) {
> +	/*
> +	 * There's no point in using shorten_unambiguous_ref here,
> +	 * as the ambiguity would be on the remote side, not what
> +	 * we have locally. Plus, this is supposed to be the simple
> +	 * mode. If the user is doing something crazy like setting
> +	 * upstream to a non-branch, we should probably be showing
> +	 * them the big ugly fully qualified ref.
> +	 */
> +	const char *short_upstream =
> +		skip_prefix(branch->merge[0]->src, "refs/heads/");
> +	if (!short_upstream)
> +		short_upstream = branch->merge[0]->src;
> +	/*
> +	 * Don't show advice for people who explicitely set
> +	 * push.default.
> +	 */
> +	const char *advice_maybe = "";

I've amended this to avoid decl-after-stmt.

I think the series is ready for 'next' but I'll wait for a few days or
until I see acks from trusted others, whichever comes sooner.

Thanks.
