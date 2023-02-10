Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E3C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 20:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjBJUdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 15:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjBJUdF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 15:33:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56E33A0A3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 12:33:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so6644023pjd.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTPwK63PZyGBt+xGScPd+P0i9UHyC+uFwig4kukGl4c=;
        b=R7wyIvtAkcjqT2OoWEEpmVWiSrvl1yChAWJXyasgrFrKCVY3lWtvSv7YSj2x9QWYnz
         kqCHqUOfd7o1DDRKG8VrDlWv2/fykkzbQ6hte5OQqBPaoDFrLfGnnt0I5GsO5/+fkWPQ
         CNqNZBglA+fVKAcPhRA+OnF5hvUSh34qkNlXVqQnbSDVMTLJbjxUB2Rf2V7/SLk/tvCo
         u4GYpey71btZS/tSb02XMK+cnfHg/BEYRVrEZwMuZoaYu/THn+MPNFl1asgIQ5rGjKSW
         3HNH07UP58LxUR0uOXYmPw9Qn5O+R5INkM1aF6eS605o2fMMcYr5nE6FKyKy171C9pKk
         AU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTPwK63PZyGBt+xGScPd+P0i9UHyC+uFwig4kukGl4c=;
        b=rqRWNbXtY3rq2YNxoCuCHGUB+Em27wNwD2JxJ7sCzCl/KF/dS0erlRZ4ueB/dZP1dD
         LIvnfZlghtxokhjPxZg7zKDV0o/jVywB0kgWqpg/6poP7FLY2r0Gn9n8hSyjzXeZU+zX
         zINtV90aoLRj1lHFYMQb/9qZVFIDrGclgpLJRNLQribdU7bcxRp4hvkGWEaWYxGnctAu
         XdZT+mQx2farSPDKBAfJYfqPbYh6P2dCZTnY4bLaO0d1/ukRukzeYM/7TnBGi6U6/cIc
         PsNqRqZAkLp+iIDApPQ3aFBipGAvJVk+owUtAeq9Dw74FD7TkzRxksUzkP5qTbOpnHyT
         lV3Q==
X-Gm-Message-State: AO0yUKUsU/uszKg+eL3BqyxXMz5ydzA87nmfrTiLTUCspWI41yKw3qQM
        C0HP0Tz+Ufl9jYWK9D28hAZMYjgyWpA=
X-Google-Smtp-Source: AK7set+kL67eKBQaq331VrCQC80zGBtM5GQ16woDavX44BealWqRLj/YbYpoUJ9mIfjw+BigJcylVg==
X-Received: by 2002:a17:903:2407:b0:198:adc4:229d with SMTP id e7-20020a170903240700b00198adc4229dmr8683118plo.24.1676061181206;
        Fri, 10 Feb 2023 12:33:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z19-20020a170902ee1300b0019a7d58e595sm512039plb.143.2023.02.10.12.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 12:33:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
        <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
        <850c94d5-973a-335e-903f-e0ab7e52f37e@web.de>
Date:   Fri, 10 Feb 2023 12:33:00 -0800
In-Reply-To: <850c94d5-973a-335e-903f-e0ab7e52f37e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 10 Feb 2023 21:20:19 +0100")
Message-ID: <xmqqwn4pgt1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>>> -				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
>>> +				strbuf_grow(tree_path, entry.pathlen + 1);
>>>  				strbuf_add(tree_path, entry.path, entry.pathlen);
>>>  				strbuf_addch(tree_path, '/');
>>>  			}
>>
>> The size_t conversion is trivially correct.
>>
>> But what do you mean with "don't double the[...]"? Do you mean that this
>> manages to evade growing these to 24 etc?
>
> strbuf_setlen() truncates the string to the directory name.  strbuf_grow() then
> makes enough room to add that directory name again (that's what I mean with
> "double") plus the entry path.  We don't add the directory name a second time,
> so we don't need to make room for it.

Yeah, I think I made the same mistake number of years ago, thinking
that strbuf_grow() was to grow the buffer to the given size, but in
reality it is to grow the buffer by the given size, which felt a bit
unnatural, at least to me.  I do not feel it too strongly but we
might want to rename _grow() to _grow_by() and make _grow() call it
while giving deprecation warning X-<.

There are ~45 calls to strbuf_grow() in C files other than strbuf.c;
I suspect probably a half or more of them can and should be removed
to reduce the resulting code size without hurting anything.

