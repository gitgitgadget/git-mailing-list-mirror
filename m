Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D19C61DA4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 00:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBQARF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 19:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBQARE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 19:17:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00D34B531
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 16:17:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w3so9373498edc.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 16:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4uw1k2Cu52zsPaurRC0nzk9oRAFBSzMhflbY3fegMSU=;
        b=VQL76vPqw/qz6P4qlO2on31fy2tufH1My21ZljlkOPsS4dVJY/zp+qhCErmEfFJa/E
         sCpjNaP2ZStKpoOWlAUz3MoUo8KFNDsX10S7xc+6PVeuJDTTFFcwAeocfq2gMTlLHbJO
         GVFXVu3rAPQ5YzPO5nOB5rL+AksPsM8qIxG952FOOkpzyYxIEkoidsnfC+WjGGvteZsZ
         ZnMg9cepsKV4jQ/cKWjx51Atk4SyTMfurqAGKci+uTphAc5J97OK6Wc5B06arzB3ayq5
         nfWno1Pe6h8hNEeW9Ds3NsAzuuXTf3KYjDn0jDHttymjV3yCUyQydODpyE5EP4L65Cv+
         B7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uw1k2Cu52zsPaurRC0nzk9oRAFBSzMhflbY3fegMSU=;
        b=0QLaWBUaAJFTYkwICxVIsY7HW9dp7LebWoq1TNkitX0mKdO+2cmiAUMyIpjDnfwS9Z
         GB3e2UHiYwFwzH3s4FIE4SU0db0d60naEvWBGr3LpoI5vzVPouyUK5TViyzzucR6klE9
         ARfdo1YxJHsmCFb12cNZHWW3R8B9Z8sLwOOY+zaktKwZywM4m28agv6wXz4w5KTRdQPt
         sUGHiLCAPTMB62lbij9XWuCb5S5EXXw3bWGp+5SMfxFveXyFk1lABLZU6/yQ8X8I55tu
         gopvNicFF0U0S1HgvrQsK7sMoQs0nbjVKDhrMyCAoitOH4O+l3RNtC+VTVfPDHbPfqN9
         zafQ==
X-Gm-Message-State: AO0yUKXH960gVFZnFMHzUhz2/l1VaCIvFDYig83KDGInijP0tmcsCpLY
        eCBb4Bzr8nG8kwWfsbUL1ZDLxdQoxWeYUNRTLo0=
X-Google-Smtp-Source: AK7set8IKGj2O2AgIp1RZxSY6npJxDK5tw2nP3auFKwYNt2Dk/QJihjddx6Rec6G9xANwJsmf10uu1gWOzybbrO8tys=
X-Received: by 2002:a17:907:76e8:b0:8b2:8876:cdd4 with SMTP id
 kg8-20020a17090776e800b008b28876cdd4mr112498ejc.7.1676593022267; Thu, 16 Feb
 2023 16:17:02 -0800 (PST)
MIME-Version: 1.0
References: <9bb10b607e46f867a3f8f5c71abf13c990d1ecfe.1676572031.git.me@ttaylorr.com>
 <Y+560+/G4pelldXF@coredump.intra.peff.net> <Y+6L9R9HkkUc7PkX@nand.local> <Y+6Mcnng0u6sz+C6@nand.local>
In-Reply-To: <Y+6Mcnng0u6sz+C6@nand.local>
From:   Matheus Tavares Bernardino <matheus.tavb@gmail.com>
Date:   Thu, 16 Feb 2023 21:16:50 -0300
Message-ID: <CAGdrTFhHBU2BNYdYr7LbOS7i1LOHGjWLw_d5ZJAXxvTKyLiFCA@mail.gmail.com>
Subject: Re: [PATCH] dir-iterator: drop unused `DIR_ITERATOR_FOLLOW_SYMLINKS`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Taylor and Jeff

On Thu, Feb 16, 2023 at 5:05 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Feb 16, 2023 at 03:03:01PM -0500, Taylor Blau wrote:
> > I have no idea either. From a cursory scan, I think I'd err on the side
> > of it being vestigial. But Matheus (cc'd) should be able to tell us for
> > sure.

Oh, it's been some time. But yes, dir5 is vestigial and should indeed
be removed. It was created back when I wanted to make dir-iterator
detect and avoid recursive symlinks (see this [1] earlier version of
the patch, where there was a test grepping for dir5 at the output).
But this idea ended up being discarded and I must have forgotten to
remove the dir5.

[1]: https://lore.kernel.org/git/20190502144829.4394-7-matheus.bernardino@usp.br/
