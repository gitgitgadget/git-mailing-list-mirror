Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CBFC433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 04:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B506A64F85
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 04:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCFEN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 23:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFENX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 23:13:23 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD1DC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 20:13:22 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 97so3829670otf.13
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 20:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OR40ZvaM9DinnaxU17jSGoX5q0Bn34V0PdMXd+STq0=;
        b=MtoJpMYh/R7Np57/3kPu7x9ad5DIT/+zsCw556gGIDvaLruHJdDEE/k8O3+aJDnOJZ
         ehWuKXjeq2hBdQZkuozNn5cf1kAqDaOj/jcpaohYk2sylRO4TU/FI98jjQceZZ7V5Tl2
         r9XnQm2N4RwensxWXey6rP4G0qHfQCNT2tcukzWZjuljmlgR6zOxurIwSLx9n4kxnBOK
         8MN1YAOW8qKVqeW3lUcftaNcLTaFlaaSrozJ/x3+yDzfzzJ3Hw2A2CCpU8yRXZ5CMRfD
         kShvI5yGVbDvkORRgaubTDHeSMviXrDE+JxaEhzhq15xw5aXo9ydIoviOG5zbXgyFd0T
         gZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OR40ZvaM9DinnaxU17jSGoX5q0Bn34V0PdMXd+STq0=;
        b=RGGrZaJvsqR7kC76FwBmPXzVLYRPM2gMVsDAhlnjFkyXq2FG7hCpT0YmljpcHhQOXc
         AtqsruF75KgvZxW2NfZ2IZ59zCnRG5XWVKb3dQQ9Go/x4b8x0ollxcgWbwfSE3nP6hko
         uVWpiET2yhsgbbzFatM+zdCFRWe7hRg4mY7RmqKUL8ndFEmuAnBHv1Lfsm+BdtfGFuaq
         FZ6c/pQJofYylCTjyMVFmfaCluxi9WF+5v/tRt85nrogKuXXIAzD1DLZf4NxKBK+szga
         QRt0ISMVSsaDEY0encH1fry58WFU6OgZTdnZDKtJnh7xJnTgOHF7ii48BnMgblDyLpBI
         D6qw==
X-Gm-Message-State: AOAM531WtgEI0g3D5EHcvuGOBwGb+2tjjKFZQyHnB7sIySpyXIoy7EZd
        qQPL2VT3Yn+LEH21u36+amhWAGqFWB+HWaZ90JJSKcHwlEZftg==
X-Google-Smtp-Source: ABdhPJyF8BmXJV972Mp+/3WGL6EBvNFPXTWC7oK6awI2AQbJgYfyirClZMWaucm9K4WsPa0S3n7d4dY0TJZDi3r04iI=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr11026854oth.184.1615004002072;
 Fri, 05 Mar 2021 20:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
 <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
 <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
 <xmqqczwfg23t.fsf@gitster.c.googlers.com> <CAPSFM5cM4fdyWXD33PkT2bH6kM+3ixkxgAnhjUVYFtjUHgwU5g@mail.gmail.com>
 <xmqqpn0ed0m2.fsf@gitster.c.googlers.com> <CAPSFM5dM4NMeGqEG7hFLzyhJskqcrNtNqL9=MUCw9SEYYaFLoQ@mail.gmail.com>
 <xmqq4khpbgqk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4khpbgqk.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 6 Mar 2021 09:43:10 +0530
Message-ID: <CAPSFM5dhxm9kuzyXj6wF7s3BoDNzCmZHpaDFhvOBVB1QWbM25w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Mar 2021 at 23:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> >> The reason I brought it up was not because "--fixup=reword" is not
> >> needed as a short-hand for "--only --fixup=amend" (but thinking
> >> about it again, I do not think it is so bad), but primarily in
> >> response to "would it be easier for users if we had reword! insn in
> >> addition to amend! verb in the todo file?" that was raised earlier
> >> in the thread.  If we position "--fixup=reword" as a short-hand
> >> and/or a syntax sugar for "--fixup=amend" and advertise it as such
> >> sufficiently to educate users, it would be easier for users to
> >> understand why they both result in "amend!".
> >
> > Okay, so now if it's Ok to keep the short-hand "--fixup=reword" ? then
> > I think making the documentation more clear would be sufficient to
> > serve it to the users ?
>
> It would be good
>
>  (1) to keep "--fixup=reword:<commit>"
>
>  (2) to keep "amend!" but not introduce "reword!" insn
>
>  (3) document "--fixup=reword:<commit>" can be thought of as a mere
>      special-case short-hand for "--fixup=amend:<commit> --only",
>      and
>
>  (4) make sure "fixup=amend:<commit> --only" is usable as a
>      replacement for "--fixup=reword:<commit>".
>

Okay, I agree that this method is more clear ...

> but if we are not doing (3) and (4), then it would also be OK to
>
>  (1) to keep "--fixup=reword:<commit>"
>
>  (2) to keep "amend!" and introduce "reword!" insn
>

... than this one and will update the patch in the above (former) suggested way.


Thanks for suggestions and detailed explanation.

Thanks and Regards,
Charvi
