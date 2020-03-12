Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34276C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C320716
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KogQt4sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCLXfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:35:07 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33895 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLXfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 19:35:07 -0400
Received: by mail-pf1-f172.google.com with SMTP id 23so4064710pfj.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SOUF3JaIhrWADHWEhpjPChQRZ0FXuCF0t3WYpP+z17w=;
        b=KogQt4sXRNDEuYasdyNrfJn8IiSVVTj/X5Ea3paTt4TcRAZevw8pI7vyXUjKWbo54e
         07xmTk3utI4zTSjnQnCm2T3W0w+ldEfmfD3VpYh1swWVaqU9j734BovvKgDcfzWXlgsL
         8ZBCkar0WJJYIxnP0g4Aabe3ltJ/KaztL0tbYGNHJLuooyejS9OjZOysp1+NSJrbjGy7
         L7S3wQdpCVFptxwPdosWFYNyFNxAqchoHZfvrVqh+me6/XYXJLjx916wSLERSmLtzCsO
         RqkaONipTvylEKTj7iJsKN0B5zgXiNMPdyusaD1dyha3ZzurzhQ5KCCEsCB5ItiO86on
         16qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SOUF3JaIhrWADHWEhpjPChQRZ0FXuCF0t3WYpP+z17w=;
        b=GKO5fw84h/DFLmjALY499V5CZE1D2vkSQTJUw39UDuSPTKoAwK3aTedKeoAYGOImzC
         GOIH8/HtMl2qCkIshp64Z9E0TmIrmDLYopWaMthfb6PWtflb2NGegNyKngyUevf3GM+F
         zzVKn1hBFZeN5gwXOPKnom1hvCSsveh1LuAduVBpiYFt+dZcIBgAI5JMBglQHJ+TnmdP
         ovboV0oIfbEE6nPxcOODOAOK+jBh4N4WM7xAyzq+nnqXgzwONp+qJIl4J3JD46WjbDaz
         1nSGMwrIHs6/zcwDjfrRPiECQgntkOodi3xKfxy8tz9Oc0eRJ2eYIx17C6ofHT+0JGWu
         F2kw==
X-Gm-Message-State: ANhLgQ1tNwR8+hye4VWrsZcl4PTKo05ZPCIluPo+8XrQmB/l2nUps8J4
        pRFF+5NDlA0Z4Tz9qkQe8VU=
X-Google-Smtp-Source: ADFU+vtphAjE3ys8dZ0vwd5cLnG2oArh4d1CrY6X3kt9vBiKu6QKCwYBKPSKXAEQ0gNLut0u2jp6vA==
X-Received: by 2002:a63:a741:: with SMTP id w1mr10352383pgo.131.1584056106269;
        Thu, 12 Mar 2020 16:35:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w16sm12350766pfj.79.2020.03.12.16.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:35:05 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:35:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Regression in v2.26.0-rc0 and Magit
Message-ID: <20200312233504.GH120942@google.com>
References: <3091652.KAqcNXvZJ4@cayenne>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3091652.KAqcNXvZJ4@cayenne>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jean-Noël AVILA wrote:

> When trying the latest rc with magit, I found that git segfaults
> under Magit with auto-revert enabled. The message in emacs is
>
> Error in post-command-hook (magit-auto-revert-mode-check-buffers):
> (wrong-type-argument number-or-marker-p "Segmentation Fault")
>
> I was able to bisect the issue to commit
> e0020b2f82910f50bc697d86aff70c3796fbdc41 but unfortunately, it seems
> difficult to print the exact command from magit.

Thanks for reporting.  This is fixed by

 commit e6c57b49eb63e77ccf72215229744c4beaf04204 (es/outside-repo-errmsg-hints)
 Author: Emily Shaffer <emilyshaffer@google.com>
 Date:   Mon Mar 2 20:05:06 2020 -0800

    prefix_path: show gitdir if worktree unavailable

Junio, can you fast-track that fix to "master"?  Emily, can you add a
test?

Thanks,
Jonathan
