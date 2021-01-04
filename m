Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928C6C433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 06:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624F721D7A
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 06:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbhADGXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 01:23:45 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:35519 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbhADGXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 01:23:45 -0500
Received: by mail-ej1-f53.google.com with SMTP id q22so35468579eja.2
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 22:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzzA/QTYHcDtkVatgYzBVdkrv0UoIu1wjN4AzQw/tm4=;
        b=PMuwmL9Be1U/Z5ukSjiWCp4rpIFEpsjlCnT72WiM03DNAH/w2bmmcyH4VZXYF52JwR
         2fvI2Dhh81AJCUHs1uVvgmrKhpzTczua+x3O4mbL3Kvc/GlWkR1qK5eUnlTWf5/C9zwB
         F0za317tAasZGXdpXghCK3/fLE8wnRJlr5WfCNxhjT7N7dKN8uD6ZKGaDKduIHoYburz
         6oIlWFcPe6g2h10Y4xbXp8fIBOCkekiKbZD4GiwC45/qj618HCDN1iVv6DJk1+uRP9LD
         9SyOK6UMyyxkT7WXq2JS8o3m2PZnJbQWN9PwAf61THIgIzuN3M56TE2yV5o2LdcNfIE5
         +69Q==
X-Gm-Message-State: AOAM532ILC/TI3HT8z9UPTih+bTKzE8ONvsCnIEZzb13ZVqHK/EUQS+8
        OhHqLdAp9R21KSzZo06NxdJB94FqnD8VQgodZdI=
X-Google-Smtp-Source: ABdhPJy+6k28Jwo95BgFqInc8bcBTc7rXjulXeJvZBf7Uts8lEyVqaby/OYXISixYTnO56y7zg1uP+QEKe1vvSvjPgI=
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr949068ejb.138.1609741383143;
 Sun, 03 Jan 2021 22:23:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <CAPig+cS-oDfCX-LaDEW2U+9Aa9VNZUPs54isODoHCv6HxAdZeQ@mail.gmail.com> <65af825c-00b1-5852-3a4a-81babfc5040f@gmail.com>
In-Reply-To: <65af825c-00b1-5852-3a4a-81babfc5040f@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Jan 2021 01:22:52 -0500
Message-ID: <CAPig+cTxCLbfsk4D-_Rd=XF=A4zje1_pETyD9CJRtJNyADb=tg@mail.gmail.com>
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 3, 2021 at 8:01 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 1/2/2021 1:12 AM, Eric Sunshine wrote:
> > This should allow you to get rid of the globals introduced by patch
> > [4/12] (assuming passing the index and repo arguments around
> > everywhere doesn't get overly hairy).
>
> Perhaps now that I've removed the compatibility macros, it would be
> easier to insert the method parameters since most of the lines that
> need to change would be method prototypes and the calls to those methods
> (plus the callback function details).
>
> Is that a valuable effort? I could give it a try, but I want to be sure
> that adjusting all of those helper methods in the builtin would indeed
> have valuable improvements over the static globals used here.

My impression was that the goal of the earlier work was to pass the
index and repository to each function specifically to avoid tying the
function to a particular index or repository. This helps in cases in
which client code needs to operate on a different index or repository
(for instance, a submodule). Generally speaking, making the index and
repository file-static rather than global does not help reach that
goal since functions are still tied to state which is not local to the
function itself.

Would the extra effort be valuable in this particular case? I'm not
familiar with this code, but given that `update-index` is a builtin,
such effort may not be too meaningful. If, however, any of the code
from `buildin/update-index.c` ever gets "libified" and moved into the
core library, then that would be a good time to update the functions
to take those values as arguments rather than relying on file-static
or globals. But that's not something that this series necessarily
needs to do; the task can wait until the code needs to be shared by
other modules, I would think.
