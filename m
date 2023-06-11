Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F0AC77B7A
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 14:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjFKO5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFKO5B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 10:57:01 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD4F0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 07:57:00 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62de5392c7bso1994746d6.2
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686495419; x=1689087419;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s98z0xoaPgTLh6ip7Wvo73gIDu9XCbwEFhF7qlBcX8=;
        b=N5ElGRgmt73RNrKOCPEkN5KLOsM6lorralV/5+ToCIOGwAGCHEXxJ2YKiQjgTLOaYX
         /qQEUz+ROiU2hX8cdR1CLrRCBBW2t4tNocwqlTL9HuQenCqCR9h2Ch1R148S/S89SQTB
         oLlYXcsQsOceth29B/TRZM+6Il8UXQWaD73tg5dGK68hBJI8UzyDVWVGtmyUTRTv02iK
         +UiT4AqzHBy/ko+uQCqoP5+6FrpBg4b303CIQ5+NvTIMw/a3TGNXeG9s7CVDsKDTcF1a
         YxoasTjhDP5tjbpx60BRH1xIK4XnqD5bK7utCKa7FssiMo0glV6z3D9KuH5lUFtBiwD3
         viGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686495419; x=1689087419;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7s98z0xoaPgTLh6ip7Wvo73gIDu9XCbwEFhF7qlBcX8=;
        b=Tuw6EFTmB/YORaf2oSZSknhpqPifLQus+HPQP/kw5/A+jU6LR30f90rJ6jbDtgys8X
         oGv+2obHHxWGXHvMs4sBoOaDqd4nZea3/m4ibPkshoqvkvBWkw1E+Gbhp/3rTpHKHrUt
         EfXMv29IpMsClbl+fm2m/GScTqeF1htuPAn6t51gYKxBbiLX6J80u5dRuC8NRqRcLeQl
         AyzYxrEaLNKcnJZ0dF9Ks9D0dAGp7GeE78zFNzSOYM2r9/+rCsVfTaRrUaY8m/ZnlATK
         fYI21VZRgxLIlc6sxjcfQIsf3HsOyUJSRKaB9EHP29w0sqW1ErsPAMiIjzT2lC4euMHa
         hYIw==
X-Gm-Message-State: AC+VfDyvWR70D7xInihcKBxZpLmCKEefSl6P9GO9ZNdHyUfuxlrCEpzG
        VO0+qvKk1gXjzSl8VoLeLxPFxTKfSNE=
X-Google-Smtp-Source: ACHHUZ5Eyl5XbuxsSJWX5VvCBXbjELUiaDB1ASLfr4QewiE5ORiVR3PCdxOtimawiSer6l7znvjeOQ==
X-Received: by 2002:ad4:5c42:0:b0:5c2:6493:f631 with SMTP id a2-20020ad45c42000000b005c26493f631mr8946049qva.51.1686495419602;
        Sun, 11 Jun 2023 07:56:59 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id y22-20020ac87096000000b003ef33e02eb9sm2690035qto.83.2023.06.11.07.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 07:56:59 -0700 (PDT)
Subject: Re: [PATCH 23/25] completion: complete --diff-merges, its options and
 --no-diff-merges
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
 <5dc1e541d1606807e188015ce51da4f2c7f8ff5b.1686428485.git.gitgitgadget@gmail.com>
 <CAPig+cQ_A1i5NNmaLUmGt+h-J0PugrFX7jkKJ=dBDg3Ygk2hJQ@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <76eeff98-3e6c-a1dd-6498-b6d88c61fe81@gmail.com>
Date:   Sun, 11 Jun 2023 10:56:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ_A1i5NNmaLUmGt+h-J0PugrFX7jkKJ=dBDg3Ygk2hJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Le 2023-06-10 à 22:35, Eric Sunshine a écrit :
> On Sat, Jun 10, 2023 at 4:24 PM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The flgs --[no-]diff-merges only make sense for 'git log' and 'git
> 
> s/flgs/flags/
> 

Thanks, I fixed this as well as the styling of the comment on patch 25.

Philippe.
