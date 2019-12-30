Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A12C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2FE206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTEIwNox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfL3SG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:06:56 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:40762 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfL3SGz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:06:55 -0500
Received: by mail-pg1-f179.google.com with SMTP id k25so18341590pgt.7
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 10:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nom+nP/w5Nd/V0vIlG4c9tcoNHbWQ+151H3bELLeHIc=;
        b=cTEIwNoxWNKdmFjW6vOB7YLpWe3wUjDTRI2h/1SjeOD5lmp8HCiB/JGX933V4fNEoX
         wzX8m+Ha7cHzRZHzEwFIXTuDUKJhqMcYpZ5AunLA1KeLkIUke4JImrhrxe8kfIkcRvfN
         g/0qTczJXnnpxngTVZtF4dVwer+K1jb0DwQo4vuiyCMHHmWE8BIKQJBgwH+nW0gzPHjU
         WXQa7cbH81fVBE0vMgQObfpJEo4ik+pTfy/bQjCrE0QZ6PScI7vDkLzMH2/6jVhNx5Ub
         cVjb+izlvLfdYOzbmMcQq5f0g/XncvJbjFjv6EgnD8K0q1tzatU0UHs9sE/cYRka4fz8
         +bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nom+nP/w5Nd/V0vIlG4c9tcoNHbWQ+151H3bELLeHIc=;
        b=aQZc58bXeflmRa3b51ajpZTVsOzHP4GOneiLWbO2UC1+W9b3ahXqNRqahG8GXx2UOJ
         QnMb2XHMu6XdK/1AfDbvq/fPF3gPSZRvDZpRkBppqC3rJPfdFdg+ZTCDKKj/tbiwo61l
         zykr/uC3rENoXa3e2U76rZVPXBFlRZk68PN7vS4287Hfxy1kzdz62sVMjDdmXkRjabLN
         ZucP01yYf716mxjE8MhkClqoyRUJCKfnE6FFzfYQ+9CNRcKElFxiUYTFcYd4oPJ5ABTR
         MIobMw3iaJmvLMZKQHHW772cpr5beNPBDj1b2mHiHI81ilflPxsas2vDnojObVJyboKu
         ysWw==
X-Gm-Message-State: APjAAAVxtjRlvzi66jcV/zz95PQQQ7kJHVW2C5/GrphI3bHkeLo7Cf3c
        xlUs+OdSgrbme5+zvVRzSwHOTYxP
X-Google-Smtp-Source: APXvYqw5MUDmd+0aw6eLIV6hdTeKsROu02UFUoNNsO5m0qCwTBZ3BPftEsJ7MQPQHFNK0SGBPEAeiQ==
X-Received: by 2002:a62:1b4d:: with SMTP id b74mr74609373pfb.59.1577729215224;
        Mon, 30 Dec 2019 10:06:55 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b21sm54397936pfp.0.2019.12.30.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:06:54 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:06:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: ERANGE strikes again on my Windows build; RFH
Message-ID: <20191230180653.GA57251@google.com>
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Sixt wrote:

> In sha1-file.c:read_object_file_extended() we have the following pattern:
>
> 	errno = 0;
> 	data = read_object(r, repl, type, size);
> 	if (data)
> 		return data;
>
> 	if (errno && errno != ENOENT)
> 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
>
> That is, it is expected that read_object() does not change the value of
> errno in the non-error case. I find it intriguing that we expect a quite
> large call graph that is behind read_object() to behave this way.

Yes, this seems dubious.

In fact this is only inspecting errno in the returned-NULL case.  If I
look only at the code above and not at the implementation of
read_object, then I would say that the bug is the 'errno &&' part: when
errno is meaningful for a function for a given return value, the usual
convention is

 (1) it *always* sets errno for errors, not conditionally
 (2) it never sets errno to 0

There are some exceptions (like strtoul) but they are few and
unfortunate, not something to be imitated.

Do you have more details about the case where read_object is expected
to produce errno == 0?  I'm wondering whether we forgot to set 'errno
= ENOENT' explicitly somewhere.

Thanks and hope that helps,
Jonathan
