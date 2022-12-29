Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC13C4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 09:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiL2JNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 04:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiL2JNB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 04:13:01 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2D412D3F
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 01:13:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id k137so7482192pfd.8
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 01:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFvdI27IcqzVytg2E96K/zPcq2GezlnrDBWowY0HSWU=;
        b=h32+B8HeXeafLZIfBlE26jonvqvDg7vJCyY5tQg89Cf7wmovNce7Dlqc0VMwmSyrw1
         zT8v5n+T/jhUyovhk70ijtjj6/hikr7MoZ9486VCYRXmcNAesF4RSpFUxrxvmuYC/Awz
         AEBPrkGRmxwcPDnZvdUSzUgew9LOLdy0dwH6Rltrg2XOned+ggWBnv/VJes+S1T+VJZY
         WhzvJkk+IdidhIzpwny1JvXqlwmKUubzkOVMfrx4ghBJ92STHyBctAoiMHlB01TtYhTi
         G7ToFOGK3hZ9IyhjvQZjjEYZ3aG5ELxQgH/SCRrYmQ831hX10RKmsngt02AtjfLASNzy
         f/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFvdI27IcqzVytg2E96K/zPcq2GezlnrDBWowY0HSWU=;
        b=jEoA4ZkB8BwTp0by+U9NbzjwMPyNgynP1vlXJZGNZbRlYERpSWp3FDQItFSlWB+3gB
         CUddukYN/CMm3BfStV/6CPyTEDngNnda0iDzVxitiQuGLs1sd3I7qa0GArljr34oXI2r
         WZA68d2/23uGDXQ4n5smsilTGk5Fnxvyk6nEhn0I4oMt545CEVQiQRg6M0stYv5R7itx
         cWqUW0mKLNjtLmK5k0rYknwREdwbhXU2J6TNpP8CEWlHjGajhmBz8IpYLCR5Da4XXV6X
         l2UA5oaH92R5QIyynoUWYMe9tm15w3mB4KKnuepHukOahhncqiY/MmW03gVFwOG+h6f8
         z7Wg==
X-Gm-Message-State: AFqh2kqIMk9wb2I1e5hYPSSpVWkG04/Bpktf3/ujjSSAeYGgysU4GmRV
        DSWZMwxhUHS9gInk0JHgG62mMl4415rAkg==
X-Google-Smtp-Source: AMrXdXv27wxC8TaVgVDFxsGLXE7/8ivEgmCSTZQaZlKimKvI1PtBJ5KAr3aO/c6N9K3rJqm/cLMIrw==
X-Received: by 2002:a05:6a00:1d28:b0:577:6525:fc98 with SMTP id a40-20020a056a001d2800b005776525fc98mr31760304pfx.3.1672305180349;
        Thu, 29 Dec 2022 01:13:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s187-20020a625ec4000000b00581ab852316sm2136515pfb.27.2022.12.29.01.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:12:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 08/20] reset: fix cmd_reset() leaks with a
 clear_pathspec() call
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
        <patch-08.20-21670099c84-20221228T175512Z-avarab@gmail.com>
Date:   Thu, 29 Dec 2022 18:12:59 +0900
Message-ID: <xmqqedsimv38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add clear_pathspec() calls to cmd_reset(), including to the codepaths
> where we'd return early.

Unlike the [05/20] step, this did not have UNLEAK(), so it is a true
improvement ;-)


