Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19275C55178
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A680D2076E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byb7dB7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgJ2Um4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgJ2Ul4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:41:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842DFC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:41:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id oq3so3787482ejb.7
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0boLBFpfpLLt9qbMjgYw4CMs4MMdxYZFmrPh8SnE6U=;
        b=Byb7dB7LvEWpQmFPqcDkiWD0VoJ1N5QkCjIPZwcUqDGJpx9xqQjfy7zsAwMCbZL9yI
         +NLrSz53i9Ai7X5uELWjb6evebiNTJLBLleTTjt76rZmwOlEJVkxEhnhd7K9T5ceUsI8
         kKWDjm9il7ugmXpo+Y0YCgWiRudOnfXOil2xH/T+wGrgvkfXdGGJIpMDqzTH8qisrFtc
         4bFF/0vDdW0W2M7LlVI1uNPsvFLZRoPmcfWINNv7xcQ7yWcxhit5THIKX6IFhp8NE1r5
         RwQxzDETuhBLQTrAwx2v6ogNcrnhu5iewynuszcOu/61neX0zYyXg3FXEq+Kn3TFNTl7
         5muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0boLBFpfpLLt9qbMjgYw4CMs4MMdxYZFmrPh8SnE6U=;
        b=OAW+qgKyAdOVcGxo2aYTHhoQsudxYH480l6ij5MH3Fp690dB5q4pqQXNo4T5ShUyZ8
         UoM2J3q4CxeQCfzluPC0OAOIzMBqh06ApjffyHSAPw+hZeG5y8UqlEoZS1y+ljLX1Yl1
         esfIXRk+9T/MhrOIhma3CzrGYp10n/izFb6Y5hRv/EHVFgDh+OZwfPk3ITTyxaipuJBC
         lOpXpyE1WQM7Z2JZqoHx8+9MjDgpRQeOCijEeLWsGdc6nmQlqpsElEvtXx9CwfzHzvG2
         g4jAaAS68FJRQJcIYnURWXT7Dx9r6El4n9S9sxKlndTce5ziIax5kt+jtSK1VUG+EKy5
         PFRQ==
X-Gm-Message-State: AOAM53072WuZKXWOO18itrCAcwX7ktbpfCLe/qUzl8CZjLzP4ob0Yznl
        0CnJjE7EUQLF0dtQNadQhyU=
X-Google-Smtp-Source: ABdhPJx3bkizpNUbmFvn/SX32s3FW+CbxYlTorracVmXvaq5PMmzbhmpPW1beyYColdM3WfdRc6Mow==
X-Received: by 2002:a17:906:804:: with SMTP id e4mr4648565ejd.420.1604004113262;
        Thu, 29 Oct 2020 13:41:53 -0700 (PDT)
Received: from partizan.lan ([46.98.123.221])
        by smtp.gmail.com with ESMTPSA id nu20sm2006807ejb.109.2020.10.29.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:41:52 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     marcnarc@xiplink.com
Cc:     git@vger.kernel.org, Serg Tereshchenko <serg.partizan@gmail.com>
Subject: RE: git-gui: Why are the main panels no longer white?
Date:   Thu, 29 Oct 2020 22:41:49 +0200
Message-Id: <20201029204149.20232-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
References: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, this git-send-email is terrible. Is there good email client supporting
plaintext messages which i can use for replying here?

I tried to send message, but only footer is delivered. Second try:

> Is there some way I can edit/view the theme definitions?

Themes is inside /usr/lib/tk8.6/ttk/, *Theme.tcl

> Unfortunately none of those gives me white panels, although I do see 
> other visual aspects change under different themes (also, `xrdb -query` 
> shows that the *Text.Background setting has applied).

This is strange.

I just checked `default` theme, and in my case panels are white by default.

I will check it on kubuntu later.

Can you show your `xrdb -query`?

--
Regards,
Serg Tereshchenko
