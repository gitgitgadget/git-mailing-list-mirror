Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB185C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbiBYQnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbiBYQnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:43:18 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434091592AB
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:42:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a23so11975479eju.3
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=625NB83UkT5IW6KzFGqYQv2gTTyuqkolBTVfOVIHck0=;
        b=Jao6fs2vwsZNdq+539yq8QFPC6mquMpPRlDqSvv8upre+jdkq5pCc988df19YOG/pp
         2wAx8JhqQ49GcnHtsYmkAe2RGv2FT8JZltSg43hLEL1lH1lCAp5VVnA2xQ6c/1LcjbUB
         TxiMlIRmVjnFoZLBFudJNGDPDKB0hemEk1thM7xn/J8EO8YI/OYds2alXTvks+QxDAmo
         OyPA0ONUVTqJ5qsWyq8TboAueeKplyqVItFZ5zaKNFY+toIcuwTEtpd45V/9+GDaD1pS
         eDuINjburMU42S03nJImTiaZLgjbYREFBuzQey20DxnlIvEn+XAIpXW8BgMyQt7djBkT
         PVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=625NB83UkT5IW6KzFGqYQv2gTTyuqkolBTVfOVIHck0=;
        b=OB3Vuk026Sma+VSwKouIk9aQNGPGZGkPUWJ6Ph8B33pawSS9mt4oyFdIk8C/PfGd9I
         Pv+jcxav0rGaCYabgZxER//2IUkYtrxCRBesRX4/CWCsZgJjyC4sPFYaAJaeIqKXuWVC
         Pvt2cjDDPhQANeuiqdAp3UAcIFnP0CL41Ggcf9yXO/O8n7RpzF/Tlz8YGVHqL4Rb8LFb
         cUoEvCu5r+CnCG6tEzM5J5lpzjBeEDquSrhsxcOAOj1WT9Qf0u97Pqy4xMgqqUvqIBc7
         DH/ki8wIWaJZ6txOwkF982S7NPTAUaIMGzIn/GTRFr/To4rLHwWsUJ8Ek1ahV81nrVoO
         tctA==
X-Gm-Message-State: AOAM532OMDvTtExDKQIdVYjBY61bss3eIb4lXsy+4VWxFm4d0ofcgIR+
        7G6H0+sjVVb1rKPTigJOmG4=
X-Google-Smtp-Source: ABdhPJy5WapB5K2iWVUn0ewkiLrZmlu2RIbSnCHTXAXJ45N5xUAJfXrgVDH99Zmbvr/cu+pHI48BgA==
X-Received: by 2002:a17:906:3905:b0:6cf:7ef5:fee0 with SMTP id f5-20020a170906390500b006cf7ef5fee0mr6600842eje.307.1645807357087;
        Fri, 25 Feb 2022 08:42:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906341700b006ce41e20023sm1172106ejb.173.2022.02.25.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:42:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNdfv-000efa-Mp;
        Fri, 25 Feb 2022 17:42:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Date:   Fri, 25 Feb 2022 17:39:43 +0100
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
 <220221.86a6ejakun.gmgdl@evledraar.gmail.com>
 <CABPp-BHmU8-a+McANE2bdAndGEtVudr74FHEEj6K6NwYECEZ6Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202221311480.11118@tvgsbejvaqbjf.bet>
 <220222.8635kb832w.gmgdl@evledraar.gmail.com>
 <YhVuCfDgFF/K5Gtl@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YhVuCfDgFF/K5Gtl@google.com>
Message-ID: <220225.86r17q7v9g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Jonathan Nieder wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> To a first approximation what makes it core.* is that we have a
>> core.sparseCheckout.
> [...]
>> Anyway, as noted (and I feel I have to comment as the originator of this
>> thread) I think the bikeshedding about namespacing is less important
>> than making sure from a user perspective that these are discoverable.
>
> Agreed.  Though there's already also advice.updateSparsePath; even
> though I suspect that ctrl+F for "sparse" is what people may already
> be using in practice, a pointer from the git-sparse-checkout(1) page
> would be welcome.
>
>> E.g. core.sshCommand doesn't reference ssh.variant or the other way
>> around, and in my "man git-config" they're at ~25% and ~90% in to what's
>> now a *huge* document. You need to read the whole thing or have the
>> foresight to search through it to discover both.
>>
>> So for core.sshCommand and ssh.variant, and core.sparse* and sparse.*
>> cross-linking etc. would go a long way...
>
> Agreed as well.
>
>> Aside: I do have some local patches (waiting on a couple of other things
>> I have outstanding) to add a "CONFIGURATION" section to all of the
>> built-in commands with some including/splitting up of
>> Documentation/config**.txt, so "man git-sparse-checkout" would have a
>> section listing the subset of "git-config" applicable to the command.
>
> Oh!  I was about to do a quick patch for git-sparse-checkout.txt, but
> this is even better, so I think I'll wait for you to send those. :)

I think if you're interested in fixing just that case you shouldn't let
me stop you.

The thing I have is currently dependant on [1], so a review would speed
it up. I.e. needing to create new sub-dirs in Documentation/config that
we lint etc. needs some of those Makefile bits (or rather, is a lot
easier with them).

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20211224T173558Z-av=
arab@gmail.com/

The diff for the ad-hoc series I have following that locally follows, to
give you some idea.

I hacked it up before there was git-sparse*, so if I submit it I'd
revisit that, and I think even for the below I stopped at some point and
would need to finish it.

 Documentation/Makefile                             |   2 +
 Documentation/config/color.txt                     | 155 ++---------------=
