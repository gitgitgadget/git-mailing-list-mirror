Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D39211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 19:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfANTI5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 14:08:57 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:48032 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 14:08:56 -0500
Received: by mail-yb1-f202.google.com with SMTP id k7so47833ybh.14
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 11:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CJr2oK+WayWEWt/TmAWO5bnbtA29m8G+GUCQNwzjYHg=;
        b=Nj2NlTfDbq1f1nlof1PIzHiYqvD8dP2xnzgs3mQNSUiYg3XSod9EXftHoq238/i47U
         2ROwU0emM6xFjNi+DhcaQoNbiOqflnO1PPbTG8Fu+UltCcMzEJzaJ24Bro6wUoByK4Y5
         6irpAv7PR36/0CXS8te5UrutlFPMzQYBJ32y7KgYMAKwj4vK+uiV8XCz3S0A+4ylZibM
         jbivXmDT9vNuqpyphYuzblUthKMsex6gSOkdVC5Xw3uPt1VMISgQEpG/OAwFJeaVpcco
         /a6kzb6KGJhEoMB6GcX+HLjb4VVioQqQc+T2KmndihFfPLqAjZCHxwywYAdJt+lEoxCa
         9xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CJr2oK+WayWEWt/TmAWO5bnbtA29m8G+GUCQNwzjYHg=;
        b=ArtA+BoJWiMZNA+3NEVWMPd+8beiVbQTgQT2WB2HUpbf5sBdw+tLBZcYFXOW6NtCpA
         qqou6zibiUPU6n/okuSuX362v69HSy6GMhaJM7W3FsKfTIUvvzbvQQQN+dBat8T+KJzn
         dx8G0dycX6wKgww0ig5cVVegYHcvi9yCy+CmQ2sFhcWgLK7C+G2ZiGFP5hwYJyzqUFbU
         7d3G5+f/2N34JKz/Hyi9is/jcslatFWIr9arrCX4ms9OP15tlAjLXLwQE3m6UHaWlR03
         oYok7G4CV1thkGdAQHo8B4RwLcr/UcpRWJaJL0wK7G4SFeEAt9UgLWt9glL685zxG0m3
         q+aQ==
X-Gm-Message-State: AJcUukfaQkKfjs7ndlmGh159MWD5wRkBbFhu/ANwGl0ZYw9BUzNn9M8/
        SNZZ2VmNrbUZ0n6H+16RV8ZOvf8dFjq5mOrLTdTz
X-Google-Smtp-Source: ALg8bN6ZK7zhnCOc4UDajVUcmM4l1G+wCp2ygJukKngG/j/ADYL60U8bHXUGVXyrm/qqVh39qXpsoiWJbeu6WMk3ViHf
X-Received: by 2002:a25:bb01:: with SMTP id z1mr6220155ybg.83.1547492935503;
 Mon, 14 Jan 2019 11:08:55 -0800 (PST)
Date:   Mon, 14 Jan 2019 11:08:51 -0800
In-Reply-To: <CAGZ79kZ8U6xWKQrmBW-G5HrZC0DN3AroxLCnkN2FPC70rQGYyg@mail.gmail.com>
Message-Id: <20190114190851.63976-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGZ79kZ8U6xWKQrmBW-G5HrZC0DN3AroxLCnkN2FPC70rQGYyg@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] fetch-pack: do not take shallow lock unnecessarily
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In other parts of the code we often have an early exit instead of
> setting a variable and reacting to that in the end, i.e. what
> do you think about:
> 
> static void receive_shallow_info(struct fetch_pack_args *args,
>     struct packet_reader *reader)
> {
>      process_section_header(reader, "shallow-info", 0);
> +    if (reader->status == PACKET_READ_FLUSH ||
> +        reader->status == PACKET_READ_DELIM)
> +            /* useful comment why empty sections appear */
> +            return;
>     while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
>     ...
> 
> instead? This would allow us to keep the rest of the function
> relatively simple as well as we'd have a dedicated space where
> we can explain why empty sections need to be treated specially.

Good idea. I'll do something like this in the next version, which will
be combined with another patch of mine into a series [1].

[1] https://public-inbox.org/git/xmqqwoncyvh5.fsf@gitster-ct.c.googlers.com/

> I like this patch..

Thanks.

> > +test_expect_success 'ensure that multiple fetches in same process from a shallow repo works' '
> > +       rm -rf server client trace &&
> > +
> > +       test_create_repo server &&
> > +       test_commit -C server one &&
> > +       test_commit -C server two &&
> > +       test_commit -C server three &&
> > +       git clone --shallow-exclude two "file://$(pwd)/server" client &&
> > +
> > +       git -C server tag -a -m "an annotated tag" twotag two &&
> > +
> > +       # Triggers tag following (thus, 2 fetches in one process)
> > +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
> > +               fetch --shallow-exclude one origin &&
> > +       # Ensure that protocol v2 is used
> > +       grep "fetch< version 2" trace
> > +'
> 
> Would we also need to ensure tags 'one' and 'three',
> but not 'two' are present?
> (What error condition do we see without this patch?)

Well, both "two" and "three" should be present, but not "one". The error
condition is that, previously, this would fail with "fatal: shallow file
has changed since we read it". I'll add a note about this in the commit
message.
