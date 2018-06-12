Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771031F403
	for <e@80x24.org>; Tue, 12 Jun 2018 19:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeFLTca (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 15:32:30 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:45779 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754025AbeFLTc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 15:32:29 -0400
Received: by mail-io0-f177.google.com with SMTP id l25-v6so717482ioh.12
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=WR5cCicRAHZwzsyiwbDZFgVmXSWAjHKIwyGJqpBl2qY=;
        b=KGwbQVYgW6VFYVpUtsPQRich96p3XQ/5zvVJbvflwmAxHIpnfNsI59dIPBMBETbRBe
         TQfnH4tdW+qPSebo6Cl7uRNehqnHrxJeRzYkgmMUENZDHHaMnxfs+fkIXiVEkoKfbCuB
         E+dKgy1DaxyuAfVCHmfa2dNZo2H9GXGG9geqdyV5PAdSQHIBL3Lt2+TTW3A8+j75oWKo
         KJo11fndh50BgRf2lzCw+eNh2wU0TXrMLV6RkVYPfr3E5c1fNT3fEeMoFZRSydEDCFZQ
         rXNCQVK6SJW7vH/sQSU79cY2fBfBsmC5cjLEKIgO4qK3n2T6sVOzGsZaJtO7p53KNGtq
         zrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=WR5cCicRAHZwzsyiwbDZFgVmXSWAjHKIwyGJqpBl2qY=;
        b=AfFLUt9Ff5MoU0N/D8HEgMl1Q19gTWJAXRsu6SBRMHb+muPxfFy+3kR3DnRtn4+E6T
         584bs9K1EbyJK0KaeydXnuao1w6rxu8fhowgqB6kmKoW92mJHdqMcECx+/VIqCImcmy3
         rfyPH9qYPBFCFZpKHscOAddUsh0IgCsiz6VBcraJbrF69RoyeT+litdhDcKTu7cv2iXf
         TzgWZXMUvL4eUG1ItnqoTCuEHzxwbI5UsVD8frUUzajQwTbLQ3F9xaIu1YFZcyCMiHoJ
         9PkbSXW99+crO2qQqCLfQYCMg9Dczn+o+LLjubEQnba7zSBeO4ibM6WK/uzt/2BODLW7
         iHtg==
X-Gm-Message-State: APt69E2GNIMltt/ZKatOExMkNpCY2HCamgyHXvZVmlHef7/D74CRw4WR
        BipVN8RSGGJbRdRrEr/RMmkoDFGuygcY4GSYNjCdkw==
X-Google-Smtp-Source: ADUXVKKRWknh7sZibQMkTW+rP9Fbppl61gdy/sx5a6qPhqmBoPkqpSzG7JgXs6dowsqtSOgimuZUoxUgs2j3OQwHZR8=
X-Received: by 2002:a6b:e89:: with SMTP id 131-v6mr1853527ioo.69.1528831949012;
 Tue, 12 Jun 2018 12:32:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:50cd:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 12:32:28
 -0700 (PDT)
From:   Sam Kuper <sam.kuper@uclmail.net>
Date:   Tue, 12 Jun 2018 20:32:28 +0100
X-Google-Sender-Auth: y8pK9r53O3AGfwlylgwbjpoEiZg
Message-ID: <CAD-JurLXh=rOC=bhjTa8jCpeDWkbDhCztSpjLuMEUGm1-QnAiw@mail.gmail.com>
Subject: `git merge --abort` does not run `git rerere clear`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`man git-rerere` says:

> clear
>
> Reset the metadata used by rerere if a merge resolution is to be
> aborted. Calling git am [--skip|--abort] or git rebase
> [--skip|--abort] will automatically invoke this command.

It makes sense that `git am [--skip|--abort]` and `git rebase
[--skip|--abort]` would run `git rerere clear`.

However, if they run it, then shouldn't `git merge --abort` run it, too?

If not, then what is the reason why not, and might it be helpful for
this reason to be mentioned at some appropriate place in the
documentation?

Thanks :)
