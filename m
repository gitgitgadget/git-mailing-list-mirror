Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73AAC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCURJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCURJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:09:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3993521F6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:08:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so16576097pjt.5
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679418474;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7cjAQEelJjJCetHZ+/cL3vph2bFf/xWjfkE9ljTqpk=;
        b=fipiv0w6S0e+EKkNt6iCksu/KDcr7GNeupqZ0aOUTVsAMir67JSkRjFfnzrVHYbBty
         CwYu/0ukcV42F6pOlo//a7yWwQH1LWjmmqw7HgnBPRxPPCro1MZogcZjcYXXUWflK7kJ
         LR2+8UMreNNiiXQ1mKz1t/dypznQw5LjSJjWuyv4HhkS8oGs8xuxVBu4PZxaSGzwgM8g
         2og2rcO4eUhXSHF9+CtFcQ1FibRouoN2kpc7Npcq1ytvJrP9L7lmDTudQQdqsY/Qzcvm
         6tp6lugt/9yk2N5NRn44+gjZLccOXTDFf/Ua+/AV9VTQAYMZPPLgtV2HNKK2rIebCw90
         ffIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418474;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X7cjAQEelJjJCetHZ+/cL3vph2bFf/xWjfkE9ljTqpk=;
        b=w92VG9dYJMGzrnPrxMBL3LoUueahvYol66OyEgw7iFhHttU34b7FPZZl3d2Fxa+fng
         NvgKARZuXtEeBQ/ZHEi27BshIjrObqKj6UojqXHtWxjGIi/tInQ/91fxB+vb06o2sa+2
         /iEaHAbR9Yo3auw1HNDqwRrI3KYKkrfBzb5aPQiUiBwDJh1PdFtgGHidyCdi9zqpaBv3
         rpuewnCP4aWakG1igHU38LMD4w2ekM+bW9kd2U1nxevRDfklSjo6gzOT/axTz1xH32pd
         EE2pe+vOHYIpSA6x8kJ8Hb1iPnmdc3LO0sgCD8zPGlqMrY8VHRZZEQIHctigDeVdRj0C
         cGeg==
X-Gm-Message-State: AO0yUKW33pzMNQj1aL2NqaIqeT8JCBNWDKbTcCJkiMITXeqb1DSp3Fu9
        9GVJDK96+ul9gZ/Gbxxz2tiBAh+TeMg=
X-Google-Smtp-Source: AK7set8V+pni615rBfjAGK99VVJGaGlElrASXAPWa8bKTt5yT31QaL6KyJUeEyY5v/cLlTglBW4QCA==
X-Received: by 2002:a17:902:e413:b0:1a0:75fe:cd66 with SMTP id m19-20020a170902e41300b001a075fecd66mr2425783ple.50.1679418474250;
        Tue, 21 Mar 2023 10:07:54 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902b58700b001992e74d058sm9007070pls.7.2023.03.21.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:07:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     "Priedhorsky, Reid" <reidpr@lanl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug? round-trip through fast-import/fast-export loses files
References: <BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov>
        <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com>
Date:   Tue, 21 Mar 2023 10:07:53 -0700
In-Reply-To: <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com>
        (Elijah Newren's message of "Mon, 20 Mar 2023 18:57:21 -0700")
Message-ID: <xmqqh6uejamu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Honestly, looking back at those two patches of mine, I think both were
> rather suboptimal.  A better solution that would handle both F->D and
> D->F would be having fast-export sort the diff_filepairs such that it
> processes the deletes before the modifies.  Another improved solution
> would be having fast-import sort the files given to it and handling
> deletes first.  Either should fix this.

Reminds me of the trick we had to invent for "git apply", where we
process deletions first and then creation, to avoid the exact
problem of creating "foo" while removing "foo/bar" ;-)
