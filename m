Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7362C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953B420575
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXUjL+cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgD1SqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731072AbgD1SqL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 14:46:11 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BBC03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 11:46:11 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id t8so22526237uap.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlYNKgK10tMQ8ImoKQ9THLN+/yb50yXE7Eh200cmDdw=;
        b=CXUjL+cUzZVT3L0NodYV/WQro+3i5biJsGnkMIZk6IKP1wmOmtBdmqJym4u9h3N/R8
         kXMfuKof7K/PzEwt9Gd5hzLqZMaD7osPxMDbzhbzSldjaRkxvozS7FC316yQiEcA4Xpa
         BbDW3m1wqttnalqimXLHbmBMlXf57F81b4RPQxzT99mGNrxmbA51BfNyGxdzmUjM6fpR
         TFfRk8XUzV0FPTV9O7Rp98wer9WXhSpao3nuyd9biy+qp8WF+q63P3Ab081y3mEy8tUV
         JRoQWl/2tgAm/YRT15fcGMRJSfxAsR7fznBEm9o9gqqWxKaaIEz9CqnE3aoPb6LvLTvZ
         vYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlYNKgK10tMQ8ImoKQ9THLN+/yb50yXE7Eh200cmDdw=;
        b=j42NbEpfAn4rlhgl7av2pIUpWYitEPtq85bmfwdLtfU73w9w0SVpnbg1k9GUtM3bn6
         3VYa8y0LBxP2h30VwcmXV85N6gqWcHbuGsLvWZVaKxjg0TDlfEL8AKCsTXpprb+AvysN
         5anKIQEDn6tF8XztWkcjhjUdlZ5sYNIy9BWH6pY6j/yEnluQMEtCl/ehIF3hd7v5wTvZ
         9kOkXQBrRKlxqhr1pWc2cp5DQGIe/Qw/lR3cIq5B2d8YVE9MjiuS40PAInWX40N1X+NR
         +c4KnyDnVui16/890tE4vsyl72YfzjldPpFzks5g4yD51/8+LC6oEMum4YiIrUFdalnu
         VfRg==
X-Gm-Message-State: AGi0PubSrpUkredCROqjXgZznmQekho4F65IoPQYs93Be9lsioxi9ZCs
        j2oC76NN7hhbc4+xvYXF51Tgji7TcvE/l+hsMypp4gzO
X-Google-Smtp-Source: APiQypK2QE3Bm8231mdn2QZS84g+9n3svAaNY6h/K03cntTryKI+4eMatkFo3ppd/TZTnAsJcLF72H6D80AWhZBUQac=
X-Received: by 2002:a67:3293:: with SMTP id y141mr22755453vsy.54.1588099569734;
 Tue, 28 Apr 2020 11:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
 <20200425022045.1089291-6-jacob.e.keller@intel.com> <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
 <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
 <xmqqo8rb4lyj.fsf@gitster.c.googlers.com> <CA+P7+xoBnS8huHiU+QM8x6LRiSDRYVVS2pduv6i_qrwb1ZS7fg@mail.gmail.com>
 <xmqqsggn32i7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsggn32i7.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Apr 2020 11:45:58 -0700
Message-ID: <CA+P7+xoSdDjbSAKeCsPz97Rc=ykpuTb2pNKazsCNcau2SBquMA@mail.gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for
 git switch --orphan
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 11:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> >> And that same "is this really helping?" reasoning applies equally to
> >> the "--orphan" option.
> >>
> >> I dunno.
> >>
> >
> > Fair enough, new branches based on previous branches makes sense.
>
> I actually do not have a strong opinion either way.  I just wanted
> to say that it would be good to make it consistent across "checkout
> -b", "switch -c" and "checkout/switch --orphan".
>
> It would be nice if "checkout -B" and "switch -C" pair offered
> existing branches, as the intention of using the capital letter is
> clear---the user wants to overwrite an existing one.
>
> On the other hand, I am OK if "checkout -b", "switch -c" and
> "--orphan" offered either:
>
>  (1) nothing, as your patch does, or
>
>  (2) all branches, except for the currently checked out one.

Why reject the currently checked out one? If the premise is: "use a
current branch to build a new branch name", I don't see a reason to
restrict including the current branch here as well.

>
> It would be preferrable if they did the same thing.
>
> Thanks.
>

The problem I see, is that regardless, I would like to see the following:

git switch -c new-branch-name <SPACE><TAB>

complete all references for the starting point.

With this series, that's handled by just checking for "-c/-C" on the
command line and enabling all references. There's no positional checks
done, so every word can complete to a reference.

I don't know offhand how to add completion which depends on the
position of the word we're completing, so I'd have to investigate how
to make that happen.

Thanks,
Jake
