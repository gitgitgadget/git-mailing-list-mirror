Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B284EC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 11:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196BF20780
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 11:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdldY+PL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ2LoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2LoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 07:44:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26268C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 04:44:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w27so3406231ejb.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtlHGrsdkRv2sEMta5DxwJ8hikNHlfKjYdRf5UOnDr8=;
        b=fdldY+PLbVEWkUsrCGm5a/6a7/hHMKGOEXkDTscasCXKimEDgpXQSBgZCRrMTZzEip
         MH96JfPSbRafUQjP95tMBcZdN6CBzD6bvZOk4y1s5SgtGE6my+sUtphPQaGZv52htBck
         gzQeYqWQCjVyVc/6ouEaIkBZbHpHsLaOPwb+7pigMZjN36bH71sS488XrPGxnWRgnwTU
         4Qr3ONIC6vJBYE4495+R2yi3SWE+f/kRJdcsr4vz5MvexBh0R82JWV61fp5i113Ww6pG
         ccuxuPliIvFpzYRMjIbdI7sCjJ9DaDCAPthhEvzEdS4Fo9OV84l4g31RY9Q7bx5KFIKL
         FR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtlHGrsdkRv2sEMta5DxwJ8hikNHlfKjYdRf5UOnDr8=;
        b=JWapAzFz4/K7Jku0+0te99A1qXiD7k3v+jj431OQAInSPXZ0CB+bomR3T7KxR/+OZP
         a3d4AsqdQGTR2gifKAZcUNTeASmVn1D2b9lljnfJ5k7qi7/ewoJIRqeQT8vq5wkMGkNj
         rzEEgfRWP9Fma5wKWEY/5GSuk8EPXfNhbHWuZlS/OkqUezDsF8/87HX/UF43vk4gsjDn
         KI4ZGWuWZsgdSuXcEWtFYb5pIpLhvhFOsUtcQvt2/dc57mcxUOd2rA6uV5YXL3Wy1i8/
         pEv0PmiHtP4X+jcPmUF/BKmvfD/sAj5B4Z54ShTvZp7PDBHZGLaRN7PrcpyXvBJ7K64E
         6vhg==
X-Gm-Message-State: AOAM533Wwqbyxl+B5YowYx1ZibNXVkGMxxBEp4OahIJzm2fwOh9INj2s
        nhH8KlTEfnaaiRt0Nlia6TM=
X-Google-Smtp-Source: ABdhPJwOPRwEdV6SjIL1fMAtj5/XdAjMDpDq6LY7077SXtTfgl+4sdD+uwb4OMk9ylUfqxA54NWNRw==
X-Received: by 2002:a17:906:7096:: with SMTP id b22mr3788890ejk.335.1603971844765;
        Thu, 29 Oct 2020 04:44:04 -0700 (PDT)
Received: from partizan.lan ([46.98.122.18])
        by smtp.gmail.com with ESMTPSA id m25sm1359704edp.36.2020.10.29.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:44:04 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     marcnarc@xiplink.com
Cc:     git@vger.kernel.org, me@yadavpratyush.com, serg.partizan@gmail.com
Subject: RE: git-gui: Why are the main panels no longer white?
Date:   Thu, 29 Oct 2020 13:44:00 +0200
Message-Id: <20201029114400.38284-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <6a38e92e-ffd5-4b0e-b850-3697e47b2b92@xiplink.com>
References: <6a38e92e-ffd5-4b0e-b850-3697e47b2b92@xiplink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc!

What tcl-tk theme are you using? Autodetection supposed to fetch
color from TreeView background, and probably your theme using
that odd gray for TreeViews.

To set your desired color for background, you can add 

*Text.Background: white

to ~/.Xresources; and `xrdb -merge ~/.Xresources` to apply it.

Or, try another theme. This one gives me white background.

*TkTheme: clam

To list available themes, run `wish`

::ttk::themes

--
Regards,
Serg Tereshchenko
