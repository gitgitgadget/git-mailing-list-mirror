Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B6C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A284F2082E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPbf910s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBFAlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:23 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49447 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBFAlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:23 -0500
Received: by mail-pf1-f201.google.com with SMTP id c9so2655631pfo.16
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=65aB+4JbPmaIF02ZFquFy7uS8zmUw7GzqjuljXUTYL4=;
        b=QPbf910soED5nifm5z6BkXHmsJjMI6APjjUIqX7nCS6Wmq9INij/i8oz9Bth8r3dix
         yehdxe7FeNlXU+MFcI3bUswKR6oM81IaROgmwzwS92Kl6IR4XX55iLqIkTxZf6MNzsel
         z7EntY5P9DhCJqIy836jw1G1Oj0HytNDEiyUBenFm5gnSlO88dbhFns2vGXqnHD+E8AY
         d4TPrAbH9UBpAhklxK7FnvlinhQYzIfxF8/g9EthMLOFIBYqXF8Jds0vZYyIniZ74BIe
         AmEkEOygzb0AQNVFde3Uo5cGa71XZ20Kq3tzwrlEyBufdNGB1AZhkL/AM7kF3Uqo2bWM
         ifKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=65aB+4JbPmaIF02ZFquFy7uS8zmUw7GzqjuljXUTYL4=;
        b=LhLFaRM9JIc+8pS2+ZD611coNDg253Nxjvm5UepwUVQZcrdvvOwTs9xqJMAqUZiLaD
         xtCcpTYOLDaZ103IZv5dxFaSwQ/Bam31v2dX+ehTB6VqNfrS48TI7plZZCAQA+G8E4Xo
         BtNfWTnZQHN1CjFwXmTBl1nE74K/EwFqO+98sqy2mdAa0TSpQPxcNoft453hrdkC33cs
         r12iFazg8znPihdZQrGzjcp6phD0oDA66Q+NEb94EfLKipzj4zjJ+sZMUUseKiSNzdae
         SIHwhbVchFLVQWB9uKRQ1FbY3GaCZzznnP7cQggYZ1xowZJjU3Dz2kZphZ0DjCED4CDY
         aoVw==
X-Gm-Message-State: APjAAAUPTtjdPzCyQQyJrbZVaUvxigBwDT83zIqdL+cfDLowoPtS/MB1
        soazlRIWsNOrkxnhs7LUVCCyBFneCBt5wLN0shjQqo46qWt7IG41k5jg/VfdmTBaB4V44p2hKnf
        NXwnxzfvLkY0W5CIlRVbFsyAhwqV88RyrEDQP/UvDG/ADcjHmDYWj/V8D8IyYUpakcYflPcyntg
        ==
X-Google-Smtp-Source: APXvYqyNX1vfKgf6ZT+d9+bOk7C5TcY2rscek+AI5WabBFIAHV796anJky8kvUPBpGKzBhe61MYSfNGU7XiR2CZ8ID0=
X-Received: by 2002:a63:cf41:: with SMTP id b1mr632822pgj.53.1580949681268;
 Wed, 05 Feb 2020 16:41:21 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:40:53 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 00/15] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset is based on mr/show-config-scope.

Since v5, I addressed comments from Martin and Junio.

 - Reorganized the series so the ecosystem cleanup comes before the
   interesting new features.
 - Spread out manpage updates to indicate each new feature as it's added.
 - Fixed a number of patches which assumed a repo, so bugreport can now
   run anywhere.
 - Wordsmithing in the report template.
 - die() instead of overwriting an existing report.
 - Added --suffix to allow user to change the name of the report to
   git-bugreport-<strftime format>.txt.
 - General NULL-ptr, leak, and bashism cleanup.
 - Changed safelist macro from bugreport:include[x] to
   annotate:bugreport[include].
 - Use git_config_get_value_multi() instead of a config callback to
   gather the safelist configs.
 - Added a convenience for_each_pack() macro to object-store.h and began
   using it in packfile.c and bugreport.c for pack summary

Emily Shaffer (15):
  help: move list_config_help to builtin/help
  help: add shell-path to --build-options
  bugreport: add tool to generate debugging info
  bugreport: gather git version and build info
  bugreport: add uname info
  bugreport: add compiler info
  bugreport: add git-remote-https version
  bugreport: include user interactive shell
  bugreport: generate config safelist based on docs
  bugreport: add config values from safelist
  bugreport: collect list of populated hooks
  bugreport: count loose objects
  bugreport: add packed object summary
  bugreport: list contents of $OBJDIR/info
  bugreport: summarize contents of alternates file

 .gitignore                              |   3 +
 Documentation/asciidoc.conf             |   9 +
 Documentation/asciidoctor-extensions.rb |   5 +
 Documentation/config/sendemail.txt      |  56 ++--
 Documentation/git-bugreport.txt         |  55 ++++
 Makefile                                |  27 +-
 bugreport.c                             | 409 ++++++++++++++++++++++++
 builtin/help.c                          |  86 +++++
 compat/compiler.h                       |  24 ++
 generate-bugreport-config-safelist.sh   |  17 +
 generate-cmdlist.sh                     |  19 --
 generate-configlist.sh                  |  24 ++
 help.c                                  | 132 ++------
 help.h                                  |   2 +-
 object-store.h                          |   6 +
 packfile.c                              |   3 +-
 remote-curl.c                           |   8 +
 t/t0091-bugreport.sh                    |  49 +++
 18 files changed, 778 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-bugreport-config-safelist.sh
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.25.0.341.g760bfbb309-goog