----
 Documentation/config/color/blame.txt               |  22 +++
 Documentation/config/color/branch.txt              |  13 ++
 Documentation/config/color/diff.txt                |  27 ++++
 Documentation/config/color/grep.txt                |  70 ++++++++++
 Documentation/config/color/log.txt                 |   9 ++
 Documentation/config/color/push.txt                |   8 ++
 Documentation/config/color/showbranch.txt          |   6 +
 Documentation/config/color/status.txt              |  20 +++
 Documentation/config/core.txt                      |  13 +-
 Documentation/config/core/bigFileThreshold.txt     |  12 ++
 Documentation/config/diff.txt                      |  15 --
 Documentation/config/diff/difftool.txt             |  14 ++
 Documentation/config/difftool.txt                  |   7 +
 Documentation/config/gc.txt                        |  12 +-
 Documentation/config/gc/rerere.txt                 |  11 ++
 Documentation/config/grep.txt                      |   7 +-
 Documentation/config/log.txt                       |  18 ++-
 Documentation/config/notes.txt                     |  43 +++---
 Documentation/config/sendemail.txt                 |  40 +++++-
 Documentation/config/uploadpack.txt                |  26 +---
 Documentation/config/uploadpack/pack-objects.txt   |  25 ++++
 Documentation/git-add.txt                          |   7 +
 Documentation/git-am.txt                           |   7 +
 Documentation/git-apply.txt                        |  10 +-
 Documentation/git-blame.txt                        |  10 ++
 Documentation/git-branch.txt                       |   6 +
 Documentation/git-checkout.txt                     |   7 +
 Documentation/git-clean.txt                        |   7 +
 Documentation/git-clone.txt                        |   9 ++
 Documentation/git-commit-graph.txt                 |   8 ++
 Documentation/git-commit.txt                       |   4 +
 Documentation/git-credential.txt                   |   7 +
 Documentation/git-diff.txt                         |   9 ++
 Documentation/git-difftool.txt                     |  28 +---
 Documentation/git-fast-import.txt                  |   7 +
 Documentation/git-fetch.txt                        |   9 ++
 Documentation/git-gc.txt                           |  14 +-
 Documentation/git-grep.txt                         |  29 +---
 Documentation/git-log.txt                          |  50 ++-----
 Documentation/git-mergetool.txt                    |   3 +
 Documentation/git-notes.txt                        |  54 +------
 Documentation/git-pack-objects.txt                 |   8 +-
 Documentation/git-remote.txt                       |  15 +-
 Documentation/git-repack.txt                       |  19 +--
 Documentation/git-rerere.txt                       |   9 ++
 Documentation/git-reset.txt                        |   7 +
 Documentation/git-send-email.txt                   |  36 +----
 Documentation/git-show-branch.txt                  |   7 +
 Documentation/githooks.txt                         |   4 +
 Documentation/includes/cmd-config-section-all.txt  |   3 +
 Documentation/includes/cmd-config-section-rest.txt |   3 +
 .../templates/configuration-include-pack.txt       |  10 ++
 builtin/help.c                                     |   2 +-
 builtin/log.c                                      |   3 +-
 generate-configlist.sh                             |   2 +-
 t/t4207-log-decoration-colors.sh                   |  12 +-
 58 files changed, 544 insertions(+), 456 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1eb9192dae8..15b71f24735 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -50,7 +50,9 @@ MAN7_TXT +=3D gitworkflows.txt
 HOWTO_TXT +=3D $(wildcard howto/*.txt)
=20
 DOC_DEP_TXT +=3D $(wildcard *.txt)
+DOC_DEP_TXT +=3D $(wildcard includes/*.txt)
 DOC_DEP_TXT +=3D $(wildcard config/*.txt)
+DOC_DEP_TXT +=3D $(wildcard config/*/*.txt)
=20
 ifdef MAN_FILTER
 MAN_TXT =3D $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 1795b2d16be..4ca476b99ac 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -8,113 +8,15 @@ color.advice::
 color.advice.hint::
 	Use customized color for hints.
=20
-color.blame.highlightRecent::
-	Specify the line annotation color for `git blame --color-by-age`
-	depending upon the age of the line.
-+
-This setting should be set to a comma-separated list of color and
-date settings, starting and ending with a color, the dates should be
-set from oldest to newest. The metadata will be colored with the
-specified colors if the line was introduced before the given
-timestamp, overwriting older timestamped colors.
-+
-Instead of an absolute timestamp relative timestamps work as well,
-e.g. `2.weeks.ago` is valid to address anything older than 2 weeks.
-+
-It defaults to `blue,12 month ago,white,1 month ago,red`, which
-colors everything older than one year blue, recent changes between
-one month and one year old are kept white, and lines introduced
-within the last month are colored red.
-
-color.blame.repeatedLines::
-	Use the specified color to colorize line annotations for
-	`git blame --color-lines`, if they come from the same commit as the
-	preceding line. Defaults to cyan.
-
-color.branch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.branch.<slot>::
-	Use customized color for branch coloration. `<slot>` is one of
-	`current` (the current branch), `local` (a local branch),
-	`remote` (a remote-tracking branch in refs/remotes/),
-	`upstream` (upstream tracking branch), `plain` (other
-	refs).
-
-color.diff::
-	Whether to use ANSI escape sequences to add color to patches.
-	If this is set to `always`, linkgit:git-diff[1],
-	linkgit:git-log[1], and linkgit:git-show[1] will use color
-	for all patches.  If it is set to `true` or `auto`, those
-	commands will only use color when output is to the terminal.
-	If unset, then the value of `color.ui` is used (`auto` by
-	default).
-+
-This does not affect linkgit:git-format-patch[1] or the
-'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
-command line with the `--color[=3D<when>]` option.
-
-color.diff.<slot>::
-	Use customized color for diff colorization.  `<slot>` specifies
-	which part of the patch to use the specified color, and is one
-	of `context` (context text - `plain` is a historical synonym),
-	`meta` (metainformation), `frag`
-	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), `whitespace`
-	(highlighting whitespace errors), `oldMoved` (deleted lines),
-	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
-	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
-	`newMovedAlternativeDimmed` (See the '<mode>'
-	setting of '--color-moved' in linkgit:git-diff[1] for details),
-	`contextDimmed`, `oldDimmed`, `newDimmed`, `contextBold`,
-	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
-
-color.decorate.<slot>::
-	Use customized color for 'git log --decorate' output.  `<slot>` is one
-	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively
-	and `grafted` for grafted commits.
-
-color.grep::
-	When set to `always`, always highlight matches.  When `false` (or
-	`never`), never.  When set to `true` or `auto`, use color only
-	when the output is written to the terminal.  If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.grep.<slot>::
-	Use customized color for grep colorization.  `<slot>` specifies which
-	part of the line to use the specified color, and is one of
-+
---
-`context`;;
-	non-matching text in context lines (when using `-A`, `-B`, or `-C`)
-`filename`;;
-	filename prefix (when not using `-h`)
-`function`;;
-	function name lines (when using `-p`)
-`lineNumber`;;
-	line number prefix (when using `-n`)
-`column`;;
-	column number prefix (when using `--column`)
-`match`;;
-	matching text (same as setting `matchContext` and `matchSelected`)
-`matchContext`;;
-	matching text in context lines
-`matchSelected`;;
-	matching text in selected lines. Also, used to customize the following
-	linkgit:git-log[1] subcommands: `--grep`, `--author` and `--committer`.
-`selected`;;
-	non-matching text in selected lines. Also, used to customize the
-	following linkgit:git-log[1] subcommands: `--grep`, `--author` and
-	`--committer`.
-`separator`;;
-	separators between fields on a line (`:`, `-`, and `=3D`)
-	and between hunks (`--`)
---
+include::color/blame.txt[]
+
+include::color/branch.txt[]
+
+include::color/diff.txt[]
+
+include::color/log.txt[]
+
+include::color/grep.txt[]
=20
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
@@ -135,14 +37,7 @@ color.pager::
 	output going to the pager. Defaults to true; set this to false
 	if your pager does not understand ANSI color codes.
=20
-color.push::
-	A boolean to enable/disable color in push errors. May be set to
-	`always`, `false` (or `never`) or `auto` (or `true`), in which
-	case colors are used only when the error output goes to a terminal.
-	If unset, then the value of `color.ui` is used (`auto` by default).
-
-color.push.error::
-	Use customized color for push errors.
+include::color/push.txt[]
=20
 color.remote::
 	If set, keywords at the start of the line are highlighted. The
@@ -156,33 +51,9 @@ color.remote.<slot>::
 	`hint`, `warning`, `success` or `error` which match the
 	corresponding keyword.
