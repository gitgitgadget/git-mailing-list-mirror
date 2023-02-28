Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754AC6FA8E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 16:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjB1QJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjB1QJT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 11:09:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5131E35
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 08:09:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id da10so42242894edb.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677600552;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MbE7Phz7OmXTzOCzlvBpf2bLTOeplS7cVALOdSGdaN4=;
        b=EpVfYdtuKtZuSH3hmz01ZE/KocIGmp2mB5aXPXoapvCEo1o/xfjm+6V8fLf2dXY/FG
         S/4b+EP1fqveTN3371x9fKWjJX1X7spxlD7BQnH7JOlqe2SVlzHOQrEl3D/OTbw993zv
         9yDeA3Fe8DXm92qjqKGJGazYB9gaVUZt+HwuF8fc29mjYlAl8rkT1UQuD9/U5yBVsU2u
         LYASaP7l7I3fFIN2v3chWd9stSi77TVAZ/xB4mD6515omiTDUfhIs9xmHuDHdz9bue0H
         MgH85/jIRGTn7J7Jt/GRlrW1C6WCaAWMInebK9tPpggYE7CfQh89feQG8hwQKn+KzGqn
         TGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677600552;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbE7Phz7OmXTzOCzlvBpf2bLTOeplS7cVALOdSGdaN4=;
        b=BC+W555jND+Ebuqs/t/C4TmiIpjeWFluBw3QSz8NzSFSw9ZHv5Js3qmwbHoe8+yhLM
         X5wgKLFmwrYMkuJ8MVN94j3skUvakIN9Ouqv1+ybLoK8lzE0wYBCRRoeK/0YePoyzR9u
         TLuOqHzwMOP9E4FzCxjg/rkN8Ka5YdTWp9Ze7E8JZsMX2n4Ykwo3RelHp7xwBiGkooPo
         hjZW1qX73kSvv+IuH0jFbCOh1QA2BSKQT/ClE5yuri3tQiq4d3saAN2I/RunnyR9iZX8
         J5x0PvSiT4GcE+qA4olHqlAWmia8zY3OmbUrOv042paO9fKU2Lwwrp/Ph6rFalXXYW8s
         jftg==
X-Gm-Message-State: AO0yUKUxsoxbPweOYfCKpq0l4wNyp8w/CZJDBCB62QFvl8zT8+SVc6CN
        TWEgfQxUEM1xLHINhp65l3dhthwNKeZYexGvSpEmOM9ntZM=
X-Google-Smtp-Source: AK7set+4QG+FKtf6b6xVQhLnAdLgJJTnaXHpp7CB1NWyAC2m0fPHVUAjQ2SqNgXoz2uKiZptYp3128jOxtmvoFipdt4=
X-Received: by 2002:a17:906:3144:b0:8b2:94c1:9e8f with SMTP id
 e4-20020a170906314400b008b294c19e8fmr1537477eje.12.1677600552182; Tue, 28 Feb
 2023 08:09:12 -0800 (PST)
MIME-Version: 1.0
From:   Danny Smit <danny.smit.0@gmail.com>
Date:   Tue, 28 Feb 2023 17:09:01 +0100
Message-ID: <CACoz=-x6kVGMq1oCq8-5k2Hb82DCqi94_EmX6w4_9uGXnwBLaQ@mail.gmail.com>
Subject: gitattributesLarge: .gitattributes too large to parse
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I'm running into a problem with git fsck and the .gitattributes file.
With more recent git versions, it reports the following error on my
bare git repository:

$ git --version
git version 2.39.2

$ git -C bare_repo fsck
Checking object directories: 100% (256/256), done.
error in blob 70dc06c1e2e79d8cfa4fb67007edcbb8c941d7e0:
gitattributesLarge: .gitattributes too large to parse
error in blob 7f2a61db90e023cc2a3b180203b7298cd971250d:
gitattributesLarge: .gitattributes too large to parse
Checking objects: 100% (33216/33216), done.
Verifying commits in commit graph: 100% (2024/2024), done.

The files seems to be around 1.5MB in size:

$ git -C bare_repo cat-file -s 70dc06c1e2e79d8cfa4fb67007edcbb8c941d7e0
1579407
$ git -C bare_repo cat-file -s 7f2a61db90e023cc2a3b180203b7298cd971250d
1579652

With a cloned repository, the error is not shown:

$ git -C cloned_repo fsck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (33158/33158), done.

I couldn't find a lot of documentation about the size limitations of
the .gitattributes file, but I did find the change that seems to have
introduced it: https://github.com/git/git/commit/27ab4784d5c9e24345b9f5b443609cbe527c51f9
The change describes that the file needs to be smaller than 100MB, which it is.

Tested on archlinux (rolling release), but also with docker to quickly
verify different versions with a completely clean git configuration:
https://hub.docker.com/r/bitnami/git

The error seems to occur with git version 2.39.2 2.38.3, but not in 2.38.2.

Why is git showing this message if the file isn't too big?
Is there a way to get rid of the message, without updating/deleting
the file and having to rewrite the history in git?

Regards,
Danny
