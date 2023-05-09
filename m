Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525DCC7EE25
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjEIBHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjEIBH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:07:27 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A639012
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:07:16 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-195c61067beso2836227fac.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683594435; x=1686186435;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCE1dYR9bHKSLT/pE3jk2UUh6tm4KMH88gjFjYfPu/s=;
        b=bZgaUnsxB3ceJ+R35Qalb0zDLjj8/Eerc7vYYa5M2pQqR7H1BQ2wgdfAIpa+LG1Dw9
         M+Ero3+M0SC81fNXQjGVyywsEGuEF1iaA9CklxZXq8rbmQCZTTGyhZCATcp/xicBP/5n
         nQuTqUZTxAc80+Nl3WfIoELMSsO/vWBTZSTbHli6ltS1sm296pOKxYBBwzOOMbjAA8kQ
         AXkvEHGewVIlK20kcRFlqFwvNDj3pMSvXGVsojTRLlJsPQ+aVD2A0AuJIun6xe8UNe0i
         r2X9xAXgvMyQZBqiqepXUOS3FVMcyCJnrHN/3X3Ze1vvLM5L60nezTWUr9bXm1imFXjn
         Pyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683594435; x=1686186435;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fCE1dYR9bHKSLT/pE3jk2UUh6tm4KMH88gjFjYfPu/s=;
        b=bYatFf46+bmh1jUjbsFFUw1HM3KADDCWkc98cQ3DRG+HPEi6FB7EZ6ePK4PFDU1h3V
         EWP130i6RTYLkzewiUTZ4JCvEDF5NpS5auLj8mqBDa8258aGooUs63l90AjsoUkB21Ee
         NHqEGZLqN2wh8WyzSc3LEGjC1koult0UhkEWyWjHvo0MympDA/cGhOyw7kXLy+b98drW
         U6Q6dLVzrnrMgeKtLtUAeOKFSyF+Itagui2s7TWtb/0rkOQTFLZKxVqOHUzmu+7j9lQP
         DAszDjOnh8lqKmExS4HMw6pCteTRHok5msSHmXuns5W0S/XgEa6v+yLpVoEA279Tpo6G
         S4Ig==
X-Gm-Message-State: AC+VfDyF0n6IA/rAXPojtR+8rHLEfAp7DZYkvAASM7DIsuMxvmJJJ+hN
        eb6li3h9BITBlO0Yuy0HDwZKTjsqJlw=
X-Google-Smtp-Source: ACHHUZ5DIfpKrKdm/jq1rvbDL1tAcvJVnKT1CcDH4NkHz9H9syX3+R0XZVDrWrwugefe9V0DNdb+Xg==
X-Received: by 2002:a05:6870:9544:b0:192:85fb:3a33 with SMTP id v4-20020a056870954400b0019285fb3a33mr4616033oal.2.1683594435621;
        Mon, 08 May 2023 18:07:15 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u22-20020a056871059600b0017703cd8ff6sm5545109oan.7.2023.05.08.18.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:07:14 -0700 (PDT)
Date:   Mon, 08 May 2023 19:07:14 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <64599cc234708_7c6829426@chronos.notmuch>
In-Reply-To: <xmqq1qjwj7go.fsf@gitster.g>
References: <20230503134118.73504-1-sorganov@gmail.com>
 <xmqqsfcdtkt0.fsf@gitster.g>
 <xmqq1qjwj7go.fsf@gitster.g>
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Sergey Organov <sorganov@gmail.com> writes:
> >
> >> --patch followed by --no-patch is to be a no-op according to the "git
> >> log" manual page.
> >
> > I briefly wondered if it is a bug in the documentation.
> > ... when "git log -p --raw" shows both patch and raw, I do not
> > think of a reason why "git log -p --raw --no-patch" should not
> > behave similarly.
> 
> So, to tie the loose ends, "log -p --raw --no-patch" and "log -p
> --stat --no-patch" do behave similarly.  Where my reaction was
> mistaken was that I did not read the manual page myself that clearly
> said it is the same as "-s" that suppresses diff output (where "diff
> output" is not limited to "patch"---diffstat is also output of "diff"),
> and incorrectly thought that "--no-patch" would countermand only
> "--patch" and nothing else.

If Sergey, you, and me all agreed on what `--no-patch` should do
(without reading the manpage), isn't that an indication that that is the
expected behavior?

The fact that the documentation documents some unexpected behavior,
doesn't mean it isn't a bug.

I would say it's a documented bug.

-- 
Felipe Contreras