=20
-color.showBranch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-show-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.status::
-	A boolean to enable/disable color in the output of
-	linkgit:git-status[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
-
-color.status.<slot>::
-	Use customized color for status colorization. `<slot>` is
-	one of `header` (the header text of the status message),
-	`added` or `updated` (files which are added but not committed),
-	`changed` (files which are changed but not added in the index),
-	`untracked` (files which are not tracked by Git),
-	`branch` (the current branch),
-	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red),
-	`localBranch` or `remoteBranch` (the local and remote branch names,
-	respectively, when branch and tracking information is displayed in the
-	status short-format), or
-	`unmerged` (files which have unmerged changes).
+include::color/showbranch.txt[]
+
+include::color/status.txt[]
=20
 color.transport::
 	A boolean to enable/disable color when pushes are rejected. May be
diff --git a/Documentation/config/color/blame.txt b/Documentation/config/co=
lor/blame.txt
new file mode 100644
index 00000000000..423290c597b
--- /dev/null
+++ b/Documentation/config/color/blame.txt
@@ -0,0 +1,22 @@
+color.blame.highlightRecent::
+	Specify the line annotation color for `git blame --color-by-age`
+	depending upon the age of the line.
++
+This setting should be set to a comma-separated list of color and
+date settings, starting and ending with a color, the dates should be
+set from oldest to newest. The metadata will be colored with the
+specified colors if the line was introduced before the given
+timestamp, overwriting older timestamped colors.
++
+Instead of an absolute timestamp relative timestamps work as well,
+e.g. `2.weeks.ago` is valid to address anything older than 2 weeks.
++
+It defaults to `blue,12 month ago,white,1 month ago,red`, which
+colors everything older than one year blue, recent changes between
+one month and one year old are kept white, and lines introduced
+within the last month are colored red.
+
+color.blame.repeatedLines::
+	Use the specified color to colorize line annotations for
+	`git blame --color-lines`, if they come from the same commit as the
+	preceding line. Defaults to cyan.
diff --git a/Documentation/config/color/branch.txt b/Documentation/config/c=
olor/branch.txt
new file mode 100644
index 00000000000..30bf0c3d108
--- /dev/null
+++ b/Documentation/config/color/branch.txt
@@ -0,0 +1,13 @@
+color.branch::
+	A boolean to enable/disable color in the output of
+	linkgit:git-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
+color.branch.<slot>::
+	Use customized color for branch coloration. `<slot>` is one of
+	`current` (the current branch), `local` (a local branch),
+	`remote` (a remote-tracking branch in refs/remotes/),
+	`upstream` (upstream tracking branch), `plain` (other
+	refs).
diff --git a/Documentation/config/color/diff.txt b/Documentation/config/col=
or/diff.txt
new file mode 100644
index 00000000000..609c7a5ca91
--- /dev/null
+++ b/Documentation/config/color/diff.txt
@@ -0,0 +1,27 @@
+color.diff::
+	Whether to use ANSI escape sequences to add color to patches.
+	If this is set to `always`, linkgit:git-diff[1],
+	linkgit:git-log[1], and linkgit:git-show[1] will use color
+	for all patches.  If it is set to `true` or `auto`, those
+	commands will only use color when output is to the terminal.
+	If unset, then the value of `color.ui` is used (`auto` by
+	default).
++
+This does not affect linkgit:git-format-patch[1] or the
+'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
+command line with the `--color[=3D<when>]` option.
+
+color.diff.<slot>::
+	Use customized color for diff colorization.  `<slot>` specifies
+	which part of the patch to use the specified color, and is one
+	of `context` (context text - `plain` is a historical synonym),
+	`meta` (metainformation), `frag`
+	(hunk header), 'func' (function in hunk header), `old` (removed lines),
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `oldMoved` (deleted lines),
+	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
+	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
+	`newMovedAlternativeDimmed` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details),
+	`contextDimmed`, `oldDimmed`, `newDimmed`, `contextBold`,
+	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
diff --git a/Documentation/config/color/grep.txt b/Documentation/config/col=
or/grep.txt
new file mode 100644
index 00000000000..390838450b3
--- /dev/null
+++ b/Documentation/config/color/grep.txt
@@ -0,0 +1,70 @@
+color.diff::
+	Whether to use ANSI escape sequences to add color to patches.
+	If this is set to `always`, linkgit:git-diff[1],
+	linkgit:git-log[1], and linkgit:git-show[1] will use color
+	for all patches.  If it is set to `true` or `auto`, those
+	commands will only use color when output is to the terminal.
+	If unset, then the value of `color.ui` is used (`auto` by
+	default).
++
+This does not affect linkgit:git-format-patch[1] or the
+'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
+command line with the `--color[=3D<when>]` option.
+
+color.diff.<slot>::
+	Use customized color for diff colorization.  `<slot>` specifies
+	which part of the patch to use the specified color, and is one
+	of `context` (context text - `plain` is a historical synonym),
+	`meta` (metainformation), `frag`
+	(hunk header), 'func' (function in hunk header), `old` (removed lines),
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `oldMoved` (deleted lines),
+	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
+	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
+	`newMovedAlternativeDimmed` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details),
+	`contextDimmed`, `oldDimmed`, `newDimmed`, `contextBold`,
+	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
+
+color.decorate.<slot>::
+	Use customized color for 'git log --decorate' output.  `<slot>` is one
+	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
+	branches, remote-tracking branches, tags, stash and HEAD, respectively
+	and `grafted` for grafted commits.
+
+color.grep::
+	When set to `always`, always highlight matches.  When `false` (or
+	`never`), never.  When set to `true` or `auto`, use color only
+	when the output is written to the terminal.  If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
+color.grep.<slot>::
+	Use customized color for grep colorization.  `<slot>` specifies which
+	part of the line to use the specified color, and is one of
++
+--
+`context`;;
+	non-matching text in context lines (when using `-A`, `-B`, or `-C`)
+`filename`;;
+	filename prefix (when not using `-h`)
+`function`;;
+	function name lines (when using `-p`)
+`lineNumber`;;
+	line number prefix (when using `-n`)
+`column`;;
+	column number prefix (when using `--column`)
+`match`;;
+	matching text (same as setting `matchContext` and `matchSelected`)
+`matchContext`;;
+	matching text in context lines
+`matchSelected`;;
+	matching text in selected lines. Also, used to customize the following
+	linkgit:git-log[1] subcommands: `--grep`, `--author` and `--committer`.
+`selected`;;
+	non-matching text in selected lines. Also, used to customize the
+	following linkgit:git-log[1] subcommands: `--grep`, `--author` and
+	`--committer`.
+`separator`;;
+	separators between fields on a line (`:`, `-`, and `=3D`)
+	and between hunks (`--`)
+--
diff --git a/Documentation/config/color/log.txt b/Documentation/config/colo=
r/log.txt
new file mode 100644
index 00000000000..056a027804c
--- /dev/null
+++ b/Documentation/config/color/log.txt
@@ -0,0 +1,9 @@
+color.decorate.<slot>::
+color.logDecorate.<slot>::
+	Use customized color for 'git log --decorate' output.  `<slot>` is one
+	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
+	branches, remote-tracking branches, tags, stash and HEAD, respectively
+	and `grafted` for grafted commits.
++
+The `color.logDecorate` name is preferred to the historical
+`color.decorate.
diff --git a/Documentation/config/color/push.txt b/Documentation/config/col=
or/push.txt
new file mode 100644
index 00000000000..8c5f19d12df
--- /dev/null
+++ b/Documentation/config/color/push.txt
@@ -0,0 +1,8 @@
+color.push::
+	A boolean to enable/disable color in push errors. May be set to
+	`always`, `false` (or `never`) or `auto` (or `true`), in which
+	case colors are used only when the error output goes to a terminal.
+	If unset, then the value of `color.ui` is used (`auto` by default).
+
+color.push.error::
+	Use customized color for push errors.
diff --git a/Documentation/config/color/showbranch.txt b/Documentation/conf=
ig/color/showbranch.txt
new file mode 100644
index 00000000000..af17e085213
--- /dev/null
+++ b/Documentation/config/color/showbranch.txt
@@ -0,0 +1,6 @@
+color.showBranch::
+	A boolean to enable/disable color in the output of
+	linkgit:git-show-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
diff --git a/Documentation/config/color/status.txt b/Documentation/config/c=
olor/status.txt
new file mode 100644
index 00000000000..d37bec5f282
--- /dev/null
+++ b/Documentation/config/color/status.txt
@@ -0,0 +1,20 @@
+color.status::
+	A boolean to enable/disable color in the output of
+	linkgit:git-status[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
+color.status.<slot>::
+	Use customized color for status colorization. `<slot>` is
+	one of `header` (the header text of the status message),
+	`added` or `updated` (files which are added but not committed),
+	`changed` (files which are changed but not added in the index),
+	`untracked` (files which are not tracked by Git),
+	`branch` (the current branch),
+	`nobranch` (the color the 'no branch' warning is shown in, defaulting
+	to red),
+	`localBranch` or `remoteBranch` (the local and remote branch names,
+	respectively, when branch and tracking information is displayed in the
+	status short-format), or
+	`unmerged` (files which have unmerged changes).
diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..6540008f319 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -411,18 +411,7 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
=20
-core.bigFileThreshold::
-	Files larger than this size are stored deflated, without
-	attempting delta compression.  Storing large files without
-	delta compression avoids excessive memory usage, at the
-	slight expense of increased disk usage. Additionally files
-	larger than this size are always treated as binary.
-+
-Default is 512 MiB on all platforms.  This should be reasonable
-for most projects as source code and other text files can still
-be delta compressed, but larger binary media files won't be.
-+
-Common unit suffixes of 'k', 'm', or 'g' are supported.
+include::core/bigFileThreshold.txt[]
=20
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
diff --git a/Documentation/config/core/bigFileThreshold.txt b/Documentation=
/config/core/bigFileThreshold.txt
new file mode 100644
index 00000000000..4eafd44013b
--- /dev/null
+++ b/Documentation/config/core/bigFileThreshold.txt
@@ -0,0 +1,12 @@
+core.bigFileThreshold::
+	Files larger than this size are stored deflated, without
+	attempting delta compression.  Storing large files without
+	delta compression avoids excessive memory usage, at the
+	slight expense of increased disk usage. Additionally files
+	larger than this size are always treated as binary.
++
+Default is 512 MiB on all platforms.  This should be reasonable
+for most projects as source code and other text files can still
+be delta compressed, but larger binary media files won't be.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 32f84838ac1..35a7bf86d77 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -178,21 +178,6 @@ diff.<driver>.cachetextconv::
 	Set this option to true to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
=20
-diff.tool::
-	Controls which diff tool is used by linkgit:git-difftool[1].
-	This variable overrides the value configured in `merge.tool`.
-	The list below shows the valid built-in values.
-	Any other value is treated as a custom diff tool and requires
-	that a corresponding difftool.<tool>.cmd variable is defined.
-
-diff.guitool::
-	Controls which diff tool is used by linkgit:git-difftool[1] when
-	the -g/--gui flag is specified. This variable overrides the value
-	configured in `merge.guitool`. The list below shows the valid
-	built-in values. Any other value is treated as a custom diff tool
-	and requires that a corresponding difftool.<guitool>.cmd variable
-	is defined.
-
 include::../mergetools-diff.txt[]
=20
 diff.indentHeuristic::
diff --git a/Documentation/config/diff/difftool.txt b/Documentation/config/=
diff/difftool.txt
new file mode 100644
index 00000000000..652bc2bd8e1
--- /dev/null
+++ b/Documentation/config/diff/difftool.txt
@@ -0,0 +1,14 @@
+diff.tool::
+	Controls which diff tool is used by linkgit:git-difftool[1].
+	This variable overrides the value configured in `merge.tool`.
+	The list below shows the valid built-in values.
+	Any other value is treated as a custom diff tool and requires
+	that a corresponding difftool.<tool>.cmd variable is defined.
+
+diff.guitool::
+	Controls which diff tool is used by linkgit:git-difftool[1] when
+	the -g/--gui flag is specified. This variable overrides the value
+	configured in `merge.guitool`. The list below shows the valid
+	built-in values. Any other value is treated as a custom diff tool
+	and requires that a corresponding difftool.<guitool>.cmd variable
+	is defined.
diff --git a/Documentation/config/difftool.txt b/Documentation/config/difft=
ool.txt
index 67625944804..dcf6213d31d 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -9,6 +9,13 @@ difftool.<tool>.cmd::
 	file containing the contents of the diff pre-image and 'REMOTE'
 	is set to the name of the temporary file containing the contents
 	of the diff post-image.
++
+See the `--tool=3D<tool>` option linkgit:git-difftool[1] for more details.
=20
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
+
+difftool.trustExitCode::
+	Exit difftool if the invoked diff tool returns a non-zero exit status.
++
+See the `--trust-exit-code` option in linkgit:git-difftool[1] for more det=
ails.
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index c834e07991f..a8873dca580 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -123,14 +123,4 @@ or rebase occurring.  Since these changes are not part=
 of the current
 project most users will want to expire them sooner, which is why the
 default is more aggressive than `gc.reflogExpire`.
=20
-gc.rerereResolved::
-	Records of conflicted merge you resolved earlier are
-	kept for this many days when 'git rerere gc' is run.
-	You can also use more human-readable "1.month.ago", etc.
-	The default is 60 days.  See linkgit:git-rerere[1].
-
-gc.rerereUnresolved::
-	Records of conflicted merge you have not resolved are
-	kept for this many days when 'git rerere gc' is run.
-	You can also use more human-readable "1.month.ago", etc.
-	The default is 15 days.  See linkgit:git-rerere[1].
+include::gc/rerere.txt[]
diff --git a/Documentation/config/gc/rerere.txt b/Documentation/config/gc/r=
erere.txt
new file mode 100644
index 00000000000..6d0544771d8
--- /dev/null
+++ b/Documentation/config/gc/rerere.txt
@@ -0,0 +1,11 @@
+gc.rerereResolved::
+	Records of conflicted merge you resolved earlier are
+	kept for this many days when 'git rerere gc' is run.
+	You can also use more human-readable "1.month.ago", etc.
+	The default is 60 days.  See linkgit:git-rerere[1].
+
+gc.rerereUnresolved::
+	Records of conflicted merge you have not resolved are
+	kept for this many days when 'git rerere gc' is run.
+	You can also use more human-readable "1.month.ago", etc.
+	The default is 15 days.  See linkgit:git-rerere[1].
diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 182edd813a5..e521f20390c 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -17,8 +17,11 @@ grep.extendedRegexp::
 	other than 'default'.
=20
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. If unset (or set to 0), Git will
+	use as many threads as the number of logical cores available.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
=20
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 456eb07800c..12ede8e31b8 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -1,12 +1,11 @@
-log.abbrevCommit::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
-	override this option with `--no-abbrev-commit`.
-
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
 	`--date` option.  See linkgit:git-log[1] for details.
++
+If the format is set to "auto:foo" and the pager is in use, format
+"foo" will be the used for the date format. Otherwise "default" will
+be used.
=20
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
@@ -45,6 +44,11 @@ log.showRoot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
=20
+log.abbrevCommit::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
+	override this option with `--no-abbrev-commit`.
+
 log.showSignature::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--show-signature`.
