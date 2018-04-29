Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E771F428
	for <e@80x24.org>; Sun, 29 Apr 2018 16:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbeD2Qm5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 12:42:57 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753927AbeD2Qm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 12:42:56 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue104
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MLyNI-1fIJam0CnE-007oxG; Sun, 29
 Apr 2018 18:42:48 +0200
Date:   Sun, 29 Apr 2018 18:42:43 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180429164232.29337-2-mail@floga.de>
Mail-Followup-To: git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20180429164232.29337-1-mail@floga.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180429164232.29337-1-mail@floga.de>
X-Mailer: git-send-email 2.16.1
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Provags-ID: V03:K1:amypSqIjVu+3jUAVOtJgroqgPecmxZqVR8INCvz/TRsEjU1inX1
 6o51a2a8CAE+F0/HMT3CEaf7Rq7aUBpyBVm2fLFeApNiFo2Ud/48xN99X3eDXqe7Ns06VYy
 gwfICJVB2XXR5R6GjPUFNFeTdmvfMcw0GehH6jT9BNzGPjhCSjYBIV/MSApBFRlXLlpPjY3
 3azZNQoPeB/hFNSeowgVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q/6DbkCYWCY=:z0M1sqeoKUZdLmsKVzkBRH
 wNnIJWF6K2/PHyg8q1CtSU9P6FJC583VzWZpD4cI4UR3/8lAv/6UpBfGg7mGTlZLf2bj/1+17
 Nx/JWBqrKtb8JSmQCzmajLfxfwje9t0zZ8RYc7deXyxmZLiEgzHbbH5J6NbcbrBUos6lcRdin
 E2HxrIDlG8nl6kA7pSjpnlnVCl5tVSx1MFlwv509CrKCVrhK9oQOIefJzQD9PvDySCnpGkRcB
 CE7TtARW/6BjNhdjq+xPPey/Jr0r8f0tUfv6WNdDqpJ3v+YKLlP8Nt4mWssrel+XU8Y4QKV5j
 68fbAWKHMPT/gyDqk5/zLIr6+u9uJ8oci0jMM6Pd4oJrs5CXttZUrOe0sXyuaTqQyMhRjdpck
 uoNu0Y+mYz4YT6s8OmDOr5i9QH1EoQDGE0cFWaomh5xusrvQ2xdlYoQb3l+eyGFF7BmHgc91J
 BWI7LfahLtyMOqCaLKLp0QBsoCJCJ30Zgm86uKjpOG5f53tC6HF4PorA06X20XHxiIRjZ2TXB
 btSfS++3cZeZmPziLEYqGqU7dJ2kXYtnM3wX4r3I4hDNNHeSDjkRlIwHPV/sntL2SasYkDKFE
 8nRzBVn5Em2E7JauJHJlhqJFp6uGUn5scEexcvneWyEnvF30KkXz7MH+25VrjhnvRqogpT+y3
 9z4i1egK5D//ybu2FRp9ZAFfBe7aaHnldNvnIRjvWKV8NNoYSI4GNFtbV4whfS6tl8cc=
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
scripts since v1.90 (preview of v2.0), it is no longer sufficient to
drop a completion script of a subcommand into the standard completions
path, /usr/share/bash-completion/completions, since this script will not
be loaded if called as a git subcommand.

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

I think the easiest method is to use a function that was defined by
bash-completion v1.90, namely _completion_loader. It will take care of
loading the correct script if present. Afterwards, the git completion
script behaves as usual.

_completion_loader was introduced in commit 20c05b43 of bash-completion
(https://github.com/scop/bash-completion.git) back in 2011, so it should
be available in even older LTS distributions. This function searches for
external completion scripts not only in the default path
/usr/share/bash-completion/completions, but also in the user's home
directory via $XDG_DATA_HOME and in a user specified directory via
$BASH_COMPLETION_USER_DIR.

The only "drawback" (if it even can be called as such) is, that if
_completion_loader does not find a completion script, it automatically
registers a minimal function for basic path completion. In practice,
however, this will not matter, because in this case the given command is
a git command in its dashed form, e.g. 'git-diff-index', and those have
been deprecated for a long time.

This way we can leverage bash-completion's dynamic loading for git
subcommands and make it easier for developers to distribute custom
completion scripts.

Signed-off-by: Florian Gamböck <mail@floga.de>
---
 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a236..604ba2b03 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3096,12 +3096,22 @@ __git_main ()
 	fi
 
 	local completion_func="_git_${command//-/_}"
+	if ! declare -f $completion_func >/dev/null 2>/dev/null &&
+		declare -f _completion_loader >/dev/null 2>/dev/null
+	then
+		_completion_loader "git-$command"
+	fi
 	declare -f $completion_func >/dev/null 2>/dev/null && $completion_func && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
+		if ! declare -f $completion_func >/dev/null 2>/dev/null &&
+			declare -f _completion_loader >/dev/null 2>/dev/null
+		then
+			_completion_loader "git-$expansion"
+		fi
 		declare -f $completion_func >/dev/null 2>/dev/null && $completion_func
 	fi
 }
-- 
2.16.1

