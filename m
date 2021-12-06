Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D507C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 18:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347336AbhLFSs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 13:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLFSs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 13:48:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948CC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 10:44:59 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id k4so11301543pgb.8
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LfHM0w+n0YSNnr15Ub/jio+NQwQVHyTJYKSeeHzrzbw=;
        b=R4WB71fBIID6os7Hdgl2UfxrmM27oqsWy9Y52k1H5C4HJpj9IDOP7G74LOBM+NAZvY
         xsY5piVCyhPkZVEbrwKpuM5uYfEaH9qbSX4PSfLz3efhxxebUZx+HHHlIYQxu9E5pNuk
         TcKuZI3NIZPr44ic3desxS7UdKHM2ca82F/M8HNRUf/8IBiTUFEqhm2InhfNLOv1VhJq
         GusOgkQma2k6zflrH0Wo5koddjic4X3ESPUZKTGUL6e9dd8J0SYMizTC+k223PLf6RPG
         uipMJ/B5eYK/me/wa+LHo0jXHswUwbI4q8E/159stIpz+kPSIpQqIIhzvs08wmsTvmDH
         KbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LfHM0w+n0YSNnr15Ub/jio+NQwQVHyTJYKSeeHzrzbw=;
        b=C8SjGexxsnVW4IHT5+h5SVjmGfbTQrwUt8/RKUcyBr2M7WZqDei9cefwwRPyWhP3Cj
         VdJTT89kFCoNYLrpOqgBKAHNJbEMrQxwqy4y0bGLFelUy0XBxeUN97HddWFsdwSFEIF4
         CUV12Gk64Oj++fbg2+BVfLaUCidXAtak7T0sAvWPjigX1KVmgzKWtUQ9Ke87y4Kd8xEm
         qNri3i6DuokQAuv+IycXrtpqp+rvCs6wHJ62QcF6IQTAZqeuzr/nifc22ugBiVT7EX7a
         ZXu+8pITdkdYPwUb+lCyjYi0cIGavZDmI+9bI0Hy50Spt25QmSLOvA43NO6JcOVvYMP0
         ZITQ==
X-Gm-Message-State: AOAM530Sgxmt1ynpBONBwkLYXvF1kJydIK3CGw92LsCDECYP/GXb59cj
        Z/h0BUVooXBkzVOglioYLvM=
X-Google-Smtp-Source: ABdhPJxEIIzmNOYERhQfNvZ8WI1sSAc3xs5/FfgTON8UnLMz6JTV3iiz4X21pyME85UbLlKWZ6JEjA==
X-Received: by 2002:a63:1446:: with SMTP id 6mr19837713pgu.150.1638816298675;
        Mon, 06 Dec 2021 10:44:58 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id j6sm12706870pfu.205.2021.12.06.10.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:44:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replace die("BUG: ...") with BUG("...")
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
Date:   Mon, 06 Dec 2021 10:44:57 -0800
In-Reply-To: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Dec
 2021 17:25:19 +0100")
Message-ID: <xmqqv901fu8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A trivial clean-up to change a couple of die() uses to BUG() where
> appropriate.

Makes sense.  I wonder contrib/coccinelle/ can help us maintain
them, though.

Will queue.

Thanks.


