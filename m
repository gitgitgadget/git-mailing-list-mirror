Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF30C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 19:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCaTFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCaTFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 15:05:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A3322E85
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 12:05:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c4so5437757pjs.4
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680289501;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A6G4uNBb7DLlDfFTD9WPnD2nniqjNfK5vGlbvfIom8=;
        b=nnQVbInooLXdYEzRcYjCEA8x4NreuYN/DR8VHHleIE47VANHyUpCEho0XHiVSRtOrj
         6HiGbzrlQzDQzfPSs057wL+/HofJ/JOk38CGJPUYRcyLp018c7ZdGDydkUutU7qjEP4x
         kB27/b+kQB5HdwtvK2aRmREbMzDE157M6eT7iF1F3/OGjqAFKuHuwtAaT0Ta5UhDeDN1
         6nZmWZOSIDGxYr69hsC7uB/fu7ScqnGa2s53499Jg5MHM/ZbD+dy/IvLGjLnuRtJIewh
         N3yCLXfsrRgHJG3jGTiH1o5akZ/RIIg0EwPk6GJVevEd1ejqaU+j4ccpaGLC8CRYM8xQ
         B6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289501;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5A6G4uNBb7DLlDfFTD9WPnD2nniqjNfK5vGlbvfIom8=;
        b=A3iTyTLOCJ1wTf3oAeFRR3qzR2HxV1LA2r1Ji9XweAQzpnIbK5M3mb3HisJOfXoPqm
         aKWTVnCSHocPLUWl2pQ1q026c7UYp5e2Ans4O610EBVoTY+tmLiSo/dztpvszqSkWhjm
         qkB2qz6HL5WwVgnRfcszdHrZw9a+ZFGWMlOn1lyOsqq8o+yFKpuWSz5TPSTfSiI6KwX6
         jhZrXOqVEbl1qHTJFOKshh67l5O1PQmgjfT5qKxsO8F3CnkJf85LiZK0tcCthjVSFO92
         t6RSW4J5aFnrVz6fx3tYiC95CtokblvW5aKKfxGu2dsDh4akysBhz8Yfhv8y5uYs/shx
         KnGw==
X-Gm-Message-State: AAQBX9f1zoAaL4ypXox0xUMKxl/0ceZpEJmglYGZfmJkYJzuEoTqxWzs
        KxWMd2Aaioh7otK8H8gprXFzV9hriWk=
X-Google-Smtp-Source: AKy350bGtoegPJBkqcKrl6CTg4Dao7KoancKU0v2AhGjQfjkS1ID+OzSTwfsGUczD3cT7W5O7IyRJA==
X-Received: by 2002:a17:90b:4a07:b0:237:1f17:6842 with SMTP id kk7-20020a17090b4a0700b002371f176842mr31519955pjb.10.1680289500761;
        Fri, 31 Mar 2023 12:05:00 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id gp11-20020a17090adf0b00b002376d85844dsm1799266pjb.51.2023.03.31.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:05:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/3] doc: interpret-trailers: remove trailing spaces
References: <20230331180817.14466-1-code@khaugsbakk.name>
        <20230331181229.15255-1-code@khaugsbakk.name>
        <xmqqsfdkep2b.fsf@gitster.g>
Date:   Fri, 31 Mar 2023 12:05:00 -0700
In-Reply-To: <xmqqsfdkep2b.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        31 Mar 2023 11:46:52 -0700")
Message-ID: <xmqqo7o8eo83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[jc: I forgot to cc the area expert, so here is a forward]

> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
>>  $ git interpret-trailers <<EOF
>>  > subject
>> -> 
>> +>
>>  > message
>> -> 
>> +>
>>  > see: HEAD~2
>>  > EOF
>>  subject
>
> This example pretends as if the above was an interactive session the
> writer of the documentation did with a shell in a terminal, and
> these lines are trying to show that each line is prefixed with $PS2
> (the secondary prompt string given by the shell for continued
> lines).
>
> Taking that fact into account, it is arguably more correct to keep
> these spaces rather than removing them like this patch does, but of
> course it does not make a practical difference, because these spaces
> are invisible unless the reader reads the source documentation pages
> without passing them through AsciiDoc machinery.
>
> The only folks that would be helped by this patch are those of us
> who edit one of these four lines of the source file (perhaps by
> replacing '>' with '|', such a patch tries to show use of a
> different $PS2) and are annoyed to see trailing whitespaces their
> patch inherited from the original trigger "git diff --check"; I
> wonder if that is a good enough justification.
>
> I, however, do wonder if we should make our example more friendly to
> cutting and pasting.  And I would not mind it if we got rid of these
> 4 trailing whitespaces as a side effect of such an effort.
>
> One way to do so, while still pretending to show an actual session
> with an interactive shell, may be to give the example with an empty
> string set to $PS2, i.e.
>
>     $ git interpret-trailers <<\EOF
>     subject
>
>     message
>
>     see: HEAD~2
>     EOF
>     subject
>     ...
>
> but then it makes it a bit harder to see what is input and what is
> output.  Showing with a separate intermediate file, i.e.
>
>     $ cat sample-message.txt
>     subject
>
>     message
>
>     see: HEAD~2
>     $ git interpret-trailers <sample-message.txt
>     subject
>     ...
>
> might make the result slightly easier to follow.  I dunno.
>
> The same comment applies to the other hunk.
>
> Thanks.
