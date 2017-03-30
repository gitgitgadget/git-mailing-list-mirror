Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AD020966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbdC3Umc (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:42:32 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33363 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbdC3Umb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:42:31 -0400
Received: by mail-vk0-f50.google.com with SMTP id d188so68857024vka.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kkHI2/wUR3HQ08ku55bSzIwiIyReL2wrZ/XKV57u5Ds=;
        b=GAIsxlfZ9bzxjcmIlzCzI+bpaWi4Yongk6XrlmcqsdwhcCMrgPtgVvn4Nc3RSE7dy6
         HE3Tf9fAdnpdpH0odkcxRkpQ8Xezhtn5tt7gOXofzjxcMHPsEzUK/c+EaxDovjeUPd7c
         VsUc9ueilvvM+nJwJgVHs1cuX/MedaHJbCvos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kkHI2/wUR3HQ08ku55bSzIwiIyReL2wrZ/XKV57u5Ds=;
        b=t8zX47RGDEp8r7SaqTooXx4zUUZnjQBg+AH0gW9Z/FuJE6E39sqFhxZqfwwBb/BKEa
         qH82sDkp4ocpmB4H8Csex3lWfXhM7tt9KAAKB5cX7J0Q3nEmuexoZP7vNZ1Yai+DwvMK
         Al5Ci6mEXXfU2wka6IRxOTFgS/BURcmvF/v9OO3K68Tnnr2Ei9uydtufsx+xYz2RHeNC
         jZ76k73A96eL2Bw1n3xIPOfWB0g0Bz1oVQVY9DsJlNUAIwJ3j+mHAwiNsU1Y47ZaPjjn
         g4yTOAwKkV5yTceoP9LsyheHLp0c+mmhASN8PinWyM0fnqilyAulkAJnq22pEM6xAIFV
         6neA==
X-Gm-Message-State: AFeK/H2TYNuP+YxM8LroSe1TZcABN7CSWJ0Wtma06j+V0+7xRQrwt4siBUToCpuo5c08T6SQvT3TMWAH8uh/cA==
X-Received: by 10.31.92.20 with SMTP id q20mr770321vkb.146.1490906549786; Thu,
 30 Mar 2017 13:42:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.125.7 with HTTP; Thu, 30 Mar 2017 13:42:09 -0700 (PDT)
In-Reply-To: <20170330202917.24281-1-dturner@twosigma.com>
References: <20170330202917.24281-1-dturner@twosigma.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 30 Mar 2017 13:42:09 -0700
Message-ID: <CAJo=hJvs0UKO_NLbWAi8Y8XRJJ0v5kdjf9BN0V=pN_9yYrDp7Q@mail.gmail.com>
Subject: Re: [PATCH] http.postbuffer: make a size_t
To:     David Turner <dturner@twosigma.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 1:29 PM, David Turner <dturner@twosigma.com> wrote:
> Unfortunately, in order to push some large repos, the http postbuffer
> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> we just malloc a larger buffer.

I'm slightly curious what server you are pushing to that needs the
entire thing buffered to compute a Content-Length, rather than using
Transfer-Encoding: chunked. Most Git-over-HTTP should be accepting
Transfer-Encoding: chunked when the stream exceeds postBuffer.
