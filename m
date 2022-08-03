Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AAEC19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 20:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiHCU5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 16:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiHCU5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 16:57:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0E1F2F2
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 13:57:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s6-20020a25c206000000b0066ebb148de6so14253116ybf.15
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=TQ0x4XHnBVpX4hysYiH1GXJcpwzabv3xc8Ucz6zYKeY=;
        b=aa/0v0Kjx+XN+ebtzW4PSVP4nWnC0Ki8vKscmBbgy6egehOwCwqwgIVdeIgF/lRfnC
         CmoIC2Gd8QbEpZ6Pnxj4MHppQ08MjlWmlR8vm5THnxdTseRwdHSWVgF4hFWAtBU2s34k
         jaIl5bUwHdMmydqnZqVAaiG0LAMLrAc69VtFG5HvSpprXrGdDlGUV9BCPd1v737Ub4rZ
         /fGXiqnWXEWhAym9bhAn9ROXz+P5OqQ+lkxsj6tdpXxg1LJ7ZPMYOpVZBwDMnkIffBAB
         5SyPjNFQxgH8fE/U7AM84ImttszmmJMw6F0zhgFRkNBCEVl+OssgZVDjD+ydnfTTlG9B
         ZsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=TQ0x4XHnBVpX4hysYiH1GXJcpwzabv3xc8Ucz6zYKeY=;
        b=vp/2hKM0abOj+iUrsSiFktGVmbHsWzRdnSuWPf/OOBe3sUwmyaPFcay0aijHogsNDc
         QqCGTMls2BT5l5g+PQcGpZ6wH7Ks0cgm/i3cIi+z/7cJ8C8KLDbxKI9NLwemYGpzEcu5
         tJr9h7E6yRFX5EoXu4OwaMxtbC5jIRMC+9lDXS16i1SUdHd+RT3FpgWKoZUo2LSATjzE
         FbbgEw0vwPhyXqKRlaPxGbGBmDhPfePuvOHTYdlEAFAzm4SQdsPQX0kpINDkdr2C+Nph
         3mbIjJR3nkDjtDM4xNS9V3strq47ng6LyjkqskD5M3Al+ZQo/QUCxlVii2KY9rWply9s
         gVRw==
X-Gm-Message-State: ACgBeo2gdWK1WG2RDULG3fM3VYHW26ZqRRlkUAr469evtoj8SjC4KLU1
        kvP7B6h6ZGX9Fx4uiegxs1c3LxsDk07O5PpXdyy3o3OZSENBY/s/Xs3riraGQ6yKAZZzqJgvI5z
        lXlBsxTTaUQDJv/ylT+hIjtAZy6GV3rn6htjdRngOerL16rOFPlVk1B2CmMr6waf4R5+AnE392w
        ==
X-Google-Smtp-Source: AA6agR6XPjBghDYkfpiKuKBXXGdElagaU9GZi2ib31/rg8qnLNlb/3LVI/xpE0ElE3YsWsr62PKq6SbF+N+VmN1sPgA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:b3d5:c5f6:e39a:a9e2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:9b88:0:b0:66d:b166:a430 with SMTP
 id v8-20020a259b88000000b0066db166a430mr21719757ybo.80.1659560250238; Wed, 03
 Aug 2022 13:57:30 -0700 (PDT)
Date:   Wed,  3 Aug 2022 13:57:19 -0700
Message-Id: <20220803205721.3686361-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 0/2] let feature.experimental imply gc.cruftPacks=true
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cruft packs seem to save us disk space during garbage collection. There
may still be some interesting races around mtime, but as I understand
it, those are not particularly worse or better with or without cruft
packs; so this setting primarily works to save us disk space. At least
at Google, we see concerns around loose object explosion during gc
fairly often, so this is a welcome change and we've turned it on for all
Googlers. Because we did so, I wonder if it's going to make sense to for
gc.cruftPacks to default to true in the future, with or without mtime
race fixes. With that in mind, I think it's a good idea to get any folks
who may be testing for us with feature.experimental to also try out
cruft packs and complain to us if there is an issue.

In Monday's standup there was some discussion around remaining concerns
with mtime and cruft packs. As I understood it at least, it seems there
can be a loss of information around mtimes when switching between cruft
repacks and no-cruft repacks, for example:

 ab/cdef is unreachable and has mtime <last week>
 'git gc --cruft'
 packs/<cruft>.pack contains abcdef
 packs/<cruft>.mtimes says abcdef has mtime <last week>
 'git gc' (no cruft)
 ab/cdef is unreachable and has mtime <now>

I could have misunderstood it. But it seems to be an issue primarily
around switching between crufty and non-crufty gc.

Read the full conversation around mtime races:
https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-08-01

As for the series, it's only a two-patch series because I noticed while
trying to add tests for feature.experimental => gc.cruftPacks=true that
there weren't any tests around gc.cruftPacks to begin with. It's
possible that there are too many tests in patch 1 - gc --cruft is tested
in t5329 'expiring cruft objects with git gc' - but it looked like the
content of the test was different, in that t5329's test checks to make
sure the cruft pack and associated metadata are deleted during
expiration, but the one I added checks that the cruft pack is generated
during a 'gc --cruft' which isn't ready to expire yet.

 - Emily

Emily Shaffer (2):
  gc: add tests for --cruft and friends
  config: let feature.experimental imply gc.cruftPacks=true

 Documentation/config/feature.txt |  2 +
 builtin/gc.c                     |  6 +++
 t/t6500-gc.sh                    | 71 ++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

-- 
2.37.1.455.g008518b4e5-goog

