Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25CC433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 04:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244D82073A
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 04:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxN8a6WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgGME6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGME6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 00:58:35 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4DC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 21:58:35 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id e11so11101862qkm.3
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 21:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6+uH3V24qqtI2V97StSfUi5EDSJt1pKBGSq8ZIIjTDQ=;
        b=pxN8a6WBlFrZnhYO/I4CpipdkomoS1Uy/QPSgZzYWdFJjiYMhHHvoiqRLap9YkXhNf
         aLcjEcP76rUoBCMPCwwurKQF90JV2JZkRTaZuO4hytJm2+E+pOFSKfj7eIuk9k4GJE35
         QnfZ92v8p5mbut3ezXzGNwxTboG/5OF1wIHltJSMTBWuS24NDPa0XEdAeSJbbUojK2x1
         lT+NW7aci6QbC4/+cJlf6fW9T+bQVfRj5K6f6oaUYBPyTSIX+E6lkFLz46sfSjC+gpPF
         F6DaWie90BeHxn5fs9aBz67eNr8EqHWmDuNMZ3ZUA6IiHuZ8aGEM2XsN9pLD+UvzNCd1
         ddRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6+uH3V24qqtI2V97StSfUi5EDSJt1pKBGSq8ZIIjTDQ=;
        b=eLrsCR5U0XMIls6B6nyNvCXYCquAYUVoy8OjawKOym52a8uVyYEp09KmyxWd1U1dyN
         iqvIoCCCC7zmMAUWPC4r614tDj9LD4hrJmfH7/Zu9Kslv/zZMX8b5vgG7NgQAPivQiTH
         8M/gjj3srXZMHPaaZhFQqUTJxXbw1C2LvJUVIWmvoIYz+PW0jKPnIJ616AMAKv2rtMh7
         Urtr36JHP//YuXWLjgPZ9qpLlMNOZAYC29j9ZTHqF4nhcGh5e7gvZstrDcDko44czznt
         Fm5u+WuoK8MjEW/8aXEKEIhpHZejg5X48+ustKitsKsjujP+ud9ArqfIPnuF92V2qo+F
         6puw==
X-Gm-Message-State: AOAM533o/5J6JATcZ3FW17lvy7NxeazFrLkh6ggQBwENn8knDXCME3yq
        L7cAzsWdRjfOa2LYbCRv8A64uktt+Zo/XOubup96GwLY
X-Google-Smtp-Source: ABdhPJwkeZeEsH5gkBr4Hxm4ifQlnKS8JsZOcHac7UuDRJ3uA3P3sRl3cRNqRKinuqkGp/TXvcySPIBk87JBop2JTIc=
X-Received: by 2002:ae9:ef04:: with SMTP id d4mr78868721qkg.41.1594616313802;
 Sun, 12 Jul 2020 21:58:33 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Xu <jasonx98@gmail.com>
Date:   Mon, 13 Jul 2020 00:58:23 -0400
Message-ID: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
Subject: Force git diff to create a binary patch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Here are two small files with non-ASCII data, yet git diff considers
them text instead of binary.

    echo -n -e '\x01\xff\xdf' > bin1
    echo -n -e '\x01\xdf\xff' > bin2
    git diff --binary bin1 bin2

Result:

    diff --git a/bin1 b/bin2
    index 802dc8e..c39b638 100644
    --- a/bin1
    +++ b/bin2
    @@ -1 +1 @@
    -^A<FF><DF>
    \ No newline at end of file
    +^A<DF><FF>
    \ No newline at end of file

I think `--binary` for `git diff` should force the creation of git
binary patches if there are any non-printable-ASCII characters, since
my understanding is that `--binary` is for safe encoding for email.
Otherwise `-a` can be used.

Original post: https://stackoverflow.com/questions/62858327/how-can-i-force-git-diff-to-create-a-git-binary-patch

Thanks
