Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB53C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 07:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBHHU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBHHUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 02:20:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492E2658D
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 23:20:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so17544315pjg.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 23:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bhdy9snYdJyZlQ+fuS/VXmx4Osl+/wEFPQFhTWCi8B4=;
        b=pPD+upc6CorvJgKGnNspddogFR/wKHfeM+jOYtXN6U7J0kK6TYZueoY6wWa1ACtANS
         dkG3giwGEhvL9gXMuyNiUMEoPmDkrMR1kILxrP0OgXbpQKzJ06dCHTXWWf+H09MKAe1d
         IE5guDUuvgpjE9Jo3Fk2q15SPed9Dle7aJ1qNN6eBemD57k+Vqw/1+mlsk9EQpnW/kA1
         tjkt0/3UcV7bfcygg47s28DmWmD9Vj+zDFr5D4p+LOWF8sfR7W7ELPNyS3dTwvhBnsrz
         mUz9TqlwbVG54GVC7ZYZay82WhhLfOEZ4X/WtB7LVel4PXSxeatExC3CVrqjqYNDwk9a
         sK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhdy9snYdJyZlQ+fuS/VXmx4Osl+/wEFPQFhTWCi8B4=;
        b=GHO18C5OE2aUqH1HBn7/nfZpksBpf8oXgSVh1XFlfpybxiuB9YWf+Lt2s51ER+drCz
         Yug2gwaxZfwYChkzko29V5dbOE+G6SFk3QjEOC4zBedlezmBDfzvzTUTJ/yutmLMdUre
         oEs6Lv4E3xAkgxViY2tHBTKtjqRgIC+bhA0bGqmN6r1dyLzvMBQiA/+aX+xT7Immy/sY
         7y2fn6a+52v+KAx/wwmyd6DVyKOUjd6UDzJXv3xQ8FEBbZRAKeznCbwRhPGi8CDXJ9ek
         EE2knXrITbv0J5KUTpauE/bb4jCxi11VPvEfBMXLj7rpodqZ5TS6TgN3lnjFSo4ZDxvI
         xTNA==
X-Gm-Message-State: AO0yUKVNvpWPnPf1LGyN+OTd/28QIG732VfTtiNkP6YCZ+K2IOJ+HG6m
        E6PVg39fJeACC7y+Q25eA2Y=
X-Google-Smtp-Source: AK7set8nwIIHz94TqjFC3mgDe4e6NMyFSusiytWAWtDkxjULArnPGONSY/KP90bEREY+Yr57MnLqTQ==
X-Received: by 2002:a17:903:120c:b0:193:e89:f5ff with SMTP id l12-20020a170903120c00b001930e89f5ffmr1501384plh.28.1675840823584;
        Tue, 07 Feb 2023 23:20:23 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b00194caf3e975sm10110849ply.208.2023.02.07.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 23:20:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     William Blevins <wblevins001@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
Date:   Tue, 07 Feb 2023 23:20:22 -0800
Message-ID: <xmqqedr0vd1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Blevins <wblevins001@gmail.com> writes:

> What is totally unexpected.... is the most simple search for ABC-1...
> ```
> $ git ls-remote --heads git@github.com:owner/repo.git ABC-1
> <ref>    refs/head/ABC-1
> <ref>    refs/head/feature/ABC-1
> ```

Sorry, but I cannot see what is surprising about the above.  If you
have these branches locally, you should also see these refs in the
output of "git show-ref ABC-1".  Refname hierarchies work just like
pathnames with directories, and without glob in the pattern, tail
matching that honors path component boundary is very much the norm
in the oldest part of Git, i.e. ABC-1 matches refs/heads/ABC-1 but
not refs/heads/XABC-1.