@@ -53,3 +57,7 @@ log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
 	assume `--no-use-mailmap`. True by default.
++
+The behavior of `log.mailmap` is impacted by the setting of the more
+general 'mailmap.*' configuration variables, i.e. `mailmap.file` and
+`mailmap.blob`.
diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
index aeef56d49ae..c7c4811734b 100644
--- a/Documentation/config/notes.txt
+++ b/Documentation/config/notes.txt
@@ -3,6 +3,9 @@ notes.mergeStrategy::
 	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
 	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
 	section of linkgit:git-notes[1] for more information on each strategy.
++
+This setting can be overridden by passing the `--strategy` option to
+linkgit:git-notes[1].
=20
 notes.<name>.mergeStrategy::
 	Which merge strategy to choose when doing a notes merge into
@@ -11,28 +14,35 @@ notes.<name>.mergeStrategy::
 	linkgit:git-notes[1] for more information on the available strategies.
=20
 notes.displayRef::
-	The (fully qualified) refname from which to show notes when
-	showing commit messages.  The value of this variable can be set
-	to a glob, in which case notes from all matching refs will be
-	shown.  You may also specify this configuration variable
-	several times.  A warning will be issued for refs that do not
-	exist, but a glob that does not match any refs is silently
-	ignored.
+	Which ref (or refs, if a glob or specified more than once), in
+	addition to the default set by `core.notesRef` or
+	`GIT_NOTES_REF`, to read notes from when showing commit
+	messages with the 'git log' family of commands.
 +
 This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
 +
