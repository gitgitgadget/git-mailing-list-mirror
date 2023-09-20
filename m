Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AFBCE79A9
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 00:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjITA3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 20:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITA3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 20:29:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22CEAB
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 17:28:59 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79275d86bc3so239357239f.0
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695169738; x=1695774538; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htIr+CjmI/KqnxxK2xpHzmLlsDA7+64u6Ii9z/5B2VY=;
        b=bu3AGA8QTv+gNa1NyTdP5pVa7oYjVn2cRzivNTTIpqRTVU3DqNgvayU93HhAqJ2vQq
         mSBGYRrAzvzNIIy81t6uoFgiTk5NETCgLQPaN9bfvliT8uZCAaogJQ4xH1wiJHU0mv5/
         d+ZF6arOas/D4qIe+mM1s9hNDD+uw+490rwWK9O3xdpNPwzIRnEAyLxcQpdT5QN9pkzz
         k9JEK80Vf7KUqqJPCVdGbVxLwTkUEdxpbFDu6LBD+NfckzrTehF3QYSxemwaCMVaqWX1
         S7itBON+AsTN2L2+ZS9fNFR0FUHO+4+K2fybbxKryrMu3NYIS205lXysS90nopd/SOwR
         JI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695169738; x=1695774538;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htIr+CjmI/KqnxxK2xpHzmLlsDA7+64u6Ii9z/5B2VY=;
        b=Y2Elq7ngjRhXwijPAIhfNOX8eQv2CQBTcsBUtRIsI7kFT5APstGx/NhLayrkHN7hku
         ID8L64rOafiKKjyj5Uqdzu2wqJWZoCCKV7zg7v1n4veKy1mjAant2yM7FuIxGg2EXPNR
         fwTzANLxx5PVvB7SFbeWgdAqc/esyJJ/WxisI4q4l6vbc/ft6uyVqYMge0YbRlGReDHa
         t9M0fHMp0vQm8w79K6Io7ZSiD59xGMVKa6oAgWFKzj3CckRrXbj9m/7Z95Ofu//KKxHP
         BLwR7Mr+N/5Dpo+oUU5zpzui99LlA07qYAEKrDJ8nWFanLt9+zB5VA36JpDDorm//wmY
         yzEQ==
X-Gm-Message-State: AOJu0YyZs4hjXiqiYZWIukiHnOikixSEP6SJv2Tfpsg8Be3LnigaSLVK
        ryx4ITdrwgyBW+qfNYyjvzQ6kds5R7k=
X-Google-Smtp-Source: AGHT+IH4N5QS5pFs7lvtDvHnHnz1R4A9pFuCtqNBybmwrpgeqUJXYYbU3BldJmVMbBbuOublEwP+tg==
X-Received: by 2002:a05:6e02:4c9:b0:349:8a8b:70ca with SMTP id f9-20020a056e0204c900b003498a8b70camr1236203ils.14.1695169738512;
        Tue, 19 Sep 2023 17:28:58 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id p6-20020a92c106000000b0034ff48f2db3sm1391978ile.48.2023.09.19.17.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:28:58 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] bulk-checkin: Only accept blobs
In-Reply-To: <87a5thrak6.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 19 Sep 2023 18:46:17 -0500")
References: <87a5thrak6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 19 Sep 2023 19:28:56 -0500
Message-ID: <87pm2d8z7b.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> Subject: Re: [PATCH] bulk-checkin: Only accept blobs
>
> s/Only/only/;
>
>> As the code is written today bulk_checkin only accepts blobs.  When
>> dealing with multiple hash algorithms it is necessary to distinguish
>> between blobs and object types that have embedded oids.  For object
>> that embed oids a completely new object needs to be generated to
>> compute the compatibility hash on.  For blobs however all that is
>> needed is to compute the compatibility hash on the same blob as the
>> storage hash.
>
> All of the above is understandable, but ...
>
>> As the code will need the compatiblity hash from a bulk checkin, remove
>> support for a bulk checkin of anything except blobs.
>
> ... I am not sure what the first half of this sentence is saying.

I mean the code will need to compute both the SHA-1 and the SHA-256
oid of the object being checked in.

What I left implied is that for blobs this is straight forward because
the object header and content are the same in both cases, and we just
need calls from the compatible hash algorithm to allow computing both
SHA-1 and SHA-256 simultaneously.

For commits, trees, and tags the entire objects must be walked before
the size of the compatible object is known.  The size of the compatible
object appears in the compatible object header.  Which means that for
commits, trees, and tags their compatible object must be computed
before their compatible hash can be computed.

Computing all of that in two passes is not what streaming interface
is about.

> Do you mean something like:
>
>     The function takes "enum object_type" and pretends that it could
>     stream trees and commits, if we wanted to interoperate with
>     multiple hash algorithms, there are a lot more information than
>     just the contents and object type needed.  A tree object needs
>     "compatibility hash" (i.e. the hash computed for the other hash
>     functions) for objects the tree contains, a commit object
>     likewise needs "compatibility hash" for its tree and its parent
>     commits.  IOW, the existing interface into the functions this
>     patch touches is way too narrow to be useful for object types
>     other than blobs.
>
> perhaps?  I agree with the conclusion that the functions on the
> callchain involved in the bulk-checkin feature can safely be
> limited to handle blobs in the current code (and I have my reasons
> to think why it is not regressing the interface), but it makes me
> feel uneasy that I am not quite sure what your reasoning is.

The interface is wide enough, as we can safely assume that all
objects a commit, tag, or tree would refer to already have both
their SHA-1 and SHA-256 oid computed.

The problem is that it would take a 2 passes over a tree, commit, or tag
object to compute both it's SHA-1 oid and it's SHA-256 oid.

>>
>> Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>
>> Apologies to anyone who has seen this before.  The last time I sent
>> this patch out it seems to have disappeared into a black hole so
>> I am trying again.
>
> I do not know if vger is dropping your messages, but I haven't seen
> this on https://lore.kernel.org/git/ archive, so I'll quote from the
> message I am responding to everything without omitting anything, to
> let others who may find out about this patch via my response.

I don't see the messages at vger either.  So I am going to try this
conversation from my gmail address and see how well that works.

Eric
