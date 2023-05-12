Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6CDC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjELVsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjELVsq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:48:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899D82133
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:48:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52c690f7fa4so7083257a12.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683928125; x=1686520125;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUX+5KWbr9o3Z7txTQ7cGuEgdEOrWY5emENkE4vMvus=;
        b=KQ+fV9HJeU0e2qX8xq48q/0vNLMHSm2KWV4WjAnMGS8iHToAaNYh0a/DMJFMXh4ZNg
         mNvxS6BOB69xWP8yGG5tSs2/iNoHUvpEGYAfzg25SlyuB0LTWQRixheoE7rsWhh2XGg9
         oCN/btzx8IOEDUiDL9goJClG+3ZdXcsk2AaDgC3oNQTGEc459YnV6HdJvAaSYRz7Efq4
         eSN3mpBdwhOweNTRIJDeAVEh9+7lujCqEdHN7oVrfsNwP13tigd3nhyce/UOGJJRj7tN
         VworitpIsPjpyKJYfmfZ0TbpP4M0a+fPlSUfoEdRMS19qXsCX8Mm1UXM3IprZsvQJRUR
         gWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928125; x=1686520125;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PUX+5KWbr9o3Z7txTQ7cGuEgdEOrWY5emENkE4vMvus=;
        b=lG4zqCu9w1yOKP4RF5zxv8YMXk3zO5f04+1SWV67KZ6c1aFP1S/A320uGjrCagJszP
         /gmvnb3h4VXbeyJhbvnaa0hKTs8a/qrc8yKDDPfbIu1bOIE1JUJkzjbIq8+dO4HSeNWm
         /ZODZmzy6VvAoFPIJ0v2EDrWpz0p27rB2+fZhkzzhvRc7JWDKLJVZna41ZN7DdS48r6a
         PuKi70GomvzeXWDeSZOMi/ulpK8uC0wGx/aAlJqYlCK7eqviEodYybqzQZrdz8tyEfgE
         fC8oNIszIKhCefGRBTWYNhrFpwAY08p0FHgS/IDvmt535kVAPno8a02VpoDEhsIS9blO
         V+4w==
X-Gm-Message-State: AC+VfDxTTt3xB44EhkYVH8ByR9i/hog4WB28S8uKs9qn1U3sJ4LAQBYj
        UMXkxuSfvR0u0O0aibOyeCg=
X-Google-Smtp-Source: ACHHUZ60p5+wcDoIUKNR169zTmo72b5DievFOqnXIvIOGzJszoE0B3K2hWyZ5U89aFS6UQUZiaRf4w==
X-Received: by 2002:a17:902:d491:b0:1ab:26a8:5401 with SMTP id c17-20020a170902d49100b001ab26a85401mr38261400plg.31.1683928124939;
        Fri, 12 May 2023 14:48:44 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b0019cbe436b87sm8446537plh.81.2023.05.12.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:48:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
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
        <xmqq1qjlp98j.fsf@gitster.g>
        <645ea94569b79_21b4f8294e7@chronos.notmuch>
        <xmqqlehtnrw4.fsf@gitster.g>
Date:   Fri, 12 May 2023 14:48:44 -0700
In-Reply-To: <xmqqlehtnrw4.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        12 May 2023 14:47:55 -0700")
Message-ID: <xmqqh6shnrur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  Either way, I am not done with the
> thread, as I said.

Eh, yes I *am* done.  drop "not".
