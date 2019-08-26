Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CEE1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbfHZT5z (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:57:55 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:39985 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHZT5z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:57:55 -0400
Date:   Mon, 26 Aug 2019 19:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566849471; bh=KDrbu+XWXQ5kPBG/hfBC4YG1L5emjpxjIUGfrQB8u2Y=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=Br/M4WTVsuEbfgYhEVvpr4jNURvI4iudXYBbEIIg9Q3zbTx5E1FnH4NLAdQMDt2Sp
         4xIZ5iO9cQAy7kIugkHvEdfp9pUgDBAkxBeeiPOIP4BjDXeHY/R1+aNmiZ/aE636oY
         p436GPz9Xbp7oAfjUr7DrrZUi8zYUYdgvv7TPM9j8iWdLQfOS07uXztCJLIepi5v6v
         M0Qo4PFo1Hri0TSa7qWWZxZHd74GEAHe6t2UIO6wK91dV7bB8rFu20kJH4JH/lF+CI
         7kl234vmduLBns0MDknmdYiA2BwjXhJCpHuZKjIF8Ijs+QnuahV+T2wXsF7A/vy27x
         o5wYZ3tZy8DwA==
To:     git@vger.kernel.org
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     Ibrahim El <ibrahim.el@pm.me>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: [PATCH 0/5] New signing interface API with pluggable drivers
Message-ID: <tz1YiiRtWStGrH2sc42DyD-8bDtH1A52rOCCapct59Qos6jEikqscvusUs7QeOBRNmCF7L_AL1ezKurbTp6qEZCmEk7L9B28wH-TVQGBSdY=@pm.me>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following previous introduction mail [1], this first series of 5 patches is=
 a re-write of the signing interface API in an effort to support easily the=
 addition of new tools with minimal effort and also keeping backwards compa=
tibility with current tools and configuration.

All existing tests currently pass with backward compatibility.

[1]: https://public-inbox.org/git/CACi-FhDeAZecXSM36zroty6kpf2BCWLS=3D0R+dU=
wuB96LqFKuTA@mail.gmail.com/T/#r43cbf31b86642ab5118e6e7b3d4098bade5f5a0a

The patches are ordered as follow:
[1/5] - Adding Documentation files explaining the different changes using a=
 design document and updates to the configuration part
[2/5] - Adding new files that define the signing interface API and also dri=
vers for the existing GPG and GPGSM X.509 tools
[3/5] - Migrating the code to using the new signing interface API. Old GPG =
Interface code is commented and ommited
[4/5] - Removing the old GPG interface and updating the code to remove all =
gpg mentions from it to make it transparent to the signing tool that is bei=
ng used
[5/5] - Duplicating existing signature related tests and updating them to u=
sing the new configuration aliases

Ibrahim El Rhezzali (5):
  Added documentation for the new signing interface
  Added new signing interface API
  Migrated to the new signing interface API
  Removed old gpg interface and gpg mentions in code
  Duplicated signing tests using new config aliases

 Documentation/config/commit.txt               |   12 +-
 Documentation/config/gpg.txt                  |   18 +-
 Documentation/config/push.txt                 |    9 +-
 Documentation/config/signing.txt              |   63 +
 Documentation/config/tag.txt                  |    4 +-
 Documentation/config/user.txt                 |   10 +-
 Documentation/git-am.txt                      |    9 +-
 Documentation/git-cherry-pick.txt             |    9 +-
 Documentation/git-commit-tree.txt             |   18 +-
 Documentation/git-commit.txt                  |   19 +-
 Documentation/git-rebase.txt                  |    9 +-
 Documentation/git-revert.txt                  |    9 +-
 Documentation/merge-options.txt               |    5 +-
 Documentation/technical/signing-interface.png |  Bin 0 -> 76116 bytes
 Makefile                                      |    4 +-
 builtin/am.c                                  |   11 +-
 builtin/commit-tree.c                         |    6 +-
 builtin/commit.c                              |   12 +-
 builtin/fmt-merge-msg.c                       |    4 +-
 builtin/log.c                                 |    4 +-
 builtin/merge.c                               |   10 +-
 builtin/pull.c                                |   16 +-
 builtin/push.c                                |    5 +-
 builtin/rebase.c                              |   60 +-
 builtin/receive-pack.c                        |    6 +-
 builtin/replace.c                             |    2 +-
 builtin/revert.c                              |    6 +-
 builtin/send-pack.c                           |    6 +-
 builtin/tag.c                                 |   17 +-
 builtin/verify-commit.c                       |   18 +-
 builtin/verify-tag.c                          |   12 +-
 commit.c                                      |   39 +-
 commit.h                                      |    6 +-
 gpg-interface.c                               |  378 -----
 gpg-interface.h                               |   67 -
 log-tree.c                                    |   20 +-
 pretty.c                                      |    8 +-
 ref-filter.c                                  |    1 +
 send-pack.c                                   |    5 +-
 sequencer.c                                   |   59 +-
 sequencer.h                                   |    2 +-
 signing-interface.c                           |  487 ++++++
 signing-interface.h                           |  151 ++
 signing-tool-openpgp.c                        |  409 +++++
 signing-tool-x509.c                           |  383 +++++
 signing-tool.h                                |   35 +
 t/t3431-rebase-interactive-signconfig.sh      | 1480 ++++++++++++++++++
 t/t4215-log-signconfig.sh                     | 1710 ++++++++++++++++++++
 t/t5548-push-signed-signconfig.sh             |  276 ++++
 t/t5573-pull-verify-signatures.sh             |   10 +-
 t/t7013-tag-signconfig.sh                     | 2074 +++++++++++++++++++++=
++++
 t/t7031-verify-tag-signconfig.sh              |  175 +++
 t/t7522-signed-commit-signconfig.sh           |  288 ++++
 t/t7612-merge-verify-signatures.sh            |   18 +-
 tag.c                                         |   16 +-
 tag.h                                         |    2 +-
 56 files changed, 7797 insertions(+), 695 deletions(-)
 create mode 100644 Documentation/config/signing.txt
 create mode 100644 Documentation/technical/signing-interface.png
 delete mode 100644 gpg-interface.c
 delete mode 100644 gpg-interface.h
 create mode 100644 signing-interface.c
 create mode 100644 signing-interface.h
 create mode 100644 signing-tool-openpgp.c
 create mode 100644 signing-tool-x509.c
 create mode 100644 signing-tool.h
 create mode 100755 t/t3431-rebase-interactive-signconfig.sh
 create mode 100755 t/t4215-log-signconfig.sh
 create mode 100755 t/t5548-push-signed-signconfig.sh
 create mode 100755 t/t7013-tag-signconfig.sh
 create mode 100755 t/t7031-verify-tag-signconfig.sh
 create mode 100755 t/t7522-signed-commit-signconfig.sh

--=20
2.11.0