+A warning will be issued for refs that do not exist,
+but a glob that does not match any refs is silently ignored.
++
+This setting can be disabled by the `--no-notes` option to the 'git
+log' family of commands, or by the `--notes=3D<ref>` option accepted by
+those commands.
++
 The effective value of "core.notesRef" (possibly overridden by
 GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
=20
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, Git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
+	`rebase`), if this variable is `false`, git will not copy
+	notes from the original to the rewritten commit.  Defaults to
+	`true`.  See also "`notes.rewriteRef`" below.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
=20
 notes.rewriteMode::
 	When copying notes during a rewrite (see the
@@ -46,14 +56,13 @@ environment variable.
=20
 notes.rewriteRef::
 	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  The ref may be a
-	glob, in which case notes in all matching refs will be copied.
-	You may also specify this configuration several times.
+	qualified) ref whose notes should be copied.  May be a glob,
+	in which case notes in all matching refs will be copied.  You
+	may also specify this configuration several times.
 +
 Does not have a default value; you must configure this variable to
 enable note rewriting.  Set it to `refs/notes/commits` to enable
 rewriting for the default commit notes.
 +
-This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
+Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
+See `notes.rewrite.<command>` above for a further description of its forma=
t.
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/send=
email.txt
index 50baa5d6bfb..51da7088a84 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -18,17 +18,49 @@ sendemail.<identity>.*::
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
=20
+sendemail.multiEdit::
+	If true (default), a single editor instance will be spawned to edit
+	files you have to edit (patches when `--annotate` is used, and the
+	summary when `--compose` is used). If false, files will be edited one
+	after the other, spawning a new editor each time.
+
+sendemail.confirm::
+	Sets the default for whether to confirm before sending. Must be
+	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
+	in the linkgit:git-send-email[1] documentation for the meaning of these
+	values.
+
 sendemail.aliasesFile::
+	To avoid typing long email addresses, point this to one or more
+	email aliases files.  You must also supply `sendemail.aliasFileType`.
+
 sendemail.aliasFileType::
+	Format of the file(s) specified in sendemail.aliasesFile. Must be
+	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
++
+What an alias file in each format looks like can be found in
+the documentation of the email program of the same name. The
+differences and limitations from the standard formats are
+described below:
++
+--
+sendmail;;
+*	Quoted aliases and quoted addresses are not supported: lines that
+	contain a `"` symbol are ignored.
+*	Redirection to a file (`/path/name`) or pipe (`|command`) is not
+	supported.
+*	File inclusion (`:include: /path/name`) is not supported.
+*	Warnings are printed on the standard error output for any
+	explicitly unsupported constructs, and any other lines that are not
+	recognized by the parser.
+--
 sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
 sendemail.ccCmd::
 sendemail.chainReplyTo::
-sendemail.confirm::
 sendemail.envelopeSender::
 sendemail.from::
-sendemail.multiEdit::
 sendemail.signedoffbycc::
 sendemail.smtpPass::
 sendemail.suppresscc::
@@ -44,7 +76,9 @@ sendemail.thread::
 sendemail.transferEncoding::
 sendemail.validate::
 sendemail.xmailer::
-	See linkgit:git-send-email[1] for description.
+	These configuration variables all provide a default for
+	linkgit:git-send-email[1] command-line options. See its
+	documentation for details.
=20
 sendemail.signedoffcc (deprecated)::
 	Deprecated alias for `sendemail.signedoffbycc`.
diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/upl=
oadpack.txt
index 32fad5bbe81..d3e5ce7236d 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -27,31 +27,7 @@ uploadpack.allowAnySHA1InWant::
 	object at all.
 	Defaults to `false`.
=20
-uploadpack.keepAlive::
-	When `upload-pack` has started `pack-objects`, there may be a
-	quiet period while `pack-objects` prepares the pack. Normally
-	it would output progress information, but if `--quiet` was used
-	for the fetch, `pack-objects` will output nothing at all until
-	the pack data begins. Some clients and networks may consider
-	the server to be hung and give up. Setting this option instructs
-	`upload-pack` to send an empty keepalive packet every
-	`uploadpack.keepAlive` seconds. Setting this option to 0
-	disables keepalive packets entirely. The default is 5 seconds.
-
-uploadpack.packObjectsHook::
-	If this option is set, when `upload-pack` would run
-	`git pack-objects` to create a packfile for a client, it will
-	run this shell command instead.  The `pack-objects` command and
-	arguments it _would_ have run (including the `git pack-objects`
-	at the beginning) are appended to the shell command. The stdin
-	and stdout of the hook are treated as if `pack-objects` itself
-	was run. I.e., `upload-pack` will feed input intended for
-	`pack-objects` to the hook, and expects a completed packfile on
-	stdout.
-+
-Note that this configuration variable is ignored if it is seen in the
-repository-level config (this is a safety measure against fetching from
-untrusted repositories).
+include::uploadpack/pack-objects.txt[]
=20
 uploadpack.allowFilter::
 	If this option is set, `upload-pack` will support partial
