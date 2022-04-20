Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1226BC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 10:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351755AbiDTKkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiDTKky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 06:40:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B23FD95
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:38:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so1703437edw.6
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2r2p/zt5+vgWWEvUgwwymVItgOoytGNoXzy9YEpqiaw=;
        b=jmpzJUg4boAv14647Rv/9VmhaYMh2OyRFv9Kgz0DOz1biRERQvAgn384Tr8Kku+NMo
         VhkvasdIdBah8morY8wnsqBneVAGHxV0mkqc9lU/arjE/DUNg387G9r9kP15nq6hlVti
         Zjg6sgAivbwaWvR0EGE6PvTO6mWWwvMQRRg6hKZG6LI9vqHUzhpuQLbS7LdjKMpUaWSQ
         BUsIb11zuMN7Ml8MVh9aqZA8X33urUWNnBlcTGYF2RqJ1eANbrjDRvl34arAdpDKG5J5
         YIwzwNGNCzVO4W3f5e+ZUPU6Wed+jlONKWCAhL9zkofjU0lnrkwOv5h1zkDXxIF47W8R
         jSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2r2p/zt5+vgWWEvUgwwymVItgOoytGNoXzy9YEpqiaw=;
        b=7/4Fv/Wue6yRnpudNKHNvA1x8cIvI+ywfBVMICDSAORLhY/gLod3EOF7IPUvBh/WcR
         WjHYYF3fw/1tsLmzqcxmJIym542zB4hjn+NNAOE/Aheib6FSdJ0YRbqS9bJYjj62X15Y
         TffvFDBafZG1WkH8YRg0O03UyBv7ksYBdLJNiI9tneBTKZkDrRTfIhsBNrPAXytGvhFT
         Ai8iIYPzr4S0gczWta4ZUOQ9y6Ev0qL+UpbQsf4JE/rcDkRhXAWWAWpbkVexodsjtHol
         5BNDpQthHsXlMl3N9cA+TVn5SQJ2ZQPIJ3oxkcuXf2UjSJUPk58Q6EPYHMB4e2CG4wqG
         tmUQ==
X-Gm-Message-State: AOAM530R6AGGLn+D0p0IhOW+56PBF2r0xP2LTlmKXQ3OZVdhB4YBupJx
        1uuPek3+eA+x3hR9c83isMq0te/jzIU=
X-Google-Smtp-Source: ABdhPJzsgdWsR5cX9i7rpj+CwSkHt5leIIMbCRYzLw7ZP7HbvERSkWYw6o8nKQDHDceIIKNFknDLkg==
X-Received: by 2002:a05:6402:218:b0:419:d804:9483 with SMTP id t24-20020a056402021800b00419d8049483mr22899094edv.396.1650451083135;
        Wed, 20 Apr 2022 03:38:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906708700b006da8440d642sm6642908ejk.113.2022.04.20.03.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 03:38:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nh7ik-007GNt-6z;
        Wed, 20 Apr 2022 12:38:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 8/8] rebase: cleanup action handling
Date:   Wed, 20 Apr 2022 12:34:15 +0200
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
 <b0d21affa788c5ac953617c3f006b19a28f85d79.1650448612.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b0d21affa788c5ac953617c3f006b19a28f85d79.1650448612.git.gitgitgadget@gmail.com>
Message-ID: <220420.861qxs82gl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 20 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Treating the action as a string is a hang over from the scripted
> rebase. The last commit removed the only remaining use of the action
> that required a string so lets convert the other action users to use
> the existing action enum instead. If we ever need the action name as a
> string in the future the action_names array exists exactly for that
> purpose.

This is very much an existing issue, just noting this since I read this
over: We really should just carry that "action_names" in the "switch"
statement immediately below the trace2_cmd_mode() call, see "git grep
trace2_cmd_mode". I.e. usually we do it in the "callback".

Or actually just add a OPT_CMDMODE_TRACE2(), which would be an
OPT_CALLBACK (see parse_opt_show_current_patch for such an example for a
cmdmode callback) that would take the "--continue" string, log
"continue" etc (do we really need to munge "edit-todo" to "edit_todo").

But I digress, this code looks fine, thanks.
