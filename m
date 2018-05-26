Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CB81F42D
	for <e@80x24.org>; Sat, 26 May 2018 05:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbeEZFw1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 01:52:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46843 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeEZFw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 01:52:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id y15-v6so6350724oia.13
        for <git@vger.kernel.org>; Fri, 25 May 2018 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+2hNqxTyJ1Wv8EE9NYaQw8BqsOs54uTSgS1H+Qby/RA=;
        b=ov5HYvniPDZcrNptOaNcE6PBvvlUfuPSfeKnWCPkGzDtu0p3w9qpUhZCDe2zvEBH4g
         IyxLXVR6cJ2mnNPDBeket3td/9/s1fFZn+bzyrW9/dMIylMfJDmXXpZH5xNlkDiyRii7
         QYKIkFk4Onbal3ngYV3SNMWp/ldbK94n9Z9I04aFtig5+FUJep5WSOd+1p9j+hIL4LlJ
         jWmKHoRnpo6+cAZQfbS/NiQIgdSJ0rnP57nOH6S8sCAu/QYe5Vm0VHqKhQRiMB0ev1CB
         bkL1PaSnL2oC+ogTm6S8f9+oYFBAahbw2gc8dfR4i04SJD1+tDZgTR67JGcQeD+7k8CF
         X2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+2hNqxTyJ1Wv8EE9NYaQw8BqsOs54uTSgS1H+Qby/RA=;
        b=EYP/mokTV9X+14H8opXyP7p1gVILWGF99UB8MzTxETMTj6kjJvZnwgEIiD6L9invUw
         8G8b748oILdLIVlSBeUB7utHbwSeEPVdE6VoNlq55+NqOXknUT2T9aZ3GG89++TD0hpD
         0VmauXSqrC/x9n5q73pRophxvqBIz9AvLBHVIGY1S2Ht9/uL2QfhYZ9HQ4hLgSVZTFWz
         Mm+B+Lp6elVx3F+3iABcyPS08mY1C28QlS7GB1qElKlm3ZBuDiryF6BHqWkA7SOgbN31
         fYrqbSqOPpzs12GPuNMt4c61ovyFuKvPKjM81QAMEIeGke8w+7UwhYwi/4rofoL6V8AM
         d1AA==
X-Gm-Message-State: ALKqPwfICXo6fWNr/gPg1/BCxkBO6XojcVag23JLLN70/aufsZFfJ12Q
        2lm8ZU1wpPgY558rS4rJ2FK9uunN2VN7/PPF224=
X-Google-Smtp-Source: ADUXVKJyt8Xync/5iiG5RMepGrIU4vw7WbrtOX1BlzMaNHZ/6votjbCnOOq8XiH4Q6UClg2zQb/1V9QzK8k8IrSmuUo=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr2977346oie.30.1527313946269;
 Fri, 25 May 2018 22:52:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 25 May 2018 22:51:55
 -0700 (PDT)
In-Reply-To: <20180525225601.22575-1-lintonrjeremy@gmail.com>
References: <20180525225601.22575-1-lintonrjeremy@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 26 May 2018 07:51:55 +0200
Message-ID: <CACsJy8C4zNZAe6Vw-mz8r8HueYdQKs4ZhMOQYX0v7ypfHdmShg@mail.gmail.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
To:     Jeremy Linton <lintonrjeremy@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 12:56 AM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
> @@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>                 return NULL;
>         memset(&stream, 0, sizeof(stream));
>         stream.next_out = buffer;
> -       stream.avail_out = size + 1;
> +       stream.avail_out = size;

You may want to include in your commit message a reference to
39eea7bdd9 (Fix incorrect error check while reading deflated pack data
- 2009-10-21) which adds this plus one with a fascinating story
behind.
-- 
Duy
