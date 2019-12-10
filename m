Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E83DC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6BE2073D
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZszHR6WS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLJCdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:33:52 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40181 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJCdv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 21:33:51 -0500
Received: by mail-pg1-f201.google.com with SMTP id z12so9761274pgf.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 18:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0jqZhmZT/DgFdysLrgBI2xu3Ajz4jseVhutOvpQ69dI=;
        b=ZszHR6WSgsPsP/L5HeHrUQRjA1eZEfYCBsFc90ImaMG6HLTq1dgAe252k+Yectz08Z
         ktmfObdVBaC7+XVNNno1rP6vEt8fuKulGbJchmGW6R/H2p+voGe1F0JivJ+c59gG8OxV
         T+NoKuC8+OrUAeoMG2leZqBk73wnBKZoPxXRXWwxJAsuM8PIxlw5loYVYDfN5WtnvpEm
         aXbBXG7WJCLkb399m/ooC8xcJ1A/nwsWk0UZxZdjgtdBEsg5mNqJNPveVmjAK+g/WzP+
         yzeCTFBmC4NP0kRBaMEeKvct/+n99zMMFNtOGJg9kNgzhmvDILnuFD765OaswkQdz3pA
         0nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0jqZhmZT/DgFdysLrgBI2xu3Ajz4jseVhutOvpQ69dI=;
        b=O/5EGkb0/rt4K0XMDCaHO+00u+Ay61qMBxpfR8PoWJrsH4weL/TAIy/NnNi5VhZRaT
         0ecUo2anFx6qH6Y5hIIoWZeTRxYc1yQObxlUn0WVO2IeDe61EvgFu3IwKvaOYSHYFA8C
         tnxW/0ZZgB4yv4pZtYIJ+eYDI5WCiZOJy21MxaRB487v67AGTT49y03xYmvPBeWFRCEW
         1zL2AChmugwOJZfa9ay8xso66jqQuST2VWJFuVC7xKjsFCQ4MtLgiUd+VchjGiI6TyLr
         DDQkSaXxhI0o5Sr4NIMSy3aHxZ0bHNaZEd9zjsOmX4e8CpHNoP6vPX/iXTIVTQNpMUS0
         WNFQ==
X-Gm-Message-State: APjAAAWSUHgN7iB1uOG/9CjhDtEvuoVKwJeBQqRE/t4Nb382FdjAFhCi
        ExFrdCEP+egD+vIJV+NNeOIt4EXgW528GUjDVBisypDnpHe/LlRb6MWmF+B0XOvEf/5RChdzBmo
        SDG/Z10QZusvJK00gXPBlFYPtqVUMGzkmqJM9msMUp8v9vuoUkWnuu5HkhRvutEuyl2kK40beaw
        ==
X-Google-Smtp-Source: APXvYqxEogkbk/mzOV41hgrSAaqy6dt3D5QlnB3LQAZ9lpXIB0vHWwwUekIDiZEuewiIMNhEbtR5g+qsnJf+ho/i+MY=
X-Received: by 2002:a63:551a:: with SMTP id j26mr21854138pgb.370.1575945230563;
 Mon, 09 Dec 2019 18:33:50 -0800 (PST)
Date:   Mon,  9 Dec 2019 18:33:29 -0800
Message-Id: <20191210023335.49987-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 0/6] configuration-based hook management
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An implementation of the first piece of the proposal given in
lore.kernel.org/git/20191116011125.GG22855@google.com.

Teaches a new command, 'git hook', which will someday include 'git hook
--add ...', 'git hook --edit ...', and maybe more. For now, just teach
it how to check the config files with 'git hook --list ...'.

The hooks-to-run list is collected in a new library, hook.o, which can
someday reimplement find_hook() or otherwise be invoked to run all hooks
for a given hookname (e.g. "pre-commit").

The change to config.[ch] allows us to display a similar scope name to
the one a user may use to 'git config --add' or later 'git hook --add' a
hook at a certain scope, e.g.:

  $ git hook --list pre-commit
  001	global	~/foo.sh
  $ git hook --add --global pre-commit 005 ~/bar.sh
  Added.
  001	global	~/foo.sh
  005	global	~/bar.sh

There are config examples in many of the commit messages in this chain.

Before I consider "--list" to be done, I also want to add support to
check "hook.runHookDir" and take .git/hooks/* into account. But I wanted
us to spend time chewing on the config format for a while before I got
too far.

It's also very possible (likely, even!) to put this feature behind an
experimental flag, which gives us more room to change the config format
if we want before the feature is "done".

In the discussion thread with brian, I also mentioned a self-paced
deprecation of hooks which live in .git/hooks/, which I'm aware some
users may not want to follow. However, it occurred to me that we may be
able to hide a Git-paced deprecation behind a config macro (since those
are new and shiny) which is opt-in, and handles something like:

  hook.runHookDir = true
  hook.warnHookDir = false

  {some months pass, we are sure config-based hooks are working nicely}

  hook.runHookDir = true
  hook.warnHookDir = true

  {so start yelling at users to move away, and wait some more
  months/years}

  hook.runHookDir = false

  {users who have opted into the hookdir phaseout macro are no longer
  using the hookdir}

As it's opt-in (and easily reversible by changing configs) this might be
a good middle ground for the "deprecate or not" discussion brian and I
had.

Thanks.
 - Emily

Emily Shaffer (6):
  hook: scaffolding for git-hook subcommand
  config: add string mapping for enum config_scope
  hook: add --list mode
  hook: support reordering of hook list
  hook: remove prior hook with '---'
  hook: teach --porcelain mode

 .gitignore                    |  1 +
 Documentation/git-hook.txt    | 53 ++++++++++++++++++++
 Makefile                      |  2 +
 builtin.h                     |  1 +
 builtin/hook.c                | 80 ++++++++++++++++++++++++++++++
 config.c                      | 17 +++++++
 config.h                      |  1 +
 git.c                         |  1 +
 hook.c                        | 93 +++++++++++++++++++++++++++++++++++
 hook.h                        | 14 ++++++
 t/t1360-config-based-hooks.sh | 89 +++++++++++++++++++++++++++++++++
 11 files changed, 352 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.24.0.393.g34dc348eaf-goog

