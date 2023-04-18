Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A746C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjDRJuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRJuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 05:50:18 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F28C2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 02:50:17 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-546ef028d62so173404eaf.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681811416; x=1684403416;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttLIapB2H33s87zyQll/l2JV1mRjITy0ziR0KMIOR1w=;
        b=JZXjZyRxuJRklE/lMvOzJknaJd4VeLv7zWKMX6L514Hfjg/Z+ENJCFhkp0XSIjaj8z
         06GB/nX8tkllFFAhUIidRi9/L7ItchvsVXYvt+E9jD96ehVSA82SXbkxXeV6fdbxLMAO
         r5l8ToHcOzRETie2TS80heOHI0ivu6ZJPnzGtd4Kk6TE7WwVTX315RY5N6Y3wnH+hMtR
         PIY3oDS1zMx0hmdpiZCXTRsyX4b51gKKaMo2dvNZDzoYWQ7dLmQuTQl+xVjxTI2t6k8d
         Igfa4Lzna40fvyo0YhDJrfqOI3fGg0fdTO+XwOs06T611f+r4BP2NBzgY+r3K78/49qu
         U2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811416; x=1684403416;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ttLIapB2H33s87zyQll/l2JV1mRjITy0ziR0KMIOR1w=;
        b=M43lqpTsK5XSYTutjQP1vgU1O694KrN8mlbLCRJMoieopxWTFZdBQVR2O6I2pC63Bj
         YJW9GwPYZN5EzH8TVsx0R/OCH/PvhLG6ypYeTIVRA8hgG8zgdw+omOh2X6nJTw3g0Kij
         S8rqUS7M0fSTbdGXBhBXN3YLZxB7Im2exzn74WHgfbdEtJoq2JbdcLNwzm2tSiDApTU6
         Xsn8YOIcKNNk6vpGnPpwx2Ccgnqx9JaKCdL8t9ypSqNTMkJLMysvnW9o+5hyUDjPAVuJ
         Otax2VFT4kkGfyOvyb76no6DY7qv8xbIabv587BgcHSb92DRPXO+mrtNJ23+3nOnJIHo
         0QuQ==
X-Gm-Message-State: AAQBX9eYGm+s9UY2Sp8jExsyyydO13JSy+IpxxCw6aJhVoV7dZWGpLh+
        YCXNxIuRsbVYZDc122bruT0=
X-Google-Smtp-Source: AKy350by70r714rF40ea+SL3JKPR5kf/xjcWs3UCIUXVfdCo6MbByEDB2rq8N3Ll0+ZvpjKL3hQzZw==
X-Received: by 2002:a05:6871:1c5:b0:17a:c7ff:ccf5 with SMTP id q5-20020a05687101c500b0017ac7ffccf5mr912461oad.32.1681811416368;
        Tue, 18 Apr 2023 02:50:16 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id yy21-20020a056871259500b0017ae1aede32sm5414776oab.46.2023.04.18.02.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:50:15 -0700 (PDT)
Date:   Tue, 18 Apr 2023 03:50:15 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <643e67d71c0ae_21cdec29495@chronos.notmuch>
In-Reply-To: <20230418090310.GA414708@coredump.intra.peff.net>
References: <20230418011828.47851-1-felipe.contreras@gmail.com>
 <20230418040034.GC60552@coredump.intra.peff.net>
 <643e2aeae0515_217cdb29473@chronos.notmuch>
 <20230418061713.GA169940@coredump.intra.peff.net>
 <643e43824a220_21b043294f8@chronos.notmuch>
 <20230418090310.GA414708@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: remove custom callouts format
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Apr 18, 2023 at 01:15:14AM -0600, Felipe Contreras wrote:
> 
> > Have you looked at the HTML output with asciidoc-py? It has the same
> > indentation problem you spotted in the manpages.
> > 
> > I don't see it in git-scm.com, but I presume that documentation there is
> > generated with asciidoctor.
> 
> I hadn't looked at it, but yeah, I see it has the same issue. That makes
> sense, since the XML output from asciidoc was wrong (and our xslt was
> papering over it for the manpage build).

Yeah, so the problem is already there and had nothing to do with my patch.

I sent a separate patch series to fix that _separate_ problem.

> > > So I'd prefer the open block.
> > 
> > What if I add a proper title?
> > 
> >     === 2. Merge
> 
> From the perspective of somebody skimming through the examples, that
> doesn't seem to help much.

I think it helps that the examples are not indented to a level that no main
prose in the manpage is indented at.

> > It's not something that's probably going to be used in practice, but to me it
> > makes total semantic sense to have big chunks of prose in a section of its own.
> > 
> > Having a huge list item on the other hand does not make sense, it would be like
> > having a list item that spans more than one page of a book.
> 
> We may have to agree to disagree on that.

Do we though?

Do you actually think the output of this command with a huge list item makes
semantic sense?

  (
    printf '1. '
    for x in $(seq 1 10000); do
      printf 'foo '
    done
    echo

    printf '2. bar\n'
  ) | asciidoctor - -o test.html


> But this is exactly why I suggested doing the syntactic fix first, rather
> than reorganizing.

The syntactic fix is--first of all--orthogonal to my patch.

And secondly: causes another glitch. So it doesn't seem like much of a fix,
more like a workaround in which we trade a big glitch for a small glitch.

> Once the fix is done, then there can be a separate discussion on reorganizing
> (which, frankly, I don't really have much interest in either way; I gave my
> opinion and I don't have anything else to say).

I'm not sure it's a fix, but more relevantly: I'm not sure what that has to do
with my patch.

The fix for how we use asciidoc in git-checkout.txt can be implemented in a
totally separate patch series that has nothing to do with $subject.

Cheers.

-- 
Felipe Contreras
