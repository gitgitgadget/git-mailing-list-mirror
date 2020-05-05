Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF4C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5481920735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmkJ4QL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEES3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEES3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:29:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64BC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 11:29:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 188so3365711wmc.2
        for <git@vger.kernel.org>; Tue, 05 May 2020 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=l4R+pcMtCfylFV3QeyZbGfcaMbNzC2aSA6OxrxKhets=;
        b=KmkJ4QL6ciXdhtFnrQLOeQNOyVspWsHSKQUHbfBbXdfAY8eQ42gQuW0Bz0xepCtB8R
         Yoa2H8Q1jj7UVnD4j0PeVy/AOyEKXKIZ3lr66M3anFswVijuDJzU99FMqx5M/1HxAgbo
         DKoqU1SDcbDE6zg7qI3g6Fc+bLagBSfG/QgWY/QIUPG91JojmS2eSjbc633tLy6GuFeQ
         I97HYfTOqMMUx9RGi7c5NQez7iqrJwAB2MpHXLGUmaOb7uaaheS4lGt6oTvOylxqRHcn
         HwQaEH/APgLVUG6ABWmhQr+1JLf6xEgxpOI42Ekk50s8S2Qi1vpK9sbkGJ/Bk1XhTL6v
         0aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=l4R+pcMtCfylFV3QeyZbGfcaMbNzC2aSA6OxrxKhets=;
        b=HADutU1HDj53GaTtSbidAHznJd36Cq/mf0bDVmr5uS6AINL5oTn7XZ1J7k8DAplMID
         HnrSPFlxB5918elZGZD1auhfhjjAcaJc4z8Ar6L0pnZRJuyz4iwkx2G5WgU0ZiXVM9MW
         diNKOvUBKqWWJAM4py/RdRyQfnXHiqudBJoOZqq11E3it7j29PchsNk7aeeesrf6DPty
         S0y28ESxeCERF8ud4/4VSFyOHWTVRO8Yv5PfeF/nRGBLYCZxv57Aebnz9DpKyalElJt+
         qzkqPNyNLlH82PP6TIo7ZPLRDV+uut0A6JurcSafbikZEpUjhsY7jAVjN+9qB9JJaDrQ
         V6IQ==
X-Gm-Message-State: AGi0PuZf2xHsk7eCyU0Ybuw5Hq3VzCoUVptHlURWiMGAowP3RkhwR4Px
        XmhD9s4PWd9bsC0/n9aspF1Iwtp9
X-Google-Smtp-Source: APiQypITYbe2+ROdb89p2fuC0figGw/C+20Fvlb6AUT+g/COGeh59Dei8n6Tdz5k7gMPxH5aXD47LA==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr52523wma.19.1588703385529;
        Tue, 05 May 2020 11:29:45 -0700 (PDT)
Received: from kaiser (ip-89-177-205-133.net.upcbroadband.cz. [89.177.205.133])
        by smtp.gmail.com with ESMTPSA id r23sm5021936wra.74.2020.05.05.11.29.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:29:45 -0700 (PDT)
Message-ID: <68d07bcc90de093701a0a5589107d91a10a3af08.camel@gmail.com>
Subject: git send-email loses annotate changes on error
From:   jtojnar@gmail.com
To:     git@vger.kernel.org
Date:   Tue, 05 May 2020 20:29:43 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

I tried sending a patch using `git send-email -1 --annotate`, and
decided to describe the checks I ran in the annotation. Unfortunately,
the submission failed due to a transient network error:

   Unable to initialize SMTP properly. Check config and use --smtp-
   debug. VALUES: server=smtp.gmail.com encryption=tls
   hello=kaiser.localdomain port=587 at
   /nix/store/d5pdyggxfcbwlk3m59nasnzdm33kdyg7-git-2.26.1/libexec/git-
   core/.git-send-email-wrapped line 1557.

Then I wanted to resubmit the patch but all the changes I made in the
annotate steps were lost, as the tempdir has been cleaned up on exit:

https://github.com/git/git/blob/de49261b050d9cd8ec73842356077bc5b606640f/git-send-email.perl#L685

I am running git version 2.26.1.

