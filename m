Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE9C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351EC6120A
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhFSIBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 04:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFSIBU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 04:01:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD9C061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:59:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g6so9567109pfq.1
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IKAwLhIfuaIYJDyvc10Od/7qd1zI7rqPnBhjPXbkE7M=;
        b=rVFjZn32yzr6YcbgVCqzvFf6HoGikHBMb5m5SO0bFXTZU+jDbrmKKSZWkOfMJCueMI
         37rNwjg3oPDBLJYeBUJeTaHKcuA8sv6K8WCw2YnXWWFpONYwRATLqR1xtgTAC4vl3ZQL
         hnwcqC1dVvrDvAD40dzeDjMQYHnIMwdWqr4Zx4tH57z8Klh+ZXg+lKaotocP3+e48pa6
         4dMN+201kw049RRPq7y/+jog2jXeybSlAAQdCn9HzDdug1Z/+oiWPL8STF+sBJsntRK+
         7C7kllgoJPCUstAsdxgZHBdlm/jXG9YIDhSHB9QX0XgocmdJm7OlBjR5eele+tpMetHZ
         BsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IKAwLhIfuaIYJDyvc10Od/7qd1zI7rqPnBhjPXbkE7M=;
        b=B6s1KlIJzPXF5RX0TB6fz6sP/wM2QLVCFFW3P9Ore+jpHjj942PQ+ntAerK5YfzcQr
         S7mtTP/henJI31uA9SoH9hM6Ju58Arjnw6DTd/8HeIsjHIcu4MT5RTVhcW8dAKVR8HnD
         7pf+no5GXcc+tMqg7Y8fNtVIa4UO1Qc9tTs3qEv0H6pjjgBCtaZUKbJ/spREXWsy/fWY
         w+HWE8Wg/FQsVdFcyw+eiNktRm9OFFJd+hih3tTQRAcevK6QUCRHhLXLZe9Sw2lptIzl
         EwF/RZtfs9JbIt/GlltLiidxkDOKXmXXLEiNHLPlOBjzBo3admE1CeAqT/FdrHH64p3C
         eR9A==
X-Gm-Message-State: AOAM530GoZRNhD36GZoTidY6AZu/m1/YJSKtHi9YOqFerZViZ/DcqwZb
        gCGJylPTzxYmPx8M4Zqp4IvXlB2Wtw6BWl97PNPktEKTtuI=
X-Google-Smtp-Source: ABdhPJzCGM6cwOgD8N0W/POpOkWVRM943veMFmWyIvkncwMDaQyY7H+I35bJ7kwvwkux4+JHNhjEG/+6c3Y14C+04yY=
X-Received: by 2002:aa7:9613:0:b029:2ec:9eea:cc4c with SMTP id
 q19-20020aa796130000b02902ec9eeacc4cmr8961238pfg.12.1624089548994; Sat, 19
 Jun 2021 00:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <YM0IpOFH4Sy9wWaE@google.com> <20210618215848.794617-1-jonathantanmy@google.com>
 <020d01d76491$dcfe7c60$96fb7520$@nexbridge.com>
In-Reply-To: <020d01d76491$dcfe7c60$96fb7520$@nexbridge.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 19 Jun 2021 03:58:57 -0400
Message-ID: <CAOjrSZtKxEbMEbNZ+KEDfoJSOBSyKPY+PQRaP9sb7xgXiEFJZg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 19, 2021 at 3:32 AM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On June 18, 2021 5:59 PM, Jonathan Tan wrote:
> This brings up a very awkward question: How are enterprise git servers go=
ing to deal with this? I do not see the standard Pull Request mechanism ava=
ilable in GitHub handing placing hooks in different places during a merge o=
peration. Or will this entire concept be omitted from PR?
>

Related question, if a project had a collection of suggested hooks,
and a contributor wanted
to update them in relation to a new feature or code change, would they
then have to create two
separate patches/PRs?  That feels like it would decentralize discussions/re=
view?

For example, if I maintained a project on GitHub and a contributor
wanted to add a clang-tidy
invocation as a suggested hook, as well as a config file for it.  What
would the suggested workflow be?

"Open 2 Pull Requests one that updates both branches and do reviews
independently"?

If it was a mailing list would I have to send two separate patches?

I'm not familiar with any workflows or tools that allow you to review
and accept changes to
two branches as part of the same series of changes.

I also think that the history wouldn't be very clear in this case,
since there won't be any obvious
connection between updates to the suggested-hooks and updates to the
rest of the history in
this case (other than timestamps I guess, but I think that's a
relatively weak form of association)

> It seems like changes to hooks have to be managed in a similar way to sta=
ndard managed files rather than as exceptions.
>
> -Randall
>


Thanks,
Matthew Rogers
