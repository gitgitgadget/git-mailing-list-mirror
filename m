Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154CEC433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbiD0UHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiD0UHH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:07:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7898E103A
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:03:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so3950966wrv.10
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eptix.co; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=p7o/fHXmkYRfOFY3B9rvlQ+3++J1xZPq4riRCaVBmdQ=;
        b=CzyKF3HDt7bxQAEPWvjb80knj3xk0+FQQSOtFjrQjhvod0ta+NCuWEuycfEE07Wwo0
         +dZFfoDnuIIV1P5dLol9g3+6J/p48iWyeWk0C64ey/oZTPPKxGfyzjFhmmM9prbdfZOC
         t6/nHawUKgl+/5Tlm0oq6Dh7xdBBvFi8bcq1qotFLy035AYQskNz614iE9xtHrLMPell
         ov4MJ9ei7BUr8Cv61dQo8miJTRibQDNr/SqmAMJnmaWn7Fwb+PD2qGKlZay2GpYuFONA
         g4m1Ot8Zje7UOx3RxaTaBYVy+k4kJ86J77rR/1WpdWjXX2cL2IyUzhvmpi2lZgX2Fk7S
         1PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p7o/fHXmkYRfOFY3B9rvlQ+3++J1xZPq4riRCaVBmdQ=;
        b=3Phi/JA2jqgn3UKsEdryJ58UQRJhTSkeio5gtXLPkiph2GRlrJ+V5ahvHGRjiOlmDt
         B/4efkSpawQYmxq6+exbeirkMZ50F4sV8jyqgB9feQt1nZb0qzKS3jpVcNq874zoNAlE
         2exFIPtGJbL7siVtsNaZZ/blND8fHxXLPevVzys8pzNTYQppU5J46DTvWKiFt/IOaq/a
         jpb2hL4NfBE4CJfEX6EE062QB+T7RFWue3e/HqivBoWburvgnxU89ExGBG//2eJ+c4wm
         KYWgPTF9mNH1N0wV1PWujphGnbqrbOcLn9+fs0LDYIFddvrm4A4dOW2zV9hwa6Kvp3pd
         uZiQ==
X-Gm-Message-State: AOAM531drDYh4nbyui2R8xw/3PEkbOe/rZP6J2PnD8LQAwl+c0Ie7Kkz
        V55sV8z3oc+Gngsak6GbXkg+t9RceYe6H1qKXjF7e011U58UQA==
X-Google-Smtp-Source: ABdhPJxlU+dy2Ym6bTSKdUU0DJIJ1WrNAk301LHbxk1YJgc8I0VpbU0jDXIjqZD3Uip+0ywPdMErXso1rdBTDtFiPRY=
X-Received: by 2002:adf:e108:0:b0:1ef:97ad:5372 with SMTP id
 t8-20020adfe108000000b001ef97ad5372mr23298077wrz.658.1651089833853; Wed, 27
 Apr 2022 13:03:53 -0700 (PDT)
MIME-Version: 1.0
From:   Maxime Fontaine Bombardier <mbombardier@eptix.co>
Date:   Wed, 27 Apr 2022 16:03:43 -0400
Message-ID: <CAHh029azN65vyscsCmwCG5sFPO_sGPVJ6twBXwMdNXxfYT0X4w@mail.gmail.com>
Subject: Issues with git config blame. ignorerevsfile when file not found
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I was looking to reformat full source code and ignore blame on this
commit. I was following this article :
https://michaelheap.com/git-ignore-rev/
Using this config command :
`git config --global blame.ignoreRevsFile .git-blame-ignore-revs`
I'm able to see git blame without seeing the formatting commit.
BUT when the file is not found on the repo, git blame is broken with
this error message:
could not open object name list: .git-blame-ignore-revs

On one hand, you don't want to manually write the ignore file every
time you want to use `git blame --ignore-rev <sha1>`, but on the other
hand, git blame is broken on every other repo that does not include
this file... I also use git lens pair with vscode to see blames and
the extension is broken if the file does not exist too.

Here are 2 ideas on how I would fix this issue:
- New config "blame.ignoreNotFound" boolean.
  - False by default.
    - Will still see the error when the file is not found.
  - True
    - Will ignore errors about the file not found and remove the
--ignore-rev feature in the current git blame command.
    - I would put this setting to true as default, because I don't
care about error messages. All I care is that git blame shows me the
real author and not the one who launched the formatter, BUT to not
break default behavior, this should be an optional setting.
- New file standard! (which I think is a better option)
  - Beside .gitignore, you can find the file .gitignorerevs (or any
better name). If the file is found in the repo, doing git blame will
use the file by default.
  - That way :
    - It's not a global config that does not apply to specific repo or
break the command when it's not found.
    - It's not a manual argument you need to add each time the command is used.
    - Nor a local config that everyone contributing to this repo needs
to set up to use git blame correctly.
  - And :
    - Any git hosting website like Github/Gitlab/etc. could also use
the file to help dev search for specific changes on the website.
  - IMO: I don't think having a file that ignores some commits will
hurt people's workflow as this is a deliberate change. You know that
this commit is bad for the code history, so you want to ignore those
changes to clean up the history.

Well I hope I gave enough description to make this change happen :)
Btw, I'm writing today because I definitely think this is a MUST
feature to make git blame truly shine and because I searched online
and I couldn't find any proper solution, just that you can't do that
yet.
https://stackoverflow.com/questions/70435937/git-blame-with-optional-ignorerevsfile
