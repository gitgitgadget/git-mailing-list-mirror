Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B66C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 04:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjFAEqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 00:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjFAEqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 00:46:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E8C185
        for <git@vger.kernel.org>; Wed, 31 May 2023 21:46:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-256531ad335so248274a91.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 21:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685594802; x=1688186802;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGmgBP/FhqZfLpdP18Yae/yPm1Qy8nYfH7LHxZs+HeY=;
        b=jEY7l7vJnWCHRwR4dl2FnWkrIB2FBil9pqhYDE3cTRPWnbA9ZH2kTncMsdq5TXk7TW
         O2UsUWINTCylCUyC7yQ5OMrEghcUE8nzLTjoLLdaKlI+/R3SARsWYIuPWaLqtUGd71CM
         V+6Tl7Xmq63vLOlymNP/HXV09KxgPlE9jvhu7aauo90yPnB4+Pkeidj5kDZ39Jd52G/9
         8M9OrbPjplXfv3D76XjahwozwGVbnoGHX+4M4Tte4kCXXHqxzA/k4Aurxduaqrvl6XFL
         mXjQo6IP4mmYDayaZkiqMxXAfddGrqGBKsnjvQYa0amshCGFEkRIEWhuo8w9h9D43NVo
         8d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685594802; x=1688186802;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yGmgBP/FhqZfLpdP18Yae/yPm1Qy8nYfH7LHxZs+HeY=;
        b=a55G4BpkYHppQBq4bg55I4cyCpl5N1WvMBO8KxjPKlQNfhjGZ0yrv3Jjx7obJFZuor
         pcGy34ocB+pAGsjoMd/Njs1Hj80dwOAmU4wTrFZROZCmtwHh0mGdMNhKA3NKhVq51WQ8
         dd3jI42sMO2HyWsDYkPjRK7yZCYUdFw22awlzBdpu3iDlFcfobdr6+1L154Y+r31ZxIW
         mmdLEJG26mF+o1bO4Ptyg11ZxGWs9shhbuZGA8pVwJngPeZqCNhieUrdwaC/s9r3dt+z
         /VCfF/UuP2CcXIwMYl3j5daVYeIW/uGEDsHW0zZKFVpI5wZ1Vsz9sEbuyl5W0lO4A7AO
         nb8g==
X-Gm-Message-State: AC+VfDwlbMbmWtmt2ipEcn3IGzWKZJz0an2Y5+tukVpRGGbCwm7FPeyP
        1pDJ6HFSzL8UyXoorVjVVBY=
X-Google-Smtp-Source: ACHHUZ7VEPu/29ijvjQLBzohFyAVGUNSp0LmCcsT9uyB8ytOAQgFxqcaF1Xn3ZzQ9p+qlnf98GzoKw==
X-Received: by 2002:a17:90a:ee8c:b0:256:959f:3443 with SMTP id i12-20020a17090aee8c00b00256959f3443mr8202956pjz.25.1685594801941;
        Wed, 31 May 2023 21:46:41 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090adb8e00b0024752ff8061sm412340pjv.12.2023.05.31.21.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 21:46:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-gpg: fix ssh-keygen -Y check-novalidate with
 openssh-9.0
References: <20230525031026.3554406-1-tmz@pobox.com>
        <xmqqsfbjeltg.fsf@gitster.g> <ZHBDbGjid-33cJb4@pobox.com>
Date:   Thu, 01 Jun 2023 13:46:41 +0900
In-Reply-To: <ZHBDbGjid-33cJb4@pobox.com> (Todd Zullinger's message of "Fri,
        26 May 2023 01:28:12 -0400")
Message-ID: <xmqqa5xjeqmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Good idea. Perhaps:
>
> 	test_lazy_prereq GPGSSH_VERIFYTIME '
> 		test_have_prereq GPGSSH &&
>
> is best there?  The GPGSSH prereq creates ${GNUPGHOME}.  It
> may not be common, but there may be folks who want to run
> the SSH tests and don't care about GPG.

OK.  I'll certainly forget, so hold on to the patch and resend after
the dust settles from the release.

Thanks.
