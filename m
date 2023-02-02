Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B99C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjBBQxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjBBQxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:53:34 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F16F702
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:53:33 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u5so1628179pfm.10
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFJ/yL5oIJa6NIbVd3JgxtbEdthBSXGbn8tJ9GUt2kM=;
        b=TK0/vjS3h4zWYgW/x8XwJ7k8dSYfkxfPOlMGCgtkyrC4fIhLTKk7QyBJeGN789q69W
         EE/6j9Z+XBh3WyznQN6btC+BEmQCGj0tFoU0RWF1ttOjOUTY3Em3tXMDE0fyaTOertOx
         6YFPfDvBZtCWEtyI8dQExZ+CX3URwKy1e7Jhkx4HVHrZJlf57VoYsj+ox8wZHHAGAj32
         Nk4h0CXk87CO7RUngxSk45Ogk3lSTOk1pMNbyv9YEJg9DvdHRxaEV49E9sMV0otWfwLd
         /5n4LNO3i1geTMkcti/Mh6rodjksjzyk54Gc1FKLk6wfATXAVn1032KPtKvI3d4VGG0d
         I/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFJ/yL5oIJa6NIbVd3JgxtbEdthBSXGbn8tJ9GUt2kM=;
        b=0G8PLKy+qYIbgEgVAdoLtDWmOhrnPGLqKtSq/bPcPEi29oIOQaLkXkUF1erk6sIxVT
         d18XHLwK0G7br2uQYM9J7ipgJhmyk3eGhKopEp+AnwSt3Hwtn+hYoCEkA49KxZs/XQJW
         p4Xw46hrQa3Y/FhEnEfoR/tllJ6xAiQUREE+HAXrw/gTNx/bbosrZVPJcLpmvYo42oOK
         rM8dqBXtfLpuXSuoP5WjkM81LlFIWPzKnziqvd67WcteiJZawaAp7vTpjoxenTEa8a3P
         vyUClYGLil9IfhV1GWDt7WJK73Lkiewh/dE4sMxS4E+QOiV/f2l/94Y5oAfRDR74R3nD
         uS0g==
X-Gm-Message-State: AO0yUKU5GBmI9NiZgwTt+0DzxNO7GIpfPfl7OD25FjiHiAqYnuMF9xjj
        5LQNLCIVITB0fz47/7i4PKs=
X-Google-Smtp-Source: AK7set/HED8ebAKCa3RQYRLP/PAxu8JcJCUT1WSpVwrCu89TsD5ut4rgD1pAOOX0l+WqN2e65a4myQ==
X-Received: by 2002:a05:6a00:228d:b0:58d:ac19:8950 with SMTP id f13-20020a056a00228d00b0058dac198950mr2611412pfe.33.1675356812609;
        Thu, 02 Feb 2023 08:53:32 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id v66-20020a626145000000b005882b189a44sm13843765pfb.104.2023.02.02.08.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:53:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Dulfer <rafael@dulfer.be>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-list: clarify git-log default date format
References: <20230201155712.86577-1-rafael@dulfer.be>
        <xmqq5ycl1c6h.fsf@gitster.g>
        <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
        <xmqqy1phxabi.fsf@gitster.g>
        <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
        <xmqqfsbovy7u.fsf@gitster.g>
Date:   Thu, 02 Feb 2023 08:53:31 -0800
In-Reply-To: <xmqqfsbovy7u.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        02 Feb 2023 08:17:09 -0800")
Message-ID: <xmqqsffouhys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rafael Dulfer <rafael@dulfer.be> writes:
>
>> like. "`--date=default` is the default format. It is a custom format
>> based on rfc2822".
>
> But the thing is it is *not* custom based on rfc2822.  The default
> format came first, 2822 much later.  If I have to guess (and I
> shouldn't because I was around back when we invented that format,
> but I am lazy and my recollecion hazy), it came straight from the
> result of ctime() but with timezone info appended at the end.

It indeed was modeled after ctime() in f80cd783 (date.c: add
"show_date()" function., 2005-05-06).

    date.c: add "show_date()" function.
    
    Kind of like ctime(), but not as broken.
