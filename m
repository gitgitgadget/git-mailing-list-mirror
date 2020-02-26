Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D7AC4BA09
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 01:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A6620732
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 01:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWS71efZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgBZBHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:07:47 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:40169 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgBZBHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 20:07:46 -0500
Received: by mail-qt1-f172.google.com with SMTP id v25so1085162qto.7
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BBeRUTIHM1Ct4JnRt+sWBWEfq8H/jRhuH1yKiPd3AaA=;
        b=cWS71efZvJfS+wZuorQ+S1dBRckpbHm81TOH4jmR6RlQylFUqNsccsGn4Lh0KSFoND
         I0rTXjoDXd/ESYBPKqSkpTJGJvBeSAIyK7tHe+I4LlYIDPDV4f5kd7stDyuMLo6rz31y
         av4slmg74kHFOdOJC17Uc5amVFTeiDhwYWGIQHUV325w2bw1FKsj/1kRHen3UfYM0JTF
         quK8wCHMhdN0wxvrw+5KFGX8+z/+snXZ4QddJ058Vs3X7pbLCXmlzNvBYo434WT6UKmU
         RoVwcRVyBTzglDqr62JLDv6Pup2ZyK5ZIrkg0030FXz+etlu4HDXvLrogfSpPrn7ok4s
         P0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BBeRUTIHM1Ct4JnRt+sWBWEfq8H/jRhuH1yKiPd3AaA=;
        b=r/dBquim09OZc+63YGUoeo3TZvZpv/j1+4nZce1BxhmSwuWEglXA80nWjAoyYZ4AfM
         bSZL2MmyHFgERx8twIA4Pkr8wTU7+lt4MUo6UHqZ777z+uxvad5YiVss+wDi4TRljzpY
         lJRdPVjjlt1Fv6P3TceDVGPjfM5cez7jk29IghAG/jKtaZpA91UrVV6K9+dXChLh9ub6
         hgrvSLieyCceiRBswpJiUlCrKLZMqs/1wKHDUmx9QrhdVjn+b2AB8AAqygBHZlHKSLqh
         a+gGvTV2SG1oB8VmuSk+nP0VFqcSF4/mYDgA+q5kbaV2c/UKBJsY1EypF8UmiF1ksu6b
         wjzQ==
X-Gm-Message-State: APjAAAVL6Pqs6kyfESkSjTErXO6iVHkMX/Y8BCeS0sZMTGoW1yG3NUgG
        yItAqyG9YXgcdupYLnxhMEGssnXbc69FBlPGX4B97UgB
X-Google-Smtp-Source: APXvYqwyeBplT2byk2Gh0MFwAq8JtgQ1OjzEAOlFnUlhVYLo9/SgyOP1xM39IsIbumMciYQTG8vWoEyOGzXthINxsaU=
X-Received: by 2002:ac8:42d7:: with SMTP id g23mr1899907qtm.206.1582679265671;
 Tue, 25 Feb 2020 17:07:45 -0800 (PST)
MIME-Version: 1.0
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Tue, 25 Feb 2020 17:07:35 -0800
Message-ID: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
Subject: create reflog for reflog-less ref
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wanted to ask on this list if there are any supported ways to create
a reflog for an existing ref that doesn't already have a reflog.

This is more likely to come up for refs not in the standard set (i.e.
HEAD, branches and remote-tracking branches), since reflogs aren't
created by default for those refs.

The only workaround I could think of is using git-update-ref to delete
the ref, and then immediately recreate it using the `--create-reflog`
option (if that option is needed), e.g.:

$ git update-ref -d refs/foo/bar
$ git update-ref -m "my message" --create-reflog refs/foo/bar <SHA>

This seems hacky though because it forces you to pass through a state
where the ref no longer exists. It also requires you to get the ref's
SHA first.

This Stack Overflow reply from 2016 suggests the idea of using `git
update-ref -m MSG REF REF` to add lines to an existing reflog:
https://stackoverflow.com/questions/36770141/can-i-add-a-line-to-the-reflog/36778898#36778898
But it doesn't seem to work to create a reflog (and only seemed to
work for me in limited circumstances otherwise, like adding to HEAD's
reflog). (I tried with version 2.25.0.)

Any thoughts?

Thanks,
--Chris
