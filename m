Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD60ECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ3SVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3SU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:20:58 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBCBC00
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:20:57 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p141so8299217iod.6
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W45RJWEcUQwWgST+g9M97t3YGdmkoZzh4HXfLfPhDhg=;
        b=O6iVfyF430GnccrrgIjAA4dzSn1dtPGJegiq9BJ5u4t2Z2cBOzcskUjt50Z2NTR3Tv
         NMRy/59IQ3btD1UdG6k4trYxA2GxF/iyz6QdFzmBizA2kLzWwP6o3wnMLT+PM2E3ICh8
         ebSW7M0YUDQpSyeNbJBf9tSs1wiKocYsfbTJgmHfP2GwGbE+ZosFSfcRc9JwjGQZECaZ
         wkJio6dR+J94AyxRzMdeWk8ihrI/D5OYz40UOVs3arGj2ew/0azUZ2fHdks6PnaEbfSp
         VLDUuz9odaU1Wp6iqCxpHy8rVLImet9JwVa0n+JIu9++JKx+xAk9VOrljKarQwhq8lUl
         oMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W45RJWEcUQwWgST+g9M97t3YGdmkoZzh4HXfLfPhDhg=;
        b=fZHmCjjRQ1ujMDs2L3WZ/SNqnZ47RbDQ8I538KeAceL+cU8Aw9jOJk9YMqq9kGDhor
         FLDGJJdc7aPWzwFY0veiCSg6h/RHSe3HuOde8ZzjLu1BQ6ItrxOA6LdtJZxtq8Q6SD5c
         lvY/nEeZHu2VGWMXjezgx7iOMvWuCwKD7TLv81aUWZrx3d07D/vn8EucFBy81/K1++32
         9sP6lbMORXZQEQzf68a9zZeNSlv3l+s301WcypVOHbX11AO3pP34tajiV/UcypR1BiIY
         MI4j96RmlA2fOpVvmTP5Dm4Sd3nR3oKzqqFPNsNADaDhSTPscA6augDQ7l/h/P1udvRV
         43WA==
X-Gm-Message-State: ACrzQf3Ydo00GeGBM7Xk25nHg5X0MrlFVVC+Pm0diJil7WrMawej2iWt
        DoopmCdpKpB/sQ7gXZYD04pO+tJVznGJojT/
X-Google-Smtp-Source: AMsMyM66i3giR0DNBUxTdbrs1nN9LuxCoOQc/fyV12qMQSsYRaNCBotLH7zqQG8xwxmgyd9+geFmQg==
X-Received: by 2002:a05:6638:dd6:b0:363:f1a1:929d with SMTP id m22-20020a0566380dd600b00363f1a1929dmr5244158jaj.188.1667153996443;
        Sun, 30 Oct 2022 11:19:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ch21-20020a0566383e9500b003638d00b759sm1873728jab.54.2022.10.30.11.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:19:55 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:19:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 0/8] clone, submodule update: check out submodule
 branches
Message-ID: <Y17ASoeq/truAQEs@nand.local>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 08:14:48PM +0000, Glen Choo via GitGitGadget wrote:
> This version has relatively few changes, and should address all of
> Jonathan's comments (thanks!).

Updated, thanks. I haven't read the topic closely, but am curious
whether other reviewers are happy with this round so far.

Thanks,
Taylor
