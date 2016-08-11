Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23A620193
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbcHKXOL (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:11 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35221 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcHKXOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:10 -0400
Received: by mail-pf0-f177.google.com with SMTP id x72so2867687pfd.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SlfzeRkw6Hb1eebkwcBfWfP2Z2L6oijSL1Dg39Bus+A=;
        b=WunT1hwyZD4uKsKNyDlQfKCCZqMtzYeH7o7SkhMzA+YPprWuo9MkN6MB7rcrEEDDHF
         kyNdg2308AFlRuOLrlMlzs5PrZxZTQuMngLrPfaENdQGRcrB39M68VsG0q9JBCaTOU1F
         TUX4IG2TPusLRQV/NW5zDblc5cJZw6Xizby5tvXvVFdgy4cNzKkopiDy34SOYl7xfygE
         AAOgCNmqQtx/FKrhoDSbRll2w12F7j0ZjXr0IhdsGB2rcS/3ZUynjlybczt8SEPYPm8/
         pAvPsNGHpsJ0FyPgsLwEOlP4sYF4q55ZorYcgKW6fMRlGBUA6Xue0l/IE0MWpmvGFYLp
         viHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SlfzeRkw6Hb1eebkwcBfWfP2Z2L6oijSL1Dg39Bus+A=;
        b=WmD+/KWXtjf3wY+AcRJ7daMIy+ejmwjKAe9t/4mcaIwnG0CN0cmXQpf/Fxp4N9KDNR
         edBC1AhxfD9uFEgyOIIBTXx5gmt+9bjI4IAKihIrPT7cnoV29+rbXykUH+/NlPf+Xlv5
         dlmoN1KMSgm0RR06m66OL/PrTT9Q7pm1w3i19HC7xkNNyExOWJhIaVZ9E6O+Jrrt6OXp
         Tzt0QQlluvJTGOSo7Hoi8hWKBmWHkAY2xrHZZsqOSc/oy6OxJDu/StJXj6Pi9FGeR4S6
         xunvO2Y6sYeIu0HojqDtNj0QV6ugtSBkovFpyaplTXKeE+K2kUwxDbwfLR2qTdZSdGYi
         +foA==
X-Gm-Message-State: AEkoousPlWP7OEuwyBivXzLzxFeYGwuK8GdKw1BfM2Asvv2Oyjalf5r4ginohRSthr0FeuYZ
X-Received: by 10.98.103.214 with SMTP id t83mr21705811pfj.158.1470957249693;
        Thu, 11 Aug 2016 16:14:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id q26sm7713045pfj.53.2016.08.11.16.14.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:08 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/6] git clone: Marry --recursive and --reference
Date:	Thu, 11 Aug 2016 16:13:57 -0700
Message-Id: <20160811231405.17318-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v4:
Thanks to Junios critial questions regarding the design, I took a step back
to look at the bigger picture, again.

new patches:
  clone: factor out checking for an alternate path
  clone: recursive and reference option triggers submodule alternates
  
The last patch redesigns completely how we approach the problem.
Now there are no new command line options (that relate to the problem
of marrying --recursive and --reference), but instead we communicate
everything via configuration options to have a lasting effect (i.e.
submodule update remembers the decision of the initial setup)

Thanks,
Stefan

v3:

Thanks to Junios critial questions regarding the design, I took a step back
to look at the bigger picture. 

--super-reference sounds confusing. (what is the super referring to?)
So drop that approach.

Instead we'll compute where the reference might be in the superproject scope
and ask the submodule clone operation to consider an optional reference.
If the referenced alternate is not there, we'll just warn about it and
carry on.


* fixed the style in patch 2.

* fixed another bug in the last patch, that is unrelated, but would have helped
  me a lot.

Thanks,
Stefan

 Documentation/git-clone.txt    |   9 ++++++++-
 builtin/clone.c                |  36 ++++++++++++++++++++++++++++--------
 builtin/submodule--helper.c    | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 git-submodule.sh               |   2 +-
 t/t7408-submodule-reference.sh | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------
 5 files changed, 217 insertions(+), 97 deletions(-)

v2:
 * fixed the p1,2 cleanups
 * added documentation to patches 5,6
 * improved commit message in v4
 
 Thanks,
 Stefan
 
v1:
 
 Currently when cloning a superproject with --recursive and --reference
 only the superproject learns about its alternates. The submodules are
 cloned independently, which may incur lots of network costs.
 
 Assume that the reference repository has the submodules at the same
 paths as the to-be-cloned submodule and try to setup alternates from
 there.
 
 Some submodules in the referenced superproject may not be there, 
 (they are just not initialized/cloned/checked out), which yields
 an error for now. In future work we may want to soften the alternate
 check and not die in the clone when one of the given alternates doesn't
 exist.
 
 patch 1,2 are modernizing style of t7408, 
 patches 3,4 are not strictly necessary, but I think it is a good thing
 to not leave the submodule related C code in a crippled state (i.e.
 allowing only one reference). The shell code would also need this update,
 but it looked ugly to me, so I postpone it until more of the submodule code
 is written in C. 
 
 Thanks,
 Stefan 

Stefan Beller (6):
  t7408: modernize style
  t7408: merge short tests, factor out testing method
  submodule--helper module-clone: allow multiple references
  submodule--helper update-clone: allow multiple references
  submodule update: add super-reference flag
  clone: reference flag is used for submodules as well

 builtin/clone.c                |  22 ++++--
 builtin/submodule--helper.c    |  45 ++++++++----
 git-submodule.sh               |  12 +++-
 t/t7408-submodule-reference.sh | 153 +++++++++++++++++++++++------------------
 4 files changed, 147 insertions(+), 85 deletions(-)

-- 
2.9.2.572.g9d9644e.dirty

