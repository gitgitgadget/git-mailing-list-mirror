Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB97ECAAD8
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiIRRyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 13:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIRRyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 13:54:41 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0E6331
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 10:54:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g12so18882473qts.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Kha5LDdcm5ejes+KTJxAGq2im9KCD1GuCk+38FMppwQ=;
        b=lXxpi5JGW5C/ok5XwhmYbg85YRGSsNKJXKpDoYr/W0TLx2POpaaUNT81GrscNzOpsO
         u5Y7lolodcLqY13HvJWCt092qumo/u9wKjNCC9L0t1AA9nwSyoIVJcE5WtLBcOHuDnhK
         K/YsMauJwmdRlrlyN1i1NHrdkHsi89iMjkVY8DnlOjiqHIJ4bMtKHi32ajRBXkScb1mc
         sqjpArxQld120hvjewqGGg/CPrLbvyT9rodoWvX22sWuKqLb56DfLvgNI2vo3c6rWhZM
         gG3zBV+2B42DJZ4mq1xwgbCiZ629JqHL9h9YWvpY/vgA4syu2DE0D7eK/j8icBtHMmYk
         8NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Kha5LDdcm5ejes+KTJxAGq2im9KCD1GuCk+38FMppwQ=;
        b=hStUrkjEHr4d0Rmuat6hhOavIU7HFQeUB0rfM0jkcYvkPgPkQ7KCuxMjRFmsud4KeS
         6QTEbDRBe5V+7Pj6eFUhqPGHhQ2e4kBjc3a5LhJdDHL2rVrhUD37R0EDXgBBXK/Q3Mrg
         NGeSz838kBZH8H0dInCazOJIzerDMSy6b9g0/HAT+hAAc2wpg8vuTpjpxH8XGE5xg5Yi
         20Rj9DABbVSfhLSKBBhSsVZ4RGl4CcX2aXsEGy+04iswDQnL9WW9gUVABFWqWl+u/qWf
         j/+ouYQMIU/+Pt4jcanPMOUkHDTxwjBh1uJv6Ktx4jVpcLC73N8r9LAz3Lb1d5moOyfH
         ITQw==
X-Gm-Message-State: ACrzQf397RfIKamxxX6HENyzojF6kjJU3RHlYUqMMv/iTAckR7T6QGK3
        WqWCkHQkrQ+gU97dGWn74unZ9OntkOI=
X-Google-Smtp-Source: AMsMyM4SzL/OUmxKK3Mn+AFe/bH23rZVK9xalHJaI0TZh1vnqqz/XrqfBx9GK/cACcBpV8tksSwVvw==
X-Received: by 2002:a05:622a:4c:b0:343:5d26:562f with SMTP id y12-20020a05622a004c00b003435d26562fmr12229122qtw.613.1663523679314;
        Sun, 18 Sep 2022 10:54:39 -0700 (PDT)
Received: from gmail.com ([2607:fb90:a90f:5bc8:aa3f:6663:a6f:ae7e])
        by smtp.gmail.com with ESMTPSA id y16-20020a05620a25d000b006bc0980db76sm9827713qko.126.2022.09.18.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 10:54:38 -0700 (PDT)
Date:   Sun, 18 Sep 2022 12:54:17 -0500
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets self
 via commit-ish
Message-ID: <YydbSeX7g/ldeq8U@gmail.com>
References: <YyZWDkZWAkS7q+Wf@gmail.com>
 <20220918121053.880225-1-aclopte@gmail.com>
 <CA+JQ7M8JX64M2m=+-NTnbRo64jy7_G=TYafj6UXv=R7UJo0vdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+JQ7M8JX64M2m=+-NTnbRo64jy7_G=TYafj6UXv=R7UJo0vdQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 18, 2022 at 05:05:29PM +0200, Erik Cervin Edin wrote:
> Thank you for the explanation!
> 
> On Sun, Sep 18, 2022 at 2:11 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
> >
> > Commit 68d5d03bc4 (rebase: teach --autosquash to match on sha1 in
> > addition to message, 2010-11-04) made --autosquash apply a commit
> > with subject "fixup! 012345" to the first commit in the todo list
> > whose OID starts with 012345. So far so good.
> 
> I wasn't aware such fixups were recognized.

Neither was I. I've repeatedly had issues where the message created by
"commit --fixup" was ambiguous (user error I know) but I can change my tool
to use OIDs for the cases when I squash them right away..

> The only way to create
> such fixups is manually, correct?

I think so