diff --git a/Documentation/config/uploadpack/pack-objects.txt b/Documentati=
on/config/uploadpack/pack-objects.txt
new file mode 100644
index 00000000000..0447c112811
--- /dev/null
+++ b/Documentation/config/uploadpack/pack-objects.txt
@@ -0,0 +1,25 @@
+uploadpack.keepAlive::
+	When `upload-pack` has started `pack-objects`, there may be a
+	quiet period while `pack-objects` prepares the pack. Normally
+	it would output progress information, but if `--quiet` was used
+	for the fetch, `pack-objects` will output nothing at all until
+	the pack data begins. Some clients and networks may consider
+	the server to be hung and give up. Setting this option instructs
+	`upload-pack` to send an empty keepalive packet every
+	`uploadpack.keepAlive` seconds. Setting this option to 0
+	disables keepalive packets entirely. The default is 5 seconds.
+
+uploadpack.packObjectsHook::
+	If this option is set, when `upload-pack` would run
+	`git pack-objects` to create a packfile for a client, it will
+	run this shell command instead.  The `pack-objects` command and
+	arguments it _would_ have run (including the `git pack-objects`
+	at the beginning) are appended to the shell command. The stdin
+	and stdout of the hook are treated as if `pack-objects` itself
+	was run. I.e., `upload-pack` will feed input intended for
+	`pack-objects` to the hook, and expects a completed packfile on
+	stdout.
++
+Note that this configuration variable is ignored if it is seen in the
+repository-level config (this is a safety measure against fetching from
+untrusted repositories).
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 11eb70f16c7..36da8bf9b51 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -431,6 +431,13 @@ they will make the patch impossible to apply:
 * deleting context or removal lines
 * modifying the contents of context or removal lines
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/add.txt[]
+
 SEE ALSO
 --------
 linkgit:git-status[1]
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 09107fb1067..7ccb46b660c 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -261,6 +261,13 @@ This command can run `applypatch-msg`, `pre-applypatch=
`,
 and `post-applypatch` hooks.  See linkgit:githooks[5] for more
 information.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/am.txt[]
+
 SEE ALSO
 --------
 linkgit:git-apply[1].
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b6d77f42068..1d478cbe9b5 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -263,13 +263,9 @@ has no effect when `--index` or `--cached` is in use.
 CONFIGURATION
 -------------
=20
-apply.ignoreWhitespace::
-	Set to 'change' if you want changes in whitespace to be ignored by defaul=
t.
-	Set to one of: no, none, never, false if you want changes in
-	whitespace to be significant.
-apply.whitespace::
-	When no `--whitespace` flag is given from the command
-	line, this configuration item is used as the default.
+include::includes/cmd-config-section-all.txt[]
+
+include::config/apply.txt[]
=20
 SUBMODULES
 ----------
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index d7a46cc6744..67942b6964d 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -242,6 +242,16 @@ MAPPING AUTHORS
 See linkgit:gitmailmap[5].
=20
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/blame.txt[]
+
+include::config/color/blame.txt[]
+
+
 SEE ALSO
 --------
 linkgit:git-annotate[1]
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c8b4f9ce3c7..601a84451ed 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -332,6 +332,12 @@ CONFIGURATION
 `--list` is used or implied. The default is to use a pager.
 See linkgit:git-config[1].
=20
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/branch.txt[]
+
+include::config/color/branch.txt[]
+
 EXAMPLES
 --------
=20
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9f37e22e130..4cb9d555b4b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -600,6 +600,13 @@ $ edit frotz
 $ git add frotz
 ------------
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/checkout.txt[]
+
 SEE ALSO
 --------
 linkgit:git-switch[1],
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a7f309dff5a..91742633fa8 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -133,6 +133,13 @@ help::
=20
   Show brief usage of interactive git-clean.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/clean.txt[]
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 984d194934f..7547cbd5266 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -358,6 +358,15 @@ $ cd my-linux
 $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 ------------
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/init.txt[]
+
+include::config/clone.txt[]
+
=20
 GIT
 ---
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-=
graph.txt
index e1f48c95b3c..c8143e9a3ba 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -143,6 +143,14 @@ $ git rev-parse HEAD | git commit-graph write --stdin-=
commits --append
 ------------------------------------------------
=20
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/commitgraph.txt[]
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6c60bf98f9f..225c6c9f2e5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -557,6 +557,10 @@ The editor used to edit the commit log message will be=
 chosen from the
 `VISUAL` environment variable, or the `EDITOR` environment variable (in th=
at
 order).  See linkgit:git-var[1] for details.
=20
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/commit.txt[]
+
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
diff --git a/Documentation/git-credential.txt b/Documentation/git-credentia=
l.txt
index f18673017f5..d80d9f671f9 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -160,6 +160,13 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/credential.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 6236c75c9b8..c9f39225fb1 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -213,6 +213,15 @@ $ git diff -R                          <2>
     rewrites (very expensive).
 <2> Output diff in reverse.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/diff.txt[]
+
+include::config/color/diff.txt[]
+
 SEE ALSO
 --------
 diff(1),
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 143b0c49d73..9f6fae615a4 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -113,33 +113,17 @@ instead.  `--no-symlinks` is the default on Windows.
=20
 See linkgit:git-diff[1] for the full list of supported options.
=20
-CONFIG VARIABLES
-----------------
+CONFIGURATION
+-------------
+
 'git difftool' falls back to 'git mergetool' config variables when the
 difftool equivalents have not been defined.
=20
-diff.tool::
-	The default diff tool to use.
-
-diff.guitool::
-	The default diff tool to use when `--gui` is specified.
+include::includes/cmd-config-section-rest.txt[]
=20
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
-difftool.<tool>.cmd::
-	Specify the command to invoke the specified diff tool.
-+
-See the `--tool=3D<tool>` option above for more details.
+include::config/diff/difftool.txt[]
=20
-difftool.prompt::
-	Prompt before each invocation of the diff tool.
-
-difftool.trustExitCode::
-	Exit difftool if the invoked diff tool returns a non-zero exit status.
-+
-See the `--trust-exit-code` option above for more details.
+include::config/difftool.txt[]
=20
 SEE ALSO
 --------
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index 39cfa05b28b..8b5dd6add00 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1564,6 +1564,13 @@ operator can use this facility to peek at the object=
s and refs from an
 import in progress, at the cost of some added running time and worse
 compression.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/fastimport.txt[]
+
 SEE ALSO
 --------
 linkgit:git-fast-export[1]
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 550c16ca616..3c66dd584ff 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -285,6 +285,15 @@ linkgit:git-gc[1]).
=20
 include::transfer-data-leaks.txt[]
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/fetch.txt[]
+
+include::config/remote.txt[]
+
 BUGS
 ----
 Using --recurse-submodules can only fetch new commits in already checked
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 853967dea01..2d2b142058e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -103,14 +103,6 @@ more time, and the resulting space/delta optimization =
may or may not
 be worth it. Not using this at all is the right trade-off for most
 users and their repositories.
