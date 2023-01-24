Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229ABC25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjAXPsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjAXPsl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:48:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F8A275
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:48:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g13so24079650lfv.7
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k5+vsihWAZNCBu0um5rWzuA0+x6Hs00ber/euMstkGQ=;
        b=iOrAA1rCqAkQRskbUObqevHDSIiKDmVWz9sDMfoSGTryryRmoBkR1c3/cw/Wsbjz+W
         j0527SI2cQ+kDKbBiiD1byzjDDts2burm0J9V5Q3HwcdohCdxEeB2EwjAriUNDjtOzUo
         sdOaB7BY8t48zQgEdfj5zJgcTVALuWMsJFdA4MVWBek8b8WoCcqb/C3LJrLryndmshlC
         YuMOYEMxrR0w8nNK2PEoyk91PNX9RxEEEASTqKLgmcxImTbFxYoF0FdlQod9tzWSJqZ9
         yf1nCyAmwdgfeADg8fqtBpvWOkS0mmjZ2l9KUM3zsg8SacO1jVq/7318kUdZizeSC6ZA
         Z2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5+vsihWAZNCBu0um5rWzuA0+x6Hs00ber/euMstkGQ=;
        b=kY0h3OnXkG8WHD9N6E4WHvr9qTztUFZaWQBEfVoxK10BAjdlwJz4iTKEEtJ4jPEPq7
         CcDxf/bINpljDBHrJgKugkdxMaSCXrdI9CQ0OQIcD5VDvHm7StY+GPLyi4DTaVq1vd7V
         yDHhLI/3Cu5iavwjDyo2wjulqebxDM/oO6wXidiKhQEI0oDCgsppyq2Zsi9SX9hj39wC
         uwdfLrIIcLsSsdUORxtzBezIh1t1BY8X1QqwX9OOUsKys31ikK94y273OaWxX6QWke6T
         Y/DlazeUNKxke/cR6gW2OY12gdL+PHXXsCs2HrrQAzYUvJDqeaSigUflXxm5pBu+8UDT
         1pmw==
X-Gm-Message-State: AFqh2koMqCJrpu5+kAhMDVjkVkKvuxf9Edt1EPLV+XHRcxROKrMWbyrh
        Mr/Ab6w6l6XyK/Slo5Bp43zckQ0utlh3EFmtK73AyrETxm4=
X-Google-Smtp-Source: AMrXdXsHBbBulKBq2xe0XzAz3K44csIAuVnJ+NoVw4AqIXdFuF4EPcRr/XLbD2lS5UayoN1RfPOt9DGjWkTHVtvTGq8=
X-Received: by 2002:a05:6512:2083:b0:4d5:9154:627b with SMTP id
 t3-20020a056512208300b004d59154627bmr1133127lfr.66.1674575317211; Tue, 24 Jan
 2023 07:48:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:84:0:0:0:0 with HTTP; Tue, 24 Jan 2023 07:48:36
 -0800 (PST)
From:   Auriane Reverdell <areverdell@gmail.com>
Date:   Tue, 24 Jan 2023 16:48:36 +0100
Message-ID: <CAFC92SFZgQtstEzV5pgT_tPSs=6fRJ=rE6ad_DENnn_UoobxFQ@mail.gmail.com>
Subject: git not allowing 744 as permissions for a file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git doesn't allow to add the execution permission on a file only for
the user. A chmod 744 on a file will transform into 755 when added to
git. This can potentially lead to security problems on certain
systems. Is there a way to fix that? I'll be happy to do so if
somebody shows me where to do it.

Auriane R.
