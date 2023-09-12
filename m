Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40102EE3F0C
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 19:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbjILTcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbjILTco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 15:32:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE24CF
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 12:32:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBB15337DB;
        Tue, 12 Sep 2023 15:32:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=XdHfA2gzaZcHk2CfSc4NSZVI+
        dF3EJkaaXgLD0uLHoc=; b=xkf+WbcKbNJ5PxSsy3aGEjiEMedLtVst7DxO6wMum
        +0CNw9tarQijIrSW1dHMvoB6HhLGsRH6FGMcs79rXMdDCMw5Tsn/1mj39if71Psq
        7nj1cuPOhUyb/mUVjMnZNn55rsAHP3dv83NjlHFeohsI8rMu8B3keq6e9m1XH7eN
        DI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4C6C337DA;
        Tue, 12 Sep 2023 15:32:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37C88337D8;
        Tue, 12 Sep 2023 15:32:37 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/3] "update-index --show-index-version"
Date:   Tue, 12 Sep 2023 12:32:32 -0700
Message-ID: <20230912193235.776292-1-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-158-g94e83dcf5b
In-Reply-To: <20230818233729.2766281-1-gitster@pobox.com>
References: <20230818233729.2766281-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 21219F8E-51A3-11EE-BE04-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though there is "test-tool index-version", there wasn't an
officially supported way for end-users to inspect the index version
of an on-disk index.  Let's have one.

This iteration takes suggestions by Linus Arver; the tests added by
[2/3] have been clarified.

Junio C Hamano (3):
  update-index doc: v4 is OK with JGit and libgit2
  update-index: add --show-index-version
  test-tool: retire "index-version"

 Documentation/git-update-index.txt    | 14 ++++++++----
 Makefile                              |  1 -
 builtin/update-index.c                | 19 ++++++++++------
 t/helper/test-index-version.c         | 15 -------------
 t/helper/test-tool.c                  |  1 -
 t/helper/test-tool.h                  |  1 -
 t/t1600-index.sh                      |  2 +-
 t/t1700-split-index.sh                |  2 +-
 t/t2104-update-index-skip-worktree.sh |  6 +++---
 t/t2107-update-index-basic.sh         | 31 +++++++++++++++++++++++++++
 10 files changed, 59 insertions(+), 33 deletions(-)
 delete mode 100644 t/helper/test-index-version.c

Range-diff against v2:
1:  7bc7f7877d ! 1:  224a72529a update-index doc: v4 is OK with JGit and =
libgit2
    @@ Commit message
         cautious about cross-tool compatibility.
    =20
         Helped-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    +    Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## Documentation/git-update-index.txt ##
    @@ Documentation/git-update-index.txt: you will need to handle the si=
tuation manual
     -may not support it yet.
     +time.  Git supports it since version 1.8.0, released in October 201=
2,
     +and support for it was added to libgit2 in 2016 and to JGit in 2020=
.
    -+Older editions of this manual page called it "relatively young", bu=
t
    ++Older versions of this manual page called it "relatively young", bu=
t
     +it should be considered mature technology these days.
     +
     =20
2:  33c924f893 ! 2:  bd3fc76b3f update-index: add --show-index-version
    @@ Metadata
      ## Commit message ##
         update-index: add --show-index-version
    =20
    -    "git update-index --version N" is used to set the index format
    +    "git update-index --index-version N" is used to set the index fo=
rmat
         version to a specific version, but there was no way to query the
         current version used in the on-disk index file.
    =20
    @@ Commit message
         teach the "--index-version N" option to report what the version =
was
         when run with the "--verbose" option.
    =20
    +    Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## Documentation/git-update-index.txt ##
    @@ Documentation/git-update-index.txt: you will need to handle the si=
tuation manual
      	Supported versions are 2, 3 and 4. The current default version is =
2
      	or 3, depending on whether extra features are used, such as
     -	`git add -N`.
    -+	`git add -N`.  With `--verbose` option, also reports the
    -+	version the index file uses before and after this command.
    ++	`git add -N`.  With `--verbose`, also report the version the index
    ++	file uses before and after this command.
      +
      Version 4 performs a simple pathname compression that reduces index
      size by 30%-50% on large repositories, which results in faster load
     @@ Documentation/git-update-index.txt: and support for it was added =
to libgit2 in 2016 and to JGit in 2020.
    - Older editions of this manual page called it "relatively young", bu=
t
    + Older versions of this manual page called it "relatively young", bu=
t
      it should be considered mature technology these days.
     =20
     +--show-index-version::
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char =
**argv, const
      		OPT_INTEGER(0, "index-version", &preferred_index_format,
      			N_("write index in this format")),
     +		OPT_SET_INT(0, "show-index-version", &preferred_index_format,
    -+			    N_("show index format version"), -1),
    ++			    N_("report on-disk index format version"), -1),
      		OPT_BOOL(0, "split-index", &split_index,
      			N_("enable or disable split index")),
      		OPT_BOOL(0, "untracked-cache", &untracked_cache,
    @@ t/t2107-update-index-basic.sh: test_expect_success '--chmod=3D+x a=
nd chmod=3D-x in t
     +test_expect_success '--index-version' '
     +	git commit --allow-empty -m snap &&
     +	git reset --hard &&
    ++	git rm -f -r --cached . &&
     +
    -+	git update-index --index-version 2 >actual &&
    -+	test_must_be_empty actual &&
    -+
    ++	# The default index version is 2 --- update this test
    ++	# when you change it in the code
     +	git update-index --show-index-version >actual &&
     +	echo 2 >expect &&
     +	test_cmp expect actual &&
     +
    ++	# The next test wants us to be using version 2
    ++	git update-index --index-version 2 &&
    ++
     +	git update-index --index-version 4 --verbose >actual &&
     +	echo "index-version: was 2, set to 4" >expect &&
    -+	test_cmp expect actual
    ++	test_cmp expect actual &&
    ++
    ++	git update-index --index-version 4 --verbose >actual &&
    ++	echo "index-version: was 4, set to 4" >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	git update-index --index-version 2 --verbose >actual &&
    ++	echo "index-version: was 4, set to 2" >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	# non-verbose should be silent
    ++	git update-index --index-version 4 >actual &&
    ++	test_must_be_empty actual
     +'
     +
      test_done
3:  137ec82973 ! 3:  d1144a8240 test-tool: retire "index-version"
    @@ Commit message
         test-tool: retire "index-version"
    =20
         As "git update-index --show-index-version" can do the same thing=
,
    -    the test-tool lost its reason to exist.
    +    the 'index-version' subcommand in the test-tool lost its reason =
to
    +    exist.  Remove it and replace its use with the end-user facing
    +    'git update-index --show-index-version'.
    =20
    +    Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## Makefile ##
--=20
2.42.0-158-g94e83dcf5b

