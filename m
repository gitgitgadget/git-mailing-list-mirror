Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD53DC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7FB610D0
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhJVTih (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhJVTig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4CC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m22so5755712wrb.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VF5w3697IvlgveJthM++0857WoY30ZN1nbF++6BEyJc=;
        b=OVVfqMuVKbQXhCKLRoNl5NQM61Xab5ZGNEjwsPZuIDX81ElaOsVK9+WuEqLsb/ck56
         6P/OiCAJhD8gQmpdAf3d5v7sgvLkMgmPYBhWWYYmf8kNP3pPiElKnzUdMOaa8Ug1Vph0
         jnL92pclsnSAZxcGRgmUuI3PCMLwxZCB7bjUBfZrOSRxjI1ydZDPMmnY+zVQdWbQOeix
         IuBXFUEOBg501vg9hJQ3hn95DF6KdvJBJlQUu+6Xsx6Z7kzuv2HBY9Te7L4+zW7Op6f3
         6rXAodona+lC5ZzyyMrkMOOmR+4boRIM0Jww/y8JM2g1m35ZvIVdeaY3EJ3wYJk3vzfj
         rkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VF5w3697IvlgveJthM++0857WoY30ZN1nbF++6BEyJc=;
        b=tQEcAt6V98NyRsmJTUzqL8bPStBEKepQQb7fCE3FaF7BqYpFvvOB8+R6hBXD5oN4y3
         4CoGFNU3n9FaLMuyN5K3dV8C7tE0GbgMh4EklyMItjN52f92XvfgqKQjOGBmT7J4r67j
         g3bEiTDE3C2yb8j6iJuaVfCi48WwmsUMGHP39acoVEdnPwWpJadSGf9N1rEtNE/nHY+J
         wo9x3xGviQs3AyT8qckFZ88NakebtHn+yzXSkzow8u3oazbo7po7F3kinw/HzuylaD1l
         hW7uy/cS74XD4wHO3wZRdxzv0b0fK1SXgsMZKZi2hcXnfpl7ZznGhipdvea0L5+pZly7
         nNRw==
X-Gm-Message-State: AOAM53174miN6EoyaVv0knEWjn5T6/mFjYJTFLN0TKKW1jY1WpnhT3CN
        Pp6gJb4gxo2HvqgzmnjfRr9ZBUaByKIWvA==
X-Google-Smtp-Source: ABdhPJybj5q1ymQLm6ZMiR0XHlQT7nlQ/Ip1UE/XaTkOTmpNjQvGMLQaHE8lcbTuYwU/QniU+UUpJw==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr2218692wrm.306.1634931376958;
        Fri, 22 Oct 2021 12:36:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] Makefile: make generate-cmdlist.sh much faster
Date:   Fri, 22 Oct 2021 21:36:04 +0200
Message-Id: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version of this series drops the Makefile-powered version of the
cmdlist in favor of making the shellscript much faster, mostly with
suggestions from Jeff King.

I still think that splitting out the generated data into files may be
useful for unifying the Documentation/ and C code build processes,
there's another custom parser for command-list.txt in
Documentation/cmd-list.perl.

But if and when I've got something for that I can dig that out of the
v1, in the meantime the v1 of this should be mostly uncontroversial.

The last tow patches make things a bit slower for me, but since they
replace command invocations with pure-shell logic they presumably make
things a bit less painful on e.g. Windows, and the 8th patch here
already made things quite very fast already.

Jeff King (1):
  generate-cmdlist.sh: do not shell out to "sed"

Johannes Sixt (2):
  generate-cmdlist.sh: spawn fewer processes
  generate-cmdlist.sh: replace for loop by printf's auto-repeat feature

Ævar Arnfjörð Bjarmason (7):
  command-list.txt: sort with "LC_ALL=C sort"
  generate-cmdlist.sh: trivial whitespace change
  generate-cmdlist.sh: don't call get_categories() from category_list()
  generate-cmdlist.sh: run "grep | sort", not "sort | grep"
  generate-cmdlist.sh: stop sorting category lines
  generate-cmdlist.sh: replace "grep' invocation with a shell version
  generate-cmdlist.sh: replace "cut", "tr" and "grep" with pure-shell

 command-list.txt    | 20 +++++++-------
 generate-cmdlist.sh | 66 ++++++++++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 38 deletions(-)

Range-diff against v1:
 1:  96885282988 =  1:  96885282988 command-list.txt: sort with "LC_ALL=C sort"
 2:  5e8fef90e42 =  2:  5e8fef90e42 generate-cmdlist.sh: trivial whitespace change
 3:  6b4de6a6088 =  3:  6b4de6a6088 generate-cmdlist.sh: spawn fewer processes
 4:  074685cf714 =  4:  074685cf714 generate-cmdlist.sh: don't call get_categories() from category_list()
 5:  f01c1fd8088 =  5:  f01c1fd8088 generate-cmdlist.sh: run "grep | sort", not "sort | grep"
 6:  e0b11514b8d =  6:  e0b11514b8d generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
 7:  0c6f9b80d3b <  -:  ----------- Makefile: stop having command-list.h depend on a wildcard
 8:  23d4cc77b6c <  -:  ----------- Makefile: assert correct generate-cmdlist.sh output
 -:  ----------- >  7:  f2f37c2963b generate-cmdlist.sh: stop sorting category lines
 -:  ----------- >  8:  83318d6c0da generate-cmdlist.sh: do not shell out to "sed"
 -:  ----------- >  9:  7903dd1f8c2 generate-cmdlist.sh: replace "grep' invocation with a shell version
 -:  ----------- > 10:  e10a43756d1 generate-cmdlist.sh: replace "cut", "tr" and "grep" with pure-shell
-- 
2.33.1.1505.g075a284c562

