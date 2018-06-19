Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBB71F403
	for <e@80x24.org>; Tue, 19 Jun 2018 22:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936139AbeFSWHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 18:07:38 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45337 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755490AbeFSWHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 18:07:34 -0400
Received: by mail-yb0-f196.google.com with SMTP id x6-v6so488038ybl.12
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FrJSn8/5pz+78CMNQhNPTfhKwtXndtN9/iqNLp/Zz7Y=;
        b=Mb1DUkKkGo49x9b+NN270SKREgmGsiYWYWgleuBr4onDNcteSLdbz6in7Aj+AujjRO
         PRUDKiCjfXMJb2JTP6r5SC/JSVM5BLLrTe5RD1yivSfpGjlZRKE9IznUdsKFyJPHoYjW
         d2IS3eqwPmY3kq56jAJ6YRYu5dHtUU1A+dFirOrGMD+tUdavWwzkbobQIfGTuPy+6uJb
         SNNHm7bOtMbPQv/rSmdLBLDQiZAggUmk/RENfWb3OTGwTHNo1MPq90rdIyps74NrTWo3
         moMB6q2oAKTtzPsLWeofDsEo+90RB+siXSaPs4AXl6qMsUELJoHBVi2pKrKy88D8d0aD
         TKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FrJSn8/5pz+78CMNQhNPTfhKwtXndtN9/iqNLp/Zz7Y=;
        b=iHKdmY6QtHI95uEIiXlRIulLheC/2aw5jSmJKfhHV4okq8bhSW+SGCq0GlzKgQHcQm
         Sx1/FBvlJCas3gEepuw77nTpme5u3fgCOSRt/S5+ax63Etfis+iavgoYZg5HQNo//gFO
         eBI1ZPEQ2iJCzyOhjFX/z58z8L5xmQX3Ijr9pEbuauAcQR8dywAbfC/OLTXBA7JvFFND
         GGlZMVK/YUh2MW3wD2Y63urjy58bTloGTl9PXJfg80UI5gjRiDvU2KPISElbM6/ktLMp
         z93DMeUOVtMo/VYAMZqWEgqfgcHB9sdMLp1VHU1cGZOqyrX/n/z70PffPoxs+CMnV/wf
         zMvg==
X-Gm-Message-State: APt69E0ugaNeZc0i5XHePT9m9OIs6usltMNIN1lpTSChjXG2J+a3QyoT
        h4Yjqx4FSRK2WnvVMByCJKe1SZFOUuohpqCgOxmcEPoElhY=
X-Google-Smtp-Source: ADUXVKLuZadWLppsb+ShT6EhRy7NFkifV8vYXItCvjnNm6rp+i/UciDZfvBTp249keLZIg7bUyc/5Gn/B7LQHTutnks=
X-Received: by 2002:a25:cc14:: with SMTP id l20-v6mr5777748ybf.334.1529446053642;
 Tue, 19 Jun 2018 15:07:33 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Jun 2018 15:07:22 -0700
Message-ID: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
Subject: The state of the object store series
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an ongoing effort to remove global state currently and switch over
to pass around the relevant data structures; for most of it we end up passing
around 'the_repository' as it contains everything there is.

Merged into master:

fcb6df32546 Merge branch 'sb/oid-object-info'
a2cec42213c Merge branch 'sb/object-store-replace'
3a1ec60c43b Merge branch 'sb/packfiles-in-repository'
cf0b1793ead Merge branch 'sb/object-store'

Currently cooking:

8c69a7d7e80 Merge branch 'sb/object-store-grafts' into pu
42d32d07298 Merge branch 'sb/object-store-alloc' into jch

(both marked for "will merge to next" in the cooking report)

Floating on the mailing list, not cooking yet:

"sb/object-store-lookup"
https://public-inbox.org/git/20180613230522.55335-1-sbeller@google.com/
  This clashes with other series in flight (Stolees get_tree series; see
  https://public-inbox.org/git/709bd61c-70fc-a925-efba-58ab9be265c9@gmail.com/
  I'll rebase this series on top of that series once the currently cooking
  series stabilize)

"nd/kill-the_index"
https://public-inbox.org/git/20180616054157.32433-1-pclouds@gmail.com/
  This converts the_index to pass around index pointers instead of
the_repository;
  it fits into the theme, but Duys end goal differs from mine; he is
less submodule focused.

Work that still needs to be done:

"xx/object-store-commit-graph"
  Convert the commit graph to have no global state, but be part of the
  repository struct. I think this can go in parallel to
"sb/object-store-lookup",
  so I'll tackle that next. Thanks Stolee for looking ahead: There is only the
  commit graph itself as well as whether it has been prepared as a global
  variable. So this series will consist of passing around a repository struct
  for all those higher level functions that do not pass around the commit graph
  or parts of it.

"xx/finish-object-stores"
  This requires "xx/object-store-commit-graph" as well as
"sb/object-store-lookup";
  it will convert parse_commit[_gently] to take a repository argument and will
  finish the actual object store part. This might be optional for the goal of
  converting submodules, that I have in mind, but it sure is a nice finishing
  touch.

"xx/convert-revision-walking"
  This series aims to convert get_merge_bases(), in_merge_bases() and all its
  revision walking code to take a repository argument.

"xx/submodule-dont-use-alternates"
  Once "xx/convert-revision-walking" is in, convert the local
find_first_merges(),
  and convert all functions to drop function add_submodule_odb() and instead
  operate on the submodule repository instead of the_repository with the
  submodule objects added as an alternate.

Thanks,
Stefan
