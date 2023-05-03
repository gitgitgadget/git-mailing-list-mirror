Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F15AC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 03:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjECDsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 23:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjECDsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 23:48:24 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDCA40E2
        for <git@vger.kernel.org>; Tue,  2 May 2023 20:48:07 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-546615d6f47so2763622eaf.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 20:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683085687; x=1685677687;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe3EBqigtzmXi6hQoVK37C7WcCWAZtIh7C2Sb3gv9XU=;
        b=UvLDYHLSmSF0y6INsrPCwxHaxEwmOe/pd0z77/IOKb/sAvW6OSzUBmIvQdIep05UDZ
         OnuXEqaaPZV5ewiPaf/xguwI5u7HggxMKjOwFQRutgYGyHTBRq0XB3ScOOOnkWbgM9Nl
         YPgcxSjsghy0lNfeDJwyGM5QzfyW7q9RiwyWxEBtsdFe+cwIoRouNd8M3z3m7VPVOkv1
         cGBfDr6GNhVKJSkmvPBGJC/Jw+BWPQo268Hdk+/R56ml6cebDjIU0PEhwZmI0V4WRXMD
         0UAceA0Gv5zQTKLCnZ9G8yc/u1HCdJhKVMdRsXIMbBctiaGKvGSjRJSuDwJXsZqOZ7Tk
         93Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683085687; x=1685677687;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe3EBqigtzmXi6hQoVK37C7WcCWAZtIh7C2Sb3gv9XU=;
        b=Y6IFekIJg332Q7irvXufvQFZ93QpuyOGla1GEePIwHZ0olu+mTYoS5aQv330IPovWV
         muZzt9vfrpBhsv7LaBzg907cx+i9udo1bgQo0oivcoHGdIFCo7NfEr7SpIbj3BaIVbm/
         F8fTZl+wiatxihB8seyQdYmX+G40gvxZxw8o6Ru2LRc9g5W+Dp6yD7D8kBcMPG7042DT
         KhOeQ4oEtHiB5afLrSeGho/kk6wOnRsvSjm8jXVM5GRqlcJ/4kt9LaFxhL5u6WeRZuhr
         CMvyJOmds8GmOyQR1rJd4A2d8ejogFxXnqnFBTVWe/TbGBEVgJBjzkAw5isjROsVDBMc
         V/+g==
X-Gm-Message-State: AC+VfDxzSsdhTeSh4eg7tKR8UwpUeqAwfv40Nuobwks2GtJAV0gSp7Ol
        ogvvXRm1dnB/VTHyRnzXvoUwu/a6z84=
X-Google-Smtp-Source: ACHHUZ7kVNbTwbj2SXtSfmPgzYt6SZ6lpz35UNoPYQ+orBR1LzLXb6qrlOeLYECN1Pi3dJwxSklfUA==
X-Received: by 2002:a4a:e5d8:0:b0:546:f42b:685b with SMTP id r24-20020a4ae5d8000000b00546f42b685bmr9668627oov.5.1683085686775;
        Tue, 02 May 2023 20:48:06 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u19-20020a4a8c13000000b00547372059afsm1870655ooj.4.2023.05.02.20.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 20:48:06 -0700 (PDT)
Date:   Tue, 02 May 2023 21:48:05 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <6451d97570a4a_2ac9f29445@chronos.notmuch>
In-Reply-To: <xmqqcz3ixsas.fsf@gitster.g>
References: <xmqqcz3ixsas.fsf@gitster.g>
Subject: Re: What's cooking in git.git (May 2023, #01; Tue, 2)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.

> --------------------------------------------------
> [New Topics]

What's wrong with:
https://lore.kernel.org/git/20230418011828.47851-1-felipe.contreras@gmail.com/

Jeff King seemed to be OK with this patch, which generates obviously superior
output for manpages.

The only issue was with git-checkout.txt, but that was orthogonal to this
patch, and the fix already landed on master, so there's no drawback.

-- 
Felipe Contreras
