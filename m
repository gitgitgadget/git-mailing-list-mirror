Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054FC433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 13:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiEMNxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 09:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiEMNxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 09:53:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419A59BA9
        for <git@vger.kernel.org>; Fri, 13 May 2022 06:50:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j6so7717098pfe.13
        for <git@vger.kernel.org>; Fri, 13 May 2022 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4jXmL7Zrg1ZokojVoQJaM9bD2IQFHmudTGshRrCwjI=;
        b=llgxOrC/PiG/tzZkZ4L9PU0vS169btnGeNWXEH98ud+hd7LQa1Yk4j7dHoFwPa7Oz9
         Zf649RbgKDURaxW8hkCzDzhFCEQT7vj//YJN1iny90IfwhI5PtCTDhbr6o7XOulwc0s2
         n7eHwWZPswwfAZXZIS1q/qrpk22ZQIoKuqvBHoSR2A+s009bSwyYvzgSIeFoHzyyoZdw
         JXgl83H48NbtssSjadMbdT8+oEp5LK9zMxsoKwQ3UWhH0tJvbJsMj6q20LhoT+jqlq/p
         UHnndMU+GG6iFDT2gmeoXcF37PTjJ9V0TJd9NMbhc+2MuRuvLnGBx7w4o4HJ2yykFqgb
         T28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4jXmL7Zrg1ZokojVoQJaM9bD2IQFHmudTGshRrCwjI=;
        b=SMTRhAyEF1Vsu8o/FEfvdNG/K05OtSVcrGEBEq8Eb9GyH8jXJoT3CBKta8aaBZU/l2
         H3QzwzSLjjq+uuE/Ui591aX22w6HzpYjoLZgBwBeX0bWMmmbdiCMlhvRjl31GEpnLqDh
         h87aWiqto9EG0EyvQnpZ1Oa7kqPnAyN8o9gdwvVjekngZqfRZzyHPHJR/7BtXzQ3Mwal
         GOHNayRqgLbrZ3ILYy+RUdEp4Osxy56ip6FNhKqyx0VRs/lOuXd3aPNQ2dRh1VbdBYQj
         37FccgZtwJCkGj5GyemMBbRWRAvlV+rxrbo2mHYZLVXS09QLHNxVlnkw4UGgnC432eV9
         3nww==
X-Gm-Message-State: AOAM533QesjueYsLaNEcmJewKNyDZsDnh6Y7TMtay2m6WAGA+lvOgLtS
        THXjb+8CSmt2n+AOhWjtDco=
X-Google-Smtp-Source: ABdhPJwV3I7ITqcjB/u3O4W9W2tf3klgl4CfnKCtS8Kc+mzC0LnOFX8CYiA2vU2HdSFL9sZX0z5LkQ==
X-Received: by 2002:a65:6a4c:0:b0:39c:f169:b54a with SMTP id o12-20020a656a4c000000b0039cf169b54amr4190075pgu.384.1652449826533;
        Fri, 13 May 2022 06:50:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:4e9e:ceaa:e164:1ef4:34a1:c63d])
        by smtp.gmail.com with ESMTPSA id v18-20020a170902e8d200b0015e8d4eb2b4sm1824341plg.254.2022.05.13.06.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 May 2022 06:50:25 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Fri, 13 May 2022 19:19:46 +0530
Message-Id: <20220513134946.1581-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqmtfqd25h.fsf@gitster.g>
References: <xmqqmtfqd25h.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Isn't it where we already are with "remote -v", though?  I am not
> sure addition of excess information that may not be universally
> useful is a very welcome change, even with "remote -v -v".  I am not
> worried about showing the "list-object-filter", but I worry about
> managing temptations of future developers to add other stuff.

If future developers come up with some really useful stuff (i.e. 
universally useful), I think those should be added in the output
irrespective of the no of existing info in the output. If the
output becomes messy, we should focus on how we can make the output
clear may be using tabular format.

Else you can drop the idea and suggest them to introduce a new flag
(depending on the situation). If you still have some doubt about my
PR i.e. if you can not determine which category my PR belongs to, I
can go with adding `show-partial-clone` flag. The downside would
be that `remote -v` will not give the full summary in case of partial
clone.

If you like the tabular format approach, I am further going to propose
a table format -

+---------------+----------------------------------------------+
|  remote name  |          remote info                         |
+---------------+--------+--------+----------------------------+
|               |        | url    | https://blah.com/blah.git  |
|  origin       |        +--------+----------------------------+
|               |        | filter | blob:none                  |
|               | fetch  +--------+----------------------------+
|               |        | .                                   |
|               |        | .     (some important data)         |
|               +--------+--------+----------------------------+
|               |        | url    | https://blah.com/blah.git  |
|               | push   +--------+----------------------------+
|               |        | ... (some important data)           |
+---------------+--------+-------------------------------------+

In this way, user can see the summary of all remotes with visual ease.
Of course it is not suitable for scripting. In that case we can use
a new flag `--raw` which will let `-v` to provide a space/tab seperated
sequence of info (similar to current format).

Let me know if you (as in all) like/dislike my view and give your
arguments regarding my proposal.

Thanks :) 
