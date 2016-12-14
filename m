Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE7D1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934533AbcLNWlM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:41:12 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35287 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933465AbcLNWlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:41:09 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so12504387pga.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E0inP8UJ41sx9WsdkAUl5+YssaQxHKFfaH8UpA5k7aA=;
        b=OfWs7x90jgzRAhPBnyzqhxJ1Qt6CklqqZMGlOhIK3vw8cz+nrSmMYKNljbFar0qzr8
         ATiKLlfPfReeRGHr+PdunOozsQSZZDPqQRF2tymmX8nearFNXwDgIG40ysbHLHu5QNdK
         phRIj/Wo76k2Sjv8qQNeFGU4EOuc6j/39KCIdr9aA/PrY8zgKJ75z10394sb7J85usih
         jzzdKtRQQ2zQbZLgn4HFboT3qe8WDp8+/ho9rJzdjBld0oObb+UDuwWMoTpunpLLAIiF
         6HainzJn+Ez3RIJ0Dn/ReXemlmVxKg1xtO4hiOk+YtD02kn4S1czzA4NVXbeGSNlZbJX
         C0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E0inP8UJ41sx9WsdkAUl5+YssaQxHKFfaH8UpA5k7aA=;
        b=BKCSh0E7YiHL+3bbn5W8G/t4xiI6FSuanvV/lUV6wQnH2OFXA0H0FpwkubGpuGf9Hu
         tB5qm/vB0Fw5Brc2S93wiwt+nXuSgy3ql4LRQDwXAqckG3k9hbiI2fJiwzxWmb7SyC5x
         Cf8Y4UnTrinFg9CuAst8vxZeMGQQhwaudY4VRQxSoLeJ1/PKrZCEDVh8hqso2kKxp9ad
         qHnGSHM7SzWzAV/ohHgIcL28FK8A5OW4VA03RzPTMXlMjv2cyAGXhRFSuH6OMjByEcLw
         EJ/Q02l6bGoMno1Q5gxmtF2rouzkT9GQL1IPiJPbiwPybccc4XAxVA5CtTBhcI2WVBsf
         cIZw==
X-Gm-Message-State: AKaTC02k9ZwwvxGB7Dtpwfz3kyyqf9H3VkRVBbIMrNF4TqPjFVy3/RP9cNMGj4hMR4fwAID2
X-Received: by 10.84.204.133 with SMTP id b5mr59253604ple.49.1481755268749;
        Wed, 14 Dec 2016 14:41:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:8d0f:31e2:8611:d98a])
        by smtp.gmail.com with ESMTPSA id q2sm90178724pga.8.2016.12.14.14.41.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:41:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/4] git-rm absorbs submodule git directory before deletion
Date:   Wed, 14 Dec 2016 14:40:57 -0800
Message-Id: <20161214224101.6211-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* removed the patch to enhance ok_to_remove_submodule to absorb the submodule
  if needed
* Removed all the error reporting from git-rm that was related to submodule
  git directories not absorbed.
* instead just absorb the git repositories or let the absorb function die
  with an appropriate error message.

v2:
* new base where to apply the patch:
  sb/submodule-embed-gitdir merged with sb/t3600-cleanup.
  I got merge conflicts and resolved them this way:
#@@@ -709,9 -687,10 +687,9 @@@ test_expect_success 'checking out a com
#          git commit -m "submodule removal" submod &&
#          git checkout HEAD^ &&
#          git submodule update &&
#-         git checkout -q HEAD^ 2>actual &&
#+         git checkout -q HEAD^ &&
#          git checkout -q master 2>actual &&
# -        echo "warning: unable to rmdir submod: Directory not empty" >expected &&
# -        test_i18ncmp expected actual &&
# +        test_i18ngrep "^warning: unable to rmdir submod:" actual &&
#          git status -s submod >actual &&
#          echo "?? submod/" >expected &&
#          test_cmp expected actual &&
#

* improved commit message in "ok_to_remove_submodule: absorb the submodule git dir"
  (David Turner offered me some advice on how to write better English off list)
* simplified code in last patch:
  -> dropped wrong comment for fallthrough
  -> moved redundant code out of both bodies of an if-clause.
* Fixed last patchs commit message to have "or_die" instead of or_dir.

v1:
The "checkout --recurse-submodules" series got too large to comfortably send
it out for review, so I had to break it up into smaller series'; this is the
first subseries, but it makes sense on its own.

This series teaches git-rm to absorb the git directory of a submodule instead
of failing and complaining about the git directory preventing deletion.

It applies on origin/sb/submodule-embed-gitdir.

Any feedback welcome!

Thanks,
Stefan


Stefan Beller (4):
  submodule.h: add extern keyword to functions
  submodule: modernize ok_to_remove_submodule to use argv_array
  submodule: add flags to ok_to_remove_submodule
  rm: add absorb a submodules git dir before deletion

 builtin/rm.c  | 78 +++++++++++++++--------------------------------------------
 cache.h       |  2 ++
 entry.c       |  8 ++++++
 submodule.c   | 31 +++++++++++++++---------
 submodule.h   | 58 +++++++++++++++++++++++++-------------------
 t/t3600-rm.sh | 39 ++++++++++++------------------
 6 files changed, 97 insertions(+), 119 deletions(-)

-- 
2.11.0.rc2.35.g26e18c9

