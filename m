Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E178C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjFAWVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjFAWVH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 18:21:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91781E4
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 15:21:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so1854198276.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685658065; x=1688250065;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1tMMghU6w92w70evY+R8W3MZVKdOGkJe3VZsEqr7se4=;
        b=CR1lGU7Sj+ywU9g58n9be1f5V+63s7kueaXKDS6lWzaF+5eNvYlG3SKCAo1cNHyE+F
         GBwbMbzcw+FTyWg55bC7Sh0qiKv9zUE+EpfG9nNtKRjsYCX4nIe/8bXdOKQFb3JGlofE
         JZL4XISwvUAX5X8FOq9Ou8mLfa6JeqiXXhQez9QZSMNJ5Kdn3G4Aus0DxR4/WEDWJaXS
         1kHcdr07lH8Hmrn31djRquGpowI4NUFG1PfoWcmqWrOv585wwMHHzNOZD69fHDL/1P/t
         PokmTleLdVObpfUImmVJOjGlu5Lj9irH36m68RjF+lWGI8/ptdimcxc55/i8upJykMXo
         XCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685658065; x=1688250065;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tMMghU6w92w70evY+R8W3MZVKdOGkJe3VZsEqr7se4=;
        b=i6uUGm9CofMlkOK2fL4PlvkjhTfbdSJkp0So9jh/7FG75IswbFG9Gc8fOWvEZapvMB
         dYalOaFeKfk8qosbJYjDYXZLDCrl3gPY+/x03Lf/OkeA8b5uQuqcoFHLa1F8/H9qUcek
         EQ+JUGuPYEfdcyiC+E5csCdxH65Jz820V0rE+cHmVhPdDIWMGNgtZeR2kOxPa5Q7rX1Y
         10WeoT+UsW6XsodpHjYMmZ7dCTZbCeHqoWD3H0B/mkzv9drsx6lQH1KcruZYjkWiSPED
         GNbk0rP9RpgSwr/DRf/BIUF6ckye5LSp2+4IEvObeMDFIByPauftNU+kSXAbcUx1xwZz
         MTAA==
X-Gm-Message-State: AC+VfDwzkjIrwfCKPAqPmMnhEK1OLIyNqz45AgOcBgJJ5Ef2vKWQJavB
        HVXm3HuT4DpDWXSNew2nJ1sdIwzDDgZbiwJmLrOq
X-Google-Smtp-Source: ACHHUZ7yUhNbmuvXlzofN93mfvpbxSrIcKSguRytW4cyF/VmR2y8A3OBBmAmzWwzKwvrM+NbP1XJ9pbogBDbz9odvAk+
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e7c6:0:b0:ba8:8fad:c19d with
 SMTP id e189-20020a25e7c6000000b00ba88fadc19dmr571444ybh.8.1685658064872;
 Thu, 01 Jun 2023 15:21:04 -0700 (PDT)
Date:   Thu,  1 Jun 2023 15:21:02 -0700
In-Reply-To: <f57c1007cad106a6387c77ac4d06208d39bfb9f8.1685472133.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601222102.420798-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 06/14] config.c: pass kvi in configsets
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> Trivially pass "struct key_value_info" to config callbacks in
> configset_iter(). Then, in config callbacks that are only used with
> configsets, use the "kvi" arg to replace calls to current_config_*(),

OK, so the end result of this patch is, indeed, that configset_iter()
passes kvi, and this is proven by some callbacks being changed to use
the kvi provided, and still functioning. I did not verify that the
callbacks in this patch were the *only* callbacks that are only used
with configsets, but I don't think that is important for the purpose of
reviewing this patch - as long as current_config_* has all been removed
at the end of this patchset, then things are fine.

> and delete current_config_line() because it has no remaining callers.

Ah, great that we can remove one of the global-reliant functions as a
result of this.
 
