Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93366EB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 20:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjGFUyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjGFUym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 16:54:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA11FCE
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 13:54:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3faf39c8ad1so2959545e9.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uw.co.uk; s=google; t=1688676876; x=1691268876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B53BpIF9KxPDTeBZtZu7SsqBQ1lRldhAXXaLi+tguko=;
        b=eWNuuCH2T+TBjjOFtBAM2PyFuN9aI5FnMSS4Dncj40XKYhfBmLH8KhTsVOhsj0gjPZ
         3RvWwNMHFHNxsIhd+Ce/SlM53A2l9cqyqAMLpcvhxl/2AJg0iY/k5xUuJcP1YvatgzY1
         2Cl+n6AiQQtDFYn+1uvV6luy/v9D2NkoHbhGFzFvIztaWpqvCdMuat+o74toqQAb3AIN
         DJP4eesamBIOxrobKEQER8JMc6wHFpXTrThiC/ahOJL8CHwUjC+kG9wrnQgfgmVr8akz
         OGtKilqXNs892b/7X28ZXi/a+SSawoZfz8TsYZomEgadGFO1fa1mCmZyR1y/3EmOdYi4
         QxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688676876; x=1691268876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B53BpIF9KxPDTeBZtZu7SsqBQ1lRldhAXXaLi+tguko=;
        b=fAkfERYdzsEF/v9QBcaAFWa9Qj1r1P6W4vfCkt9NFyO+PcAZip78KODJU/FF/96Z2D
         AZ6w8+/xapHbZRspJLR4Cf38/Is65rO47FtTqEH/QlLfFD9rNgagybec/heFgkza6Nvd
         6WFWvgijstdaZTCI8+ZtNSNmYTKVMD1WKq7YwYGYNueL/q8yTxbHG/DGI8h+V8L+xlyE
         GVVWygEupY7mT/B4QQQL2DCKlHvskFKoOvs8GKs3wnmrL0fti6MHUQr1W8kj6+EXaIXG
         dFuWK+WUQ6lQvLXm5KXHSypgUXTnzDIuBFvf9MzJAP4P0UJsKu8qgk8UE580J7RpiPaj
         OC+w==
X-Gm-Message-State: ABy/qLacSEULiT9o6+AKlp8nSeLR0SbEgGffnte1Tl+Secoj05s/UoPD
        ALy/0X1j1k3Ul/UdBPsvjqOL2Zn3hSOek1SBoULFeU6Xpi1M8WzHcN8=
X-Google-Smtp-Source: APBJJlH6YfdVs/4G2Bt8YG9AFUe6DmEm+J1wal/j3vFX7zWqiO4O4I4Qv4jwcoj/BcRIFOeE0SvQxylUtDWlxDzd8Xg=
X-Received: by 2002:a05:600c:82c6:b0:3f7:fb5d:6e7a with SMTP id
 eo6-20020a05600c82c600b003f7fb5d6e7amr2491669wmb.0.1688676876335; Thu, 06 Jul
 2023 13:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
 <xmqq7crddjtq.fsf@gitster.g>
In-Reply-To: <xmqq7crddjtq.fsf@gitster.g>
From:   Matthew Hughes <mhughes@uw.co.uk>
Date:   Thu, 6 Jul 2023 21:54:10 +0100
Message-ID: <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
Subject: Re: Expected behaviour for pathspecs matching attributes in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Jul 2023 at 18:35, Junio C Hamano <gitster@pobox.com> wrote:

> I wonder if this serves a good addition to the tests?

Good idea, that would help clear up what's expected.

What about some tests for the case of attributes defined in a subdirectory? I'm
still trying to understand what's expected in that case, specifically the
test_must_be_empty case (the 'rm' at the end is just to avoid polluting any
other tests with extra attributes, not sure if there's a more standard way of
doing this):

diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index 457cc167c7..7a7502a6eb 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -87,6 +87,23 @@ test_expect_success 'check specific set attr (2)' '
     test_cmp expect actual
 '

+test_expect_success 'check specific set attr nested .gitattributes' '
+    cat <<-\EOF >sub/.gitattributes &&
+    fileSetLabel otherLabel
+    EOF
+    test_write_lines sub/fileSetLabel >expect &&
+    git ls-files ":(attr:otherLabel)" >actual &&
+    test_cmp expect actual &&
+
+    git ls-files ":(attr:otherLabel)sub" >actual &&
+    test_cmp expect actual &&
+
+    git ls-files ":(attr:otherLabel)sub/" >actual &&
+    test_must_be_empty actual &&
+
+    rm sub/.gitattributes
+'
+
 test_expect_success 'check specific unset attr' '
     cat <<-\EOF >expect &&
     fileUnsetLabel