=20
-CONFIGURATION
--------------
-
-The below documentation is the same as what's found in
-linkgit:git-config[1]:
-
-include::config/gc.txt[]
-
 NOTES
 -----
=20
@@ -150,6 +142,12 @@ HOOKS
 The 'git gc --auto' command will run the 'pre-auto-gc' hook.  See
 linkgit:githooks[5] for more information.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/gc.txt[]
=20
 SEE ALSO
 --------
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..70f3f7993e7 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -334,34 +334,9 @@ performance in this case, it might be desirable to use=
 `--threads=3D1`.
 CONFIGURATION
 -------------
=20
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
+include::includes/cmd-config-section-all.txt[]
=20
+include::config/grep.txt[]
=20
 GIT
 ---
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e87cecf49..cb66f0a9cac 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -42,6 +42,10 @@ OPTIONS
 	shown. The option `--decorate` is short-hand for `--decorate=3Dshort`.
 	Default to configuration value of `log.decorate` if configured,
 	otherwise, `auto`.
++
+This output may be colored. See `color.ui` in linkgit:git-config[1]
+and `color.logDecorate` (also known as `color.decorate`) there and in
+the "CONFIGURATION" section below.
=20
 --decorate-refs=3D<pattern>::
 --decorate-refs-exclude=3D<pattern>::
@@ -199,47 +203,11 @@ i18n.logOutputEncoding::
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
=20
-log.date::
-	Default format for human-readable dates.  (Compare the
-	`--date` option.)  Defaults to "default", which means to write
-	dates like `Sat May 8 19:35:34 2010 -0500`.
-+
-If the format is set to "auto:foo" and the pager is in use, format
-"foo" will be the used for the date format. Otherwise "default" will
-be used.
-
-log.follow::
-	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
-
-log.showRoot::
-	If `false`, `git log` and related commands will not treat the
-	initial commit as a big creation event.  Any root commits in
-	`git log -p` output would be shown without a diff attached.
-	The default is `true`.
-
-log.showSignature::
-	If `true`, `git log` and related commands will act as if the
-	`--show-signature` option was passed to them.
-
-mailmap.*::
-	See linkgit:git-shortlog[1].
-
-notes.displayRef::
-	Which refs, in addition to the default set by `core.notesRef`
-	or `GIT_NOTES_REF`, to read notes from when showing commit
-	messages with the `log` family of commands.  See
-	linkgit:git-notes[1].
-+
-May be an unabbreviated ref name or a glob and may be specified
-multiple times.  A warning will be issued for refs that do not exist,
-but a glob that does not match any refs is silently ignored.
-+
-This setting can be disabled by the `--no-notes` option,
-overridden by the `GIT_NOTES_DISPLAY_REF` environment variable,
-and overridden by the `--notes=3D<ref>` option.
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/log.txt[]
+
+include::config/notes.txt[]
=20
 GIT
 ---
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.=
txt
index e587c7763a7..5a9d94d3d17 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -101,6 +101,9 @@ success of the resolution after the custom tool has exi=
ted.
=20
 CONFIGURATION
 -------------
+
+include::includes/cmd-config-section-all.txt[]
+
 include::config/mergetool.txt[]
=20
 TEMPORARY FILES
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 0a4200674c4..68d547e2474 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -44,7 +44,7 @@ using the `--notes` option. Such notes are added as a pat=
ch commentary
 after a three dash separator line.
=20
 To change which notes are shown by 'git log', see the
-"notes.displayRef" configuration in linkgit:git-log[1].
+"notes.displayRef" configuration in linkgit:git-config[1].
=20
 See the "notes.rewrite.<command>" configuration for a way to carry
 notes across commands that rewrite commits.
@@ -316,57 +316,9 @@ core.notesRef::
 	This setting can be overridden through the environment and
 	command line.
=20
-notes.mergeStrategy::
-	Which merge strategy to choose by default when resolving notes
-	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
-	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
-	section above for more information on each strategy.
-+
-This setting can be overridden by passing the `--strategy` option.
-
-notes.<name>.mergeStrategy::
-	Which merge strategy to choose when doing a notes merge into
-	refs/notes/<name>.  This overrides the more general
-	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section above
-	for more information on each available strategy.
-
-notes.displayRef::
-	Which ref (or refs, if a glob or specified more than once), in
-	addition to the default set by `core.notesRef` or
-	`GIT_NOTES_REF`, to read notes from when showing commit
-	messages with the 'git log' family of commands.
-	This setting can be overridden on the command line or by the
-	`GIT_NOTES_DISPLAY_REF` environment variable.
-	See linkgit:git-log[1].
-
-notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`), if this variable is `false`, git will not copy
-	notes from the original to the rewritten commit.  Defaults to
-	`true`.  See also "`notes.rewriteRef`" below.
-+
-This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
-environment variable.
+include::includes/cmd-config-section-rest.txt[]
=20
-notes.rewriteMode::
-	When copying notes during a rewrite, what to do if the target
-	commit already has a note.  Must be one of `overwrite`,
-	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
-	`concatenate`.
-+
-This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
-environment variable.
-
-notes.rewriteRef::
-	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  May be a glob,
-	in which case notes in all matching refs will be copied.  You
-	may also specify this configuration several times.
-+
-Does not have a default value; you must configure this variable to
-enable note rewriting.
-+
-Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
+include::config/notes.txt[]
=20
=20
 ENVIRONMENT
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-ob=
jects.txt
index f8344e1e5ba..41042ebcc7d 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -414,12 +414,10 @@ over user-wide config, and so forth).
 CONFIGURATION
 -------------
=20
-Various configuration variables affect packing, see
-linkgit:git-config[1] (search for "pack" and "delta").
+include::templates/configuration-include-pack.txt[]
+
+include::config/uploadpack/pack-objects.txt[]
=20
-Notably, delta compression is not used on objects larger than the
-`core.bigFileThreshold` configuration variable and on files with the
-attribute `delta` set to false.
=20
 SEE ALSO
 --------
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2bebc32566b..03ae8399bae 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -196,13 +196,6 @@ be updated.  (See linkgit:git-config[1]).
 With `--prune` option, run pruning against all the remotes that are update=
d.
=20
=20
-DISCUSSION
-----------
-
-The remote configuration is achieved using the `remote.origin.url` and
-`remote.origin.fetch` configuration variables.  (See
-linkgit:git-config[1]).
-
 EXIT STATUS
 -----------
=20
@@ -255,6 +248,14 @@ $ git remote add -f -t master -m master origin git://e=
xample.com/git.git/
 $ git merge origin
 ------------
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/remote.txt[]
+
+include::config/remotes.txt[]
=20
 SEE ALSO
 --------
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ee30edc178a..893a2a7a281 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -204,22 +204,9 @@ linkgit:git-multi-pack-index[1]).
 CONFIGURATION
 -------------
=20
-Various configuration variables affect packing, see
-linkgit:git-config[1] (search for "pack" and "delta").
-
-By default, the command passes `--delta-base-offset` option to
-'git pack-objects'; this typically results in slightly smaller packs,
-but the generated packs are incompatible with versions of Git older than
-version 1.4.4. If you need to share your repository with such ancient Git
-versions, either directly or via the dumb http protocol, then you
-need to set the configuration variable `repack.UseDeltaBaseOffset` to
-"false" and repack. Access from old Git versions over the native protocol
-is unaffected by this option as the conversion is performed on the fly
-as needed in that case.
-
-Delta compression is not used on objects larger than the
-`core.bigFileThreshold` configuration variable and on files with the
-attribute `delta` set to false.
+include::templates/configuration-include-pack.txt[]
+
+include::config/repack.txt[]
=20
 SEE ALSO
 --------
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 4cfc8833780..1a32ca368c1 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -217,6 +217,15 @@ same as lines with conflict markers, 'git rerere' may =
fail to record a
 conflict resolution.  To work around this, the `conflict-marker-size`
 setting in linkgit:gitattributes[5] can be used.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/rerere.txt[]
+
+include::config/gc.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 6f7685f53d5..a193024d39f 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -499,6 +499,13 @@ working index HEAD target         working index HEAD
=20
 `X` means any state and `U` means an unmerged index.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/reset.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-emai=
l.txt
index 41cd8cb4247..3290043053a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -456,41 +456,9 @@ Information
 CONFIGURATION
 -------------
=20
-sendemail.aliasesFile::
-	To avoid typing long email addresses, point this to one or more
-	email aliases files.  You must also supply `sendemail.aliasFileType`.
+include::includes/cmd-config-section-all.txt[]
=20
-sendemail.aliasFileType::
-	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
-+
-What an alias file in each format looks like can be found in
-the documentation of the email program of the same name. The
-differences and limitations from the standard formats are
-described below:
-+
---
-sendmail;;
-*	Quoted aliases and quoted addresses are not supported: lines that
-	contain a `"` symbol are ignored.
-*	Redirection to a file (`/path/name`) or pipe (`|command`) is not
-	supported.
-*	File inclusion (`:include: /path/name`) is not supported.
-*	Warnings are printed on the standard error output for any
-	explicitly unsupported constructs, and any other lines that are not
-	recognized by the parser.
---
-
-sendemail.multiEdit::
-	If true (default), a single editor instance will be spawned to edit
-	files you have to edit (patches when `--annotate` is used, and the
-	summary when `--compose` is used). If false, files will be edited one
-	after the other, spawning a new editor each time.
-
-sendemail.confirm::
-	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
-	in the previous section for the meaning of these values.
+include::config/sendemail.txt[]
=20
 EXAMPLES
 --------
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-bra=
nch.txt
index 5cc2fcefbab..e5ec6b467f9 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -199,6 +199,13 @@ shows 10 reflog entries going back from the tip as of =
1 hour ago.
 Without `--list`, the output also shows how these tips are
 topologically related with each other.
