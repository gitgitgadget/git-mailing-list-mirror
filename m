Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343B81FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbcLSX2r (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:28:47 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:38447 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbcLSX2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:28:46 -0500
Received: by mail-it0-f44.google.com with SMTP id x2so8465148itf.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R2eLctxjSCWK58TorxgPyI/kr3dKBN8BHFbaonEYRec=;
        b=K/0IV9dybMBDmPtx8JfVAeFOTIbExGQb+k7ihfrRMTi7KCoewv73O6ENLLWa6PM0gh
         yWbwKPeoAe6KcwM/aPvnMk0vBiZrsFGBHs9K+COvKZlQbMtF3/KweCxppwx8ftyP0jDx
         BY9aXYx513ZHzjvpuGUMMQo/ngRiUcYL4rlHO/rrUaYxZjNNRFfIV669vn8w30COU7A9
         1S/iHhdkVPg0Vq3qeCUFHt0u8QB4K4UK0hnH7rfhNoVrMA9pm+KzBrGZlQ0f4u/SPC3S
         K0zapj/4a11vO6kYU8QZlF8QikkImvwCetpi8vFvggrVHS07hqP45Q4BekZw0pqtUkuB
         hjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R2eLctxjSCWK58TorxgPyI/kr3dKBN8BHFbaonEYRec=;
        b=qRr01m26PJsHgZKKM/u64MCG3kghEUl7E0/90apDuwSF4Zq2tAmuYE2nvcaqonkb3m
         aWXWIPLJ25QRIx6r1Ytp+TGrvVhACp0CYOucCJ1KLQFJq6WvPNl2QfYpyH/uKjdxQuiL
         SqOuhUQWfOFY5Ur0qsNO1c8uBk0FQU0APqYRkAunKyuGc4PYwWLM4AKmWFs3IrvrFBPb
         6eUW7natfQFRPQ4xo5hT5QSUh5je/G+j09DVWS/lzjvHomL5+uuQfmRZOMFdVcaX78Re
         bimVzLVwwM7O+qyWqOBXPFiZxYXzhFQWjOHVPZnkpXPFgdB61xOwkX0xkLUz1CHh5oF1
         fSig==
X-Gm-Message-State: AKaTC01FKxcAEWkFNbtGoIexjiP1p6fFMQNttbwYfkFzpsGtBrUBQVo69XLaG9aNoOLAfAWj
X-Received: by 10.36.70.21 with SMTP id j21mr20993584itb.60.1482190124153;
        Mon, 19 Dec 2016 15:28:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id m127sm7843052itc.19.2016.12.19.15.28.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:28:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/5] git-rm absorbs submodule git directory before deletion
Date:   Mon, 19 Dec 2016 15:28:23 -0800
Message-Id: <20161219232828.5075-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* reworded commit messages of the last 2 patches
* introduced a new patch introducing {run,start,finish}_command_or_die
* found an existing function in dir.h to use to remove a directory
  which deals gracefully with the cornercases, that Junio pointed out.

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

Stefan Beller (5):
  submodule.h: add extern keyword to functions
  submodule: modernize ok_to_remove_submodule to use argv_array
  run-command: add {run,start,finish}_command_or_die
  submodule: add flags to ok_to_remove_submodule
  rm: absorb a submodules git dir before deletion

 builtin/rm.c  | 82 +++++++++++++++--------------------------------------------
 run-command.c | 28 ++++++++++++++++++++
 run-command.h |  4 +++
 submodule.c   | 27 ++++++++++----------
 submodule.h   | 58 ++++++++++++++++++++++++------------------
 t/t3600-rm.sh | 39 +++++++++++-----------------
 6 files changed, 114 insertions(+), 124 deletions(-)

-- 
2.11.0.rc2.53.gb7b3fba.dirty

