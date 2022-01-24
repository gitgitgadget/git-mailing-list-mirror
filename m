Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69EC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 02:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445820AbiAYCBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387597AbiAYAFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 19:05:01 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A031C061757
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 13:51:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z19so16112845lfq.13
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 13:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herrmann.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzP70nh/oFvUAAqkiC0Yhg1VahZmVtFsXolAHDCXy90=;
        b=QHcC4hu9RkhZC0vznNU1ayJGyeaxwG2wEMynYrUgydji5Bv/zkGxRLDWlvxxF1Mhao
         shabooMjjCCKNth5zstll0k44XXpd/Bik/0TeUjG87OBu+LvkZ/XQE/LH7EI8+NH3q8F
         THdm8E96GHwrPiastqBvM0Yub9JSR4WWQzWWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzP70nh/oFvUAAqkiC0Yhg1VahZmVtFsXolAHDCXy90=;
        b=bUvreoodg+/5RwJv8BnphaPcaPVpulH9CwzYhHKiudd1MH8LMeOqFuQNWgaytiFpLZ
         PYQzlaQBT4+mcYp1NTyfzMg5NkEEVCEJCx2NMAxIRTlXCoibbEqdYgjpbH/TB3t3w9OT
         WhSotTN7iEfR76g4OOpmgKQ6pIDA89VYp67sRWupCFeaPfx8S//7J+WljGG887Xwaqs9
         AjeG3QHm1OxVUcgzWz32jx+FrZXUP8kVL7jlRZMr1fYe22mU5uSeQ8MYzK+eqrnGOg61
         sq4+LB8hPDojIw29eKDEXt7LrgudZsS5GZW3u7IBdGNrhz9R5t6UndGohj5OPkDpfLwR
         +ThA==
X-Gm-Message-State: AOAM531MUX5Op7rSOQoTycaPlz0q1xzEzg7CPT4v9KUhkqKvBJe+3MEB
        MEvaAXc8vwC7IzpZbT1QaTN1/S5Wf/4yeBu0Kh5prqMzwaKXSjmM
X-Google-Smtp-Source: ABdhPJyxickw351Ltq0JleMaQNpAXlZI+NwZYXfVPKiRKMv8lBf2MXB2tRV9NcXnnFArAMz+fAqE9nLo+MXoOBeW6zI=
X-Received: by 2002:a05:6512:b15:: with SMTP id w21mr14690446lfu.11.1643061065980;
 Mon, 24 Jan 2022 13:51:05 -0800 (PST)
MIME-Version: 1.0
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> <xmqqilufl5cv.fsf@gitster.g>
 <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
 <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net> <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
 <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
 <xmqqk0ep57ou.fsf@gitster.g> <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
 <xmqqfspc3k8k.fsf@gitster.g>
In-Reply-To: <xmqqfspc3k8k.fsf@gitster.g>
From:   Michael Herrmann <michael@herrmann.io>
Date:   Mon, 24 Jan 2022 18:50:49 -0300
Message-ID: <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
Subject: Re: A puzzle: reset --hard and hard links
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your explanations Junio. This is the first part where I differ:

> $ ln -f a b

My hard link is outside the repo. In your example, it makes sense that
Git has to sever the hard link to be able to give the files different
contents. In my case and example, this complication is not present.
And it does not address the main point:

My working tree is clean. `git reset --hard HEAD` (not HEAD^ like you
had) should not do anything.

Finally, your (kind!) explanation does not give a reason why calling
`git status` should change the behavior that Git unnecessarily severs
the hard link.

My suspicion is that Git keeps a cache of the stat(...) result of
files. An additional hard link increases the .st_nlink count of this
struct. `git reset` compares the cached stat(...) values to the actual
ones and sees that one has changed. `git status` does the same but is
smart enough to realize that the additional hard link does not change
anything. It writes this to the cache. `git reset` should also be
smart!
