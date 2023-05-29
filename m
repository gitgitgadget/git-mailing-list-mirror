Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9159DC7EE29
	for <git@archiver.kernel.org>; Mon, 29 May 2023 11:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjE2LsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjE2LsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 07:48:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734BA7
        for <git@vger.kernel.org>; Mon, 29 May 2023 04:48:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51452556acdso1940452a12.2
        for <git@vger.kernel.org>; Mon, 29 May 2023 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685360891; x=1687952891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98r2RSyVjV89XOMnmlzQS8wdPCfaqqH0+8Pfb8Ue+4Y=;
        b=eDuMfmvxPvrFekRX9EzPAqHODThqYyBjXXPAViykrTazB9+EKd7iPdOcpsAVORaETx
         +KvQPET7G4XzEEBWpHCwFzF4NZF4lebnMwZNKiYy2uXSRxD45+av/uMuQtguSawwPPdi
         PEeZIxq+r3Cp1o7lhKfE2otQ4BAUtEOLvDQeWzBRv4MEO2BaUrpCvLz6ppMeP48O9UUZ
         yBSp9OgLxwOoUd3srVRzAgkzuy1vD2wBFD4ffizbEGRZJ7YqK1LpO3PaTRgsTKVjhzOa
         p31lLA67SmUSiquYut6Y0qIiTrUbn6bejE+1EEdWMccJ2LXJ4Af6w05pWjkDVEJGJBWb
         Qxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360891; x=1687952891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98r2RSyVjV89XOMnmlzQS8wdPCfaqqH0+8Pfb8Ue+4Y=;
        b=aXPYEVwV9poLFfKAW2Rpm3J7D7GZtmiRIEQnW8in0qG76qH0X7AIkZ45OHfIIYZ5xj
         LXXMbE7oStLBR+/jfUn/xJUD46VDCHKjBVzuPOuadh38eEEHshE04FLcfRpm8kZIn1J/
         lLmw2daj6rhx8aoxyrnch8HdPPAZMvjPjg3YueS4ekdH4OkL7Rh48NNY5cFme11FABHW
         amCSfglaUCvr3zRf3yjKGqpE/RpkLy+L97xZEpzaNbc+HiAAHpv8QpX+1AmdZ1ZnB8/b
         u50VaCtX6og2jktqz74Y2za86S8n1Fcoml4ko+yvxTNptsVNG9yE3aqjnXI1jnzXol41
         SJlA==
X-Gm-Message-State: AC+VfDwBXGIkuuWFKyn5eQ6xBtG83qOpYF/V0Ojx/8I6w1XOr6YsvJHq
        5zkX2+sd23g4RvqA8Es+M9wFszfYyTOL7DRR
X-Google-Smtp-Source: ACHHUZ7qPI+tAlgS9hRejh0tGNRz16qbDovZlVcJBZFzzxg6BYjRiCn8RWaqqxfTkJXE0fn4I+c+TA==
X-Received: by 2002:a17:90b:68f:b0:24f:13ec:ecac with SMTP id m15-20020a17090b068f00b0024f13ececacmr10309368pjz.26.1685360890765;
        Mon, 29 May 2023 04:48:10 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090ae00500b0025677ccf217sm2139269pjy.1.2023.05.29.04.48.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 May 2023 04:48:10 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 4/6] notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]' option
Date:   Mon, 29 May 2023 19:48:04 +0800
Message-ID: <20230529114804.5129-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <20230527171936.GA1460206@coredump.intra.peff.net>
References: <20230527171936.GA1460206@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> No, not usually. I usually run it when I am working on a patch that does
> something tricky with memory handling, and I want extra confidence that
> I haven't screwed anything up. :)
> 
> We do run CI jobs for both ASan and UBSan, as of 1c0962c0c4 (ci: add
> address and undefined sanitizer tasks, 2022-10-20). But they run with
> gcc, which doesn't seem to catch this particular case.
> 
> IMHO it might be worth switching to clang for those jobs. My vague
> recollection was that I've seen it catch more things, but now we have a
> concrete example. I think it might also run faster (for some reason
> doing both sanitizers at once is slower for gcc, but faster for clang).

Thanks for explaining this.
