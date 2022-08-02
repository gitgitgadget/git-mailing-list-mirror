Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B256C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiHBM6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHBM6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85AD114
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so17794937wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Eda2TGS71RbwQ11ttW9PZ3JrWcSg+6MCPZcyvEuhdQw=;
        b=WARy9Vy/zGg5e8/Cm62WwUZzqNEXeO3X8Okon2HsrkHW6PRKFff8poVUM+QQKcRQwk
         MP8XVapCG0jbBbFv3wfrjw4uucJAsL5K64BFGOa5wKYFpOWk3mPgIGErhJETlskOBSK/
         zC9M5YlmVKaXfUShKQv2+jgrw87VDsNadBydTUKXt/4PRMv1ds4yKANdrEs85PZk/jwD
         bzuyeaokkE7w1xXU4HqZYNLrMdU6hPfO1c7v/RPECNW3+R+NZhtxu+XOdYpUnbKNQTCh
         K6N2rzZ2gRAoXHKzHr0pDZkl7CstVZ3DMSatIHy8ElFjECjIRFo3cseYnQJMWxWIHLJm
         cDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Eda2TGS71RbwQ11ttW9PZ3JrWcSg+6MCPZcyvEuhdQw=;
        b=dULl7r/C8wSN9ZkD2rbbjjpVW7zW1YVB+svU/ncnG3Ah5Td2MW+2LsEeEik2F+qaJO
         N1IFL/jgxKU2cbGcP0C9oYwO62ZldmlywJyL6NTy7paJCGha1IRaoGQpsPGQvQ/D3n5I
         JapteCRp2dFoTvTLtDashTR8Cf7l3TMP7yqvi6954bNffF2QoxtpRKxGHfUWt7vXdAin
         jj+UNwk/9wF5dlwZvxhvcmVrA2VZ1jhVCFgxXmQAf4aU9iHvW5Ub0lUgCbajvJB2dNUQ
         03kAJAH0ESj+fAetbBxnlY1/kFzU7ibmwaQqkvZGUn5er/L7bxCESKBW+uLiiAt309vK
         1mqA==
X-Gm-Message-State: ACgBeo2qaWrpX0pdulYdeUiyNwv4QIrrUWTTNtCQIE/o0kkUNlWpnH8j
        82KfENWb9YOeDq5fncM3T9/bmOrY2BY=
X-Google-Smtp-Source: AA6agR5tP8r8eEfNEaEPQrD6So16z0t8MD9eyVMFpO4LQWvpcEEwkF1wmBqOi+iUrwQKrMK8kV8Png==
X-Received: by 2002:a05:6000:1c08:b0:21f:f61a:4087 with SMTP id ba8-20020a0560001c0800b0021ff61a4087mr9382257wrb.200.1659445078298;
        Tue, 02 Aug 2022 05:57:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:57:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 00/10] docs: create & use "(user|developer) interfaces" categories
Date:   Tue,  2 Aug 2022 14:56:49 +0200
Message-Id: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the v5 for a general overview:
https://lore.kernel.org/git/cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com/

This v7:

 * Gets rid of the BUG() addition in an earlier commit when handle the
   command-list.txt data.

 * We still need to change that drop_prefix() function to handle our
   new categories.

   That's now done in a couple of commits. One to
   change it to a "switch" statement without any functional changes,
   another to strip either "git" or "git-" prefixes, not both.

 * There was an indentation error in a command-list.txt addition, fix
   it.

Ævar Arnfjörð Bjarmason (10):
  help.c: refactor drop_prefix() to use a "switch" statement"
  help.c: remove common category behavior from drop_prefix() behavior
  git help doc: use "<doc>" instead of "<guide>"
  git docs: add a category for user-facing file, repo and command UX
  git docs: add a category for file formats, protocols and interfaces
  docs: move commit-graph format docs to man section 5
  docs: move protocol-related docs to man section 5
  docs: move pack format docs to man section 5
  docs: move http-protocol docs to man section 5
  docs: move multi-pack-index docs to man section 5

 Documentation/Makefile                        | 26 +++++-----
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/pack.txt                 |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-bundle.txt                  | 13 +++--
 Documentation/git-commit-graph.txt            |  5 ++
 Documentation/git-help.txt                    | 27 ++++++++--
 Documentation/git-multi-pack-index.txt        |  6 +--
 Documentation/git-upload-pack.txt             |  7 ++-
 Documentation/git.txt                         | 17 +++++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++---
 .../chunk-format.txt => gitformat-chunk.txt}  | 29 ++++++++---
 ...-format.txt => gitformat-commit-graph.txt} | 49 +++++++++++++------
 .../index-format.txt => gitformat-index.txt}  | 22 ++++++++-
 ...dex.txt => gitformat-multi-pack-index.txt} | 20 +++++++-
 ...uft-packs.txt => gitformat-pack-cruft.txt} | 22 ++++++++-
 .../pack-format.txt => gitformat-pack.txt}    | 39 +++++++++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++--
 ...ities.txt => gitprotocol-capabilities.txt} | 28 ++++++++---
 ...ocol-common.txt => gitprotocol-common.txt} | 23 ++++++++-
 ...http-protocol.txt => gitprotocol-http.txt} | 35 ++++++++++---
 ...pack-protocol.txt => gitprotocol-pack.txt} | 28 ++++++++---
 .../protocol-v2.txt => gitprotocol-v2.txt}    | 27 +++++++---
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 Documentation/lint-man-section-order.perl     |  3 ++
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/packfile-uri.txt      |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 Makefile                                      |  1 +
 builtin/help.c                                | 20 +++++++-
 cache.h                                       |  3 +-
 command-list.txt                              | 38 +++++++++++---
 help.c                                        | 41 ++++++++++++++--
 help.h                                        |  2 +
 pack-revindex.h                               |  2 +-
 refspec.h                                     |  2 +-
 t/t0012-help.sh                               | 14 +++++-
 t/t5551-http-fetch-smart.sh                   |  4 +-
 41 files changed, 512 insertions(+), 126 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (89%)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (87%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/multi-pack-index.txt => gitformat-multi-pack-index.txt} (94%)
 rename Documentation/{technical/cruft-packs.txt => gitformat-pack-cruft.txt} (96%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)
 rename Documentation/{technical/protocol-capabilities.txt => gitprotocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitprotocol-common.txt} (89%)
 rename Documentation/{technical/http-protocol.txt => gitprotocol-http.txt} (97%)
 rename Documentation/{technical/pack-protocol.txt => gitprotocol-pack.txt} (98%)
 rename Documentation/{technical/protocol-v2.txt => gitprotocol-v2.txt} (97%)

