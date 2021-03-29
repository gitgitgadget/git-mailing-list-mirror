Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54027C433E1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2348861987
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC2QpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhC2QpN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:45:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F28C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:45:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so13528190wrn.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RQdmschoPOFkac+QU2c3IMeth/e+LBTR2gnf6BD0fjA=;
        b=hXXkO8bvrYaSjvdyFd1BDxzn2HWUxJ13nSTK2XtvOJ/6JY3+plUqzScu7kdr7Si4WS
         05laZ0O/qrqQ3FWW2X98Ecvg1HBDn2PH0UsNn8MR7G07+ycaWhW0BhNGUd0+9f92fFgT
         0jFRtIfS60rhF7lHzhRcAe3P3N1cpcRbt4iDi6/ShtK+dt841GWKdBTlv7lu9fou70FM
         1klpp9+9ZVzbrJVKrbYDHufnU13qqehBW/zwzW2p/ii1qpeIOlEu65iI5U/AOGH/VzbO
         Uh1CRheBQZAR4bA6kAksXrjlgOPIVjOABSL6Rv6ZvmEDoLpdVaUgEVzYXHWwT5rFzjny
         +dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RQdmschoPOFkac+QU2c3IMeth/e+LBTR2gnf6BD0fjA=;
        b=nIGk359gbDeL4EpE3bwLgHPCS8CrLgAoeFbV3/BflFxk0SrdiRnU1wFK3P/tQFg+7z
         5bf3cMa92t1L6/XK8OtKJamvl4Hzf+CfSTh217YXAQdAJGcFwIvwfCXr+v4SgK/f4Dep
         pTt1q70cxGwRsL+8vJosLW2PxhnP1TdOG2hOVvUKwPRZQvhOWtSTUfPiuirA1qgUCdZf
         BnHdUt8vBGZxkdX4jgKfYiubHHlOhsry5s0FTY/e3+ySf9XnDkYRQ7iuZjTTKSV+R1zz
         U7lLGSNGgYnvz+++0xb6wDhYRLMpHk4g3XlPLS2eyq9U3ayuVViE6BWw73djWFkw6Yml
         On8w==
X-Gm-Message-State: AOAM532AlgPa3yWK6PLqX5pV24j/l+LH+tk4QfwC/Efof3XV/+PZbhID
        25DrcFxwOYyiGeGVrzf+fFegKC3jtaDBvV9gEAZ2SQUyiHw=
X-Google-Smtp-Source: ABdhPJyrslaWm5XMmAcPbw6zU9nRrGr6MQT2AQoVcL76NaBebRPPYj/vG+OgB2ZDu1TwnOUdLFm2+s4A3+cRtUrt5l8=
X-Received: by 2002:a5d:4307:: with SMTP id h7mr29218663wrq.227.1617036311100;
 Mon, 29 Mar 2021 09:45:11 -0700 (PDT)
MIME-Version: 1.0
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Mon, 29 Mar 2021 09:45:00 -0700
Message-ID: <CABXAcUx0uWyk1e0UCaTwGt1VwVZkj1sV-OapSgZJOv3eS88eng@mail.gmail.com>
Subject: Running scheduled maintenance in quiet mode
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Now that Git v2.31.0 has the fix for 'git maintenance register' on
bare repositories, I've enabled it. I'm now getting a fairly useless
daily e-mail with a couple of hashes listed (no other info).

I'd like to disable this e-mail and get the configuration to stick -
changing my Crontab with either --quiet or a /dev/null redirect works,
but the next time 'git maintenance start' is called, this will be
rewritten.

I could not find a 'maintenance.quiet' option (or similar) in the
config. Is there a way to do this currently?

Thanks,

Cl=C3=A9ment
