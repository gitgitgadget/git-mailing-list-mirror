Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3758C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F552074B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEPuYUON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgFAUAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgFAUAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 16:00:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9EC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 13:00:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so257186pje.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=00rtcSlKoJxyRATpwRk6+cvoK6CS+0PDX5BUDniZFZY=;
        b=YEPuYUON3w0Ak+eHs3JPuiYEBp35k/JRRtzwQmqyyNRuUeX+f0cpk37e4cjKMlnMrZ
         /wmqRojKPvtxl9qINSoHQKzKUOigBdPndqlhzTG1eLOtCQ/SbolZbyMKwgChVByW7WeF
         ZjUSnWU0hnUc6q9d+67M78Y9MBK8mPuefSaeMkAxaK4PGz2cO245NqXbTFRah6/EHinZ
         fWnOfY+qpzKN4Z0Sz4utAOFH4CfHPxjuy8wW/3FtVAS794z5nKpZ8mi8sRS5pRzyZQoI
         K4CzX1zU1/K63a8oA3g9W5qKOB5n49N0KqubQ3shySXjKKmTgPiOoSeJSZils+cIQuyS
         DroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=00rtcSlKoJxyRATpwRk6+cvoK6CS+0PDX5BUDniZFZY=;
        b=QuG6NjmLeF6NC0/3/Me9tsOh7wpObTxxfHVQ3ACZ8Y5CYmHs0plaK4SJ4vuClMX1mN
         EdAzrMAsEFAtUPchZtJr34E7ISU7vuIecyxkqcg6oL1HrdFHbkL9aW3SRxSYg2nCBDpE
         uvtAXhgtMpxe8xg8PXPvxg9/4kFKL/RMEATChE9FaVjkq32KHjbF1MW2IrbSPt+GbUn/
         NYgexmGwplC2zMQzzKZC1aLzG8tF8HE/an1+RaWl7YKCKQvlENTJzDVJX50W5mh0grLj
         qdU6i3/C4cezUM7YwopWjV8rrc4zgKSS1ok23xM9iqPd5IJGZkfbmRIIo1tkpLMBrwng
         /t9A==
X-Gm-Message-State: AOAM530w3bdsBoy6Tu35Z0LBLA9RemgKgnRJbcQQwuXW4lHif4URSKlc
        oxHysegymgAFm1XhSPpt4hzBU25C
X-Google-Smtp-Source: ABdhPJwq5zfOFPSdtj2tkZv21SSkyMJQxX8JQfa+xILIpQFLP63uJYwaCjQWyiBGy93jv6tEGuHecg==
X-Received: by 2002:a17:902:b710:: with SMTP id d16mr21793328pls.28.1591041604177;
        Mon, 01 Jun 2020 13:00:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id e19sm226984pfn.17.2020.06.01.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:00:03 -0700 (PDT)
Date:   Mon, 1 Jun 2020 13:00:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] upload-pack: send part of packfile response as uri
Message-ID: <20200601200001.GB98003@google.com>
References: <cover.1590789428.git.jonathantanmy@google.com>
 <2cfee363873736d9ff73cd38d96f3533bb49c904.1590789428.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cfee363873736d9ff73cd38d96f3533bb49c904.1590789428.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> +++ b/builtin/pack-objects.c
[...]
> @@ -192,6 +227,11 @@ static void create_pack_file(const struct object_array *have_obj,
>  					 spec);
>  		}
>  	}
> +	if (uri_protocols) {
> +		for (i = 0; i < uri_protocols->nr; i++)
> +			argv_array_pushf(&pack_objects.args, "--uri-protocol=%s",
> +					 uri_protocols->items[0].string);

Should this be items[i]?

Thanks,
Jonathan
