Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9423EB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 20:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjFWUcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFWUcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 16:32:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A75272D
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:32:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so13592887b3.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687552343; x=1690144343;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=70NzmnAnX55wR3X0zxD5YGeGS5/n/xFtYsdAzVw6md8=;
        b=qAd8TOhQRVfkc1rIDt4GJJMc+XOmVYCnOXvC4gM9YIM4Z0cDAchgWuU2ykSOLL+T2A
         rlxfyd/FSI+nsSWSAt0nD+Ss9+I4/wWzckTX2/XcCRPCz3kwFDt6bh3rQu88L2eLKlPa
         BZkiz7a0xKQ8yD97R8auS7WFtz1PI5HbNbHraDt2zqsXlOWhzUAGPh4ax649W5YGqvn2
         TVxA0sEkLtGGNoVuWCLpVO1d9ioqAyXzhitb3DGC2Ip4+rMvGkarbRtONysifH25gyMO
         As8vg+DbzbActN2mUhIYxD7X0DoL8bhommtgz5N9ggdBXIxkXScY8nfB3GqItzEdodrm
         mblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552343; x=1690144343;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70NzmnAnX55wR3X0zxD5YGeGS5/n/xFtYsdAzVw6md8=;
        b=Si3RvHutsmvUPLW9K2LT4xzyozA9t3qHmHmYQ3l41EJx/B6Esf812JA0Awg6DpYl1M
         cXR6TrEkP4Y6kWZz5KuX+xduL8otdOJl/r4nEw9CYu6uhDOb3Yc3IzZFODrh9SVIQusS
         jG2a9jOt8Z3KqgQ2MbkT0h3DQgLXFETwz4fmWPf5BsYE3B6V6d4ojccRob2PRIT6eeuQ
         Lis0kzIJS3P4Pkyn2XU9yNvqpU6+NU4eiqvQFJIJsfZICGWSlVnBJ36OusnUnu9Dng2d
         07E99BsPHAFz8KYVVlU4grGHsiUygJohM09qPowiVqljo7rvSVy+qtuvmJgZszguyj1g
         k4+g==
X-Gm-Message-State: AC+VfDxVdnwqiNICHqI0iVlS3OlXmI8uAQlsSXkkM1467fY8niLqmjPP
        4dG6AU7Ms7Dk7O7IiPJCxGdbXtO41JaZBkFjMqT5
X-Google-Smtp-Source: ACHHUZ71AoSJ+gqZruucTYnKz1H+dhZzaJ69/avDJtHh7jCNuLdpHcIDPTWr3QMLS3MnvAV12ISmTuvNpoCOzXKC8XLf
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:7ab2:ee09:eab1:38cc])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b717:0:b0:570:8a30:767f with
 SMTP id v23-20020a81b717000000b005708a30767fmr7998424ywh.10.1687552342782;
 Fri, 23 Jun 2023 13:32:22 -0700 (PDT)
Date:   Fri, 23 Jun 2023 13:32:19 -0700
In-Reply-To: <a2a891a069f46d3d77cafe61f64402c93cffaae4.1687290233.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230623203219.3255267-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 06/12] builtin/config.c: test misuse of format_config()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +test_expect_success '--show-origin with --default' '
> +	test_must_fail git config --show-origin --default foo some.key
> +'

On my machine, this fails with

  BUG: config.c:4035: current_config_origin_type called outside config callback
  /usr/local/google/home/jonathantanmy/git/t/test-lib-functions.sh: line 1067: 3255109 Aborted                 "$@" 2>&7
  test_must_fail: died by signal 6: git config --show-origin --default foo some.key

(So it indeed fails, as expected, but test_must_fail seems to not like
the exit code.)

Not sure if we need to be more precise with the exit code we're testing
for.
