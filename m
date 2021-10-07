Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D7BC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA896103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbhJGSfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhJGSfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:35:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B07C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 11:33:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x8so4454893plv.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=W47Iw2lW6jIXdo7LqNkdEUoDU0kCj1fyGSl/k66w8Bc=;
        b=OvvBxZYlRb95BPbLvQQaZPchDbihuUP77zFI3qybEGKKLbDpS2Hwm8S4ZBnVCPNi+u
         m5oF1MQ6dunXzkTovmHYA3FoztC6GZT9dUrhWIrrgRD3/mnAQzdCd8pYPzL3lZq8QYx6
         Y6OWdTAqHkNM7wnJuMJPJkwTLtOG9QzRo9ruHdxAyp6Zo1WicdqyEaAXnCrMprZWjMO0
         cs8zrwgUDTLpLsg7jMLSfTUPe3WODn8Cb3/6xGH6Gk/72PlRUytZZUAxVOoUGceTI2yP
         Cn58eVSq/ApXgjnAXGvk2gCeFVyGTtQyAcnOmzFnBkJwEE7hzBHsZcUoGfymmHS7xiZP
         vEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=W47Iw2lW6jIXdo7LqNkdEUoDU0kCj1fyGSl/k66w8Bc=;
        b=4bGSLEfMs1bQ/WU82ATuEAWe/WbSSfEAipDtZIFpepjrdpw3Su/+ViIPeGmgsMDXbH
         s4rFcphH1Xclkp3vaGpnv3QoUo/HeBsAkzAXVp1VQgTCkxKBPmKgxxqo9vPFSx/BvBZi
         YX87JY9bPGedPGZjIzWBBw8rlLaUNTnbNjjJko6YMBXsjWoqJ0CWfHdQKZmXN5qaIu/8
         nT+6ReYSr0rnCG8uMthtEUkTcvLoml3inPIkpo9R3B4tpdSaBM4yDydgYSuoqMRMQSoV
         R9HrUoHuEf3gfuerUnN+Kk1ks8D3oyYzjLjZ6L+jHpUIO7IeGy4T6wm+cFUIn8GpUqy7
         D0Hw==
X-Gm-Message-State: AOAM533qcI2ATJ3C3mJfUzH6cbmKwpkAAXzi8BnOQA14Bce7XHmxdxSq
        2tddoysV6xfHc7kYNinO0AkDTdGksnGEMQ==
X-Google-Smtp-Source: ABdhPJwVWRfZMYT1a+q9eq0tXcLkqrNXIk5YtCuZkRmfnVdkBhdlljYv5AwcJKTHowISgL6qXuDkgg==
X-Received: by 2002:a17:90a:e7c6:: with SMTP id kb6mr6671414pjb.84.1633631600181;
        Thu, 07 Oct 2021 11:33:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf7:7c1c:a2ca:e52a])
        by smtp.gmail.com with ESMTPSA id p4sm53588pgc.15.2021.10.07.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:33:19 -0700 (PDT)
Date:   Thu, 7 Oct 2021 11:33:13 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/7] refs: plumb repo into ref stores
Message-ID: <YV89aRzwnP4Jk8x1@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1632242495.git.jonathantanmy@google.com>
 <cover.1632956589.git.jonathantanmy@google.com>
 <80673975382af534cafaec3fdc034966d6f41105.1632956589.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80673975382af534cafaec3fdc034966d6f41105.1632956589.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.09.29 16:06, Jonathan Tan wrote:
> In preparation for the next 2 patches that adds (partial) support for
> arbitrary repositories to ref iterators, plumb a repository into all ref
> stores. There are no changes to program logic.
> 
> (The repository is plumbed into the ref stores instead of directly into
> the ref iterators themselves, so that existing code that operates on ref
> stores do not need to be modified to also handle repositories.)

The second paragraph is a bit confusing, as in patch 2 we do end up
adding repository pointers into various iterators. Could you clarify
this a bit?