Range-diff against v6:
 1:  f3588319057 !  1:  2665148f45b help.c: BUG() out if "help --guides" can't remove "git" prefixes
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    help.c: BUG() out if "help --guides" can't remove "git" prefixes
    +    help.c: refactor drop_prefix() to use a "switch" statement"
     
    -    Adjust code added in 929d9192828 (git docs: split "User-facing file
    -    formats" off from "Guides", 2021-06-04) to be more strict about the
    -    prefix trimming of the "guides" category.
    +    Refactor the drop_prefix() function in in help.c to make it easier to
    +    strip prefixes from categories that aren't "CAT_guide". There are no
    +    functional changes here, by doing this we make a subsequent functional
    +    change's diff smaller.
     
    -    There are no guides in the command-list.txt that don't start with
    -    "git", and we're unlikely to ever add any, if we do we can remove this
    -    BUG() invocation, but in the meantime this makes the intent more
    -    clear.
    +    As before we first try to strip "git-" unconditionally, if that works
    +    we'll return the stripped string. Then we'll strip "git" if the
    +    command is in "CAT_guide".
    +
    +    This means that we'd in principle strip "git-gitfoo" down to "foo" if
    +    it's in CAT_guide. That doesn't make much sense, and we don't have
    +    such an entry in command-list.txt, but let's preserve that behavior
    +    for now.
     
         While we're at it remove a stray newline that had been added after the
         "return name;" statement.
    @@ help.c: static struct category_description main_categories[] = {
      static const char *drop_prefix(const char *name, uint32_t category)
      {
      	const char *new_name;
    -+	const char *prefix;
    ++	const char *prefix = NULL;
      
      	if (skip_prefix(name, "git-", &new_name))
      		return new_name;
    @@ help.c: static struct category_description main_categories[] = {
     +	switch (category) {
     +	case CAT_guide:
     +		prefix = "git";
    -+		if (!skip_prefix(name, prefix, &new_name))
    -+			BUG("'%s' in category #%d should have '%s' prefix",
    -+			    name, category, prefix);
    - 		return new_name;
    ++		break;
     +	}
    - 	return name;
    --
    ++	if (prefix && skip_prefix(name, prefix, &new_name))
    + 		return new_name;
    +-	return name;
    + 
    ++	return name;
      }
      
      static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 -:  ----------- >  2:  56429194634 help.c: remove common category behavior from drop_prefix() behavior
 2:  80322d44ea5 =  3:  2d6c00a51fa git help doc: use "<doc>" instead of "<guide>"
 3:  0d22eb645bd !  4:  8e9384a92f2 git docs: add a category for user-facing file, repo and command UX
    @@ help.c: static struct category_description main_categories[] = {
      };
      
     @@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    - 		return new_name;
    + 
      	switch (category) {
      	case CAT_guide:
     +	case CAT_userinterfaces:
      		prefix = "git";
    - 		if (!skip_prefix(name, prefix, &new_name))
    - 			BUG("'%s' in category #%d should have '%s' prefix",
    + 		break;
    + 	default:
     @@ help.c: void list_guides_help(void)
      	putchar('\n');
      }
 4:  c25f8ec9bf5 !  5:  4367c1e7f50 git docs: add a category for file formats, protocols and interfaces
    @@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
      	case CAT_userinterfaces:
     +	case CAT_developerinterfaces:
      		prefix = "git";
    - 		if (!skip_prefix(name, prefix, &new_name))
    - 			BUG("'%s' in category #%d should have '%s' prefix",
    + 		break;
    + 	default:
     @@ help.c: void list_user_interfaces_help(void)
      	putchar('\n');
      }
 5:  466dbd2a993 =  6:  5adabbb3a26 docs: move commit-graph format docs to man section 5
 6:  9a551b2d53a =  7:  cfd1b0afb53 docs: move protocol-related docs to man section 5
 7:  92be18b95d9 =  8:  3505fa86039 docs: move pack format docs to man section 5
 8:  a8a883ebf85 !  9:  c4a7fe9d439 docs: move http-protocol docs to man section 5
    @@ command-list.txt: gitmodules                              userinterfaces
      gitnamespaces                           guide
      gitprotocol-capabilities                developerinterfaces
      gitprotocol-common                      developerinterfaces
    -+gitprotocol-http                       developerinterfaces
    ++gitprotocol-http                        developerinterfaces
      gitprotocol-pack                        developerinterfaces
      gitprotocol-v2                          developerinterfaces
      gitremote-helpers                       guide
 9:  ecfda8c6770 = 10:  8baf1db4d30 docs: move multi-pack-index docs to man section 5
-- 
2.37.1.1232.gc0cde427aa7

