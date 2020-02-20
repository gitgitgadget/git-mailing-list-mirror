Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB4C34031
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 05:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173E224656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 05:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EumEgaV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgBTFrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:47:33 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34158 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 00:47:32 -0500
Received: by mail-pg1-f173.google.com with SMTP id j4so1359006pgi.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 21:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VOLODrF2oDqCrhu48N4pWAayeWMEnZUW3w6rySX0OY0=;
        b=EumEgaV1PHOfPdhCD5u+h3WHXYJ83sW4acE2UnZlA6Fa+L4wMLBQaIxTS1zIpmRxPo
         xzNWRfL50fNl/gkKn8Fy+cR9/OxsEY28waUX+yIOqhH+mq4oi0B3pUKvFFwdeBNKGzNj
         vcv1UsZgX2pDM86KoH/HHhW8xpWAAys6GnFq20MAgD7Drl0PSj+FqAZwtFb4TxkRiIXk
         6MFEqtRIvqbLsFasBB02rSAeIJtB1EN65niGAJ8l3qywvb6Ph3OhZ1EYzF6972aP/d39
         PFe3IBZhVg4DyjqzKkX2HJ56Z8RYhH7bcVqnLMdXmqtxEJuvxdAnp/PEj6aTuLszOtNS
         y3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOLODrF2oDqCrhu48N4pWAayeWMEnZUW3w6rySX0OY0=;
        b=rGHEs8Cx1L304cPZNAXNoLZmrcXRVIvypArM07yq+r2JWvRcnH9FywgV0yUDIXw/s1
         sTqHPKciFHkN+61I99KK+CIqBzkUDqrDj+YvtvppUTmeS3oZsZdgYUzzdOBAqIlUaZJN
         dC/ervuKQMx484nRX2zULACucT8gpj1e+UVw67QVYdXUjMUM/LY7PHVHlSvKX/rcItfM
         fNl1V05SPlr8A1uxDqXFhd9dV+VShNhad1NFj6NTJMb7z0rkJzDoJecyeqzgK872z848
         n3PDI6uZJk8Q88d2bAOV0RijhxICatXeEt5eW/N/dL5+XFNgpZoVgfHvkiTgh68H5nrb
         nNpg==
X-Gm-Message-State: APjAAAUEI7hquMr3xn3mE5Qc/vyr/3J3hf0eu2IgSkW9H2we3VuSYSHH
        7N3rWxlqAsFRdylMTpCuwLUBo5iF
X-Google-Smtp-Source: APXvYqx+bnDeMneyeNdU8XIjTM0neJbNGO6gu9JsWc8Mvobpv+ZXU9EzCCcp30TNyzg8Q4vVS0wmOw==
X-Received: by 2002:aa7:84cd:: with SMTP id x13mr31743390pfn.130.1582177651638;
        Wed, 19 Feb 2020 21:47:31 -0800 (PST)
Received: from [172.21.112.155] (gateway-est.zohoindia.com. [121.244.91.2])
        by smtp.gmail.com with ESMTPSA id o9sm1583418pfg.130.2020.02.19.21.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 21:47:30 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.25.1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20200219185329.6640-1-johannes.schindelin@gmx.de>
 <nycvar.QRO.7.76.6.2002192110230.46@tvgsbejvaqbjf.bet>
Message-ID: <f134ed69-05fb-56f1-5005-db738b6afcd4@gmail.com>
Date:   Thu, 20 Feb 2020 11:16:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2002192110230.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

-Cc: git-packagers@googlegroups.com, git-for-windows@googlegroups.com

On 20 February 2020 01:40:39 GMT+05:30, Johannes Schindelin 
<Johannes.Schindelin@gmx.de> wrote:
>
>The reason for these two glitches is the same as the reason for the
>delay
>(Git v2.25.1 has been released almost four days ago, after all, and I
>try
>to stay relatively close with Git for Windows releases): for technical
>reasons, I had to move the automation that I use to publish new
>versions
>of Git for Windows, and I used this excuse not only to make it public
>(https://dev.azure.com/git-for-windows/git/_build?definitionId=34) but
>also to modernize the pipeline as well as to split it into a build and
>a
>release pipeline.
>
>This required a lot of refactoring of the huge automation shell script
>(https://github.com/git-for-windows/build-extra/blob/master/please.sh),
>and every refactoring has some fallout. On the positive side, the new
>pipelines should be more robust and a lot faster, too.
>

That's a good thing despite the minor fallout.

> Here's hoping that future releases go smoother than this one :-)

Thanks a lot for your relentless efforts to make Git-for-Windows better!

>Thanks,
>Johannes
>

I haven't noticed you sign using your real name before that I had a mild 
suspicion if this was really you or one of your automaton's gone rogue 
;-) Just now realized that you sign all your Git-for-Windows release 
e-mails this way.

--
Sivaraam
