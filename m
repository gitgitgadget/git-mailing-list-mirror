Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA340EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 18:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGKSlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSle (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 14:41:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB6170A
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 11:41:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so11722104a12.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689100891; x=1691692891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6GHiRCvn5wqOgll7vLac7YWEeKjkGVfhUMbeWt74FS0=;
        b=R5FFU1LTmNj7NqsvZ297nkyzE3AEmxgDrxrnFV99VSZ3JOGVCeFQRSx4vnB48rCCXk
         sSgHWwWa/Ij04QrFPqBSWzPHgI3h6F+/hEFUH98CbVaPpt7bFyBkLPH7jgSAqgWaEdaW
         sG+dxSrHmqIYXb3/XC78hX9LOX1p19ob2p6wzuVmAXI+tmERkfSlyICcAYXEhkJuJgkn
         tkobH0MVtuXP9e2qy83I2uCgGw2rZr+/wlu1AbVjXlfLONTfusxWP7FbTE2lJjKYb67r
         rm1jLUmM50GMu/1kNxLJf9Sc6e1GKJxiMkt9qOsOjZriyXu1Os0KmmYxRBT5J/OMe560
         dClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689100891; x=1691692891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GHiRCvn5wqOgll7vLac7YWEeKjkGVfhUMbeWt74FS0=;
        b=BwybazLgrDO8arPeCRYcVXcI3MAuGyN0xT8Df9PjVYKxIUFjDJENn9KwgfG+Phu2+B
         WHV6JqZowEc2JqZhNZUZtBdkTZww9/TeBjYFK2Re6dzjyr/hNVIKz9PSdOjVTprL874M
         bUEMBk7GJ+vjFuS5PBz1FhX7cSA7cYkQIAixnlaVwyxBPqqJKKPvRKUn2zDnWlWB2DSa
         hobgel7pI9XZLqjQLHF/KTf8jdUnFkrZg8nqG8M2xF1HqStucmWNbXlC/vBTnlV9pdKV
         +GnjHedKuD90tXyhR7A6TocNClUQ/xRyI83D1TRyKCQXhwzfw3891jVuw7gNhziKHWgX
         tsaA==
X-Gm-Message-State: ABy/qLa7D8Bvs9tMJs25zKE6vKLBrrs453IyMZFD6q/RBoxabZ+9Xffs
        U4Hhu6fxWgBvFAL+R8PfKrs=
X-Google-Smtp-Source: APBJJlExByl5XO6GSzS7AXBzosKDx6U3O1B7WrmONw0iGyxoCD+jW1+maakHfLpD0WLF9TCmV0WZuA==
X-Received: by 2002:aa7:d1cb:0:b0:51d:ec4b:d873 with SMTP id g11-20020aa7d1cb000000b0051dec4bd873mr22161128edp.16.1689100890917;
        Tue, 11 Jul 2023 11:41:30 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7dc16000000b0051bed21a635sm1591886edu.74.2023.07.11.11.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 11:41:30 -0700 (PDT)
Message-ID: <00194850-b881-2b01-9b9b-fc7d7422e804@gmail.com>
Date:   Tue, 11 Jul 2023 19:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 00/11] config: remove global state from config
 iteration
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
References: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
 <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen

Sorry it has taken me so long to look at these patches. I see they're in 
master now but I have just had a quick look through anyway and they 
looked good. It would definitely be nice to fix the hacky handling of 
"git checkout --conflict" at some point but that is a long standing 
problem and not the fault of this series.

Best Wishes

Phillip

