Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E46C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2622F64E40
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhCNN6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhCNN6R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 09:58:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F7C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:58:10 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 75so5848993otn.4
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4g0hGus8wJDfI+ojajp/B4GA10F6RO6j4QTsv0gLcDY=;
        b=ijyXUClY+lDVcrPGQlY0s4TSl4xUd3rR31V+f96MHf0yQGj6k1jKzNM1oIjHlzaNtM
         EZ100zvMjocCeWlbUR5hHVV1R61+L4UIZPYDWz1ENEcRhIEvEm8r3j9daMB2WN8eOUqg
         6eNez1Djbdo2J5muOtKSoZj8ZuaWrJSnUiifW7iKQoc9kV1RMmr2Dq+b1WEqf1yxDWdS
         JjVqXEP1CFlVxTO3qMUE4fWBo5V9MegphxVQBZUPBH6+rPyqYQnqBuizl33CFEMfGcqt
         jwr4kVkFLIydAuGkI0X2uV0XUoL/FNjCIJwWbtlSRb4X9VtD5SfcPcAQLEKVPU9usHbv
         vBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4g0hGus8wJDfI+ojajp/B4GA10F6RO6j4QTsv0gLcDY=;
        b=p03A4LqZ5D1HUZvlXaZxv6l5U/H3RAl+BFAju7N0LnW1ey97kEZ4JyGjpZOS6qrtU2
         8cc21L0JtLA1TETKtFDXvkRx8yzuf6M5nta0a82f15Bs/Unbdi+99uug1Dy1RkyygVta
         vZXwqB9GQntIzpTIGfu1aueEZ2v5/ubpcIfMk/HGXoR3rWHMaRbslt/Oxypm8tsz2E7E
         mxXqk1dhUREqmn7ybi/T/fSj9YAeqKvU67Jq0i8KK+DMypSAGcQolsWQGi3j3UHhN/R9
         8EYE0OF0maLS/N9lyDBZRHt5sgMzYl/J27zm+y6Z5rBoEIu8+Fd0xMs+gKqAkiTJMRCe
         /FWQ==
X-Gm-Message-State: AOAM530mjiuVp49LeDAStTPm3CHeamg6sVIR7TtJLg1Cjg9uyElARI2q
        EEMKrK2y4vT7ye/JzB8bpdnRtJYTyYAkKcqaeJc=
X-Google-Smtp-Source: ABdhPJz0nJ97onL5uSMqjS8wWz1Zn5ii20p4FJiAVRMPSVzGWbGh1yHEeK1n1ObHocjVhMR3oyrGsjzysxlQuLXNt48=
X-Received: by 2002:a9d:6341:: with SMTP id y1mr10539155otk.210.1615730290006;
 Sun, 14 Mar 2021 06:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210310194306.32565-1-charvi077@gmail.com> <20210313134012.20658-7-charvi077@gmail.com>
 <CAPig+cRQe3EURfXYQ9QwxfiSjJom3gZoZ_Q07ON4B+YgHu6dCw@mail.gmail.com>
In-Reply-To: <CAPig+cRQe3EURfXYQ9QwxfiSjJom3gZoZ_Q07ON4B+YgHu6dCw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 14 Mar 2021 19:27:58 +0530
Message-ID: <CAPSFM5dE=3EDZZ1E=4SOyYWjOA=uNtHAWphruojPtfLCv7xuWg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Mar 2021 at 06:40, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Mar 13, 2021 at 8:43 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>
> It may have been more accurate to retain the Helped-by: with my name
> while adding the Signed-off-by: (which I offered in case you
> incorporated my significant rewrites), rather than replacing the
> Helped-by: altogether. Not worth a re-roll, though.
>

Okay I will add that too, thanks.
