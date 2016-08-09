Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7852018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbcHIEPg (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:15:36 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32780 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbcHIEPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:15:33 -0400
Received: by mail-pa0-f42.google.com with SMTP id ti13so1282969pac.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:15:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=V+P+Y+MFa+c0/OXzl9SuqlzaMuNFnp7zCCdWt/SJQwY=;
        b=gprAe+ku6A9jyPtuCziPxgsZ/mpZRsY+iL3UQyOUb1ujVNMShaV0CwVkWfWFhcUBhF
         cQks9mTXOyjqoQwEdJ0BvIRtYc+WAlXXL96+VvGLBv16+6yyB3SjchkkbkrLdbldJCGC
         6vzuQTryACEngR+VT/F6Z1Q5pC69mdrPf0DDzjLV614KPX2giFcp8n270PFKJsQ5zG12
         ePJvCWH9RgEO95DDGO95oiFwwOgJzQN+3LXynEfqPsQE5QxB6ZwcajBO1IhscPlCOHb1
         a1PLgrjt+hLpRV16faBbWB4VyO72GRDpbbcYv0EIy1ryxjGGDmn6dZ2LEZnWDreiiK3P
         U+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V+P+Y+MFa+c0/OXzl9SuqlzaMuNFnp7zCCdWt/SJQwY=;
        b=mQf/NQ9bgEowMoQmFl40RYcg/vrXnVI2lYm/clMS5oF+4z/1wBnma+tQnpcp4zL7xt
         2C+7qcMQsjVq1yXh6UPzs0DxmCuKFq6fNe2xlzctwVDI79pp6cMnkqcxNwAUk6EFNGfa
         ZHGyGXn3UsdoSjN2JPtB9juZQ07ZG4WOx9cyL+aiYsWdBaYIcFs6lIhHbUbRUhi7nVU3
         nIiocEzY6NMBCHZWm4UA9dBwK1iFFE5EOiTaE6dmXPrSH3cj4mLqlsIhWbvZou118LdK
         YgRTL5exYznypTLDx1yZ/rLBOhSVLQw5iUO5XiM758geTbQ4UGvEOCDxerYeDTyLqb/A
         eVXQ==
X-Gm-Message-State: AEkooutYPeSu5EoWAlLcs+MtvWew+EVl2rCxTVVDbyJBRbUryEPDv2ex+Ib0L5MsBNbNGK1m
X-Received: by 10.66.78.5 with SMTP id x5mr56910834paw.108.1470715694992;
        Mon, 08 Aug 2016 21:08:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id x184sm51480514pfd.70.2016.08.08.21.08.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:14 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/6] git clone: Marry --recursive and --reference
Date:	Mon,  8 Aug 2016 21:08:00 -0700
Message-Id: <20160809040811.21408-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


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

