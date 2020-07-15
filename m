Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C64CC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 02:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037EE2074B
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 02:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRPAmzjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgGOCSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGOCSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 22:18:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DAC061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 19:18:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w27so545641qtb.7
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 19:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=o4CaTWYde1aKxsFxEwTM1w5/5yJPfpGY6GApN/9hT6I=;
        b=WRPAmzjJREGncwKlbgiNtn+lxj1U6TSFoycRKFonc4Dyf5ESHdQe7AD7sFkTWFm+Yb
         c0fBgur0xxNnz2d+JtpPZMuYbeZLgXEIy7ObEqq2iibSIJgSEOS80Bqiurzi86+XGAe2
         EIZZSlJScYI1Y5uGfeO3fg/6Rb9dyOC6mJ8xm3ljQynQq2teAb8X7CBOU39zIrj5nnvK
         hD2eutyNZgIg974CxtpLKAveK+yNO+05HeaJB//ovVuboA/57qjbvuTi+NRBO2ndtApN
         DzYLStA0J9jQBis7xqXqWHMg39URk+vnET+kz4bb3sSu5ymc+aiJsyZoX0+5MjGs1IKO
         NSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=o4CaTWYde1aKxsFxEwTM1w5/5yJPfpGY6GApN/9hT6I=;
        b=W94bIRrvy9w3Y0BifPJ6gg0J88Oi3a4KdMZP4pb3pYJrqJVC2agDZWerBWFKPm2Gb9
         UrCYtltM7gThQN7ie0D5qM4MQtf7rZWudn4juAVoMAx2aIiwiLEXih7uGDlKZhqYWSyV
         sXmdDh4jkTmRxNM00qJHHRMpDkBHBAvHLGgNQHYg2ErIua9NHx0++D7xrHVp+GjGGuZx
         kYLifk7KQ5I73epbEMPqtCmZle12VPKuexFbyWhKcanbAoNS3aVaTHbKNwS/mhSyNfBp
         +lyabq29h+dyktsKdB0B7YiaTkaO1VZcQyukOoanaRe2SAVAsvJd4L73t96RfncZ39O/
         NYCA==
X-Gm-Message-State: AOAM533s5kfcd7hAdDrZRWODlD30v3RNY9BFVnxxJsO3H3C0AaiailOo
        gVtXZLsnrRfP8LZSkgZVLhclnIPe+7E=
X-Google-Smtp-Source: ABdhPJw49WKBeFPvrgdz2hT9sovdxdbk0RYjvnDsuPkDj+m56LLz+pit9LgJt0yTXSZf/q2ncjFWwA==
X-Received: by 2002:aed:32e5:: with SMTP id z92mr7797652qtd.282.1594779482399;
        Tue, 14 Jul 2020 19:18:02 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a5sm1122629qtd.84.2020.07.14.19.18.01
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 14 Jul 2020 19:18:01 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [BUG?] Fetching a single tag to a local tag requires `--no-tags`
Message-Id: <12F0A2A4-CC71-4452-B8B8-F540339F8519@gmail.com>
Date:   Tue, 14 Jul 2020 22:17:59 -0400
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

If I want to fetch a single tag from a remote repository to a local tag,
it seems I have to use `--no-tags`, or else all tags on the remote are =
fetched:

git remote add ggg https://github.com/gitgitgadget/git
# this command fetches all tags on Gitgitgadget
git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2
# this command fetches only the tag listed on the command line
git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2 --no-tags

Am I reading the documentation correctly ?

tag <tag> syntax [1]:
"tag <tag> means the same as refs/tags/<tag>:refs/tags/<tag>;=20
it requests fetching everything up to the given tag."

--no-tags [2] :
"By default, tags that point at objects that are downloaded
from the remote repository are fetched and stored locally.
This option disables this automatic tag following."=20

Clearly the commits at the tips of the multiple iterations of all series =
ever submitted using
Gitgitgadget should not be downloaded when I'm just fetching a version =
of=20
my own submission, so I don't understand why these objects are fetched
and why those local tags are created...

[1] =
https://git-scm.com/docs/git-fetch#Documentation/git-fetch.txt-ltrefspecgt=

[2] =
https://git-scm.com/docs/git-fetch#Documentation/git-fetch.txt---no-tags

Cheers,

Philippe.=
