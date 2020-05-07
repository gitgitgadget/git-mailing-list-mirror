Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921FAC54E49
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6638A2084D
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEzmSN2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgEGKxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 06:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgEGKxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 06:53:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C700C061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 03:53:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f6so2533659pgm.1
        for <git@vger.kernel.org>; Thu, 07 May 2020 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=buNFUX5Vj73F44vALmwcpLFpoqo8B/U6U36Uotr3hi8=;
        b=iEzmSN2m+DsGdBuoUsRnuXLU3OTtGalT3KhLRnya/8yAyL+Yx1osTIsGk+o0y8EwbU
         ipu0naRpufZ69qkLFox5xVYizWidLE2idh6hPHQcwk8b3gHBKBcxOCiAl6t+BcbAtMCr
         1wJgpE1fSRVgpZrRT0MbsmI7Iz6ISbT7OQhMIIWeUUUhu9TaN5PtOKxhDyBKbXkb9RMF
         GTSFifO9GE/D1czApGr0o7epIYlTqkTjny7xYDpC7fWrj39YM0sdN3MWTfwdIsuXBZ5S
         JQk1i17RsCUTOAPKXppCcaBVQ8ctYNoHgmM5jDnp9v31HLUlZ9cUj9E26ZR4R/qkmGso
         KJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=buNFUX5Vj73F44vALmwcpLFpoqo8B/U6U36Uotr3hi8=;
        b=dyvLkVb51c+UTrGJXhB53stUhsahbGY60bj0PAEwLkwtXC3qb2QdTu6gYmS1GrRr52
         EoGZjBYwjdKNWui5tWWMr59Zs5T3RIdhZcyMe6lAhH/p9FcLElDuJ4Qkyt2W5CGbj69V
         metkHZ7BA6KnBJJ+0iXGvB9hXvlhnt+a+AHsw/XfSOb1Wjxrtbj1SQJLQ4itdnWRuns1
         ccPZyUNEg86SlvfaDGKa7bKA6euM5uL7lvuwD7+HlhQiPdZDE7IGGLI2VNc4/g7f4hlY
         pQfXxSewcGNpljbTSsSxQBchvRYXCLDG4eXh26O0Oi/VnATW/2Ii/t4hJGe6OY04eTDO
         TlDQ==
X-Gm-Message-State: AGi0Pub5EtneG2Vd69YHLryY1ve3Sm4jlB+enRQGLJY2iwW5eq3zoFMO
        YakQr1Vqe7+sLtPz72axcV3cn1qQmzP13A==
X-Google-Smtp-Source: APiQypLnM4dq+9C4jvPNhvHL5km9SbwEuy+PnbaNYrO7tfbNjRFnCj02FTBIXDDEJ6coWe+W8LhVog==
X-Received: by 2002:a63:e602:: with SMTP id g2mr11017707pgh.380.1588848831553;
        Thu, 07 May 2020 03:53:51 -0700 (PDT)
Received: from [192.168.43.125] ([101.2.183.173])
        by smtp.gmail.com with ESMTPSA id a19sm4735586pfd.91.2020.05.07.03.53.50
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 May 2020 03:53:51 -0700 (PDT)
Message-ID: <5eb3e8bf.1c69fb81.1098a.f32b@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: HELLO
To:     git@vger.kernel.org
From:   loganblont@gmail.com
Date:   Thu, 07 May 2020 11:53:51 +0100
Reply-To: karen.valerian@outlook.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello
Can you be honest to receive money and help the less privileged in your cou=
ntry? =

Reply!=20
