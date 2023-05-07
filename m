Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905BC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 21:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGVfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEGVfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 17:35:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91012D42
        for <git@vger.kernel.org>; Sun,  7 May 2023 14:35:07 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6a5ecdb455bso1409536a34.0
        for <git@vger.kernel.org>; Sun, 07 May 2023 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683495307; x=1686087307;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObFW0jiuqSZPtFIC3FoQbfdQVuOe5vEBHbYU/0Gmlyg=;
        b=qRFpoJukZWBrYeNRfflTbLhelNwWVzTT78NZl5MqIW6V2HpkyNP+6WuFEpTC9gKg7y
         5NuFCdKzAlGJv0q43oroljrchycIdXktoOfCt4TDnA0EI6Z6/XV8eoUDfNlXuvYZqISW
         AM9HuvJ6FZtf6LveHtBjhZiQNpVk3Qp5ecEshe2M7OTktwBPB5uv0XYC/u1AqHtVZ5VC
         6DsvAkXYrg877HC6pzOZ3fwUryBp8oMHwy9JJCsWcEXY1ywknd/XgQgpZBgz2HJSqJPM
         DuhFGkf++Z0ZVjsSU7u7TSI87yqmH1oUO+YPvvvmNTnILaE8aLHwJORe61/4mFU5tZr+
         skmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683495307; x=1686087307;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ObFW0jiuqSZPtFIC3FoQbfdQVuOe5vEBHbYU/0Gmlyg=;
        b=NHgrgS5MKPdnmPUbD0vCrSs9Rzik6SzRbJnNR58G7jJj2F82k9YBpI8z7FX2qKSSUO
         VBLuNMbJrqnsiZ/GcOhBIXcX119wR3mTvHRYTesu2vmLvBS5a/rdwXRdk7zAg4Myj/+P
         MSQY9stMpZ8RZ2u0Tk2UxM0xYL03A/k2JETkVucTZzh9kAtBsvQQTPTTwASp8BQ8dKzR
         zh8b1E0tk9tGb9zsRLwkAQgGCW6Ui8efjJWXbo8YQ3w0kFCHXzocdNS3jOK9Yy/S/YCy
         lGML2mKDn+X5BtOQiyjddIKa/JXssb9OE2Z4Owfn31uUo+bm9Ru7waiXpSkcuyDgpUBu
         SGew==
X-Gm-Message-State: AC+VfDx3IPAkQlLLPGpX0s+DcGTCFCsDRX/A2Nf1KQ70TZ2tvRfygt22
        B+OFkX2/GEWOrXoZ7AM1M5w=
X-Google-Smtp-Source: ACHHUZ40DoZLP6fLi3H2kbd0GrrlmhjJHH3tVIsyi/harWvtWKRA8jqew/60DR4wnyq9kinnjGTC7A==
X-Received: by 2002:aca:2316:0:b0:38b:ed87:41ad with SMTP id e22-20020aca2316000000b0038bed8741admr3289289oie.22.1683495307098;
        Sun, 07 May 2023 14:35:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g25-20020a4ad319000000b00549f2828585sm3421768oos.33.2023.05.07.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 14:35:06 -0700 (PDT)
Date:   Sun, 07 May 2023 15:35:05 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Message-ID: <64581989b26de_4e6129456@chronos.notmuch>
In-Reply-To: <fce603aa-ceb7-d601-6a19-657e36d9059c@iee.email>
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
 <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
 <fce603aa-ceb7-d601-6a19-657e36d9059c@iee.email>
Subject: New canonical gitk url
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Philip Oakley wrote:
> On 27/03/2023 10:17, Johannes Schindelin wrote:
> > Hi Pau & Junio,
> >
> > this patch series saw a positive review from Junio (thank you! I know that
> > you try to stay away from Tcl code, so I appreciate the effort very much),
> > but apart from that it simply languished on the mailing list for more than
> > two months now.
> >
> > Paul, is there anything I can do to help you integrate this into `gitk`?
> > Or is it time to pass over `gitk` maintenance to the Git project?
> 
> I just tripped over this problem while trying to de-stack my Git backlog
> https://github.com/git-for-windows/git/issues/4408 "sdk gitk interaction".
> 
> > On Tue, 24 Jan 2023, Johannes Schindelin via GitGitGadget wrote:
> >
> >> These patches have been cooking for such a long time in Git for Windows that
> >> you might think they turned into broth. Yummy broth, to be sure. But broth.
> >> 'Tis beyond time for the patches to make it upstream.
> 
> If there was a way to un-stick this [1] it would be great.

One of the main selling points of git is that it was a *distributed* version
control system, which means there wasn't any centralized repository.

We are not forced to use Paul Mackerras' repository, so I created a fork that
includes the outstanding patches [1]. Junio can simply pull from there from now
on.

I don't want to maintain this, but as I've often found out is the case in open
source: if I don't do it, nobody else will.

If anyone else wants to step up and maintain gitk, that would be great.

Cheers.

[1] https://github.com/felipec/gitk

-- 
Felipe Contreras
