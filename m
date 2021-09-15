Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7905CC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D9361179
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 15:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhIOPp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhIOPp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 11:45:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFFAC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 08:44:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so4577778wrr.9
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gsHcEUxsytmpN8EQknocxaAH1O1aIvD6d82RCytym8g=;
        b=SCXB1Tmuh69wA3Ft2XwRRHczIlBGi4bHw+xkJ5QdDzsaZdwGjOCMMalEtdzaUYC+PE
         sgTiKqtU09j9K2CG+bHd6sMeb8wx1Rmg7lk4kx/0U09W1eHjASDcHjzuAdfQD3HgRNxv
         z1OHnwwIbO1vKKrhykjNAKj2vStXCVk7zgL0BoonE0yxqDltB9uVcPVMOkQQPnQr9i9Y
         L8lUwxpfhL2yWxNJGogVgTI/Y+6TtMtak0Up9Nsf2cZMz8PjdivYVVH8P/JLY2zJnszg
         dIgTk2swxubZ4apn0agCJlhu4jcCiDMMd8f+gKnGHnzG/E3X8P8upKC5PmnXaXiY8ZDK
         wNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gsHcEUxsytmpN8EQknocxaAH1O1aIvD6d82RCytym8g=;
        b=qCwW1FA8C+NJSFasz+L7sMtH25IkMqdzUHv90Noe7P3fcB4e66zHFrz+BTJgNH/TkE
         2KrzR2Zw3QDzmbID9daGSWIRI+ABC6r7Pt6AZEAWL97Rz9VhtL1O84fyRGbsVdUOHJtI
         2AnLFGxkDDYhOqm/3SV6qKcKX9TnY54Vi7ReXsLOKgOVn8SVZ2N6LfIOlZ2ub8TMFJc8
         o0qMQEuVtAQE8NgXgiISBRq2xeWt9ZBlxQhzsmGi7/NHIKcn2aAXARVcPY6OAowgAUKq
         JBX0gXnwzIlhm2Y44OxFDwDdxeMXuSTZO9uci8ESKLSUovHPwSSWs9sPYF8qKmfyFUhs
         kLqQ==
X-Gm-Message-State: AOAM5331fVYfXqKEAcf8yvqobh0crai7mp1aXKuO26DGZv1ob7M3LQpy
        6mzFzM5BQIzW1O+cj8CwXSk=
X-Google-Smtp-Source: ABdhPJy0Bk7dNUWH9bqbImV7G22+Q8QXBq+W+pXbxWQRFDjoERhKzb0fKkwH6UXrZsr37egISc+wbw==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr734568wrw.186.1631720675671;
        Wed, 15 Sep 2021 08:44:35 -0700 (PDT)
Received: from [192.168.1.240] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.gmail.com with ESMTPSA id o7sm268563wmc.46.2021.09.15.08.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 08:44:35 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
 <c42d4051-59cd-094a-4570-32cf4d38ec27@gmail.com>
 <e7224105-83c6-7f12-f63a-474bd477583a@gmail.com>
 <408dc1d3-44b8-a955-4d7b-94f23fa8a6bc@gmail.com>
 <CABPp-BEbY0BqkBP4r-6XpGk46J+Y+W8+7cVZXQg5fuJXYOntDQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1311e9e9-6d10-40f8-2073-077313a94301@gmail.com>
Date:   Wed, 15 Sep 2021 16:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEbY0BqkBP4r-6XpGk46J+Y+W8+7cVZXQg5fuJXYOntDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 09/09/2021 16:01, Elijah Newren wrote:
> [...]
>> merge-ort.c:checkout() which is used by merge_switch_to_result() uses
>> unpack_trees() so it will pick up the global state and hopefully should
>> just work (cc'ing Elijah to check as I didn't look what happens when
>> there are conflicts).
> 
> Yep, merge-ort was designed to just piggy back on checkout code.  The
> checkout() function was basically just code lifted from
> builtin/checkout.c.  Using that code means that merges now also
> benefit from all the special working tree handling that is encoded
> into git-checkout -- whether that's parallel checkout, submodule
> handling, tricky D/F switches or symlink handling, etc.  In contrast
> to merge-recursive, it does not need hundreds and hundreds of lines of
> special worktree updating code sprayed all over the codebase.
> 
> Conflicts are not special in this regard; merge-ort creates a tree
> which has files that include conflict markers, and then merge-ort
> calls checkout() to switch the working copy over to that tree.
> 
> The only issue conflicts present for merge-ort, is that AFTER it has
> checked out that special tree with conflict markers, it then has to go
> and touch up the index afterwards to replace the entries for
> conflicted files with multiple higher order stages.  (You could say
> that merge-recursive is "index-first", since its design focuses on the
> index -- updating it first and then figuring out everything else like
> updating the working tree with special code afterwards.  In contrast,
> merge-ort ignores the index entirely until the very end -- after a new
> merge tree is created and after the working tree is updated.)

Thanks for explaining, it's a nice design feature that you can just reuse
the checkout code to update the working copy with the merge result

>> merge-recursive.c:update_file_flags() does this
>> when updating the work tree
>>
>>          if (S_ISGITLINK(contents->mode)) {
>>                   /*
>>                    * We may later decide to recursively descend into
>>                    * the submodule directory and update its index
>>                    * and/or work tree, but we do not do that now.
>>                    */
>>                   update_wd = 0;
>>                   goto update_index;
>>          }
>>
>> so it looks like it does not update the submodule directory. Given
>> merge-ort is now the default perhaps it's time for rebase (and
>> cherry-pick/revert) to start reading the submodule config settings (we
>> parse the config before we know if we'll be using merge-ort so I don't
>> know how easy it would be to only parse the submodule settings if we are
>> using merge-ort).
> 
> I'd just parse any needed config in all cases.  The submodule settings
> aren't going to hurt merge-recursive; it'll just ignore them.  (Or are
> you worried about a mix-and-match of rebase calling both checkout and
> merge code doing weird things, and you'd rather not have the checkout
> bits update submodules if the merges won't?)

I'd rather just parse the config when we know submodules are going to be
rebased, I think it's confusing if some bit work and others don't. I've
tried the diff below locally, but t7402-submodule-rebase.sh does not show
any change (I was hoping some text_expect_failure would be fixed) so I'm
not sure if it's working or not and I ran out of time.

Best Wishes

Phillip

--- >8 ---
diff --git a/builtin/rebase.c b/builtin/rebase.c
index eed70168df..a35a9e3460 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -26,6 +26,7 @@
  #include "rerere.h"
  #include "branch.h"
  #include "sequencer.h"
+#include "submodule.h"
  #include "rebase-interactive.h"
  #include "reset.h"
  
@@ -1114,6 +1115,10 @@ static int rebase_config(const char *var, const char *value, void *data)
                 return git_config_string(&opts->default_backend, var, value);
         }
  
+       if (starts_with(var, "submodule.")) {
+               return git_default_submodule_config(var, value, NULL);
+       }
+
         return git_default_config(var, value, data);
  }
  
@@ -1820,6 +1825,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
             getenv("GIT_TEST_MERGE_ALGORITHM"))
                 options.strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
  
+       /* only the "ort" merge strategy handles submodules correctly */
+       if (!is_merge(&options) ||
+           (options.strategy && strcmp(options.strategy, "ort")))
+               git_default_submodule_config("submodule.recurse", "false",
+                                            NULL);
+
         switch (options.type) {
         case REBASE_MERGE:
         case REBASE_PRESERVE_MERGES:
  
