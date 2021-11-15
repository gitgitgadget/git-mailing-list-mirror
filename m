Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7290C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981EC63211
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKOPDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232053AbhKOPDT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Nov 2021 10:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636988418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DVLLZVX0wzVcLBBRXN3A/XQdAAohrdUcAdX9XhtRzGY=;
        b=HzqNE+tlmGl2+u+c0IzEhkeykmEf3IV6u01AeLms2dj5xvgwcQsdxA6Hzr47zuNLUTzWcC
        s1GZ4kqcVrIJAEkDmL/VxZwtR7fYAUEbFtETZrT8kszxba6XD0sd2XcklQBXxvUwhg1M8S
        eyEQsZgqWXxh7Nwy+qLA4/2WD5xyInA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-Kc6zBiUVPTqSC0r47yIFTQ-1; Mon, 15 Nov 2021 10:00:12 -0500
X-MC-Unique: Kc6zBiUVPTqSC0r47yIFTQ-1
Received: by mail-io1-f70.google.com with SMTP id b1-20020a05660214c100b005e241049240so10829890iow.18
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DVLLZVX0wzVcLBBRXN3A/XQdAAohrdUcAdX9XhtRzGY=;
        b=pQTrYJM6a2jOtF9CNL3TSeUNZgms0ZYqlGQl5B9uMsDq3JII62igqkfIouiLIYn0HE
         mz9GOTrA6T0o8pe38zTT1WuyuhbbYwQfkpLRyHsH+Tnq9bDSAuHkA3gu/hg7+rO6b2Zz
         RjoUcQST1oy9aEkbEfiwvQzUFQezsMqnNS4WiaRtgvXfFbD2n1yXWMSklZG9Fex1a+i6
         OT7T19dXmX9tdcH38u0+WRBoVaLtafGFc0ekFbULq162FcH6Qkw8+gjYD+k0OnFpMfGN
         DEtbXKqMDAh4ZVdzNR6Yh3Pf1lnOPT+1J96pYaKmtIFZlK2ljhLplQENisRH5q52+T6F
         QLTA==
X-Gm-Message-State: AOAM532SqAiohY1aNzxj/jJXClGQDIqwhK/VWfT4xXfwC6KZ8hBCYK4Q
        kcF9FqI8Qx8AeI/+1MW+MdcTPkjHg49t1VEECSxVIDH0nat6/DayTfL/EYP9hXHrq7MYatKxKNb
        ymEnh/B+qGy1ut230XfzcD5eNuNO0
X-Received: by 2002:a05:6e02:20cb:: with SMTP id 11mr22729435ilq.258.1636988411038;
        Mon, 15 Nov 2021 07:00:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI2Rj9mdECijEX3T1rryo14c7dBdBr/bCyUzvyyhS6TKPeLuKx37D7fDSvGXWzh5kr/zddCeXUvgATTxv49pw=
X-Received: by 2002:a05:6e02:20cb:: with SMTP id 11mr22729413ilq.258.1636988410735;
 Mon, 15 Nov 2021 07:00:10 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 15 Nov 2021 15:59:59 +0100
Message-ID: <CACT4oufbbtCUjd1DcBcmUYhh_dmgsXxXLGSCrOstNxrwYEA4Sg@mail.gmail.com>
Subject: Ordering list of commits by topo-order
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I have a list of hashes of commits which I want to order by
topological order. I'm trying this: `git rev-list --topo-order
--no-walk <commit1> <commit2>`

However, no matter what I do, I always get the 2 commits in the order
I provide them in the input.

As an example, I'm using commits from Linux kernel `e4073430ee1de` and
`0d55b76fd815f4`:

$ git log --topo-order -2 --oneline 0d55b76fd815f4
0d55b76fd815 ath11k: setup REO for WCN6855
e4073430ee1d ath11k: add dp support for WCN6855

$ git rev-list --topo-order --no-walk 0d55b76fd815f4 e4073430ee1de
0d55b76fd815f4d685a62afe44e623501186ceb4
e4073430ee1dec5402a6158755ac8b84eade83c6

$ git rev-list --topo-order --no-walk e4073430ee1de 0d55b76fd815f4
e4073430ee1dec5402a6158755ac8b84eade83c6
0d55b76fd815f4d685a62afe44e623501186ceb4

$ git rev-list --topo-order --no-walk=3Dsorted e4073430ee1de 0d55b76fd815f4
e4073430ee1dec5402a6158755ac8b84eade83c6
0d55b76fd815f4d685a62afe44e623501186ceb4

Is it possible to obtain a fixed list of commits sorted by topological orde=
r?
--=20
=C3=8D=C3=B1igo Huguet

