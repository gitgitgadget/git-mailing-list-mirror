Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154071F404
	for <e@80x24.org>; Tue, 10 Apr 2018 20:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbeDJU2X (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 16:28:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeDJU2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 16:28:22 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue006
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MQpjt-1etiJR2dG1-00U4jA; Tue, 10
 Apr 2018 22:28:16 +0200
Date:   Tue, 10 Apr 2018 22:28:14 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/1] completion: dynamic completion loading
Message-ID: <20180410202758.5877-1-mail@floga.de>
Mail-Followup-To: git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.16.1
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:W50McxIBeZVaYtEEYiiRmciSKazPX0R3E51OUJ8MFvMh0/FwYoO
 o5iw0kBSiWTQqndtXp6ZTJJY+E2mKTNfQmJdYAxXMXqCWL0tqQbrXuK6OWuzsBhVOdSxJGR
 WbBF9xagyq0E2O0Ae4SjX7hxJA/hZUVeevwGFPPx2aHMuFJTN1EMdJ3w4KVQudSTFxjcj3c
 g6yOHX+IOnhuKY3VdEVCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8U/MQpV951Y=:KUjQuXH9EXD4YeJUHXHCKm
 Y8nNsySkj7wMGBZA4E15O1xsr93/y6yOsFg/xHgQCK3lNY33hUqS0VjZUuDXjT8M/IRXZBL0L
 3C3Uq/QootHNNOmQZXLXx+HgSPXcaqQicwFECIZ2tIhP17zwAomk+ATLZCz55Z/VOTyiOCBJx
 TvZ1GRgRcwLxXLLx9bfLm6mAvtQKEq+Scu0fY1RMexKIat6/7azxB02bkRqowU1c09aMC8+8w
 qq90rkz/2rR14Gx+vVYiNJbziKnjDABFa5Ht6Dl/fas73pIYKawooJDHxbu/2aGn37E3gAZ7p
 zdh0+tZzT6qHWoW2TbOAjjiIkFc+ju5ds8XGWX88H4U68RGGhkxO++O7fUSZESW7lGPtVNmhA
 gJI98bVUJZRrvaay5Df3cBuTMcld3W0H3QHXceJtXjy1u4taEwmIuMwR2H8/dKefGT61Kyi1z
 w/M3VyHaGD7K180fwL8cOKuugMYfuuuy/ihDM9QevezJG4IsjViPgoRaBMcW2T2NRbA5/cn6R
 8M9XiMbKQFwN4eDP+/a2Lig90ndnJSzjUPiYoY+X1KS6JHvO+y0GgXM31yLsNA4u0WCBO7YRG
 u+fo/4jEX8rt5W495ST4GacG6BbbOYdEozXIbtNuxTa+v9ojnEOUz4o+M03w6omH0KnbPFUnO
 jSbtm2ojlQf+oNqx8n++OxTniuTGfHYBiFraWyo/rCB/QyzQ4mjlzNa3QU3zh+X+kwrZpKuXr
 ASfONh+TTBibEqxG1OrN9LZyGvfAGGABAjYIPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this small patch I want to introduce a way to dynamically load completion 
scripts for external subcommands.

A few years ago, you would put a completion script (which defines a Bash 
function _git_foo for a custom git subcommand foo) into 
/etc/bash_completion.d, or save it somewhere in your $HOME and source it 
manually in your .bashrc.

Starting with bash-completion v2.0 (or, to be absolutely exact, the preview 
versions started at v1.90), completion scripts are not sourced at bash startup 
anymore. Rather, when typing in a command and trigger completion by pressing 
the TAB key, the new bash-completion's main script looks for a script with the 
same name as the typed command in the completion directory, sources it, and 
provides the completions defined in this script.

However, that only works for top level commands. After a completion script has 
been found, the logic is delegated to this script. This means, that the 
completion of subcommands must be handled by the corresponding completion 
script.

As it is now, git is perfectly able to call custom completion functions, iff 
they are already defined when calling the git completion. With my patch, git 
uses an already defined loader function of bash-completion (or continues 
silently if this function is not found), loads an external completion script, 
and provides its completions.

An example for an external completion script would be 
/usr/share/bash-completion/completions/git-foo for a git subcommand foo.

Changes since v1 (RFC):

-   Re-arranged if-fi statement to increase readability (suggested by Junio C 
    Hamano)

-   Re-worded commit message to include the exakt version of bashcomp that 
    introduced dynamic loading (suggested by Stefan Beller)

Florian Gamböck (1):
  completion: load completion file for external subcommand

 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.16.1

