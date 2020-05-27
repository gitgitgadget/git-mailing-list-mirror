Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F53C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9436520707
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5F5d77S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE0W3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 18:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0W3V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 18:29:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF510C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:29:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y17so17462569wrn.11
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=O30FYNA15Fr/rLwTh19CXjC+z2F7THzVztgO6VYbPAc=;
        b=h5F5d77SNC3D0l/wEAhixduZxGjmmCbQcUHR9+ni1QS0b3IxzfbyT3DupBAguhiedC
         GHVnO21CPFbD4d9Ks9vtzmiAm0BQK13kEzAlgWP3k/Wrc3Vu5k8iKhl+RXhJVwRejTlR
         eczGU3iaB50UQYOHZey8L4DyqVPHEcmivqxbvSy7JNgx5U4sULRLCESMmHazCaVlTAtu
         t58Ux5UmHx8OkYRw8HlAjvlwQL+y/ou7DSzv7UsbfDBbo1Xo4MnAi8RUMbMqQSp9RpxP
         ZaL0LU5KurHhAB20gduE+VlJRcLLmmNvC1xFtbXWKC0wwcjhZxwl0ZQPZIPnlA2IRJe7
         cInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O30FYNA15Fr/rLwTh19CXjC+z2F7THzVztgO6VYbPAc=;
        b=BQyYPDI6KvMrVTKRkhdF2JCgew9DCYnXpAfWm6bFVQRWAEuEHgXq3SKqemrZ5IngI1
         Y8tvW/nURQJqgD/ET6utLJsJZ0jpxOKZbaB8e72/2eI7Tzx4WPkSWB8iAIOsTDUk76DB
         eU1Ag1OO7okCc2k1ZCw+zpWi91d8OelzTv3tMAQbLMzI5CTEfT4+hyAc3M9O/jTomz4i
         qHaA3gJHjKgcbUVrLYBLGZ1bYxbULw2oH4zp1LM8tY30nCwWPglc6h53ABaJP0rTG2Tu
         YAUduMNFiCq8Bkz3MwyDuUjoFVf0TMcFJggIjtSMgJZN7ud5LonB8UXKC2i+sl1Hgi3I
         UdDw==
X-Gm-Message-State: AOAM5311HQlJwokS4K8VbIKjpCZopOyFrHLkf/2G9jTYRQ6EufpUSc00
        TX6aoOGjGganwgIG8cjsoBM7t/7haPuDL70ALqTEKdeaQCs=
X-Google-Smtp-Source: ABdhPJyZm3XJS0VMY5144wBS5dauII3PDO/qXgucB1sxGYOyAO3vYBKZFTJTYec8ilcRq79SKO0ntYbp0nZQv90DXQY=
X-Received: by 2002:adf:a55e:: with SMTP id j30mr506736wrb.60.1590618559011;
 Wed, 27 May 2020 15:29:19 -0700 (PDT)
MIME-Version: 1.0
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Wed, 27 May 2020 17:29:08 -0500
Message-ID: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
Subject: git grep --show-function treats GOTO labels as function names
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git grep is an amazing tool, and --show-function makes it very easy to
create reports that contain not only line information, but the
containing function as well.

It looks like there is an issue with how the parser handles "goto"
labels, as it treats them the same as a function name.

In the example below, there is only one function, with two matches,
but using --show-function indicates there are two function names.

$ cat test2.cpp
int main() {
    FOO
exit:
    FOO
}

$ git --version
git version 2.26.2

$ git grep --no-index --show-function -e FOO test2.cpp
test2.cpp=1=int main() {
test2.cpp:2:    FOO
test2.cpp=3=exit:
test2.cpp:4:    FOO


Zach Riggle
