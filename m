Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E346C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225FD23A33
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 19:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8PZzNJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI0TXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 15:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgI0TXs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 15:23:48 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645AC0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 12:23:48 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a16so4558785vsp.12
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQ9meEx7lkrXgaMezOqSJR/5L5hZWjLJ1IBaimxe2XY=;
        b=X8PZzNJDvmqiR85eoScEVgfti9jydWf6R9gGJXHlcfclXjPB6aVu1Ykr3HuaHCuFNN
         RnKjM3h05b10kLyehYnxEngJdWvWXlyYAFGUY0Zu4DV5P/UBo8afiOEyQip1G0gLuNVf
         Yr3FZdo++DftkwkAKqjtqjZF4wWdfrCnOjeMkcQS4BvzcYy9QygUcF2CkLfCAd2Xr7nI
         xNv1wh7WNC3UKS9xbq2wKVZRQMsaEyolbPd0ciumlhj2ZCcRwJDHwinvDmW62++TRMmr
         IDhZ4BrAJbjUvq+uNMXBX1QGL47v/0szRFtyHvOHiYkTfHuvgCbber3sJMRyxFzimKUd
         cVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQ9meEx7lkrXgaMezOqSJR/5L5hZWjLJ1IBaimxe2XY=;
        b=OA9+w25ZqRD4rQYgXQ0V4It60+sDhhHlY3E5bDnRDB9GIEhIBM92RkHe/1O/74QJN8
         1O4J1M2CCAnckwOaPTSS1h4sN6uY0Ew8l9sO2pXLtXcjszyx5Sqw8MOaxUFpWqotVENk
         KkQTwLdU+rKs4NZMtL+VDTUcUgk+8/8/vd+/pWsG4CSHY3uWDhVYeUSckPXdt8zcaSg8
         7rPIEIfS6leZDTelwP4WDJWqLc3eskX0mRga/cbgMbLVRDa3fNXRa/S6rK2knjXYGBbK
         ibL0s/ikpmDTgFu+Tdqydb2QzXHupBHuhvJD29OtqNnubOzvy1321v3Bxg1fEy19p7hP
         Fffg==
X-Gm-Message-State: AOAM532RVQdicum3PY7CimcQt0cj1GUWF5HU3D3BCNTm6/N84fgX6WCJ
        uMhw+N/crytUs5LuJsMCwze4C0WyMnMqs/ZwmAo=
X-Google-Smtp-Source: ABdhPJwAvUJfcKTr0BPFqJnzBBGqkMmn2oHi0TcUIseOL1jwDfjwaPBv3NHvkvca8fmI626j5lItEuEJ7zDOuCTqcxs=
X-Received: by 2002:a67:d601:: with SMTP id n1mr4754472vsj.2.1601234627878;
 Sun, 27 Sep 2020 12:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com> <20200909004939.1942347-4-emilyshaffer@google.com>
In-Reply-To: <20200909004939.1942347-4-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 27 Sep 2020 21:23:35 +0200
Message-ID: <CAN0heSq1iVtJycjgh-iv2O6vNr6CLn69N3286hzkfu5sXLjf5w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] hook: add list command
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 9 Sep 2020 at 02:54, Emily Shaffer <emilyshaffer@google.com> wrote:

>  DESCRIPTION
>  -----------
>  You can list, add, and modify hooks with this command.

(BTW, I think this patch could teach this to say "You can list hooks
with this command." If/when we add the other commands, we can expand
on this.)

> +This command parses the default configuration files for sections "hook" and
> +"hookcmd". "hook" is used to describe the commands which will be run during a

I propose s/"hook"/`hook`/ and similar to set this as monospace since we
are discussing configuration sections. If we want to avoid starting
sentences with "hook" (or `hookcmd`; do we?), maybe something like "The
section `hook` ..." would work fine.

> +particular hook event; commands are run in config order. "hookcmd" is used to

"config order" feels a bit too colloquial/vague. You use the same phrase
in the commit message and I think it works well there for the indented
audience. But for this document, I'm not so sure. How about

  Commands are run in the order they are encountered as the Git
  configuration files are processed (see linkgit:git-config[1]).

? It's also quite possible that "config order" hits the exact right tone
-- please trust your judgment.

> +describe attributes of a specific command. If additional attributes don't need
> +to be specified, a command to run can be specified directly in the "hook"
> +section; if a "hookcmd" by that name isn't found, Git will attempt to run the
> +provided value directly. For example:

> +  [hook "post-commit"]
> +    command = "linter"
> +    command = "~/typocheck.sh"
> +
> +  [hookcmd "linter"]
> +    command = "/bin/linter --c"

Hmm. "hook", "command" and "hookcmd". Should that be "cmd", or
"hookcommand"? I'd favour the latter, but the current proposal somehow
feels asymmetric. (If code uses, and is consistent about using,
"hookcmd" that's another thing entirely, I think. It's just that for the
configuration, it looks a bit odd.)

> +List the hooks which have been configured for <hook-name>. Hooks appear

`<hook-name>` with backticks.

> +in the order they should be run, and note the config scope where the relevant
> +`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).

I had to read and re-read this a few times. The "and note the" does not
mean "and please observe that", but rather "and they make note of". Not
sure how that can be done clearer. The second thing that tripped me up
was that last part. Maybe end the sentence after "specified", then add
something like "The scope is not affected by if and where
`hookcmd.<hook-name>.command` appears.".

I think you could add

  CONFIGURATION
  -------------
  include::config/hook.txt[]

here and add such a file

  hook.<hook-name>.command::
         ...

  hookcmd.<hook-name>.command::
         ...

where you define/describe those items. And you can include it from
config.txt as well.

Martin
