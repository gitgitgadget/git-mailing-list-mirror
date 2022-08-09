Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ACC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiHIVgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 17:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHIVgN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 17:36:13 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3946566E
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 14:36:13 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so15556951fac.7
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EU8CuMJJAIX+YD6XmXnLJugVi7ohO9Pg0kvBxGyoZwM=;
        b=Y9E74AMbPcZkLWyvB2Hi1kGyIL3uyl8N9Ct7H3yPHfTt7Pwa72r66GdIIUrrKCGzl/
         83YUKedjquPqtSPHoi8tFgZs6J+KDhfs4MAPN+8QAc9QDLooKJ4Kyn/0srRR/Y/E8/C9
         vuK7ZY3nrIp0wnegfSG3wuPh4c5l94aIyqKxVpvfHw/bXTXTdy4B31SAVi7aqHpSPWif
         isjdqAvpueoKrXhI3o5XEyq8gHv881P7Cp9AHoOkGz5uvIQF1P3rySmEXpgTtz61z+cZ
         TcFJzIFKa9oGZLXZEBz/FiHUBkeQnI6JP7PcqpyahyHDL+o1tbfTlyCiCCgSw1yuptMV
         JItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EU8CuMJJAIX+YD6XmXnLJugVi7ohO9Pg0kvBxGyoZwM=;
        b=t9vlslfHAcTkMywExsshrZuWuObieoURfCXpBWUtg1sUyym05WVHuiUnyUrboko023
         38CTuWkBx3Zcun656gS9T+jNwE3Xu7anTUfly0ZA2tY2qEjHzSWSI0Q8G18Ew3c2mUcm
         qJOLJ5q4KEqgd9gH5VkFmDXyrZ6yEJgybOXVth/PgTvH7suVhLcnlhFeWpEne9uq0taL
         sjbZ0PBnYBcWeJuX052RgyHsQ2SxSnAT7BQRGdwR6m2Tq/rJkGf+DzrL/SQd87HQIz9p
         Ub03WM8yWX1xr0HSjs1EbOArhOYgQnYbEoh5lW4YL5SiKkXTJhyTE0RECN+Cd7Ha7RV7
         qecg==
X-Gm-Message-State: ACgBeo2ARouW1orpYg5zIWYkEGB/FD9vk8IsXKBXwEc5KaTfkvRCjDrW
        PvWxi7xJ+eQP/wzn/z7YdpG8zxHLBz3OwJbc/4FJmmc9qx9PLQ==
X-Google-Smtp-Source: AA6agR4yYUcX3Ja99+RECPkdXMRmXxsR+a8Q5W4Q+aH6LTNonL7o7kk0ZpH0xEzppsQDnQsJXVpw+mFn2GZC7Yi11LY=
X-Received: by 2002:a05:6870:2191:b0:10e:75b6:fc3a with SMTP id
 l17-20020a056870219100b0010e75b6fc3amr201458oae.236.1660080971647; Tue, 09
 Aug 2022 14:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220809182045.568598-1-calvinwan@google.com> <CA+VDVVVQQ4=um_L_h=EQASPHD_oYjwZxecYewLrCAbQV_m4hwQ@mail.gmail.com>
In-Reply-To: <CA+VDVVVQQ4=um_L_h=EQASPHD_oYjwZxecYewLrCAbQV_m4hwQ@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 9 Aug 2022 14:36:00 -0700
Message-ID: <CAFySSZBJU=NUR7HRWEUM-n2e4ww_FOPdkWUGLrFt4pybP-qq7Q@mail.gmail.com>
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
To:     Alexander Meshcheryakov <alexander.s.m@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the additional information! I have reproduced the
issue after setting 'core.quotepath' to false. Are you interested in
submitting a patch to fix this? No pressure, but if you are I can
walk you through the process. If not I can take it from here :)

Calvin
