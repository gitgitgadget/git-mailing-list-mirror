Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E117C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 05:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCQFBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 01:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQFBS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 01:01:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB78FB06F4
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so3355148wrp.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679029275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4zdQhUJMglGOQ3OsErqDUUlCVMZih0hiRsSzDpiufs=;
        b=aKJm9ezq2P0zuIFXBNG1Xj482bOEYar56y+3UotOIH/lbIsPLsLyQ4oH1VKUeTXMie
         op3lbv1fVO/TK+RskF/CpJBuQsiwTT+OYpVWrrr6GUdPAAnsMLX13AjU1HQF6pePhH5f
         Yvy4M2BiQTpTrpZ7zoF9aeacPKhlBsEQUS0E/I3oi40AdR1hjD5e1WZDROt1yUlHsL1F
         6bhpeU9Lxm8UqeTAsCZ5AunRBqCgtyNR88xi7EJaDnnTuvW5TLbuP7BlG5VChqoqOvsd
         q0PtlI0UUTdkttwDOm8rBax8yfZS62LSgMXgw5BSM8RvIUH3SbvQ/h/ziRqMJHAh7qMA
         5jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679029275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4zdQhUJMglGOQ3OsErqDUUlCVMZih0hiRsSzDpiufs=;
        b=IgdU11mp8NXgg/r5c138nmNszUUfQQjmmufgyDiEYjSMiD4jSNmyHpWhvetv62vLBR
         6FpCBsRbXW8qRUJU1yoLiKcRnZamXo2sUOiWfQ6m0wEiLllANlWrmVFSHY/yBIyfnbf4
         3iqtC3Z4OcGYu/aN7maHvewfbO+cS8qcKfICdAFyDtWt47G2RQsxMT38im8Dh+BCjPcu
         6HLb4octYb0HY0HY8YsY+bTN3JHvXyfjP7C5tQsrYfEdp+bnFFGNnEmYeuDkLQpseDqT
         LVaegZSuk23ovqdaNIUONTpoTt8sjNtNgE8Eg57KPYTEe3EfO0efzsvDSJgjK6fANFVs
         yvLQ==
X-Gm-Message-State: AO0yUKUpXs12b8obUfz70t1DPhyTvzhGgge7GneoXK8cAcQe/PC89i6a
        lcLQ201WlRq0HkNCE/3YzTr74LdrkQAuoA==
X-Google-Smtp-Source: AK7set/g+PJ30cuJa/ZDbmExIr8XbrCfQZFnHCmtMpSkGKTpAJOzA7Cx0RrSK4faq7H8tgZIfuT3DQ==
X-Received: by 2002:adf:efd0:0:b0:2cf:ed7c:29c with SMTP id i16-20020adfefd0000000b002cfed7c029cmr7122434wrp.62.1679029274626;
        Thu, 16 Mar 2023 22:01:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b002c559843748sm1027844wrq.10.2023.03.16.22.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:01:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/5] bypass config.c global state with configset
Date:   Fri, 17 Mar 2023 06:01:05 +0100
Message-Id: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16 2023, Glen Choo via GitGitGadget wrote:

> After reflecting on Ævar's responses on v1, I'm fairly convinced that
> "struct config_reader" shouldn't exist in the long term. I've written my
> thoughts on a good long term direction in the "Leftover bits" section. Based
> on that, I've also updated my WIP libification patches [1] to remove "struct
> config_reader" from the library interface, and think it looks a lot better
> as a result.

