Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE86BC43460
	for <git@archiver.kernel.org>; Wed, 19 May 2021 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0CB6124C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 17:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhESR6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 13:58:19 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:37792 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230171AbhESR6S (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 13:58:18 -0400
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 19FA01829CA
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:56:57 +0000 (UTC)
Received: from mailgw-02.dd24.net (100-101-162-48.trex.outbound.svc.cluster.local [100.101.162.48])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 210051831A6
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:56:55 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-02.dd24.net (mailgw-02.dd24.net [193.46.215.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.101.162.48 (trex/6.2.1);
        Wed, 19 May 2021 17:56:56 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Fearful-Befitting: 12985dd366c922f8_1621447016846_3097583897
X-MC-Loop-Signature: 1621447016846:164743433
X-MC-Ingress-Time: 1621447016846
Received: from heisenberg.fritz.box (ppp-46-244-246-192.dynamic.mnet-online.de [46.244.246.192])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id 4D9C15FC25
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:56:54 +0000 (UTC)
Message-ID: <681aefe15af98f6758f28544b96bc2eca90642f3.camel@scientia.net>
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound
 variable
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Git Mailing List <git@vger.kernel.org>
Date:   Wed, 19 May 2021 19:56:53 +0200
In-Reply-To: <xmqqv97nb51b.fsf@gitster.g>
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
         <xmqq4kf7cmaj.fsf@gitster.g> <xmqqzgwzb7ad.fsf@gitster.g>
         <CABPp-BGERNLKbLA_r7i7+r+v7YK6xT00_5n9ebESb2SzLhC0Cg@mail.gmail.com>
         <xmqqv97nb51b.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there.

I think I found another case of an unbound variable:

Completing e.g.:
git commit --[press TAB]

gives:
$ git commit  --bash: GIT_COMPLETION_SHOW_ALL: unbound variable


with some debugging:
$ set -xv
$ git commit --+ __git_func_wrap __git_main
+ local cur words cword prev
+ _get_comp_words_by_ref -n =: cur words cword prev
+ local exclude flag i OPTIND=1
+ words=()
+ local cur cword words
+ upargs=()
+ upvars=()
+ local upargs upvars vcur vcword vprev vwords
+ getopts c:i:n:p:w: flag -n =: cur words cword prev
+ case $flag in
+ exclude==:
+ getopts c:i:n:p:w: flag -n =: cur words cword prev
+ [[ 6 -ge 3 ]]
+ case ${!OPTIND} in
+ vcur=cur
+ (( OPTIND += 1 ))
+ [[ 6 -ge 4 ]]
+ case ${!OPTIND} in
+ vwords=words
+ (( OPTIND += 1 ))
+ [[ 6 -ge 5 ]]
+ case ${!OPTIND} in
+ vcword=cword
+ (( OPTIND += 1 ))
+ [[ 6 -ge 6 ]]
+ case ${!OPTIND} in
+ vprev=prev
+ (( OPTIND += 1 ))
+ [[ 6 -ge 7 ]]
+ __get_cword_at_cursor_by_ref =: words cword cur
+ words=()
+ local cword words
+ __reassemble_comp_words_by_ref =: words cword
+ local exclude i j line ref
+ [[ -n =: ]]
+ exclude='[=:]'
+ printf -v cword %s 2
+ [[ -v exclude ]]
+ line='git commit --'
+ (( i = 0, j = 0 ))
+ (( i < 3 ))
+ [[ 0 -gt 0 ]]
+ ref='words[0]'
+ printf -v 'words[0]' %s git
+ line=' commit --'
+ (( i == COMP_CWORD ))
+ (( i++, j++ ))
+ (( i < 3 ))
+ [[ 1 -gt 0 ]]
+ [[ commit == +([=:]) ]]
+ ref='words[1]'
+ printf -v 'words[1]' %s commit
+ line=' --'
+ (( i == COMP_CWORD ))
+ (( i++, j++ ))
+ (( i < 3 ))
+ [[ 2 -gt 0 ]]
+ [[ -- == +([=:]) ]]
+ ref='words[2]'
+ printf -v 'words[2]' %s --
+ line=
+ (( i == COMP_CWORD ))
+ printf -v cword %s 2
+ (( i++, j++ ))
+ (( i < 3 ))
+ (( i == COMP_CWORD ))
+ local i cur= index=13 'lead=git commit --'
+ [[ 13 -gt 0 ]]
+ [[ -n git commit -- ]]
+ [[ -n gitcommit-- ]]
+ cur='git commit --'
+ (( i = 0 ))
+ (( i <= cword ))
+ [[ 13 -ge 3 ]]
+ [[ git != \g\i\t ]]
+ (( i < cword ))
+ local old_size=13
+ cur=' commit --'
+ local new_size=10
+ (( index -= old_size - new_size ))
+ (( ++i ))
+ (( i <= cword ))
+ [[ 10 -ge 6 ]]
+ [[  commi != \c\o\m\m\i\t ]]
+ cur='commit --'
+ (( index > 0 ))
+ (( index-- ))
+ [[ 9 -ge 6 ]]
+ [[ commit != \c\o\m\m\i\t ]]
+ (( i < cword ))
+ local old_size=9
+ cur=' --'
+ local new_size=3
+ (( index -= old_size - new_size ))
+ (( ++i ))
+ (( i <= cword ))
+ [[ 3 -ge 2 ]]
+ [[  - != \-\- ]]
+ cur=--
+ (( index > 0 ))
+ (( index-- ))
+ [[ 2 -ge 2 ]]
+ [[ -- != \-\- ]]
+ (( i < cword ))
+ (( ++i ))
+ (( i <= cword ))
+ [[ -n -- ]]
+ [[ ! -n -- ]]
+ (( index < 0 ))
+ local words cword cur
+ _upvars -a3 words git commit -- -v cword 2 -v cur --
+ (( 11 ))
+ (( 11 ))
+ case $1 in
+ [[ -n 3 ]]
+ printf %d 3
+ [[ -n words ]]
+ unset -v words
+ eval 'words=("${@:3:3}")'
words=("${@:3:3}")
++ words=("${@:3:3}")
+ shift 5
+ (( 6 ))
+ case $1 in
+ [[ -n cword ]]
+ unset -v cword
+ eval 'cword="$3"'
cword="$3"
++ cword=2
+ shift 3
+ (( 3 ))
+ case $1 in
+ [[ -n cur ]]
+ unset -v cur
+ eval 'cur="$3"'
cur="$3"
++ cur=--
+ shift 3
+ (( 0 ))
+ [[ -v vcur ]]
+ upvars+=("$vcur")
+ upargs+=(-v $vcur "$cur")
+ [[ -v vcword ]]
+ upvars+=("$vcword")
+ upargs+=(-v $vcword "$cword")
+ [[ -v vprev ]]
+ [[ 2 -ge 1 ]]
+ upvars+=("$vprev")
+ upargs+=(-v $vprev "${words[cword - 1]}")
+ [[ -v vwords ]]
+ upvars+=("$vwords")
+ upargs+=(-a${#words[@]} $vwords ${words+"${words[@]}"})
+ (( 4 ))
+ local cur cword prev words
+ _upvars -v cur -- -v cword 2 -v prev commit -a3 words git commit --
+ (( 14 ))
+ (( 14 ))
+ case $1 in
+ [[ -n cur ]]
+ unset -v cur
+ eval 'cur="$3"'
cur="$3"
++ cur=--
+ shift 3
+ (( 11 ))
+ case $1 in
+ [[ -n cword ]]
+ unset -v cword
+ eval 'cword="$3"'
cword="$3"
++ cword=2
+ shift 3
+ (( 8 ))
+ case $1 in
+ [[ -n prev ]]
+ unset -v prev
+ eval 'prev="$3"'
prev="$3"
++ prev=commit
+ shift 3
+ (( 5 ))
+ case $1 in
+ [[ -n 3 ]]
+ printf %d 3
+ [[ -n words ]]
+ unset -v words
+ eval 'words=("${@:3:3}")'
words=("${@:3:3}")
++ words=("${@:3:3}")
+ shift 5
+ (( 0 ))
+ __git_main
+ local i c=1 command __git_dir __git_repo_path
+ local __git_C_args C_args_count=0
+ '[' 1 -lt 2 ']'
+ i=commit
+ case "$i" in
+ command=commit
+ break
+ '[' -z commit ']'
+ __git_complete_command commit
+ local command=commit
+ local completion_func=_git_commit
+ __git_have_func _git_commit
+ declare -f -- _git_commit
+ __git_have_func _git_commit
+ declare -f -- _git_commit
+ _git_commit
+ case "$prev" in
+ case "$cur" in
+ __gitcomp_builtin commit
+ local cmd=commit
+ local incl=
+ local excl=
+ local var=__gitcomp_builtin_commit
+ local options
+ eval 'options=${__gitcomp_builtin_commit-}'
options=${__gitcomp_builtin_commit-}
++ options=
+ '[' -z '' ']'
+ local completion_helper
bash: GIT_COMPLETION_SHOW_ALL: unbound variable

These seem to be in: 
/usr/share/bash-completion/completions/git
and possibly also:
/usr/share/bash-completion/completions/gitk


Cheers,
Chris.

