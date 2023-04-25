Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D274C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 16:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjDYQG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjDYQG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 12:06:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BA9146F1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:06:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso7800667b3a.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682438809; x=1685030809;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnxT4hU9x5MS6KPMoUqo5hWIVqc1VYjQ9LSO8AZk3C0=;
        b=V9tebOXEzcOIG2oO0Lvut0uauAwmeQiP/hahTLuQITbQDvL7nzo0mX0XNB/9BVlPyJ
         zW23cOz5NKZV0VmukWEDI6ZwsSw9TrupFFNq4Nm9LDdrRXNeQxM6gzKDNneLwOw+bwJi
         abMzlx+CDJ/Pk1qape+wzKvfA3tr//zOGK6Q4vv5vrYGd4YR5QiCRSyHscMlwB9tTg4X
         Trs3/9SDeR4ODbddJV/P76rvCwHSw/UXZ/3g1/nn7f25bTqhLCziLL5kjI+8qJr5Mxsp
         opmfgFs8oX8rubGrLxLcE78UpIe/NSOJdboZshHHcxvmQzmY5cbp2HyfzXCpaL8VNMKs
         p/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682438809; x=1685030809;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gnxT4hU9x5MS6KPMoUqo5hWIVqc1VYjQ9LSO8AZk3C0=;
        b=GBX1YdS9cR7n1/qeS6cWtrn3t66gb0lE1b2hoq5j8gQjpMsAvX5vH4+BXkhP4iaskE
         chGAsq8TYB7hzvbR+uV4E6QHK+0zuAyxa9kzWM644VM6Mhx7tmBECGL6Xscm3nqiBe0N
         CRPWhGXHPJc2okM3EZxTtFnhz8cw6HbBJG/WwKGe3HxgV+Al298bH4BpRbZxw+bJC9m/
         UqvnDlxyaaUwXO0fXpgUX0Co2UfZfhiSpQbjMUqEgrdeWfd7C98/RglqjiptQ+yevZYf
         IjJzil4qBAAl/4sFFMYfQboS3I07wZymO3EiQQevLfEdjkY/8blTGRZ3ULbawFe9gKVv
         WrwQ==
X-Gm-Message-State: AAQBX9fBbz5AUkc8QyQyJb2EwvBvKdPECnRJO4PnWgLyyLclyeGAG196
        ml/PtffqNycmEzB/DE0waxA=
X-Google-Smtp-Source: AKy350Y+z/TCtcqxQBhDPNrAF4pwXu6rWSRGxy1htK+erlrRtBYbAkczd4c6j5md+ytUf+X+aSheog==
X-Received: by 2002:a05:6a20:748b:b0:ef:f5fc:cb44 with SMTP id p11-20020a056a20748b00b000eff5fccb44mr23336632pzd.35.1682438808584;
        Tue, 25 Apr 2023 09:06:48 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h8-20020a056a00170800b00571cdbd0771sm9515105pfc.102.2023.04.25.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:06:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/4] parse_commit(): handle broken whitespace-only
 timestamp
References: <20230425055244.GA4014505@coredump.intra.peff.net>
        <20230425055458.GC4015649@coredump.intra.peff.net>
        <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
Date:   Tue, 25 Apr 2023 09:06:47 -0700
In-Reply-To: <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com> (Phillip Wood's
        message of "Tue, 25 Apr 2023 11:11:08 +0100")
Message-ID: <xmqqttx43q08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This probably doesn't matter in practice but we define our own
> isspace() that does not treat '\v' and '\f' as whitespace. However
> parse_timestamp() (which is just strtoumax()) uses the standard
> library's isspace() which does treat those characters as whitespace
> and is locale dependent. This means we can potentially stop at a
> character that parse_timestamp() treats as whitespace and if there are
> no digits after it we'll still walk past the end of the line. Using
> Rene's suggestion of testing the character with isdigit() would fix
> that. It would also avoid parsing negative timestamps as positive
> numbers and reject any timestamps that begin with a locale dependent
> digit.

A very interesting observation.  I wonder if a curious person can
craft a malformed timestamp with "hash-object --literally" to do
more than DoS themselves?

We are not going to put anything other than [ 0-9+-] after the '>'
we scan for, and making sure '>' is followed by SP and then [0-9]
would be sufficient to ensure strtoumax() to stop before the '\n'
but does not ensure that the "signal a bad timestamp with 0"
happens.  Perhaps that would be sufficient.  I dunno.

> I'm not familiar with this code, but would it be worth changing
> parse_timestamp() to stop parsing if it sees a newline?

Meaning replace or write our own strtoumax() equivalent?

