Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1619C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 06:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjBWGYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 01:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBWGYV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 01:24:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3538003
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 22:24:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso3489573pjv.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 22:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7Fz+jKn71vQ/Nl2b2Ludd7FyT+CW9jwQUaLNsxs5wo=;
        b=KP0iBoRE3dHyK/YX6qBvukOcxkRV8dtahpRViDk4hk/AoDDne7UQytD3px2P/JSvlO
         JXfh/5O9Aa8b6tJl4sCfiy1lmbTYq7LnfRshEjQcX5VGCkDRXT5zvWT0J3mZJMH1+faf
         Z4lSAfoHoc6KCaIBBA6AwNuMK19bc6KeX5fxPDJIMo6jyJTFmOdYYpdAuGKY6PUC1rJP
         4rjPJPMR2bFUnySXwrI8UZe2cD0mArhQtv441MAXXqZkoIVtVJEFqInr2AzSX3+iKrSd
         Ofv7/UtpgDun8zoxnbNuVB0ZdNUrV2pVtHWhzpybKTo7y5J3e0OKp3e3QFYUEm8Un0pB
         E8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7Fz+jKn71vQ/Nl2b2Ludd7FyT+CW9jwQUaLNsxs5wo=;
        b=rVk+OCJ+0PnB3ivLXQspKBzJqZlg7TiKJRjG59g1dmbFwJ7pUYIfENWM6K89aHXSIP
         rNbGBk/RQ8JqanFj4IvTHerGgVrjLEyd3S5iginQRMIKv/UVaFnnjGCjHjzHV+FbFbGU
         jgVx6JtJ0XXni28PKjmHmeSiL3PyMH8/cds7w10ClDK80olvb9s6LWFf63vpaBdfM5FH
         dpnBWp6j5FPdMFD8KpQC7W3TRf9iWS6CCznc/h274lw5VeEsX7R5612MF8S39fz1PJ+j
         UXG+ZxHMOYjlMB2xstPxhMsYhc24/rWWXqwhH9GpA2xQNSAmg0+uBmg0EKZa5UqMf5yi
         sEVw==
X-Gm-Message-State: AO0yUKWjyLHoKM8sTYpg7dmoDUmUcWmgydeSyweZWOAqWJuFViQo/l6H
        TCmW6eRZ9ZIfZbRMuD1VP9Pz
X-Google-Smtp-Source: AK7set8ug1k4hjCDar7rR8zfFw7Oi8OLSp8qGCzMRt2emBRd0HL0ig5VxQhdpCf+hkLj18dqQJWK0Q==
X-Received: by 2002:a17:90b:1041:b0:236:6e2d:7d47 with SMTP id gq1-20020a17090b104100b002366e2d7d47mr12484818pjb.27.1677133460115;
        Wed, 22 Feb 2023 22:24:20 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090a1b8900b0023440af7aafsm5633685pjc.9.2023.02.22.22.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 22:24:19 -0800 (PST)
Message-ID: <be5fbb48-4599-f6d0-e7c3-cf0470ce8bbd@github.com>
Date:   Wed, 22 Feb 2023 22:24:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 0/1] MyFirstContribution: add note about SMTP server
 config
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com
References: <20230222011317.97943-1-gvivan6@gmail.com>
 <20230223054040.30088-1-gvivan6@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230223054040.30088-1-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg wrote:
> Vivan Garg (1):
>   MyFirstContribution: add note about SMTP server config
> 
>  Documentation/MyFirstContribution.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Range-diff against v1:
> 1:  bd9bc70307 < -:  ---------- Documentation/MyFirstContribution: add setup template for git send-email
> -:  ---------- > 1:  d295b4d913 MyFirstContribution: add note about SMTP server config

Since you also did this in your microproject, it's worth pointing out: you
don't need a cover letter for a single-patch submission (see "Bonus Chapter:
One-Patch Changes" in MyFirstContribution). You can include the range-diff
below the '---' line (i.e., below the commit message) in your patch.
