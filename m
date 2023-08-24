Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC6C27C40
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbjHXULa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbjHXULD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:11:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE558E7F
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:11:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c0d5b16aacso1000855ad.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692907861; x=1693512661;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h5XDsQoJ6sVu3tF4/3OfJ3AlpFWem2Kd+mQgCOSU30=;
        b=EqMkNc4lvPIXIbLVdab+wS+aKEwxaoi88vp3bMuT9aNbV1+50G6A+H7x3fab4AJExd
         T/5EXAjuKE5qU0LkCEuGXACkSxZAf5BhvlqkemLs6Nzf2tmXVp4e3wilJrOxNG3InnlT
         jOEmtJGFEaTAtiZ6lgWfV/Y/rQ4zUIbCK+QpOL7F/oaeylOdqcSdDRV/Zm9lrjE07YZL
         Z1YfnczFMQybcB/mu7Ys8IcLIN+VAyGrE59z0kjqplQqL21D1kkPzvB4e2rWm343CIQK
         ApyJQe5paVS4ACWBucSbZZKjVwkZTn1sQaPRAum2oPYtqoAZHDyYCY2a5zLxzPv3Phmv
         Fzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692907861; x=1693512661;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5h5XDsQoJ6sVu3tF4/3OfJ3AlpFWem2Kd+mQgCOSU30=;
        b=Tx4ewsNJ18PwYlRfh7DVHDC1fhRfgHK5cJzP0ZWJ6JI2g7wv+MK0DRHnwxq/l/whV6
         Br+oCnzwQiLS38VrFn/DZfQ/BSoBgEA1eoxwZGt5wd5CfSZBRuS4uPoCLvX/GMWsvxJ4
         82yw1fAaupJZBQ7YqOv7+4hOnyGViuVVXPQW6aaBTWHxpa39KFVZ6X2mvlJ1nA9L8SWz
         3p+m808gUMHWml3VqVeOuSL7od8nejAmHHctPvnD1uoNHylo59ivC4pg/INsZR4Ad35p
         JRY4Ly6Rtixl6oNQV+XPNBVCy0erufXjzVsouxxlrtgrK4ElnVyAeWqk82zWn5Imjjgd
         QbAg==
X-Gm-Message-State: AOJu0YwZcrgC1LKGzgWV2cWY2kNidHP/m/cMJTvMaJsBoYu0Zd0TLd52
        8sYX/xAi5gD/xyn5pLOnP+IOcb0OKz9qEQn7KvEK1A==
X-Google-Smtp-Source: AGHT+IH8Nq4uvEMzu4EV5YuHy94VE1bEsVv4W0L4pmAVeGPVLSrAO3FS/riAHwYM8Gxyt5mVC9r0Sw==
X-Received: by 2002:a17:902:ec83:b0:1c0:d17a:bfe9 with SMTP id x3-20020a170902ec8300b001c0d17abfe9mr1629519plg.46.1692907860687;
        Thu, 24 Aug 2023 13:11:00 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:699c:c07:e0db:43a0])
        by smtp.gmail.com with ESMTPSA id je1-20020a170903264100b001c0a414695dsm62521plb.62.2023.08.24.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:11:00 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:10:55 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/4] config-parse: create config parsing library
Message-ID: <ZOe5T0jsNAMfT/K2@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
 <cover.1692827403.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692827403.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.08.23 14:53, Josh Steadmon wrote:
> I'll be taking over this series from Glen (thank you for the work so
> far).

BTW, I'm going to be AFK for a couple weeks, so it will be a while
before I'm able to address feedback on this series. Thanks in advance.
