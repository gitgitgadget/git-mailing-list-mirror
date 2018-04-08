Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D4B1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 18:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeDHS0S (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 14:26:18 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbeDHS0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 14:26:16 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue004
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Mb5Gp-1el5ZN1WO3-00KeDt; Sun, 08
 Apr 2018 20:26:14 +0200
Date:   Sun, 8 Apr 2018 20:26:13 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180408182552.26289-3-mail@floga.de>
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
X-Provags-ID: V03:K1:mTh0rUH94Mvs4ZmXid3J1yUFowq0sndIWsPrhoeJunkXjsWIzz4
 MI8u/blP7hTfwb1ERk0IBnc2kjVuG75kpuU1VkVbUO+oQIjFFzlxw04tIETVvfK3JgfXEZ8
 Um+cS0KAWVfWm2l+Yqve+DJ9AqQE4ZrZYksdnMG5nML3c2RYLNjkNOxHGDOd9p2hd5A5bAH
 c4v2tXIUgQseGGaQ4Gx+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XsKMBrYOnak=:JW9n5yVWqNi0hXBs/BulMX
 t6YFPuNKveH2iGpxg9V6bTVN40TyEX+U+OrN6onrUIsC/dwhzpEs0R59cpPV4iqIrL4swWi0C
 hA3UFnUBMH0qmaoVA0V1+IN1M4QQj5b2iAr27/bclCmTf00NnDrdxi5JvsD+Knwi64uY3A7F9
 qjuirXRA5tEgFyP/othDzHp/KXK/4LNmpmEnL4kkuTPFY/aTtWADyW6WkKpPVU+51BHnCkQ4N
 xW9gAn7LTpCYGFGDBs/71BOZoeE++r7J7x8Qaklm/Al3gCJbrUHA5+RS/EKBJWa+glM+hXn5K
 Zi4d+WlsBtLd2c6iVuArd1dHoQtbYGAeaO77gBYcACwADR6jD6Sa8kEALXca8NElfw0eOxPQn
 jcBLEeNQTZZFKEmMR/geqzR4n7J//IYTJtjKfkT05+KAtuZV2w1tas9fDX7+8oeMNNyhTaHjk
 sZpATSaP6VPTQtvJ6gWj+TVDJj9KkEQnS0JMmP7bU00sqcQktjWWp/M7ce/3Avrb1Y/XxFsnm
 +Kp/V98za5a/ZDJ5ql+7BjXL7Lq2YxLFkz6fHgQantP+j3w9j6EWa5vnLias/BIrm+Cm54rF2
 tQTcO5mVEmqZfGNBr/l/jP8YCvYgZEW3iAIZRW5Ieu31XBGNFvSbUBVcfO+ezYnYkkVDEpYp/
 WHLchHXwLoyLxjjlsrujD40bUgUdVkc+V3PgVIomKbsCrSWGE/in5MCuL3egB/MhkRY6vs6YG
 ZeAPw+LGuIDC3zAxw10BvRgM5hsXbDoJ2961OQ==
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

