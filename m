Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E0F1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 18:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeDHS0Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 14:26:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeDHS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 14:26:15 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue005
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LvxEH-1eQtNw2wCz-017obx; Sun, 08
 Apr 2018 20:26:13 +0200
Date:   Sun, 8 Apr 2018 20:26:08 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 1/1] completion: Load completion file for external
 subcommand
Message-ID: <20180408182552.26289-2-mail@floga.de>
Mail-Followup-To: git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20180408182552.26289-1-mail@floga.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180408182552.26289-1-mail@floga.de>
X-Mailer: git-send-email 2.16.1
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:iVG5I3hYk8AnAGBpmKbXr1VlayCNGvb5OedT4tqF++ECdBs8C9w
 j9is8wZ1xmirQ2V65a67A5KOt7ql1RRz9mQDl/dplzFytnzHRVPzmHlzLssMiZC3tCJcekU
 99DQBSr8G5ZaQMya5cIImYGzAkPwLvUtVb/MR6BKGauwY+QGVvG7OxkrZyMdCtbohS1Swzj
 +ESym5byL6r+luyXJxfNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mEQv6zadIHk=:ACZTZwLsrleWr+vlJv3Jvq
 pYBFut6ZBsP+JUCn/8vPbeBHe4HIkSSjPQke3g8eGigGFmHAR/uIMi7CuwZHhOXzQnsIMv6UN
 C0S1SDAeZ0E7Yj+xkJrOVHN2VFkQyurHGMMe71Et67T12yiCZHGfy/zPp5El5iw0JjPWEdz/v
 Jo4FBfmjc1ZhfBi4w4Sp6/m/8lKd4qikV7174BZjiVaBt95Y+r91QSHhIgZxJFjhebbOAVj++
 9gE5LzR6ecOgpxrvV1O6EAfIVL9NdUBGImckMqs2lmZKXjuuj6GJQjJkYHSBpMKIAEcNTi3/r
 q81nFohF/9BBrhY4YqbLZpBkxkTgI85uAXwAR37d/TRK54zdlta72IdequMxvsOtPBFLMF5gg
 mJFzCYlOTQDzsLHPWSU22akCTrUVkw/B7xLm0SdyiUbIyDh+h4h5IjxLHhCqevYOm4w4PakgP
 aVRPk4B04feez50C6NgW2M7the/nQCzX0FZdrG5fNKr8QPtlSAXEIcaCY4IrAzyLeG4/3O+29
 IBmAwoE/IyGOZ4Haxr0B0LkDC92LLKV2fE0V76yHbtlKVQf1FMbLuilZfn37ZGkWV3NvlcH5q
 f1HffcoFyEOpSLIwDCA+UTnO8a4JQwrrYo74Sa7vBVVUjizVoWGRka8Qo1gdOCgtlckNrbDlW
 xJyG09k/eKEFeRdeGMuRa2aGFRuuEE8AZ7cUrdSWI3VmfE7e/j4LOEuXCnvGtZYCrs3ocucpy
 chNZ+eQ5hTY69pzo46/1IuOlBUx14PUzxZf40Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding external subcommands to Git is as easy as to put an executable
file git-foo into PATH. Packaging such subcommands for a Linux
distribution can be achieved by unpacking the executable into /usr/bin
of the user's system. Adding system-wide completion scripts for new
subcommands, however, can be a bit tricky.

Since bash-completion started to use dynamical loading of completion
scripts somewhere around v2.0, it is no longer sufficient to drop a
completion script of a subcommand into the standard completions path,
/usr/share/bash-completion/completions, since this script will not be
loaded if called as a git subcommand.

For example, look at https://bugs.gentoo.org/544722. To give a short
summary: The popular git-flow subcommand provides a completion script,
which gets installed as /usr/share/bash-completion/completions/git-flow.

If you now type into a Bash shell:

    git flow <TAB>

You will not get any completions, because bash-completion only loads
completions for git and git has no idea that git-flow is defined in
another file. You have to load this script manually or trigger the
dynamic loader with:

    git-flow <TAB> # Please notice the dash instead of whitespace

This will not complete anything either, because it only defines a Bash
function, without generating completions. But now the correct completion
script has been loaded and the first command can use the completions.

So, the goal is now to teach the git completion script to consider the
possibility of external completion scripts for subcommands, but of
course without breaking current workflows.

I think the easiest method is to use a function that is defined by
bash-completion v2.0+, namely __load_completion. It will take care of
loading the correct script if present. Afterwards, the git completion
script behaves as usual.

This way we can leverage bash-completion's dynamic loading for git
subcommands and make it easier for developers to distribute custom
completion scripts.

Signed-off-by: Florian Gamböck <mail@floga.de>
---
 contrib/completion/git-completion.bash | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a236..e6114822c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3096,12 +3096,20 @@ __git_main ()
 	fi
 
 	local completion_func="_git_${command//-/_}"
+	if ! declare -f $completion_func >/dev/null 2>/dev/null; then
+		declare -f __load_completion >/dev/null 2>/dev/null &&
+			__load_completion "git-$command"
+	fi
 	declare -f $completion_func >/dev/null 2>/dev/null && $completion_func && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
+		if ! declare -f $completion_func >/dev/null 2>/dev/null; then
+			declare -f __load_completion >/dev/null 2>/dev/null &&
+				__load_completion "git-$expansion"
+		fi
 		declare -f $completion_func >/dev/null 2>/dev/null && $completion_func
 	fi
 }
-- 
2.16.1