That libification url
(https://github.com/git/git/compare/master...chooglen:git:config-lib-parsing)
doesn't work for me, and I didn't find a branch with that name in your
published repo. So maybe you've already done all this
post-libification work...

> = Leftover bits
>
> We still need a global "the_reader" because config callbacks are reading
> auxiliary information about the config (e.g. line number, file name) via
> global functions (e.g. current_config_line(), current_config_name()). This
> is either because the callback uses this info directly (like
> builtin/config.c printing the filename and scope of the value) or for error
> reporting (like git_parse_int() reporting the filename of the value it
> failed to parse).
>
> If we had a way to plumb the state from "struct config_reader" to the config
> callback functions, we could initialize "struct config_reader" in the config
> machinery whenever we read config (instead of asking the caller to
> initialize "struct config_reader" themselves), and config reading could
> become a thread-safe operation. There isn't an obvious way to plumb this
> state to config callbacks without adding an additional arg to config_fn_t
> and incurring a lot of churn, but if we start replacing "config_fn_t" with
> the configset API (which we've independently wanted for some time), this may
> become feasible.

...in any case. This RFC expands a bit on my comments on the v1 (at
[1] and upthread). It doesn't get all the way there, but with the
small change in 5/5 we've gotten rid of current_config_line(), the
1-4/5 are trivial pre-refactorings to make that diff smaller
(e.g. moving the "struct key_value_info" around in config.h).

Maybe it still makes sense to go for this "the_reader" intermediate
step, but I can't help but think that we could just go for it all in
one leap, and that you've just got stuck on thinking that you needed
to change "config_fn_t" for all its callers.

As the 5/5 here shows we have various orthagonal uses of the
"config_fn_t" in config.c, and can just implement a new callback type
for the edge cases where we need the file & line info.

This still leave the current_config_name() etc, which
e.g. builtin/config.c still uses. In your series you've needed to add
the new "reader" parameter for everything from do_config_from(), but
if we're doing that can't we instead just go straight to passing a
"struct key_value_info *" (perhaps with an added "name" field) all the
way down, replacing "cf->linenr" etc?

Instead you end up extending "the_reader" everywhere, including to
e.g. configset_iter, which I think as the 5/5 here shows isn't needed,
but maybe I've missed something.

Similarly, you mention git_parse_int() wanting to report a filename
and/or line number. I'm aware that it can do that, but it doesn't do
so in the common case, e.g.:

	git -c format.filenameMaxLength=abc log
	fatal: bad numeric config value 'abc' for 'format.filenamemaxlength': invalid unit

And the same goes for writing it to e.g. ~/.gitconfig. It's only if
you use "git config --file" or similar that we'll report a filename.

So just as with the current_config_line() I wonder if you just grepped
for e.g. git_config_int() and thought because we have a lot of users
of it that all of them would require this data, but for e.g. this
log.c caller (and most or all of the others) we'll be reading the
normal config, and aren't getting any useful info from
die_bad_number() that we wouldn't get from an error function that
didn't need the "linenr" etc.

> And if we do this, "struct config_reader" itself will probably become
> obsolete, because we'd be able to plumb only the relevant state for the
> current operation, e.g. if we are parsing a config file, we'd pass only the
> config file parsing state, instead of "struct config_reader", which also
> contains config set iterating state. In such a scenario, we'd probably want
> to pass "struct key_value_info" to the config callback, since that's all the
> callback should be interested in anyway. Interestingly, this was proposed by
> Junio back in [4], and we didn't do this back then out of concern for the
> churn (just like in v1).

I think we can make it even simpler than that, and from playing around
with builtin/config.c a bit after the 5/5 here I got a POC working
(but am not posting it here, didn't have time to clean it up).

We can just make config_set_callback() and configset_iter()
non-static, so e.g. the builtin/config.c caller that implements
"--show-origin" can keep its config_with_options(...) call, but
instead of "streaming" the config, it'll buffer it up into a
configset.

The advantage of that is that with the configset API we'll get a
"struct key_value_info *" for free on the other end. I.e. we'll
configset_iter() with a fn=NULL, but with a defined "config_kvi_fn_t",
which 5/5 is adding.

But I haven't done that work (and am not planning to finish this), but
maybe this helps.

We'll also need to track the equivalent of "cf->linenr" etc. while we
do the actual initial parse. I think it might be simpler to start by
converting those "linenr" to a "struct key_value_info" that's placed
in the "config_source" right away.

I.e. when we pass it to the error handlers we'll need to give them
access to the "linenr", but we don't want to provide e.g. "eof" (which
is internal-only state).

I wonder how much else you're converting here is actually dead code in
the end (or can trivially be made dead). E.g. the
current_config_line() change you make in 1/8 is never going to use the
"cf_global" if combined with the 5/5 change here.

1. https://lore.kernel.org/git/230308.867cvrziac.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (5):
  config.h: move up "struct key_value_info"
  config.c: use "enum config_origin_type", not "int"
  config API: add a config_origin_type_name() helper
  config.c: refactor configset_iter()
  config API: add and use a repo_config_kvi()

 builtin/remote.c       | 11 +++----
 config.c               | 67 ++++++++++++++++++++++++++----------------
 config.h               | 29 +++++++++++++-----
 t/helper/test-config.c | 13 ++++----
 t/t5505-remote.sh      |  7 +++--
 5 files changed, 80 insertions(+), 47 deletions(-)

-- 
2.40.0.rc1.1034.g5867a1b10c5

