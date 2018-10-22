Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE361F453
	for <e@80x24.org>; Mon, 22 Oct 2018 03:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJVL4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:56:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38830 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeJVL4H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 07:56:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so3624215wrs.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 20:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HZvv1ETD1B23Q4ryDpGT6TRvfSzPLerv79sObTMVoRY=;
        b=kiA9/zqpRWi6rKy0uCS5d8hiHw5aDLQU3vZfK9Btrf8m6l1fl/L33OAxjhJp0JA9IK
         QCjSUiivR8uB7ci3VJCzwQB+OrCfpznKz9AZhB0WKKaDPQRXdo15M2wrh6LuMgjS4GSy
         6dWEuvvAktc2ArRTl/AEF0gRG6pkziwEhKJHrqPo9YUExiKXZcK6umkuJi8pVXZA7srL
         1En4PKeLqyabQB138JCuqzK8q+IjyXLIdUkZ8npwRwwhSx9aF0ctg3EZS0NICcTnzJh8
         Pgs1r/SLGjD9pdr5o0ExEEY0zKqmM14G2abxt1+3KAnAEbzUkK/Sj03CPHfYEyQYJr3g
         tIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HZvv1ETD1B23Q4ryDpGT6TRvfSzPLerv79sObTMVoRY=;
        b=DY6yST+6m5sHhoeX0xfDzTP7WLY7nyLFpKgSdBe23Qc51vEwYkD2ZtPHT9w4s8qb5Y
         voRF+PsLATZgNUV/tnCEbK1HbQ+KbBI9rXlJc69x/MzHjWFb3NUL20xUMIKfHIoeDPME
         n61BBrmfTmmlHfc6s73zpvzd0iQ+8ZOeD44Aew4lFVE/13C+gam53OPNtkY+3up9SxFL
         GvLQ9M8ydvpbyTKBMtavVaKbdPSIHQ6ed3y0W2xZyjwZ56DVJp6g0Muw3cGVdqzECcVm
         ZNVAvsBXTOVg5YTecthmaUwRd+Iqvvk+lzKv/LTCm/LUMCkrSPBCOZYol2Ip7UJ4v05C
         RlFw==
X-Gm-Message-State: AGRZ1gJYzN24F12bW/XJqnNRV6O44zrlurybCre9mE0gT7xtRuQfTNNU
        t/YYNUn+uYRg5AqqLNveX68/OlD7PUc=
X-Google-Smtp-Source: AJdET5dB/Q2YhuRs8dLWU263hxSlkc299Ql1fW/hGJxZCFcWKq3dujn8ojIbALv0cx1EYOZcgfuIKA==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8-v6mr3441603wrs.272.1540179564158;
        Sun, 21 Oct 2018 20:39:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j7-v6sm193408wrw.29.2018.10.21.20.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 20:39:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     carenas@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] read-cache: use of memory after it is freed
References: <20181020073334.48348-1-carenas@gmail.com>
        <CACsJy8B8q84=AqMvAkc5=oSPBbwMQkdQhRe=RYVKGYmnsGxVGA@mail.gmail.com>
Date:   Mon, 22 Oct 2018 12:39:22 +0900
In-Reply-To: <CACsJy8B8q84=AqMvAkc5=oSPBbwMQkdQhRe=RYVKGYmnsGxVGA@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 20 Oct 2018 17:15:01 +0200")
Message-ID: <xmqqva5uwsyd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>         freshen_shared_index(base_path, 0);
>>         merge_base_index(istate);
>>         post_read_index_from(istate);
>> -       free(base_path);
>>         trace_performance_leave("read cache %s", base_path);
>> +       free(base_path);
>
> Oops. Ack.

Thanks, both.

>> introduced with c46c406ae1e (trace.h: support nested performance tracing)
>> on Aug 18, 2018 but not affecting maint

Yup.  The series nd/unpack-trees-with-cache-tree however was
designed to be merge-able down to 'maint', so it is a good idea to
fix this at the tip of the topic.  So I'll queue it on top of
5f4436a7 ("Document update for nd/unpack-trees-with-cache-tree",
2018-08-25).
