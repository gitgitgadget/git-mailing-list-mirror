Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AADC7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC0NNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 09:13:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895941723
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 06:13:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r7-20020a17090b050700b002404be7920aso7736034pjz.5
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679922826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFiF3ORDqn0c+QKFN/HVBmlOFGcxoyZPTNqS3jl9AbI=;
        b=HB7E9nk+Q/iJ2wk/+A0/vQ2amEJYd//6FwpuwZU+Vz3+BB7HY1wzCZFyBrqsIzZkqL
         BX64zbRP5RSMjMBSkxSZDevCqIOm7jSv4EiOBxgZb1XlCN3q5EmNfi0dPHkPHIbmdbee
         5ItgKLM1yS1qeqRU6mBxOneutJrB1rXd4d7Jp2FLsG3OxTmvv2In254huzUknEv2IFrf
         5WeblBIXiYlMgtWbWPzLUFdZfzdm9c3LxEp+OdjEyAj4Pb+hzj+A6SqR0N2Uvs9sTL7p
         3Bk2n6LyUJU2/9kN0KIh6Gwt2wZsPYCnIJXYF08ltDM+TwJaTaCH+mpp8fHIbg2khOoL
         PFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFiF3ORDqn0c+QKFN/HVBmlOFGcxoyZPTNqS3jl9AbI=;
        b=2e+DHTJjBz5268M58sfbejWuT2gtBwDUDO0Md668OKr7R3m7EcRGC//t3x5oVZ5FKP
         ztBsvlPodGBtXayb+ZCBf7HaiWkqjCIbbbmirbDgrbJAj0o6xT6gn+21whTbjjZf1os7
         1L+kmEgkQmf/UPmC4Di6VaLIXEz9FmSBwphSrHmydFcHCSQ0rM9lKqtYzGL3nWvQYI7U
         fK520k54EILg3HJaF2+mxOQQVFJa3WWNk5p9UazwlImA3zDNb+Xqe3aGZcAaMvrTiWWd
         J0ipIILI3DEzbrQ2uP6IMJzz1aezLe6vf0MJbVIPRmxerU10N6DU3Ke0/dgKDaQwWN9V
         j5/A==
X-Gm-Message-State: AAQBX9fvsiHBR0IZkVLpmcZDFDC6wLFhbdn3w9U/kEO6NXpyc57Ctc6j
        9tcie22RdpmEUhBIrHrB4jo=
X-Google-Smtp-Source: AKy350ZZYQrg36xfi2jKEiQm2Ii/W3+fWzGDbyb3yDURAN5hkmZGSfsGLeDV2g/+Mj+q7et1Y2GZRg==
X-Received: by 2002:a17:90b:1d86:b0:23b:3f18:a8fe with SMTP id pf6-20020a17090b1d8600b0023b3f18a8femr13111667pjb.31.1679922825902;
        Mon, 27 Mar 2023 06:13:45 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id mn13-20020a17090b188d00b002372106a5casm7521632pjb.44.2023.03.27.06.13.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:13:43 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 0/3] notes.c: introduce "--separator" option
Date:   Mon, 27 Mar 2023 21:13:33 +0800
Message-Id: <20230327131333.35036-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.rc2.3.g81c1f01a.dirty
In-Reply-To: <cover.1677136319.git.dyroneteng@gmail.com>
References: <cover.1677136319.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working on the new patchset recently, and I found there may be a
weired test code writting like this in t3301:


test_expect_success 'refusing to edit notes in refs/remotes/' '
	test_must_fail env MSG=1 GIT_NOTES_REF=refs/heads/bogus git notes edit
'

should it be like:

test_expect_success 'refusing to edit notes in refs/remotes/' '
	test_must_fail env MSG=1 GIT_NOTES_REF=refs/remotes/bogus git notes edit
'

Thanks.
