Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF96E9413E
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 03:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjJGDH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 23:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjJGDHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 23:07:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8310BD
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 20:07:24 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7a2bfd584f0so122640939f.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696648044; x=1697252844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qcDfHGRAxA6aVWEJLkp0TzZ3Vh5ys4Y5Rep69kMWFnc=;
        b=VZk5bN5OQwHhjmhp/0DChUtWkfbPtvqR6yM10cKLv76aeXasmuscMlMwTJVEjHMf6x
         6WzOeuzxUfnaE+Ve+gIa5UzbZiByiAHozgC4HDKjf8iu8+jT8y6CEbzrmQB9GAePjWWp
         gRVS/azQ7rIx5qpoXYrsj+P6kUVnfasJdPsEX93DRIF36yoPOnxYf65wH4F6PzbPnlRA
         PNtwbp2ZkXBJKL7SoS3jzR/AdXmCzUojtfGokJ0YiOcvG8/yM8s5W/ZpuCmJwylXRLO5
         gbLfK9rO2HsLUAqraHm6iFhn/Z9owO0EQpdBe1CL497SGq1I6CovGccPpzjiuVgeWcmz
         8vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696648044; x=1697252844;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcDfHGRAxA6aVWEJLkp0TzZ3Vh5ys4Y5Rep69kMWFnc=;
        b=nv1WFajJqAA05QX9Af+Bmm6FOy+HYeAOY42D17SM3Ed00KsJO4hYkjtCMmdOYH+UFX
         +x7AUZ1nQC/om4THX9VxBObCyDIEYpYURYZCEaApAxyqV7sB6TtdsWAUDs/if5On/uCm
         u8Zh8AWejs08BrA3S96QUC0yFwuGJVf3L9fNvffRPaKka4TtgqPUPWlLZKJ+Fo5lA17r
         OAuEWpf+dCLjVzitbOHkYh+ZAXa5G0SYTUCDYo1GLB6c4SuNAVVvSvlGyr3JGMXvDg2O
         Ps35JDYwMNRDxZTebwKRrhUph95kb47AIRVVO/ewlJlDaSf7NavzGBFYtcRJ2mlVlwM6
         FLEA==
X-Gm-Message-State: AOJu0Yy1sAdzepgtTNEaugyJWTYW+ovIC/qkYZEoR58TTNmrsR06aXRf
        q+FL2T1KHpH8kHUCwpg0fIg=
X-Google-Smtp-Source: AGHT+IGIad/NS65j2Cp5xaGNlMwaZKYRaCtSFIhhGSA1CeLRQVXT+SxGw2XuVlk6aRevVhrgx8AQrg==
X-Received: by 2002:a05:6e02:1ba6:b0:349:7832:5d8 with SMTP id n6-20020a056e021ba600b00349783205d8mr12627591ili.5.1696648043932;
        Fri, 06 Oct 2023 20:07:23 -0700 (PDT)
Received: from ?IPv6:::1? ([2600:8804:1503:bcfa:98e2:7dce:b0a1:7462])
        by smtp.gmail.com with ESMTPSA id w14-20020a92d2ce000000b003513de0eae9sm1468830ilg.24.2023.10.06.20.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 20:07:23 -0700 (PDT)
Date:   Fri, 06 Oct 2023 22:07:20 -0500
From:   Eric Biederman <ebiederm@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
CC:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6/7=5D_bulk-checkin=3A_introdu?= =?US-ASCII?Q?ce_=60index=5Ftree=5Fbulk=5Fcheckin=5Fincore=28=29=60?=
User-Agent: K-9 Mail for Android
In-Reply-To: <cb0f79cabb7921ab7e334ad8a467ae84853bbd39.1696629697.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com> <cb0f79cabb7921ab7e334ad8a467ae84853bbd39.1696629697.git.me@ttaylorr.com>
Message-ID: <E81727B0-A523-4A45-A606-61442357291D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On October 6, 2023 5:02:04 PM CDT, Taylor Blau <me@ttaylorr=2Ecom> wrote:
>
>Within `deflate_tree_to_pack_incore()`, the changes should be limited
>to something like:
>
>    if (the_repository->compat_hash_algo) {
>      struct strbuf converted =3D STRBUF_INIT;
>      if (convert_object_file(&compat_obj,
>                              the_repository->hash_algo,
>                              the_repository->compat_hash_algo, =2E=2E=2E=
) < 0)
>        die(=2E=2E=2E);
>
>      format_object_header_hash(the_repository->compat_hash_algo,
>                                OBJ_TREE, size);
>
>      strbuf_release(&converted);
>    }
>
>, assuming related changes throughout the rest of the bulk-checkin
>machinery necessary to update the hash of the converted object, which
>are likewise minimal in size=2E

So this is close=2E   Just in case someone wants to
go down this path I want to point out that
the converted object need to have the compat hash computed over it=2E

Which means that the strbuf_release in your example comes a bit early=2E


Eric