On 28/06/2023 20:26, Glen Choo via GitGitGadget wrote:
> As promised, this version addresses the comments on v3.
> 
> = Changes since v4
> 
> - Squash 6-7/12 since `test_must_fail` doesn't catch BUG()
> - Move a hunk to later in the series where it belongs
> - Replace a memcpy with `*a = *b`
> 
> = Changes since v3
> 
> - Rebase onto newer 'master'
> - Move the 'remove UNUSED from tr2_cfg_cb' hunk from 9/12 -> 8/12. It should
>    have been there all along; v3 8/12 didn't build at all.
> 
> 
> Glen Choo (11):
>    config: inline git_color_default_config
>    urlmatch.h: use config_fn_t type
>    config: add ctx arg to config_fn_t
>    config.c: pass ctx in configsets
>    config: pass ctx with config files
>    config.c: pass ctx with CLI config
>    trace2: plumb config kvi
>    config: pass kvi to die_bad_number()
>    config.c: remove config_reader from configsets
>    config: add kvi.path, use it to evaluate includes
>    config: pass source to config_parser_event_fn_t
> 
>   alias.c                                       |   3 +-
>   archive-tar.c                                 |   5 +-
>   archive-zip.c                                 |   1 +
>   builtin/add.c                                 |   8 +-
>   builtin/blame.c                               |   5 +-
>   builtin/branch.c                              |   8 +-
>   builtin/cat-file.c                            |   5 +-
>   builtin/checkout.c                            |  12 +-
>   builtin/clean.c                               |   9 +-
>   builtin/clone.c                               |  11 +-
>   builtin/column.c                              |   3 +-
>   builtin/commit-graph.c                        |   3 +-
>   builtin/commit.c                              |  20 +-
>   builtin/config.c                              |  72 ++-
>   builtin/difftool.c                            |   5 +-
>   builtin/fetch.c                               |  13 +-
>   builtin/fsmonitor--daemon.c                   |  11 +-
>   builtin/grep.c                                |  12 +-
>   builtin/help.c                                |   5 +-
>   builtin/index-pack.c                          |   9 +-
>   builtin/log.c                                 |  12 +-
>   builtin/merge.c                               |   7 +-
>   builtin/multi-pack-index.c                    |   1 +
>   builtin/pack-objects.c                        |  19 +-
>   builtin/patch-id.c                            |   5 +-
>   builtin/pull.c                                |   5 +-
>   builtin/push.c                                |   5 +-
>   builtin/read-tree.c                           |   5 +-
>   builtin/rebase.c                              |   5 +-
>   builtin/receive-pack.c                        |  15 +-
>   builtin/reflog.c                              |   7 +-
>   builtin/remote.c                              |  15 +-
>   builtin/repack.c                              |   5 +-
>   builtin/reset.c                               |   5 +-
>   builtin/send-pack.c                           |   5 +-
>   builtin/show-branch.c                         |   8 +-
>   builtin/stash.c                               |   5 +-
>   builtin/submodule--helper.c                   |   3 +-
>   builtin/tag.c                                 |   9 +-
>   builtin/var.c                                 |   5 +-
>   builtin/worktree.c                            |   5 +-
>   bundle-uri.c                                  |   9 +-
>   color.c                                       |   8 -
>   color.h                                       |   6 +-
>   compat/mingw.c                                |   3 +-
>   compat/mingw.h                                |   4 +-
>   config.c                                      | 552 +++++++-----------
>   config.h                                      |  80 ++-
>   connect.c                                     |   4 +-
>   .../coccinelle/config_fn_ctx.pending.cocci    | 144 +++++
>   contrib/coccinelle/git_config_number.cocci    |  27 +
>   convert.c                                     |   4 +-
>   credential.c                                  |   1 +
>   delta-islands.c                               |   4 +-
>   diff.c                                        |  19 +-
>   diff.h                                        |   7 +-
>   fetch-pack.c                                  |   5 +-
>   fmt-merge-msg.c                               |   7 +-
>   fmt-merge-msg.h                               |   3 +-
>   fsck.c                                        |  12 +-
>   fsck.h                                        |   4 +-
>   git-compat-util.h                             |   2 +
>   gpg-interface.c                               |   7 +-
>   grep.c                                        |   7 +-
>   grep.h                                        |   4 +-
>   help.c                                        |   9 +-
>   http.c                                        |  15 +-
>   ident.c                                       |   4 +-
>   ident.h                                       |   4 +-
>   imap-send.c                                   |   7 +-
>   ll-merge.c                                    |   1 +
>   ls-refs.c                                     |   1 +
>   mailinfo.c                                    |   5 +-
>   notes-utils.c                                 |   4 +-
>   notes.c                                       |   4 +-
>   pager.c                                       |   5 +-
>   pretty.c                                      |   1 +
>   promisor-remote.c                             |   4 +-
>   remote.c                                      |   8 +-
>   revision.c                                    |   4 +-
>   scalar.c                                      |   4 +-
>   sequencer.c                                   |  29 +-
>   setup.c                                       |  18 +-
>   submodule-config.c                            |  31 +-
>   submodule-config.h                            |   3 +-
>   t/helper/test-config.c                        |  24 +-
>   t/helper/test-userdiff.c                      |   4 +-
>   t/t1300-config.sh                             |  27 +
>   trace2.c                                      |   4 +-
>   trace2.h                                      |   3 +-
>   trace2/tr2_cfg.c                              |  16 +-
>   trace2/tr2_sysenv.c                           |   3 +-
>   trace2/tr2_tgt.h                              |   4 +-
>   trace2/tr2_tgt_event.c                        |   4 +-
>   trace2/tr2_tgt_normal.c                       |   4 +-
>   trace2/tr2_tgt_perf.c                         |   4 +-
>   trailer.c                                     |   2 +
>   upload-pack.c                                 |  18 +-
>   urlmatch.c                                    |   7 +-
>   urlmatch.h                                    |   8 +-
>   worktree.c                                    |   2 +-
>   xdiff-interface.c                             |   5 +-
>   xdiff-interface.h                             |   4 +-
>   103 files changed, 960 insertions(+), 638 deletions(-)
>   create mode 100644 contrib/coccinelle/config_fn_ctx.pending.cocci
>   create mode 100644 contrib/coccinelle/git_config_number.cocci
> 
> 
> base-commit: 6ff334181cfb6485d3ba50843038209a2a253907
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1497%2Fchooglen%2Fconfig%2Fno-global-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1497/chooglen/config/no-global-v5
> Pull-Request: https://github.com/git/git/pull/1497
> 
> Range-diff vs v4:
> 
>    1:  7bfffb454c5 =  1:  7bfffb454c5 config: inline git_color_default_config
>    2:  739c519ce62 =  2:  739c519ce62 urlmatch.h: use config_fn_t type
>    3:  a9a0a50f32a =  3:  a9a0a50f32a config: add ctx arg to config_fn_t
>    4:  39b2e291f86 =  4:  39b2e291f86 config.c: pass ctx in configsets
>    5:  bfc6d2833c5 =  5:  bfc6d2833c5 config: pass ctx with config files
>    6:  897bdc759b5 <  -:  ----------- builtin/config.c: test misuse of format_config()
>    7:  33e4437737d !  6:  7b24eefbcf3 config.c: pass ctx with CLI config
>       @@ Commit message
>            * git_config_parse_parameter() hasn't been setting config source
>              information, so plumb "kvi" there too.
>        
>       -    * "git config --get-urlmatch --show-scope" iterates config to collect
>       -      values, but then attempts to display the scope after config iteration.
>       -      Fix this by copying the "kvi" value in the collection phase so that it
>       -      can be read back later. This means that we can now support "git config
>       -      --get-urlmatch --show-origin" (we don't allow this combination of args
>       -      because of this bug), but that is left unchanged for now.
>       +    * Several sites in builtin/config.c have been calling current_config_*()
>       +      functions outside of config callbacks (indirectly, via the
>       +      format_config() helper), which means they're reading state that isn't
>       +      set correctly:
>        
>       -    * "git config --default" doesn't have config source metadata when
>       -      displaying the default value. Fix this by treating the default value
>       -      as if it came from the command line (e.g. like we do with "git -c" or
>       -      "git config --file"), using kvi_from_param().
>       +      * "git config --get-urlmatch --show-scope" iterates config to collect
>       +        values, but then attempts to display the scope after config
>       +        iteration, causing the "unknown" scope to be shown instead of the
>       +        config file's scope. It's clear that this wasn't intended: we knew
>       +        that "--get-urlmatch" couldn't show config source metadata, which is
>       +        why "--show-origin" was marked incompatible with "--get-urlmatch"
>       +        when it was introduced [1]. It was most likely a mistake that we
>       +        allowed "--show-scope" to sneak through.
>       +
>       +        Fix this by copying the "kvi" value in the collection phase so that
>       +        it can be read back later. This means that we can now support "git
>       +        config --get-urlmatch --show-origin", but that is left unchanged
>       +        for now.
>       +
>       +      * "git config --default" doesn't have config source metadata when
>       +        displaying the default value, so "--show-scope" also results in
>       +        "unknown", and "--show-origin" results in a BUG(). Fix this by
>       +        treating the default value as if it came from the command line (e.g.
>       +        like we do with "git -c" or "git config --file"), using
>       +        kvi_from_param().
>       +
>       +    [1] https://lore.kernel.org/git/20160205112001.GA13397@sigill.intra.peff.net/
>        
>            Signed-off-by: Glen Choo <chooglen@google.com>
>        
>       @@ config.c: static int configset_find_element(struct config_set *set, const char *
>         			       const char *value)
>         {
>        @@ config.c: static int configset_add_value(struct config_reader *reader,
>       - 	l_item->e = e;
>       - 	l_item->value_index = e->value_list.nr - 1;
>       -
>       --	if (!reader->source)
>       --		BUG("configset_add_value has no source");
>       + 	if (!reader->source)
>       + 		BUG("configset_add_value has no source");
>         	if (reader->source->name) {
>        -		kvi_from_source(reader->source, current_config_scope(), kv_info);
>        +		kvi_from_source(reader->source, kvi_p->scope, kv_info);
>       @@ config.h: void git_global_config(char **user, char **xdg);
>          * Match and parse a config key of the form:
>        
>         ## t/t1300-config.sh ##
>       -@@ t/t1300-config.sh: test_expect_success 'urlmatch with --show-scope' '
>       - 	EOF
>       +@@ t/t1300-config.sh: test_expect_success 'urlmatch' '
>       + 	test_cmp expect actual
>       + '
>         
>       - 	cat >expect <<-EOF &&
>       --	unknown	http.cookiefile /tmp/cookie.txt
>       --	unknown	http.sslverify false
>       ++test_expect_success 'urlmatch with --show-scope' '
>       ++	cat >.git/config <<-\EOF &&
>       ++	[http "https://weak.example.com"]
>       ++		sslVerify = false
>       ++		cookieFile = /tmp/cookie.txt
>       ++	EOF
>       ++
>       ++	cat >expect <<-EOF &&
>        +	local	http.cookiefile /tmp/cookie.txt
>        +	local	http.sslverify false
>       - 	EOF
>       - 	git config --get-urlmatch --show-scope HTTP https://weak.example.com >actual &&
>       - 	test_cmp expect actual
>       ++	EOF
>       ++	git config --get-urlmatch --show-scope HTTP https://weak.example.com >actual &&
>       ++	test_cmp expect actual
>       ++'
>       ++
>       + test_expect_success 'urlmatch favors more specific URLs' '
>       + 	cat >.git/config <<-\EOF &&
>       + 	[http "https://example.com/"]
>        @@ t/t1300-config.sh: test_expect_success '--show-origin blob ref' '
>       + 	test_cmp expect output
>         '
>         
>       - test_expect_success '--show-origin with --default' '
>       --	test_must_fail git config --show-origin --default foo some.key
>       ++test_expect_success '--show-origin with --default' '
>        +	git config --show-origin --default foo some.key >actual &&
>        +	echo "command line:	foo" >expect &&
>        +	test_cmp expect actual
>       - '
>       -
>       ++'
>       ++
>         test_expect_success '--show-scope with --list' '
>       + 	cat >expect <<-EOF &&
>       + 	global	user.global=true
>        @@ t/t1300-config.sh: test_expect_success '--show-scope with --show-origin' '
>       -
>       - test_expect_success '--show-scope with --default' '
>       - 	git config --show-scope --default foo some.key >actual &&
>       --	echo "unknown	foo" >expect &&
>       -+	echo "command	foo" >expect &&
>       - 	test_cmp expect actual
>       + 	test_cmp expect output
>         '
>         
>       ++test_expect_success '--show-scope with --default' '
>       ++	git config --show-scope --default foo some.key >actual &&
>       ++	echo "command	foo" >expect &&
>       ++	test_cmp expect actual
>       ++'
>       ++
>       + test_expect_success 'override global and system config' '
>       + 	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
>       + 	cat >"$HOME"/.gitconfig <<-EOF &&
>    8:  9bd5f60282c =  7:  7d64dcbdade trace2: plumb config kvi
>    9:  114723ee4a7 =  8:  9e71c10ca0a config: pass kvi to die_bad_number()
>   10:  807057b6d7f !  9:  4776600e790 config.c: remove config_reader from configsets
>       @@ config.c: static int configset_add_value(const struct key_value_info *kvi_p,
>         	l_item->e = e;
>         	l_item->value_index = e->value_list.nr - 1;
>         
>       +-	if (!reader->source)
>       +-		BUG("configset_add_value has no source");
>        -	if (reader->source->name) {
>        -		kvi_from_source(reader->source, kvi_p->scope, kv_info);
>        -	} else {
>        -		kvi_from_param(kv_info);
>        -	}
>       -+	memcpy(kv_info, kvi_p, sizeof(struct key_value_info));
>       ++	*kv_info = *kvi_p;
>         	si->util = kv_info;
>         
>         	return 0;
>   11:  3f0f84df972 = 10:  2b33977aba6 config: add kvi.path, use it to evaluate includes
>   12:  fe2f154fe8b = 11:  8347d3c9b80 config: pass source to config_parser_event_fn_t
> 
