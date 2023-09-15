Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CAEED619
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 16:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjIOQpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjIOQpi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 12:45:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CC5AC
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 09:45:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41512bfdcfbso14566611cf.3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694796332; x=1695401132; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mNZkabvmsQnjsKAGCgT97DlDNETmmWt1FF5YyLYCwU=;
        b=JcIGMZg0KAnVPRpT1LX2aY5ShMsfpvWN/Sfcuoct690J1xW/vxshSIAD+COXqC/gZP
         u1Fa40BEbc1Bf3rnZwDm99c7kJnyyb8OQ4/7Gj2vOwqAKQgpR6ZI4UBXfxjcJOV0OfRG
         7lDl94qunRVj1UoWTihf8WvlcRfKRKohSz/sE2arIMNGtTJsd5ogAEnVDlTOm/zN/Osv
         pVkUSoyOebV/UqLySn0+r23X02aSxac7pF5lLRwQwQUX1uWiMa2Y7XYyNnAZpaOFg38C
         bH28nYWd20MQtoNhx2wqqPKQSFiXHxMKawOgchj8bWA24DphN9bkr3EaO4v5DzcyexL7
         R7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796332; x=1695401132;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mNZkabvmsQnjsKAGCgT97DlDNETmmWt1FF5YyLYCwU=;
        b=pGV0X4uwAwxb47xAbcgQrS7/kq+2Zc7Z1RaS0DQ2hUPlFXPLvJHHJl8srt/M05ppfy
         oQi/bmRPF1/vQelon00uMGUSZoG9aTczhdjRVR2A0xH80Qhlxasnge3jUrbxpFKfTx7p
         JKuyiKoubFa1B0Khy93kAIG+fNvCaQccxcZl8ONZdqgRuo6Phhxv8sEd/irJbwxg/O6Q
         GLlPByaMDGyYOSQE0m+/GLcij3e3ik8e+DaB6ElWiyK7VD2FxLSGmRYReBaoPhnuyhC7
         DWbOn2gX7iWq9Gp4OLKXTAl7Sf9ux4NdEnh1UamSJj0s+IvMYUIb2Jajfc6lZxe6AQ/g
         70kg==
X-Gm-Message-State: AOJu0YxXk+gaBXjRd2cnkW8G0llomV0S406JW1OCEXZ4N8AU8K10+uiP
        P3xI8assk4XqIFJ41IE10TFaWfO67Jg=
X-Google-Smtp-Source: AGHT+IEE681U75P8qF7/aezCbsCgRK8hKlN3KTsod760JmWjOUx1+uaBN2Omy7nXj0C1sCQGWhkddQ==
X-Received: by 2002:a05:622a:50d:b0:405:5092:7dce with SMTP id l13-20020a05622a050d00b0040550927dcemr1830607qtx.3.1694796332073;
        Fri, 15 Sep 2023 09:45:32 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id z18-20020ac87cb2000000b004108fe9697asm1261436qtv.61.2023.09.15.09.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 09:45:31 -0700 (PDT)
Message-ID: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
Date:   Fri, 15 Sep 2023 12:45:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
From:   Mark Levedahl <mlevedahl@gmail.com>
Subject: BUG: git-gui no longer executes hook scripts
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The commit titled "Work around Tcl's default |PATH| lookup",|aae9560, 
adds checking on all commands to be executed to assure these are on the 
PATH. Any script in .git/hooks is rejected as .git/hooks is not (in 
general) on the PATH, even if the entry in .git/hooks is a symlink to a 
file on the PATH. Instead, git-gui throws and error without completing 
the operation. This is easily demonstrated by say, enabling the 
commit-msg script (hooks-commit-msg.sample templates) and attempting a 
commit.
|

|I don't have a suggested solution to this: reverting the above commit 
will fix this problem, but that commit  was made to mitigate a security 
issue.  Perhaps anything in .git/hooks should be accepted without 
further checks?
|

|
|

|Mark
|

