Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646CA20970
	for <e@80x24.org>; Fri, 14 Apr 2017 20:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbdDNUZA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:25:00 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34933 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdDNUYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:24:50 -0400
Received: by mail-pg0-f41.google.com with SMTP id 72so38865784pge.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pTEi0FtIpg+2Kq4gWmZpUD3h82RIJ/Qwaz2Rcjb/9xI=;
        b=l0WNZc09oD+AKxJGW3xmIfhVxcI7mSZhQAeqZkJKyQ9lKjmSvz86N1aMxI5SNvgSxZ
         LZeFfNs3ZVjfIyCj5qo+bAz/MpnilxOqtpNVGMLbsdKOs9ZFNfnQWdb8CTPcT3je2J+R
         hQJB/Ml4gM3Srl1FhvmIG7xv6YuAHftjUi+n+jDee0/Z2zJjso0vTSRgBT2k6CCLTQad
         QSwuEMeq4mzgjLoJjycshpf66yalR+qal7dbU690RXIqrkkoJCICo5QMaM0jpRoIbxo1
         1KvMklMXsvQTYcvyLc2t35jp+kVNaveToSPeUa0X5J2cIdf7izSqk1LNgM5qCpRdpcAM
         K1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pTEi0FtIpg+2Kq4gWmZpUD3h82RIJ/Qwaz2Rcjb/9xI=;
        b=BAzcRAX0BCQ7r2AEFe1Noy//sWDsmq4ylhysFhY0TeFmT7mJbjvxxaQaozTNKVUFAC
         Iv4g11BlM5+Y09j66yCi0u6bRDQI8OWNu2h4Re0EZFVQd2kK5VB+7EjiNKVpYt2yPWJs
         b9D3B/e0cx2tTDTRKQbr1tIEWeNHsrSEJK5YnkKY1BFz+EZxETUIUxqyCwPnzX1oC6lA
         sYVUZij5UDjde2BwfE80pjb7otZbk/yBmAd1WXQzk7ShxS4A7kEmyPzO6KDlGwKtSPYW
         mCyVTruzKK8ZI0F3LyR0VmkwmZo4x2kgfOv/9UV1rzOcypawb1ckBzNxSlvLbYGha+nj
         2e3g==
X-Gm-Message-State: AN3rC/6hFSkMTYG8OhpEkmnbct9n/5xelgZFz52yS6wnwPe8Dt/ZW56X
        qgKbMQA1pqswIyQ6
X-Received: by 10.98.202.80 with SMTP id n77mr8934252pfg.158.1492201489294;
        Fri, 14 Apr 2017 13:24:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:11e7:137a:7479:ecbc])
        by smtp.gmail.com with ESMTPSA id o23sm4743265pfi.100.2017.04.14.13.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2017 13:24:48 -0700 (PDT)
Date:   Fri, 14 Apr 2017 13:24:47 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, jrnieder@gmail.com
Subject: Re: [PATCH v3 10/10] run-command: block signals between fork and
 execve
Message-ID: <20170414202447.GC54940@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
 <20170414165902.174167-11-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414165902.174167-11-bmwill@google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/14, Brandon Williams wrote:
>  		/*
> +		 * restore default signal handlers here, in case
> +		 * we catch a signal right before execve below
> +		 */
> +		for (sig = 1; sig < NSIG; sig++) {
> +			sighandler_t old = signal(sig, SIG_DFL);

So sighandler_t doesn't work on macOS.  Is there a more portable lib
that needs to be included for this to work?

> +
> +			/* ignored signals get reset to SIG_DFL on execve */
> +			if (old == SIG_IGN)
> +				signal(sig, SIG_IGN);
> +		}
> +
> +		if (sigprocmask(SIG_SETMASK, &as.old, NULL) != 0)
> +			child_die(CHILD_ERR_SIGPROCMASK);
> +

-- 
Brandon Williams
