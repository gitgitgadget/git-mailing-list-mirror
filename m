Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D0EC2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 11:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ECC2084D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 11:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anirban-org.20150623.gappssmtp.com header.i=@anirban-org.20150623.gappssmtp.com header.b="GqNefPzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDKLVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 07:21:47 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:36877 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgDKLVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 07:21:46 -0400
Received: by mail-pg1-f174.google.com with SMTP id r4so2129532pgg.4
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anirban-org.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=EwEYek9vMTQll25owZ9aE8GjjgCOcXvpjDa1yZhfiu4=;
        b=GqNefPzzhEnou44rgMc3PIMg3KKFFDu72RqRQOQwDQKDOyw/Q7uNl1mqT+eulwoI/H
         9AQy1lnrW+14gRjahgpN//XIiF02y62xgGJChBQCZYbMVsosCwkCf9bVKg02jnDrXybk
         SVC/EnX/meITHQaI16jaMoXDRaxz2ZVPCoqmFSbbS0WlOuC++CWsfy4Bai5L31KxA18Q
         EAKM0q3jbo8YCuZBzE+XtCWhgPNQOBpmDUNHvY3nHagjVb+DBK9MeMu7V1StLLTg9V2v
         vbtQYRdPHdYU31R5/tnqNlKRaI++UMr/h21WctFcfuZQyI7nMoFp2YZwpdtsTLInlM3D
         WhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=EwEYek9vMTQll25owZ9aE8GjjgCOcXvpjDa1yZhfiu4=;
        b=Gjj1SKcCQASPetF8oYkTKQD7UtbIVULld/b+GgXs07q1/1nqE7kmNmUdHvHsGDqWKU
         zP+SIPaFxUysu4bypN9iZZPHUiqjgKWFB5O3HB7vfw+G/lwsKPx7Mo4+X1r2vL2aBm00
         +m07vQUkS49eJTjtu8EO9IzxqT1a08LLbDDTcgnX9VpjbHNRhLOZzIZIknVn8g22X/26
         oTiswCD4VcmV7QuQMzamZCd2nDKgDtLAjTgbFFfvi4LFQglxRRLkaQt6szqFyPk15HoQ
         XrNsuPxGal6/kyvM0rHcObaPqKbDCxYirvFcPiBA4W5X6DWyKYodY2pFHJDtVMH8Do7o
         GBag==
X-Gm-Message-State: AGi0PuZyVquiPVCtLbVQhkA6kySQkQJE6K8VYmlir2S8G1rue4xvpSvx
        urfiiIjVhKrUlqgf1BfW4Fz13163vjo=
X-Google-Smtp-Source: APiQypI5n2D9ni2dyGI5zLnSdJy/LfGrBDM5rlcwuoEBksL/Ui1Y5CYrFgILPxxSNbPQ9tjrHhkAFA==
X-Received: by 2002:a62:1b12:: with SMTP id b18mr9438850pfb.258.1586604105396;
        Sat, 11 Apr 2020 04:21:45 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.129.142])
        by smtp.gmail.com with ESMTPSA id v36sm3639161pgn.44.2020.04.11.04.21.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 04:21:44 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Ani Sinha <ani@anirban.org>
Mime-Version: 1.0 (1.0)
Date:   Sat, 11 Apr 2020 16:51:42 +0530
Subject: Cherry pick a commit but with files in another location 
Message-Id: <FC3905FB-D3B9-433D-876D-8DB68D3491C3@anirban.org>
To:     git@vger.kernel.org
X-Mailer: iPad Mail (17E255)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have an use case where I need to cherry pick a change from one branch to a=
nother. The change will apply cleanly but the files in the branch  where I w=
ant to cherry pick the co mit to have been moved under a different directory=
. So simple cherry pick will result in conflicts. Is there a clean way to ch=
erry pick in this case? Is there an option to provide -p0, -p1 etc to the pa=
tch?

Thanks
Ani=20=
