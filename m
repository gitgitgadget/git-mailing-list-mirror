Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DC6C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 19:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ2T0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 15:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2T0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 15:26:11 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1CC37180
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 12:26:10 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e15so7089601iof.2
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sjN+okoEbBJT4Rtifl0uYahKeHB7q9crHDM/clyvflc=;
        b=N48BHTWCJQqtgO6oEKLeG9U3xKYYN6NdC4LKXRWA/9jJYk0YB9Tnx1RI2cYvvcf+Dm
         KtsHi9ckq7VSEKIRqQy0YQtIrBls+fSgTbLwrFULW1ewLyhCMCA1ZD57Hkv43We4x9uc
         e9w4jN5Bkhoz87QmUeHJV62zEMYjDiwibqoVQ487/Lg9++VNZB9h5RVfq6dGAGxFyAJ9
         dr3TziZJ6jxpZ/mrb94TLjkKt81WwDLgnXf12Yn7TAr7hWVmedqQay9pzH3ftEniy1AJ
         VndX9a3jUdsD2yTeVuju3MFuDMUGEhrFShFuKwW5wq4oeDHIsQ0Lw4LJ4QFWyXps7Ske
         aY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjN+okoEbBJT4Rtifl0uYahKeHB7q9crHDM/clyvflc=;
        b=V2+2sopl4ZIwp3kwysEQ/awhHM2x+iPyDU56R55SklKhYJbFcZtBP8QnVKqi1LxpGZ
         KLvcSBTZH24WA0j6l8WiQ9l8OiM1DNBXoOCmkGkEiat7zmN6R0NfVa3MjdyoYxKKjEVE
         7b8Lk3DiYyVyAJYuolygXP3csPCzqjtsGAKgXWQ/7nudK+CcU4SOYEJBnZcgw9lZP0d/
         5MgR6vRazID/7g12xmH4LJs1T1EYr8sS761Kmfset307lL4EJrajBD/gxiZUuquB/Qvo
         R/mF4RErslNzEmFLeGKeplg5H3pRYyHnMgrI4vb+PNuTVaJWUITuDG7B75EhpidJX/sL
         S8+w==
X-Gm-Message-State: ACrzQf0cs5StNkiUtFjWEIjT5N3lZmRgiFZ4UtWcdsEuwFmSB4yeBETQ
        IgVHqb3zRJnXQ4tVYp2ree7wfA==
X-Google-Smtp-Source: AMsMyM4dyhCY21bGfXDKmQRSby7T0bX74c0TbiFMbbhNaESPqxQvaGSuC5wrNYMDvFainC84KOp6sQ==
X-Received: by 2002:a02:ccc5:0:b0:375:4975:48fe with SMTP id k5-20020a02ccc5000000b00375497548femr1263436jaq.122.1667071568541;
        Sat, 29 Oct 2022 12:26:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q28-20020a02a99c000000b00371ef930be0sm924161jam.1.2022.10.29.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 12:26:07 -0700 (PDT)
Date:   Sat, 29 Oct 2022 15:26:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/8] replace and remove run_command_v_opt_cd_env()
Message-ID: <Y11+Tt2xNtPo0/pA@nand.local>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <e72a1abe-3098-e4fb-f064-a8b5c8f14239@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e72a1abe-3098-e4fb-f064-a8b5c8f14239@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 06:38:41PM +0200, René Scharfe wrote:
> run_command_v_opt_cd_env() is only used in an example in a comment.  Use
> the struct child_process member "env" and run_command() directly instead
> and then remove the unused convenience function.

Nice, this is a very satisfying clean-up.

Thanks,
Taylor
