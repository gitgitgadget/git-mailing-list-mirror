Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB9C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbiAJS6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbiAJS6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:58:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED353C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:58:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f12-20020a056902038c00b006116df1190aso466436ybs.20
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iuyGWAKW4Fa4VnJvyVxiYW0sKBO8f5AP1I2uJxLnNjA=;
        b=cTkwmrpDtdPJOUwVM0wKI3gQegsLONdzKT3sLZ7emyPUKEys9OBl70kOXgbtIa65Zg
         jVxyq1kZqyhDnxPBqTs93hBCStsOrCGHhBzlbNKS8bxNRqqmcgmHj8PhxWyEGucqH4bc
         F0xmC3gWsllCtHeGRoKjhLQRh9Yt8bYrfNP+Gz4yyV2LJaSdVSTAtKSRK9hkqJjb7TSB
         PR3P9c/wjWBr4JdUeTnJGye1a29k+3R3OhfJi0sVbDQPa3RsU+jcqZiMYO3mUXaZ8yvk
         6hWdTt6cSvOJ//mLzy/qKogyFtW+GGWQhH+BhSVLMhmI58ei27yl/vfoyqgGT/0i84QG
         /IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iuyGWAKW4Fa4VnJvyVxiYW0sKBO8f5AP1I2uJxLnNjA=;
        b=AM4/rJMxTf5ZJnti1NY5vscDwMYcQ/SZO62M4VyC6gFzVIIsnCtJYlVomUcvHL+rmo
         SPXf5+WrU8H4qfv/zZENd/hIhFQTLTch/A9oLzWK9eEJbDN7ePGW6xxo7yJ4aKn43rlt
         FB6EeMAdUziZHJHEh9ZcaEebH1WDUTcLhPqA09XSnmxfu0DZT9+UONu9y+QXzUSXdWSo
         9lTVaRcl5Ki0/7Ozx4Ny9xbmmDEw582I+KcK83cDo3OxzSUJfzhaEwlLI+VudUUvp0EK
         d2zygzmE98aDNCwXpK4DXFtaEjhbYKsN1fk/BPoDrd0k8LDxUB9uTAeMcRByLvtr1iUE
         KwIA==
X-Gm-Message-State: AOAM531uYKmREUycyNnlCKm6qFtSy/7cVbzxlj9KnouHXzG4f5tnXb9B
        ZtCRFLq5PCIv7Isf/iSlUuPjf0Crbs2t9unh+3f0
X-Google-Smtp-Source: ABdhPJysfQrnWsnKYqhbxrC/9LKwAut3M3e5Q2cRurwsZdaPn35B5wA2/q9o2NQuUb21tSWLutDl6Lp61l17hIEezfnU
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2390:: with SMTP id
 j138mr1348396ybj.177.1641841114160; Mon, 10 Jan 2022 10:58:34 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:58:30 -0800
In-Reply-To: <CABPp-BF+_33zR-vwh-tMTG=vxuah5jyuJVXssa-vAH51qdsrDQ@mail.gmail.com>
Message-Id: <20220110185830.1115343-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BF+_33zR-vwh-tMTG=vxuah5jyuJVXssa-vAH51qdsrDQ@mail.gmail.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH v7 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, chooglen@google.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> > +test_expect_success 'includeIf.hasconfig:remote.*.url' '
> > +       git init hasremoteurlTest &&
> > +       test_when_finished "rm -rf hasremoteurlTest" &&
> > +
> > +       cat >include-this <<-\EOF &&
> > +       [user]
> > +               this = this-is-included
> > +       EOF
> > +       cat >dont-include-that <<-\EOF &&
> > +       [user]
> > +               that = that-is-not-included
> > +       EOF
> > +       cat >>hasremoteurlTest/.git/config <<-EOF &&
> > +       [includeIf "hasconfig:remote.*.url:foo"]
> > +               path = "$(pwd)/include-this"
> > +       [includeIf "hasconfig:remote.*.url:bar"]
> > +               path = "$(pwd)/dont-include-that"
> > +       [remote "foo"]
> > +               url = foo
> 
> Which "foo" is relevant here?  The remote name, or the url value?
> Could they be given different values so that the testcase is a bit
> easier to read and understand?

Thanks for taking a look. Sorry for the late reply - I just got back
from vacation.

This is a good point - I'll change one of them.

> > +test_expect_success 'includeIf.hasconfig:remote.*.url respects last-config-wins' '
> > +       git init hasremoteurlTest &&
> > +       test_when_finished "rm -rf hasremoteurlTest" &&
> > +
> > +       cat >include-two-three <<-\EOF &&
> > +       [user]
> > +               two = included-config
> > +               three = included-config
> > +       EOF
> > +       cat >>hasremoteurlTest/.git/config <<-EOF &&
> > +       [remote "foo"]
> > +               url = foo
> 
> ...similarly here.

Noted.

> The testcases are very helpful.  I found myself confused when reading
> just the documentation about how it would be used.  Perhaps an example
> or two should be added to the documentation?

Will do. I notice that there is a section with examples - I'll add it
there.
