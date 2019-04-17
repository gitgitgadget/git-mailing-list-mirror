Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FE320248
	for <e@80x24.org>; Wed, 17 Apr 2019 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbfDQUh0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 16:37:26 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40883 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbfDQUhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 16:37:25 -0400
Received: by mail-ot1-f50.google.com with SMTP id t8so21905920otp.7
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DcuyCpedy6FloVvAckAb8ILtszeJ8y+j4oQ6gYjTHNQ=;
        b=KLLGjdALrNwUBfW5u2q/iON7txXS/R6kI8fnpvmdi1spXXOfHKh8T/R6/g+LZZpgi6
         XfkTuQK9APDSCO5hma4RGXny+ZS1e3NIK6lwVTHV0l5yd+QQ+2JApusw5PHck1RQYeci
         u5AVfA8Pu0tgJ5qQZQSXNHHhayEY/G87O21NtGTatD7M6QetGaUKr8wPquHYuo1NuZJp
         YuKO7wFXdcLy8REeWhK3ESFnMA71MEfIGSQ5Vgrie/wZuchYK76obI/6eR6SInMnSxlc
         qbLQS+oGe4+yn3Yc0jNU+tPTk8dM2PyiXDAtMG9HQ7TmDDTTZKlZqq9jo2aZ6cb+WADQ
         NaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DcuyCpedy6FloVvAckAb8ILtszeJ8y+j4oQ6gYjTHNQ=;
        b=V7UL57pRSYR/F0KHuv8sK3N+f7BQwBixwAiKRooFIrOgtNzT9OcVVPGH90eu1fM6Qr
         VM5CV4FYRafU9ey9ZQxAoa7uxegMaDej0WKL6v8XHUBkpZidjq4m4WLRmWbM9oyKLRZQ
         tqjmsD5w97nOhPToO2m/110KX7TmICjA6/o9jDIn4JZKobya2u4Xc5fr0ICIXb2PHMH4
         weQ2tOEi/ui6drxoqrb7KLUZ41DoeU7dZo+PopjY8x8PwvM1Nk7daVtf3Fvylc/uEeGu
         P9xva430mRhMmYSaZIV8k2W7TLgd+NotLFsuf5/gUrJHCC58+/Ov4CWRfuiM6YLkjnOl
         usGw==
X-Gm-Message-State: APjAAAXXaSd2iZuTqV8YrrCfFexGuxTavAPiAWUj99MUR1BDniIIT3x7
        dG5Ig9LN3czaj/s/z31MhqLZyqndOcKqBKfO6L5u7XdE
X-Google-Smtp-Source: APXvYqzIm6P+gAhuCRutTX6fv0ju1B9KUwvtATuWgSUdv5oqU5o4GhBkHTrTh++P2QCnNumRFHNQqzlkfnUo65JV0DI=
X-Received: by 2002:a05:6830:2042:: with SMTP id f2mr52889425otp.89.1555533444590;
 Wed, 17 Apr 2019 13:37:24 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>
Date:   Wed, 17 Apr 2019 22:35:23 +0200
Message-ID: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
Subject: Feature request: Allow to update commit ID in messages when rebasing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The feature I'm asking is to add an extra-step during rebasing,
checking whether there's a reference to a commit that's not going to
be included in history and asks the user whether the heuristics is
correct and if she wants to update those references.

Scenario: it can happen for a commit message to contain the ID of an
ancestor commit. A typical example is a commit with the message
"revert 01a9fe8". If 01a9fe8 and the commit that reverts it are
involved in a rebase the message "revert 01a9fe8" is no longer valid
-- the old 01a9fe8 has now a different hash. This will most likely be
ignored by the person who's rebasing but will let the other people
reading history confused.

Giuseppe
