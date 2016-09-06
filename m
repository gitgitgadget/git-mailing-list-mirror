Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546801F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938785AbcIFSIF (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:08:05 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36380 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936277AbcIFSIE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:08:04 -0400
Received: by mail-wm0-f49.google.com with SMTP id b187so77920155wme.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=17Qh2F4S2L/EH63o1MwwlcZmHdi2oTXFD5AcNZ/uD2c=;
        b=LMflQMxr6da8arZbYicHDOmz6S9ba7iqEODWWXPX0hIFeHxkY4r0+0DVGOemvwTmy1
         X1gTmkCIM37HD0TDr6XKE/XI9kG07VeGMLYSzx0NrWlBLBCfJm8gxrztFhAd+5+h71Pa
         OoE35vADiu/6FHoZrysh1RqgyXKnFR00AgAWxuHCbm3rDTql15awmsCxkaUH5xVWvCWy
         kGvCMeW9cjxVn4FKlsVDmn0OkJTPFpq1/uAbPP1RzYFpnj6yo+cNR0lYhwSErPIM5Igt
         Lhx9L4TS2b3JCVQgQ7Q8z4Yr+QcdAcjpvh8SmzzCKMdHgouppcD6RnHpZG/oltHtZ6eF
         cUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=17Qh2F4S2L/EH63o1MwwlcZmHdi2oTXFD5AcNZ/uD2c=;
        b=Xs7OARsihlvpwRprx+8NCpY4O19jLrqspcgO0AvLX44+Pj2+s7P0TMzhAt2gCsMXvO
         uEFsHMHzVZOxynjaPOyt80XwOJgW5Y6LWWaw+3yJ2B3JAeJ54KOglAZFNU7yO/4S5YJL
         OS3BrKjmDeIsBy53fhLeBXeoA0eqLHpUd7fwh3lU/kGleMnfNwO3UNAIdt26tzJtfOv7
         UinZLNJR5DNMfqzo8j75Su9tHmSaL8pl91f3YMe9UmvEkJ6IFP9lTjys/Z1mwlBGJzoG
         7G5aHY0GCzt2Ywci5ID0t9JfjYNE6JTk2kRaEtJQu8jmnMqvMvjNpECwIuV4FVwePoc0
         +iAw==
X-Gm-Message-State: AE9vXwOlxjbpZ8pyvEQxkPjtwhAb8OP2gj6yNGFZzBpc6b9e47QnmNX+UfFjtLF7udagktWVOAcTCsERACKlIA==
X-Received: by 10.28.57.4 with SMTP id g4mr18782683wma.75.1473185282085; Tue,
 06 Sep 2016 11:08:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.234.212 with HTTP; Tue, 6 Sep 2016 11:08:01 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 6 Sep 2016 20:08:01 +0200
Message-ID: <CAN0XMO+ZOV3M02wJ_=oMPbN4ch-=7gA_pXEegfHApvSNeOu3KA@mail.gmail.com>
Subject: Bug? ran into a "fatal" using interactive rebase
To:     git <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

today I accidentally triggered a "fatal" using interactive rebase.

If you edit the instruction sheet after 'rebase -i' and add an unknown
command, Git stops because it doesn't know the command.
That's fine, however, now we are in a state where 'git status' fails with

interactive rebase in progress; onto 311f279
fatal: Could not open file .git/rebase-merge/done for reading: No such
file or directory

After finishing the interactive rebase, things are fixed.  Looks like a
special case that isn't handled well, yet.

My Git version is the current 'next' branch.

Ralf
