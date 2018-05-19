Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5090D1F51C
	for <e@80x24.org>; Sat, 19 May 2018 23:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeESXTZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 19:19:25 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35657 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeESXTY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 19:19:24 -0400
Received: by mail-vk0-f43.google.com with SMTP id g72-v6so6904257vke.2
        for <git@vger.kernel.org>; Sat, 19 May 2018 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1o6zc28UYCrtszoFRZreAqyfDshmTjEO9r2rfuZFinM=;
        b=DOXI/Ai2/oPnt2DsRE5vm+AQK3N8vkRkWTHot4RzZb+uM2CRDnQXUI3IfS75dfwZ+r
         CwUAj5tM4cfPCS2AwRfB3kscI575PuLNgcOjWyMlqRPyuVq/tdy6u8eSqflp60tn8U3d
         0kI+ZApI/imk3cj1FcqveX+f36EdLEpQN3TFYbal6BK9rryUXExs6E+6/NEVimA6iz+E
         ea1YIk0pAfF+J+VR6JiEQNLqdbU13wQPuZUt/0V1bHDPu0DQxBI1+l84doD8I9tKW+jn
         z0MselcxlUhrM54f1N4oEZYNbfjJkpPIy6EVSQWnxm0/QcwjCMemz1OqmV04kScWbLRA
         LUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1o6zc28UYCrtszoFRZreAqyfDshmTjEO9r2rfuZFinM=;
        b=ZmwDiZ/1Gdrbsfr6afOKSuggLXC3oh/iw+7a6LtuBzSpaA6h/tqemPdfO0Sm0e6xHv
         erNl1KW6P4XJZtRvAqHg2N4zImx1s4QrEkXBgr38/JTMLpWd4wN7jrAwTl7vUCRe8Xlo
         ElZdk/lTw/wQD2qQkySJMgIvfzZvP1PbhA7J6aqz65v34yGRKOa4Km/1a5JZmU78XNK9
         oU2QZyuBsQjcYh/mU+e54C4qxYSc+U+373KBoG15E71yxiW4O74wTZ3UHRHybKzu2nIL
         VMafDEBcrBZAvwacG8Js+18fgTL3pGRd+3pqk6Wp/6Rvvmaf+WWFbPhH0tk4ZIcb6Xws
         ImtA==
X-Gm-Message-State: ALKqPwdCd66OC5ixSXkPZdtCNGybdqYswxVSCmUQq/r9DkjfJCRKtCf0
        kRRMHG624+BxiFXE3HumVLY1AYoXmrPBB2ixIO3xWQ==
X-Google-Smtp-Source: AB8JxZoxphftrRa1PyQFPZz7eocrmWbEsYh6gIaaJE1Pig/WqJeZPXdLxhivTjWCIURuQdxNyf/mAWXV+JasgxYxnoY=
X-Received: by 2002:a1f:6b17:: with SMTP id g23-v6mr10869570vkc.0.1526771963472;
 Sat, 19 May 2018 16:19:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.200.150 with HTTP; Sat, 19 May 2018 16:18:42 -0700 (PDT)
From:   hIpPy <hippy2981@gmail.com>
Date:   Sat, 19 May 2018 16:18:42 -0700
Message-ID: <CAM_JFCza0Az32RC-ytu_6PxG9JnteySPEDyKEeDzZAv9MdadAQ@mail.gmail.com>
Subject: git apply does not honor diff.noprefix config setting
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I disable mnemonic prefix,

$ git config --global diff.noprefix true

and do a round-trip of format-patch and apply,

$ git format-patch -1 @
$ git apply <some-file.patch>

git apply fails with,

error: git diff header lacks filename information when removing 1
leading pathname component (line 16)

Without 'diff.noprefix' config setting, git apply works. It seems git
apply does not honor the diff.noprefix config setting.


Thanks,
Rish