=20
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/showbranch.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..fa1ebb13dbe 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -702,6 +702,10 @@ SEE ALSO
 --------
 linkgit:git-hook[1]
=20
+The `uploadpack.packObjectsHook` configuration variable can configure
+a hook for linkgit:git-pack-objects[1] to use, but not in a way that
+uses the hook facility discussed above.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/includes/cmd-config-section-all.txt b/Documentat=
ion/includes/cmd-config-section-all.txt
new file mode 100644
index 00000000000..296a239f2ab
--- /dev/null
+++ b/Documentation/includes/cmd-config-section-all.txt
@@ -0,0 +1,3 @@
+Everything below this line in this section is selectively included
+from the linkgit:git-config[1] documentation. The content is the same
+as what's found there:
diff --git a/Documentation/includes/cmd-config-section-rest.txt b/Documenta=
tion/includes/cmd-config-section-rest.txt
new file mode 100644
index 00000000000..fe4721dac76
--- /dev/null
+++ b/Documentation/includes/cmd-config-section-rest.txt
@@ -0,0 +1,3 @@
+The discussion above this line is unique to this documentation, but
+everything below is included from section(s) in linkgit:git-config[1]
+aplicable to this command:
diff --git a/Documentation/templates/configuration-include-pack.txt b/Docum=
entation/templates/configuration-include-pack.txt
new file mode 100644
index 00000000000..fa80f68b658
--- /dev/null
+++ b/Documentation/templates/configuration-include-pack.txt
@@ -0,0 +1,10 @@
+Various configuration variables affect packing. Those variables and
+more are discussed in linkgit:git-config[1].
+
+The below documentation is selectively included from
+linkgit:git-config[1]. It should be all the configuration variables
+relevant to this command, but some may have been missed. When in doubt
+doubt consult linkgit:git-config[1] for the full listing:
+
+include::../config/core/bigFileThreshold.txt[]
+include::../config/pack.txt[]
diff --git a/builtin/help.c b/builtin/help.c
index d387131dd83..d03fc7aaac4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -94,7 +94,7 @@ static void list_config_help(enum show_config_type type)
 	struct slot_expansion slot_expansions[] =3D {
 		{ "advice", "*", list_config_advices },
 		{ "color.branch", "<slot>", list_config_color_branch_slots },
-		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
+		{ "color.logDecorate", "<slot>", list_config_color_decorate_slots },
 		{ "color.diff", "<slot>", list_config_color_diff_slots },
 		{ "color.grep", "<slot>", list_config_color_grep_slots },
 		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
diff --git a/builtin/log.c b/builtin/log.c
index 093d0d26553..3240785a7ee 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -522,7 +522,8 @@ static int git_log_config(const char *var, const char *=
value, void *cb)
 		default_follow =3D git_config_bool(var, value);
 		return 0;
 	}
-	if (skip_prefix(var, "color.decorate.", &slot_name))
+	if (skip_prefix(var, "color.logDecorate.", &slot_name) ||
+	    skip_prefix(var, "color.decorate.", &slot_name))
 		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
 		use_mailmap_config =3D git_config_bool(var, value);
diff --git a/generate-configlist.sh b/generate-configlist.sh
index 8692fe5cf4d..de418d2b8bd 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -7,7 +7,7 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] =3D {
 EOF
-	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/conf=
ig/*.txt |
+	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/conf=
ig/*.txt Documentation/config/*/*.txt|
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
 	sed 's/^.*$/	"&",/'
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colo=
rs.sh
index b8709424981..f125ce4fa7a 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -56,10 +56,16 @@ EOF
 # We want log to show all, but the second parent to refs/stash is irreleva=
nt
 # to this test since it does not contain any decoration, hence --first-par=
ent
 test_expect_success 'Commit Decorations Colored Correctly' '
-	git log --first-parent --abbrev=3D10 --all --decorate --oneline --color=
=3Dalways |
-	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
-	test_decode_color >out &&
+	git log --first-parent --abbrev=3D10 --all --decorate --oneline --color=
=3Dalways >out.raw &&
+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" <out.raw >out.color &&
+	test_decode_color <out.color >out &&
 	test_cmp expected out
 '
=20
+test_expect_success 'color.logDecorate.* is preferred to color.decorate.*'=
 '
+	git config --rename-section color.decorate color.logDecorate &&
+	git log --first-parent --abbrev=3D10 --all --decorate --oneline --color=
=3Dalways >out.raw2 &&
+	test_cmp out.raw out.raw2
+'
+
 test_done
