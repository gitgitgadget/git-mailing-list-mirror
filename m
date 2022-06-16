Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07E5C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379136AbiFPVTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379129AbiFPVSx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:18:53 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0B60DAA
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:18:52 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q104so3919610qvq.8
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sf9bz3x8XimyBmzA0TDcEm9yxHK2VBXgEE0ROQlEQWQ=;
        b=z8yuSF/Cq7yvoa3O/GyvyGBBdNpzOZMvB2VLPsx8KunXtcR2sSIya/XS36Q56nhPYv
         jwTifLQzcmi7TKwU+oyCxSPTn0Aa29vUla6XKPT5luvbH/d8Ogox6kzA0LUvOO1m5JQo
         01Grtny+iQzM6MqBcwOeNlwtDqDrLSA48uhprxVZ5AzMERrVYpvKIhJqBU9mcrzEyC/j
         PARk8go7QpBTdBmYBo97y3rWQlY/FOsoeDfvbAv01Lilfns0oMwtYirSq4TEvzajozuL
         V9JwDwhIk25ScWZ1I5DUbub02itd6zq9uctcBwzeOv4jCBdstuNvZNOh9nB/HA2KNa4N
         056w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sf9bz3x8XimyBmzA0TDcEm9yxHK2VBXgEE0ROQlEQWQ=;
        b=ZxfxnHRGFlMkC6ERj+9O87EAmk9k5cyPMlWHXOhhgiAnMk+dI4HUS06cpNEnikDSTy
         GcXMovRWK2GIS8NOXp/WQv7dRFlUffwPgOcRORnpGMFYVj++F5As9qs0YrorlcXV+BXl
         rSm9tUfvn7T9OaoeieAiwtI/GqScHzj4o1ilD71lNqRkGofKfB6dx+LplcctlaAqCEGm
         12AJheb16iIoXdpGuf+4t0OVdRE1zfSPoKYwGay9sbxmxhJ2CCCcmo3IQogtYfVI7ifv
         AhBP+xoSWKBJgGvhXKEYeqqGNQ0pLs9JmWvUFCea0Cq+eu/3TqlWtLGg96cPo8Rv47hm
         7rsQ==
X-Gm-Message-State: AJIora9D94/VwFj8SlH/M6Jo6paEM/9NCv3NV7gd+B6ZckjCkQ6Tifon
        1AbWx+yZ+r5UQQokRhKKc/PLSfax3BPlUPf7
X-Google-Smtp-Source: AGRyM1sS6+o6jiXHrJBfi8lz13l2zbd60hTslABrVlAYvEjEhM9PmjxeFK2hHebsfK1mAKGB9RV+CA==
X-Received: by 2002:ac8:59c6:0:b0:305:2f9c:a53e with SMTP id f6-20020ac859c6000000b003052f9ca53emr5786003qtf.59.1655414331198;
        Thu, 16 Jun 2022 14:18:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b006a9901130b2sm3113971qkp.86.2022.06.16.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:18:50 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:18:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4 0/3] bitmap-format.txt: fix some formatting issues and
 include checksum info
Message-ID: <YqueOVZcv8/zYWUF@nand.local>
References: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
 <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
 <xmqq35g4tp7c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35g4tp7c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 11:53:27AM -0700, Junio C Hamano wrote:
> This version looks good and seems to format well.  Well done.

Agreed. Nice work, Abhradeep!

Thanks,
Taylor
