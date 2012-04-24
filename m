From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #09; Mon, 23)
Date: Tue, 24 Apr 2012 11:57:26 -0700
Message-ID: <xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
	<4F966F0C.6090504@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Apr 24 20:57:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMkve-0001S3-QI
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 20:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385Ab2DXS5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 14:57:30 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:50764 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab2DXS53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 14:57:29 -0400
Received: by bkcjk7 with SMTP id jk7so52659bkc.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 11:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=CO2l/oWZO6KcHmGuXdbVr5pnMQMAv6qtZcjc4RzJFD0=;
        b=DT5X76eINbKg76OWRbVaYdUWvd7l6m1YZff31rVR6//JXjAEt9CAYxN8GdhswNajGH
         bwBMVWYPTelEOS39v9SqmGcogFde1mD5Wjn96ub73ccCJiecq3r6jvjSYke4E0BAC8sL
         vtWAbjwqXfcwIEtewu5oBQMUe/LXIYu+hzkTLEKcJ1x280niAD593AVlletYwn5wA/hs
         SYXGVApL/cTwjERjQwUtNBBXKBZK6Yo250w0vjIfnaxFJXINhR0oCTxDGKu4wvVgbM2C
         rT3jaQ7L/RJxleYJA6Of/IUlwB0YIghUPU0m3DpWSFif0J0deKwJu3Qde8rUzC6zCZ+4
         3lDw==
Received: by 10.213.2.198 with SMTP id 6mr7906ebk.25.1335293847879;
        Tue, 24 Apr 2012 11:57:27 -0700 (PDT)
Received: by 10.213.2.198 with SMTP id 6mr7896ebk.25.1335293847725;
        Tue, 24 Apr 2012 11:57:27 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si18572943een.0.2012.04.24.11.57.27
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 11:57:27 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 8403F5C0060;
	Tue, 24 Apr 2012 11:57:27 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id C8A3DE125C; Tue, 24 Apr 2012 11:57:26 -0700 (PDT)
In-Reply-To: <4F966F0C.6090504@seap.minhap.es> (Nelson Benitez Leon's message
	of "Tue, 24 Apr 2012 11:14:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlOOBdRtHkgx9N5JWuMBmyqWckPGioDBACNkmSW3IdaxuBznsznVR4zcGn1lN92tJbcGfQ2enfyTWCvkbOxgMj00+kPnAz5rvI+/3pU0Y5iGCFQ4MOcZjcy8MzA6USYtCmkXSFE4Of4iF5O1zoKoQjxsa/OJevbiXYL2gRaRIsRB81PfcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196236>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> My original patch already peeked in HTTPS_PROXY env var, I post the
> relevant part:
>  
> +	if (!curl_http_proxy) {
> +		const char *env_proxy, *no_proxy;
> +		char *env_proxy_var;
> +		int read_http_proxy;
> +		struct strbuf buf = STRBUF_INIT;
> +		credential_from_url(&cre_url, url);
> +		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
> +		env_proxy_var = strbuf_detach(&buf, NULL);
> +		env_proxy = getenv(env_proxy_var);
>
>                 ^^ HERE ^^

When cre_url.protocol is "https", this looks at $ENV{"https_proxy"}, no?

    http://curl.haxx.se/docs/manpage.html#ENVIRONMENT

> so are you referring to something else ?

There may be some other things that break people's settings but
regarding PROXY, the above was wnat I was referring to.
