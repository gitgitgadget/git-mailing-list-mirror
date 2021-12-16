Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CBAC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 12:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhLPMQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLPMQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 07:16:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C9C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 04:16:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id f11so1812039pfc.9
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 04:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYgSDo552kGyCqjjG4u0hVF03Ttv/natFB9SWdR+6jk=;
        b=kQtjYi0wN2RTKQpEQTGonDZ+HgoQQsTxzOk5yso1wOc9mUVDxJ7RVSmizPP1EnCmR5
         FyC4xXP7Qiel0cvT6ECGZRcJy0ZOGGAvpu6+DwjLlsuY73OfmcWkGUy1QEmHc+w7svzQ
         lgdT4PIzCYRr1FhEiwpHr1R2brynYzn3NvzgXIaFE3/r9GPxru+miuU/1hPZ+6a/IIXi
         wE4tlYGx6bXJvvhb5PgtgRqRdNFRoM3B5ZC428NxSJSAYGhudzusfMR3s+RANX/wUbV8
         wm3bHcjRJf5JuUDOLdrtXLSdcY8ck2IusQRccnvmPChKk1Aa5GSwh3MrljgHyRShJT1+
         E47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYgSDo552kGyCqjjG4u0hVF03Ttv/natFB9SWdR+6jk=;
        b=BCsCKRDsoliqGTKs9QQo1xOZk3+szHFePoLL12KOudJHWtUQhqOn3VfQ4rzv5biHUi
         yTxBANkNYH17JmexSSnDRYnMjKP+L7NFhtCLnL0THEGafuFUuvTw2vWZx+NG9Q83UwIH
         82tHQls0j7AgdCWX5zHwqp8KvMMT9LcBbbyy8QyKwlhV5MukzsVio/8ld8HZLyEccRGh
         cepoudfn9ueUgbEoIeXuBJUzG8gjcDw2xvAtaxYEyYfb3eUftPD9RxcN2MWBGyhj3Tom
         KCpQ2Mpm+/m11IjfaOpLtmylPVzpMFseKHSRkMyQNciH+QTA29SWVPySGueaiHaabQZ1
         KqeQ==
X-Gm-Message-State: AOAM530nyg4nEnlCEP73dEBDFjPDVYr02QIU7OY8ft4by1WFWTtFOoKj
        dz7Xv8riRKWPgj0Vqt0MRAM=
X-Google-Smtp-Source: ABdhPJzpTwKDCrLc6H6ILvLkyyP576YKgVgWuBHEcjlr/ZDIHw1AfnCufRYLtmYZ8ewAbWCV0SkFSQ==
X-Received: by 2002:a65:648b:: with SMTP id e11mr11858355pgv.138.1639656996642;
        Thu, 16 Dec 2021 04:16:36 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id nv17sm9268774pjb.55.2021.12.16.04.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 04:16:36 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, dyroneteng@gmail.com,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 1/1] ls-tree.c: support `--object-only` option for "git-ls-tree"
Date:   Thu, 16 Dec 2021 20:16:30 +0800
Message-Id: <20211216121630.14553-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g5f17c1a2c1
In-Reply-To: <xmqqk0g5656r.fsf@gitster.g>
References: <xmqqk0g5656r.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I notice that this changed from --oid to --object and I agree that
> it would probably be more friendly to end users.  In fact, this
>
>    $ sed -ne '/^SYNOPSIS/,/^DESCRIPTION/p' Documentation/git-*.txt |
>      grep -e -oid
>
> did not find any hits.

Thank you for comfirming that.

> It usually is a good idea to enclose these in () so that they are
> safe to use in any context in a statement.
> 
> Luckily, bitwise-or and bitwise-and, which are the most likely
> candidates for these symbols to be used with, bind looser than
> left-shift, so something like 
> 
> 	if ((LS_TREE_ONLY | LS_SHOW_TREES) & opt)
> 		... do this ...
> 
> is safe either way, but (LS_TREE_ONLY + LS_SHOW_TREES) would have
> different value with and without () around (1 << N).

Make sense.

Will fix in patch v6.


> Style: we do not initialize statics explicitly to zero.
> ...
> Likewise.  It is a bit curious to see these listed in decreasing
> order, though.

Will fix.

> It is a good idea to leave a comma even after the last element,
> _unless_ there is a strong reason why the element that currently is
> at the last MUST stay to be last when new elements are added to the
> enum.  That way, a future patch that adds a new element can add it
> to the list with a patch noise with fewer lines.

Very clear explanation.

Will fix.

> A better name, anybody?
> 
> This bit is to keep track of the fact that we made _some_ output
> already so any further output needs an inter-field space before
> writing what it wants to write out.

I found a word "interspace", it looks like a little better than the old
one. I will rename to it in next patch, and If there's a better idea,
will apply further.

> SP before ','.

Will fix.


> Curious.  I wonder if we can get rid of these two lines (and the
> line_termination bit in the SHOW_FILE_NAME part), and have an
> unconditional 
> 
> 	putchar(line_termination);
> 
> at the end of the function.
> 
> That way, we could in the future choose to introduce a feature to
> show only <mode, type, size> and nothing else, which may be useful
> for taking per-type stats.
> 
> We need to stop using write_name_quoted_relative() in SHOW_FILE_NAME
> part, because the helper insists that the name written by it must be
> at the end of the entry, if we go that route, but it may be a good
> change in the longer term.

Let me try to represent to make sure I understand your suggestion
sufficiently.

"write_name_quoted_relative" is used to compute the relative file name
by "prefix" and output the name and a line termination to the given FD.

We do not want use "write_name_quoted_relative" in here because the
function alway output a line termination after "name", this may bring
some inconvenience because the "name" may not be the last field in the
future.

So, instead:

We need to calculate the file name (relative path and quotes if need)
without "write_name_quoted_relative"  and then output the line
termination before return.


Thanks.
