Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4F5C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 22:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjELWRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 18:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELWRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 18:17:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F05C198B
        for <git@vger.kernel.org>; Fri, 12 May 2023 15:17:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so8776513b3a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683929861; x=1686521861;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbmxyCetEfr1HDII239goejMQD3BlGa412Wy+9w0Vsw=;
        b=UY+e3qOsZUYD0MXVFSFzV6ZwtW7eGsiDiiTpa6ekYj+TM8Q6NXtp73DYS9TXcr/XBP
         hrYXbSFqnjQpRNUV9Q2ojULVkmVj7FkGV/i7JYUEMV88Qv5voNnnk4HrRaSGs6h4aLMa
         Vl1hdPi01mstS72Uwqk7735mWL8VZp1Eg8odZGsdlq0FBf3Pp+xQxTL4cnPUFGgncdfo
         bZnBI0kNiZ85XUkntGkZWmQvq4KeBYJg3JYUjWBtMh6aYcgFLTcFxtO5eIRzQteeT/Ed
         Ha9ROWcZUfx4U6tlYdxTCfUA3Rn53qSDslg4X2iAU+Z/lP5p4nnv1UoBbBSJAiw1UAS6
         itoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683929861; x=1686521861;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SbmxyCetEfr1HDII239goejMQD3BlGa412Wy+9w0Vsw=;
        b=j7XdAFXefWjT9Ama0cn6uhZwJ09qUfOBFahUmAFV0OBQRRc3Z/R6BLds1U7joTza/x
         r6vdp42h6x/8KrMo/bGn2Za9l07TQSnJ4JXKp9FAwx2J+VAYpBZhiY63O1tEsL8upPhE
         A9NWobBne1CmPyFdJAEl9m2zgHaT3On8GJdrg20K6FPIaE8U2QuV4egQUFBLaftSK4lT
         nEC5TQHeRCutf1U2xKVMP8CQG8sd17ZjUfTousReAR0iYKK3IfRm7sCRI7++XGhTWlSK
         Qpa8e2ZyK7EN1FY33S83+s0y7cE8AFzYV6cxtcsWmIgKJKbU6UfeHzalskHai6s43WEf
         HJ4g==
X-Gm-Message-State: AC+VfDxXttfCdnh7LBCWaB+y+QMSARIhplR4xRDx5vgZLyhpJdQesbib
        0vJQV2bjF3adOCH6tuH41Jc=
X-Google-Smtp-Source: ACHHUZ7iVQN3wZE9boi4z9r7oRhYRlQdKlZD/TFNUZcR0hMPIVnCanIoHX7Fbw4uCi3OR6UxlCwpqQ==
X-Received: by 2002:a17:902:e80b:b0:1a9:57b4:9d5a with SMTP id u11-20020a170902e80b00b001a957b49d5amr36460978plg.31.1683929860979;
        Fri, 12 May 2023 15:17:40 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001ab0a30c895sm8403717plb.202.2023.05.12.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 15:17:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
        <xmqqv8gxpd8r.fsf@gitster.g>
        <645ea15eca6fa_21989f294f5@chronos.notmuch>
        <xmqq1qjlp98j.fsf@gitster.g> <877ctdi5wp.fsf@osv.gnss.ru>
Date:   Fri, 12 May 2023 15:17:40 -0700
In-Reply-To: <877ctdi5wp.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        13 May 2023 00:41:42 +0300")
Message-ID: <xmqq8rdtnqij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> Indeed "--silent" or "--squelch" is one of the things that I plan to
>> suggest when we were to go with "--no-patch is no longer -s" topic.
>
> While we are at this, may I vote against "--squelch", please?

Sure.  I actually do not think either "--silent" or "--squelch" is a
good name in the context of "git show"; as the output from the
command consists of the commit log message and the output from the
diff machinery, and "-s" is about squelching only the latter.

I have a name better than these two in mind, but as I said already,
we are getting closer to the pre-release feature freeze, and I'd
rather reserve my bandwidth to review rerolls of the topics that are
in 'seen' and have seen some reviews already to merge them down to
'next' if they are ready, rather than staying on this thread, as
"--no-patch is no longer -s" will not happen within this cycle.

Thanks.
