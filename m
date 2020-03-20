Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF9C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8068120752
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a46SX2rP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgCTPnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:43:24 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33219 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgCTPnX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:43:23 -0400
Received: by mail-pj1-f66.google.com with SMTP id dw20so3573194pjb.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwXrB30kDzN2q//x4wFE3yOy7qUuJx9iEqr/YhN2hMc=;
        b=a46SX2rPZwgQsYtrO77znZxdcer9QxCN27SNT2Kkx/NiBqdm3aAKN1d4cO/fyDIstT
         XZVXR9WbkGCiBiRqmohUy/Cex4G6dnDlIjZPzp8SIdOWwC41YhAlzx2iYW6vuucjvAPe
         EcSv/a4I6l6X8A+NNl+GcVbzSfsiPUVp4KBt+j1q/K8OZ8tn4ASWmpOanH2Xlt70poEb
         P45iJFsqB7kUTmjt3Nzw41mVujboXkLhRcARoQHkNYhRL81cotrG0KiewwzDNSvUnPKw
         wAmiFo19xBvr5Il7v5M1ijpG6g2k2+VzxIL8O0lZge8PfiBa+xfG5fT+b9BaVUeiUk6d
         RAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwXrB30kDzN2q//x4wFE3yOy7qUuJx9iEqr/YhN2hMc=;
        b=CAtVFh3AeDCrOGG6HGUUy3i5FFI2AYiALwHY0raBN4uCigcCe9r5jMe/hTbPuWggL4
         SUwvOI0hzQuIgdlKjkycU0WvwNIIIU5KLqvUDbj4WBiHjZMRzgsp5qIQ/zsJdTSI4H4a
         l3TbtfZHE4doReRTrv6PMOEkUqhDHcknuqP+xJtJTcqzXaHNbt4bg4RDSTtnCLaSMHv+
         H5cShL/LPkN1UDZRtXh15Egrv6pLNdks/c3kfWeHa7OsAMRCyZzW8rWYXvgdgddH0RkE
         Ac1En6ylNiStg9i4R6XKGoxPwGWo0cOk8Mo/kQWhG0VIXCdBMfDEowBjVWYQ+kV/cAOq
         xakg==
X-Gm-Message-State: ANhLgQ3gO2x7SoDxOWFmcAdW6RWhrQcREGcCL/XFpHJVnHIMQ+bSM2vY
        CLxekcdoqpn6TciFmF6XxnE=
X-Google-Smtp-Source: ADFU+vssnK96BTXc5On2LOlQdBfo4B4JyY0w4nEEWyO4lFZ6HSKhJ7ZFxX/P5LHb2IYubag6G+phNw==
X-Received: by 2002:a17:90b:310c:: with SMTP id gc12mr10198959pjb.193.1584719002792;
        Fri, 20 Mar 2020 08:43:22 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id g69sm5161233pje.34.2020.03.20.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:43:22 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, harshitjain1371999@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: Re: [GSoC][Patch]
Date:   Fri, 20 Mar 2020 21:13:15 +0530
Message-Id: <20200320154315.6746-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqq1rpodn25.fsf@gitster.c.googlers.com>
References: <xmqq1rpodn25.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies, I totally missed that out for some reason. Silly me! :/
